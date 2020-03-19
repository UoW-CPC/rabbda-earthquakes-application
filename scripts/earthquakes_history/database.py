from logs import Log
from tinydb import TinyDB, Query
from datetime import datetime


class Database:

    @classmethod
    def QueryInput(cls, years_temp_list, magnitude_over, download_again):
        years = []
        db = TinyDB('../../data/earthquakes-history/history_db.json')
        if download_again:
            Log.warning("Download again option activated. This might result to duplicates.")
        for year in years_temp_list:
            now = str(datetime.utcnow())
            if download_again:
                db.insert({'year': year, "magnitudeOver": magnitude_over, 'requestDate': now})
                years = years_temp_list
                Log.info("Database updated with record: year={}, magnitude={}".format(year,magnitude_over))
            else:
                query = Query()
                record = db.search((query.year == year) & (query.magnitudeOver == magnitude_over))
                if record == []:
                    db.insert({'year': year, "magnitudeOver": magnitude_over, 'date': now})
                    years.append(year)
                    Log.info("Database updated with record: year={}, magnitude={}".format(year,magnitude_over))
                else:
                    Log.warning("Database record exists for: year={}, magnitude={}, skip values".format(year,magnitude_over))
        return years
