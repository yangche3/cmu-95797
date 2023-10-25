#!/usr/bin/env python
import duckdb

tables = [
    "bike_data",
    "central_park_weather",
    "fhv_bases",
    "fhv_tripdata",
    "fhvhv_tripdata",
    "green_tripdata",
    "yellow_tripdata"   
]

def main():
    # Connect to duckdb main.db
    con = duckdb.connect(database='main.db', read_only=True)

    # loop over the list of tables and run SQL queries, which will count the number of rows in each table
    for t in tables:
        count_rows = con.sql(f"SELECT COUNT(*) FROM "+t).fetchall()[0][0] 
        # The returned value is list of set, so using index locator to extract the number we need 
        print(t, count_rows)

if __name__ == "__main__":
        main()