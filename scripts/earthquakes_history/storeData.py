from logs import Log
import os


class StoreData:

    @classmethod
    def toFile(cls, eq_list, year, d, magnitudeOver):
        count = 0
        with open('../../data/earthquakes-history/earthquakes{}mag{}.csv'.format(year,magnitudeOver), 'a') as writer:
            for eq in eq_list:
                count = count + 1
                eq_str = ",".join(eq)
                writer.write("%s\r\n" % (eq_str))
            Log.info("Earthquakes for {} stored to file, records: {}".format(d, count))

    @classmethod
    def createFolder(cls):
        path = "../../data/earthquakes-history/"
        try:
            os.mkdir(path)
        except OSError:
            Log.info("Creation of the data directory %s failed, already exist" % path)
        else:
            Log.info("Successfully created data directory %s " % path)
