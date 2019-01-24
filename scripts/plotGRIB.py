import os
import sys

import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

import numpy as np
import pygrib


def plotGRIB(gribFile):
    plt.figure()

    grbs=pygrib.open(gribFile)

    #for grb in grbs:
    #    print grb.keys()
    
    grb = grbs.select(name='2 metre temperature')[0]

    forecastTime = grb.forecastTime
    print forecastTime

    data=grb.values

    # minValue = np.amin(data)
    # maxValue = np.amax(data)
    # print round(minValue) - 5
    # print round(maxValue) + 5

    lat,lon = grb.latlons()

    m=Basemap(projection='mill',lat_ts=10,llcrnrlon=lon.min(), \
              urcrnrlon=lon.max(),llcrnrlat=lat.min(),urcrnrlat=lat.max(), \
              resolution='c')

    x, y = m(lon,lat)

    cs = m.pcolormesh(x,y,data,shading='flat',cmap=plt.cm.jet)

    m.drawcoastlines()
    #m.fillcontinents()
    #m.drawmapboundary()
    m.drawparallels(np.arange(-90.,120.,30.),labels=[1,0,0,0])
    m.drawmeridians(np.arange(-180.,180.,60.),labels=[0,0,0,1])

    plt.colorbar(cs,orientation='vertical')
    plt.clim(235,300)
    titleString = "T2m FStep(h): %d" % (forecastTime/60)
    plt.title(titleString)
    fileName = "out_%04d.png" % (forecastTime)
    plt.savefig(fileName)
    plt.close()
    #plt.show()

for filename in os.listdir(sys.argv[1]):
    if filename.endswith(".grib2"):
        plotGRIB(filename)
        # print(os.path.join(directory, filename))
        continue
    else:
        continue



