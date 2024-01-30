-- Usage: spark-sql-hms-hudi -f spark.sql
-- Depends on trino.sql

CREATE SCHEMA IF NOT EXISTS tpch_hudi_sf2 LOCATION 's3a://tpch-sf2/hudi';
DROP TABLE IF EXISTS tpch_hudi_sf2.lineitem;
CREATE TABLE tpch_hudi_sf2.lineitem
USING hudi
TBLPROPERTIES (
  'hoodie.metadata.enable' = false,
  'hoodie.parquet.max.file.size' = 1073741824
)
AS SELECT /*+ COALESCE(1) */ * FROM tpch_hive_sf2.lineitem;
