-- Usage: $TRINO_HOME/bin/trino -f trino.sql

USE tpch.sf100;

-- Use the same compression codec for all storage files
SET SESSION hive.compression_codec = 'GZIP';
SET SESSION iceberg.compression_codec = 'GZIP';
SET SESSION delta.compression_codec = 'GZIP';

-- Limit the number of concurrent writer thread to 1
SET SESSION task_max_writer_count = 1;

-- Do not collect extended statistics on write
SET SESSION iceberg.collect_extended_statistics_on_write = false;
SET SESSION delta.extended_statistics_collect_on_write = false;

-- Hive
CREATE SCHEMA IF NOT EXISTS hive.tpch_hive_sf100 WITH (location = 's3a://tpch-sf100/hive');
DROP TABLE IF EXISTS hive.tpch_hive_sf100.lineitem;
CREATE TABLE hive.tpch_hive_sf100.lineitem WITH (format = 'PARQUET') AS SELECT * FROM lineitem;

-- Iceberg
CREATE SCHEMA IF NOT EXISTS iceberg.tpch_iceberg_sf100 WITH (location = 's3a://tpch-sf100/iceberg');
DROP TABLE IF EXISTS iceberg.tpch_iceberg_sf100.lineitem;
CREATE TABLE iceberg.tpch_iceberg_sf100.lineitem AS SELECT * FROM lineitem;

-- Delta Lake
CREATE SCHEMA IF NOT EXISTS delta.tpch_delta_sf100 WITH (location = 's3a://tpch-sf100/delta');
DROP TABLE IF EXISTS delta.tpch_delta_sf100.lineitem;
CREATE TABLE delta.tpch_delta_sf100.lineitem AS SELECT * FROM lineitem;
