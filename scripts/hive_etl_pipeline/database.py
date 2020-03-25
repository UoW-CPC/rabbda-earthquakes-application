from logs import Log
from tinydb import TinyDB, Query
from datetime import datetime


class Database:

    @classmethod
    def CreateDB(cls):
        db = TinyDB('../../data/hive-etl-pipeline/pipeline_db.json')
        now = str(datetime.utcnow())
        query = Query()
        record = db.search(query.hiveDB == 'created')
        if record == []:
            db.insert({'hiveDB': 'created', 'date': now})
            Log.info("Database updated with record 'hiveDB': Creating application database to Hive")
            create = True
        else:
            Log.info("Database record exists 'hiveDB': application database already exist")
            create = False
        return create

    @classmethod
    def UploadStaticData(cls):
        db = TinyDB('../../data/hive-etl-pipeline/pipeline_db.json')
        now = str(datetime.utcnow())
        query = Query()
        record = db.search((query.cities == 'uploaded') & (query.seismographicStations == "uploaded"))
        if record == []:
            db.insert({'cities': 'uploaded', 'seismographicStations': 'uploaded', 'date': now})
            Log.info("Database updated with records 'cities' and 'seismographicStations': Uploading the files to HDFS")
            upload = True
        else:
            Log.info("Database record exists 'cities' and 'seismographicStations': data already imported to Hive")
            upload = False
        return upload