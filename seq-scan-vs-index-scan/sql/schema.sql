CREATE SCHEMA IF NOT EXISTS lab;
SET search_path TO lab;

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
  id           BIGSERIAL PRIMARY KEY,
  user_id      INT NOT NULL,
  status       SMALLINT NOT NULL,
  amount       INT NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL
);
