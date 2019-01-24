#!/bin/bash
#for file in *.grib2 ; do python plotGRIB.py $file 2>/dev/null; done
python plotGRIB.py .
convert -delay 100 -loop 0 `ls out*.png | sort ` T2m_Movie.gif
