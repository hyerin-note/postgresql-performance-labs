# PostgreSQL: Seq Scan vs Index Scan

## Goal
Understand when PostgreSQL chooses a sequential scan over an index-based plan,
even when indexes exist, and how planner decisions are affected by selectivity,
statistics, cache state, and cost model settings.

---

## Environment
- PostgreSQL: 16
- Dataset: orders table (~5,000,000 rows)
- Settings tested:
  - enable_seqscan
  - random_page_cost

---

## Dataset & Indexes
- Table: orders
  - Columns: id (PK), user_id, status, amount, created_at
- Indexes:
  - idx_orders_user_id (btree)
  - idx_orders_created_at (btree)
  - idx_orders_status (btree)

---

## Test Cases

### Case A: High selectivity
Query:
SELECT * FROM orders WHERE user_id = 42;

Observation:
- Index-based plan selected due to high selectivity.

---

### Case B: Low selectivity
Query:
SELECT * FROM orders WHERE status = 1;

Observation:
- Seq Scan or Bitmap Heap Scan chosen depending on index availability.

---

### Case C: Range condition with ORDER BY and LIMIT
Query:
SELECT *
FROM orders
WHERE created_at >= now() - interval '1 day'
ORDER BY created_at DESC
LIMIT 100;

Observation:
- Index Scan efficiently satisfied filtering and ordering.

---

## Additional Experiments
- Cold vs Warm cache comparison
- Forced index usage using enable_seqscan
- random_page_cost sensitivity testing

---

## Conclusion
- Sequential Scan is not inherently bad and can be optimal for low-selectivity predicates.
- Index Scan is most effective with high selectivity or when LIMIT allows early termination.
- Bitmap Heap Scan provides a practical compromise between Seq Scan and Index Scan.
- Accurate statistics, cache awareness, and cost model tuning are critical for understanding
  and optimizing PostgreSQL query performance.
