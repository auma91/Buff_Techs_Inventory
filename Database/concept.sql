CREATE TYPE "orders_status" AS ENUM (
  'created',
  'running',
  'done',
  'failure'
);

CREATE TABLE "items" (
  "id" int PRIMARY KEY,
  "name" varchar(20),
  "serial_number" varchar(50),
  "brand" varchar(20),
  "checked_out" boolean
);

CREATE TABLE "log" (
  "identikey" varchar<11>,
  "item_id" int,
  "checked_out_time" time,
  "return_time" time
);

ALTER TABLE "items" ADD FOREIGN KEY ("id") REFERENCES "log" ("item_id");