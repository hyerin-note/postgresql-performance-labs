INSERT INTO lab.orders (user_id, status, amount, created_at)
SELECT
  (random() * 99999)::int + 1,
  (random() * 9)::int,
  (random() * 9999)::int + 1,
  now() - (random() * interval '365 days')
FROM generate_series(1, 5000000);

ANALYZE lab.orders;
