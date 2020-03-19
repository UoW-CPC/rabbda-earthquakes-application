import sys
from datetime import timedelta, date

from input import Input
from database import Database
from acquisition import Acquisition
from preprocessing import Preprocessing
from storeData import StoreData
from hdfs import HDFS
from logs import Log


def main():
    Log.info('-----------------------')
    Log.info('Download process starts')
    Log.info('-----------------------')
    inputArgs = sys.argv
    args = inputArgs[1:]
    StoreData.createFolder()
    yearsTempList, magnitudeOver, download_again = Input.getValues(args)
    years = Database.QueryInput(yearsTempList, magnitudeOver, download_again)
    Log.info("Requesting earthquakes data with magnitude over {}, for years: {}".format(magnitudeOver, years))
    for year in years:
        Log.info("Processing year: {}".format(year))
        Log.info("Data acquisition starts.")
        firstDate = date(year, 1, 1)
        lastDate = date(year, 12, 31)
        for d in dateRange(firstDate, lastDate):
            start = d.strftime("%Y-%m-%d") + "T00:00:00.000Z"
            end = (d + timedelta(days=1)).strftime("%Y-%m-%d") + "T00:00:00.000Z"
            try:
                eq_list_raw = Acquisition.Request(start, end, magnitudeOver)
                eq_list_temp = Preprocessing.cleanHeaders(eq_list_raw)
                eq_list = Preprocessing.splitDateTime(eq_list_temp)
                StoreData.toFile(eq_list, year, d,magnitudeOver)
            except Exception as error:
                Log.error("Error while processing a Request:")
                Log.error(error)
        Log.info("Data acquisition for  year {} finished".format(year))
        path = HDFS.getPath()
        HDFS.put('../../data/earthquakes-history/earthquakes{}mag{}.csv'.format(year, magnitudeOver), path)
    Log.info('---------------------')
    Log.info('Download process ends')
    Log.info('---------------------')


def dateRange(firstDate, lastDate):
    for n in range(int((lastDate - firstDate).days)):
        yield firstDate + timedelta(n)


if __name__ == "__main__":
    main()
