
--Create tables from downloaded data files 
CREATE TABLE IF NOT EXISTS bike_data
    as select * from read_csv_auto('./data/citibike-tripdata.csv.gz', union_by_name=True, filename=True, all_varchar=True);

CREATE TABLE IF NOT EXISTS central_park_weather 
    as select * from read_csv_auto('./data/central_park_weather.csv', union_by_name=True, filename=True, all_varchar=True);

CREATE TABLE IF NOT EXISTS fhv_bases
    as select * from read_csv_auto('./data/fhv_bases.csv', union_by_name=True, filename=True,all_varchar=True,header=True);

CREATE TABLE IF NOT EXISTS fhv_tripdata as 
    select * from read_parquet('./data/taxi/fhv_tripdata.parquet', union_by_name=True, filename=True,all_varchar=True);

CREATE TABLE IF NOT EXISTS fhvhv_tripdata as 
    select * from read_parquet('./data/taxi/fhvhv_tripdata.parquet', union_by_name=True, filename=True,all_varchar=True);

CREATE TABLE IF NOT EXISTS green_tripdata as 
    select * from read_parquet('./data/taxi/green_tripdata.parquet', union_by_name=True, filename=True,all_varchar=True);

CREATE TABLE IF NOT EXISTS yellow_tripdata as 
    select * from read_parquet('./data/taxi/yellow_tripdata.parquet', union_by_name=True, filename=True,all_varchar=True);




