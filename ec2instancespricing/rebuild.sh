#!/bin/bash

date=$(date '+%d-%m-%Y-%H-%M-%S')
date_for_json=$(date '+%d-%m-%YT%H:%M:%SZ')
pricing_type="spot"
home="/c/Users/uabeyc1/Documents/Repository/ec2instancespricing/ec2instancespricing"
region_list="$home/region.txt"
type_list="$home/type.txt"
format="json"
data_store="$home/data"
parse_data="$home/parse"

cd $home
for region in $(cat $region_list); do
    for type in $(cat $type_list); do
        mkdir $data_store/$region/$date -p
        ./ec2instancespricing.py --type $pricing_type --filter-region $region --filter-type $type --format $format > $data_store/$region/$date/$type_$date.json
    done
    parse_file_location=$data_store/$region/$date
    for jsonfile in $parse_file_location do
        instance_price=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].instanceTypes[0].price)
        instance_price_currency=$(cat $data_store/$region/$date/$type_$date.json | jq .currency | tr -d '"')
        instance_price_unit=$(cat $data_store/$region/$date/$type_$date.json | jq .unit | tr -d '"')
        instance_os=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].instanceTypes[0].os | tr -d '"')
        instance_utilization=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].instanceTypes[0].utilization | tr -d '"')
        instance_region=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].region | tr -d '"')
    done
done








    instance_price=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].instanceTypes[0].price)
    instance_price_currency=$(cat $data_store/$region/$date/$type_$date.json | jq .currency | tr -d '"')
    instance_price_unit=$(cat $data_store/$region/$date/$type_$date.json | jq .unit | tr -d '"')
    instance_os=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].instanceTypes[0].os | tr -d '"')
    instance_utilization=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].instanceTypes[0].utilization | tr -d '"')
    instance_region=$(cat $data_store/$region/$date/$type_$date.json | jq .regions[0].region | tr -d '"')
        mkdir $parse_data/$region/$type -p
        jq --arg in_type $type --arg in_price $instance_price --arg in_region $instance_region --arg in_date $date_for_json --arg in_currency $instance_price_currency --arg in_unit $instance_price_unit --arg in_os $instance_os --arg in_utilization $instance_utilization '.[.| length] |= . + {"instance_type": $in_type, "region": $in_region, "currency": $in_currency, "unit": $in_unit, "os": $in_os, "utilization": $in_utilization, "time": $in_date, price": $in_price}}' sample.json > $parse_data/$region/$date.json
