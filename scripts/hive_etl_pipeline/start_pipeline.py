import sys

from logs import Log
from input import Input
from hdfs import HDFS
from hive import Hive

def main():
    Log.info('------------------------')
    Log.info('Hive ETL pipeline starts')
    Log.info('------------------------')
    inputArgs = sys.argv
    args = inputArgs[1:]
    drop_tables = Input.getValues(args)
    files = HDFS.getFiles()
    Log.info("Files to be imported in Hive: {}".format(files))
    Hive.create_database()
    if drop_tables:
        Hive.clear_tables()
    Hive.create_tables()
    Hive.load_cities()
    Hive.load_seismographic_stations()
    for file in files:
        Hive.




    Log.info('------------------------')
    Log.info('Hive ETL pipeline ends')
    Log.info('------------------------')


if __name__ == "__main__":
    main()
