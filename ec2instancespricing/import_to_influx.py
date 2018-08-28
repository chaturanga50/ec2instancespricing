#!/usr/bin/env python

from influxdb import InfluxDBClient
import datetime

data = [
    {
        "measurement": "spot_pricing",
        "tags": {
            "instance_type": "t2.large",
            "region": "us-east-2",
            "currency": "USD",
            "unit": "perhr",
            "os": "linux",
            "utilization": "spot"
        },
        "time": str(datetime.datetime.now()),
        "fields": {
            "price": "0.0278"
        }
    }
]

client = InfluxDBClient(host='54.174.100.208, port=8086, database=mydb')
client.write_points(data)
