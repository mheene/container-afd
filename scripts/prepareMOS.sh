#!/bin/bash
# get the latest MOSMIX data from the DWD OpenData server
#wget -N -P data https://opendata.dwd.de/weather/local_forecasts/mos/MOSMIX_S_LATEST_240.kmz

zcat data/MOSMIX_S_LATEST_240.kmz | xsltproc --stringparam station "${STATION}"     mos-filter.xsl - > data/MOSMIX_S_LATEST_240-de.kml

STATION=$1
TITLE=$2
TITLE_SHORT=$3

cat data/MOSMIX_S_LATEST_240-de.kml | xsltproc --stringparam station "${STATION}" \
    --stringparam title "${TITLE}" --stringparam titleShort "${TITLE_SHORT}" \
    mos-json.xsl - > data/${STATION}.json

sed s/INPUTDATA/"data\/${STATION}.json"/ meteogram_template.html > meteogram_${STATION}.html

#if [ ! -d "~/data/meteogram" ]; then
#  mkdir -p ~/data/meteogram
#fi
