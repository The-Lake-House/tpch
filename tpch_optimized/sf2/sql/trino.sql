-- Usage: $TRINO_HOME/bin/trino -f trino.sql

USE tpch.sf2;

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
CREATE SCHEMA IF NOT EXISTS hive.tpch_hive_sf2 WITH (location = 's3a://tpch-sf2/hive');
DROP TABLE IF EXISTS hive.tpch_hive_sf2.lineitem;
CREATE TABLE hive.tpch_hive_sf2.lineitem WITH (format = 'PARQUET') AS SELECT * FROM lineitem;

-- Iceberg
CREATE SCHEMA IF NOT EXISTS iceberg.tpch_iceberg_sf2 WITH (location = 's3a://tpch-sf2/iceberg');
DROP TABLE IF EXISTS iceberg.tpch_iceberg_sf2.lineitem;
CREATE TABLE iceberg.tpch_iceberg_sf2.lineitem AS SELECT * FROM lineitem;

-- Delta Lake
CREATE SCHEMA IF NOT EXISTS delta.tpch_delta_sf2 WITH (location = 's3a://tpch-sf2/delta');
DROP TABLE IF EXISTS delta.tpch_delta_sf2.lineitem;
CREATE TABLE delta.tpch_delta_sf2.lineitem AS SELECT * FROM lineitem;
