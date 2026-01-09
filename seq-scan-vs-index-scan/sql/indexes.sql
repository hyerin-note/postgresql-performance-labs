CREATE INDEX idx_orders_user_id
ON lab.orders (user_id);

CREATE INDEX idx_orders_status
ON lab.orders (status);

CREATE INDEX idx_orders_created_at
ON lab.orders (created_at);

ANALYZE lab.orders;
