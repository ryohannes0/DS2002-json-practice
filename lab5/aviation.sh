#!/bin/bash

data=$(curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85")

echo "$data" | jq -r '.[].receiptTime' | head -n 6

temps=$(echo "$data" | jq -r '.[] | .temp' | head -n 12)
total=0
count=0
for temp in $temps; do
    total=$(echo "$total + $temp" | bc)
    ((count++))
done
avg_temp=$(echo "$total / $count" | bc -l)
echo "average temperature: $avg_temp"

clouds=$(echo "$data" | jq -r '.[] | .clouds[0].cover' | head -n 12)
cloudy_count=0
for cloud in $clouds; do
    if [[ "$cloud" != "CLR" ]]; then
        ((cloudy_count++))
    fi
done

if ((cloudy_count > 6)); then
    echo "mostly cloudy: true"
else
    echo "mostly cloudy: false"
fi
