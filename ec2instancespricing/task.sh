#!/bin/bash

DATE=$(date '+%d-%m-%Y-%H-%M-%S')
TYPE="spot"
HOME="/Ansible_Roles/python/ec2instancespricing/ec2instancespricing"
REGION_LIST="$HOME/region.txt"
FORMAT="json"
DATA_STORE="$DATA/data"

cd $HOME
for region in $(cat $REGION_LIST); do
mkdir $DATA_STORE/$region
./ec2instancespricing.py --type $TYPE --filter-region $region --format $FORMAT > $DATA_STORE/$region/$DATE.json
done