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
    con = duckdb.connect(database='main.db', read_only=True)
    for t in tables:
        count_rows = con.sql(f"SELECT COUNT(*) FROM "+t).fetchall()[0][0]
        print(t, count_rows)

if __name__ == "__main__":
        main()