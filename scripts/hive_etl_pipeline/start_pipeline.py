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
    drop_tables = Input.getValues(args)
    files = HDFS.getFiles()
    create = Database.CreateDB()
    upload = Database.UploadStaticData()
    path = HDFS.getPath()
    if create:
        Hive.create_database(path)
    if upload:
        Log.info("Uploading cities and seismographic stations to HDFS..")
        HDFS.put('../../data/hive-etl-pipeline/cities.csv', path)
        HDFS.put('../../data/hive-etl-pipeline/seismographic-stations.csv', path)
        Hive.load_cities(path)
        #Hive.load_seismographic_stations(path)
    Log.info("Files to be proccessed:")
    Log.info("Files to be imported in Hive: {}".format(files))
    if drop_tables:
        Hive.clear_tables()
    """
    Hive.create_tables()
    if upload:
        Hive.load_cities(path)
        Hive.load_seismographic_stations(path)
    for file in files:
        Hive.load_earthquakes_data(path,file)
    """
    Log.info('------------------------')
    Log.info('Hive ETL pipeline ends')
    Log.info('------------------------')


if __name__ == "__main__":
    main()
