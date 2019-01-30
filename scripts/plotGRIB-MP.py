import os
import sys
from multiprocessing import Pool

import matplotlib
matplotlib.use('Agg')

import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

import numpy as np
import pygrib


def plotGRIB(gribFile):
    directory = sys.argv[1]
    plt.figure()

    grbs=pygrib.open(gribFile)

    grb = grbs.select(name='2 metre temperature')[0]
#    for grb in grbs:
#        print grb.keys()

    
    forecastTime = grb.forecastTime
    year = grb.year
    month = grb.month
    day = grb.day
    hour = grb.hour
    minute = grb.minute

    date = "Reference Date: %4d%02d%02d-%02d%02d" %(year,month,day,hour,minute)
    data=grb.values


    lat,lon = grb.latlons()

    m=Basemap(projection='mill',lat_ts=10,llcrnrlon=lon.min(), \
              urcrnrlon=lon.max(),llcrnrlat=lat.min(),urcrnrlat=lat.max(), \
              resolution='c')

    x, y = m(lon,lat)

    cs = m.pcolormesh(x,y,data,shading='flat',cmap=plt.cm.jet)

    m.drawcoastlines()
    m.drawparallels(np.arange(-90.,120.,10.),labels=[1,0,0,0])
    m.drawmeridians(np.arange(-180.,180.,10.),labels=[0,0,0,1])

    plt.colorbar(cs,orientation='vertical')
    plt.clim(240,300)
    titleString = "%s T2m FStep(h): %d" % (date, forecastTime/60)
    plt.title(titleString)
    fileName = "out_%04d.png" % (forecastTime)
    plt.savefig(os.path.join(directory, fileName))
    plt.close()



def main(argv):

    directory = argv[1]
    myGRIBs = []
    for filename in os.listdir(directory):
        if filename.endswith(".grib2"):
            #plotGRIB(os.path.join(directory, filename),directory)
            myGRIBs.append(os.path.join(directory, filename))
            continue
        else:
            continue

    p = Pool()
    p.map(plotGRIB,myGRIBs)


          
if __name__ == "__main__":
    main(sys.argv)



