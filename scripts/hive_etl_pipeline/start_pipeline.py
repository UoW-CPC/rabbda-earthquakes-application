import sys

from logs import Log
from input import Input
from hdfs import HDFS
from hive import Hive
from database import Database

def main():
    Log.info('------------------------')
    Log.info('Hive ETL pipeline starts')
    Log.info('------------------------')
    inputArgs = sys.argv
    args = inputArgs[1:]
    drop_earthquakes_tables = Input.getValues(args)
    earthquakes_files = HDFS.getFiles()
    create_DB = Database.CreateDB()
    create_earthquakes_tables = Database.CreateEarthquakesTables()
    upload_static_data = Database.UploadStaticData()
    path = HDFS.getPath()
    if create_DB:
        Hive.createDB(path)
    if create_earthquakes_tables:
        Hive.createEarthquakesTables()
    if upload_static_data:
        Log.info("Uploading cities and seismographic stations to HDFS..")
        HDFS.put('../../data/hive-etl-pipeline/cities.csv', path)
        HDFS.put('../../data/hive-etl-pipeline/seismographic-stations.csv', path)
        Hive.loadCities(path)
        Hive.loadSeismographicStations(path)
        Log.info("Uploading seismograph script to HDFS..")
        HDFS.put('seismograph.py',path)
    Log.info("Files to be proccessed:")
    Log.info("Files to be imported in Hive: {}".format(earthquakes_files))
    if drop_earthquakes_tables:
        Hive.clearEarthquakesTables()
    for file in earthquakes_files:
        Hive.loadEarthquakesData(file)
        Hive.distanceToAllSeismographicStations()
        Hive.distanceAllToCities()
        #Hive.distanceToClosestSeismographicStation()

       # Hive.distanceToClosestCity()

       # Hive.produceSeismographs()
    Log.info('------------------------')
    Log.info('Hive ETL pipeline ends')
    Log.info('------------------------')


if __name__ == "__main__":
    main()
