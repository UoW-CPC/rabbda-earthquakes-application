from logs import Log
from tinydb import TinyDB, Query
from datetime import datetime


class Database:

    @classmethod
    def CheckTables(cls):
        db = TinyDB('../../data/cities-stations/cities_stations_db.json')
        now = str(datetime.utcnow())
        query = Query()
        record = db.search((query.cities == 'uploaded') & (query.seismographicStations == "uploaded"))
        if record == []:
            db.insert({'cities': 'uploaded', 'seismographicStations': 'uploaded', 'date': now})
            Log.info("Database updated with record: 'cities', 'seismographicStations': Uploading the files to HDFS")
            upload = True
        else:
            Log.info("Database record exists for:  'cities', 'seismographicStations': Data already imported to Hive")
            upload = False
        return upload
