from logs import Log
from system import System


class Hive:

    @classmethod
    def createDB(cls, path):
        hivevar = "path='" + path + "/earthquakes.db'"
        Log.info("Creating hive database: 'earthquakes'")
        (ret, out, err) = System.command(['hive', '-hivevar', hivevar, '-f', '../hive_ql/create-database.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))

    @classmethod
    def createEarthquakesTables(cls):
        Log.info("Creating hive tables:")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/create-earthquakes-tables.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))
        print ret
        print out
        print err

    @classmethod
    def loadCities(cls, path):
        hivevar = "path='" + path + "/cities.csv'"
        Log.info("Loading cities data to hive:")
        Log.info("Creating cities staging table..")
        (ret, out, err) = System.command(['hive', '-hivevar', hivevar, '-f', '../hive_ql/load-cities-staging.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))
        Log.info("Creating cities final table..")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/load-cities.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))

    @classmethod
    def loadSeismographicStations(cls, path):
        hivevar = "path='" + path + "/seismographic-stations.csv'"
        Log.info("Loading seismographic stations data to hive:")
        Log.info("Creating seismographic stations staging table..")
        (ret, out, err) = System.command(
            ['hive', '-hivevar', hivevar, '-f', '../hive_ql/load-seismographic-stations-staging.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))
        Log.info("Creating seismographic stations final table..")
        (ret, out, err) = System.command(
            ['hive', '-hivevar', hivevar, '-f', '../hive_ql/load-seismographic-stations.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))

    @classmethod
    def clearEarthquakesTables(cls):
        Log.warning("Option 'drop-tables' is enabled. All data will be removed.")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/clear-tables.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))

    @classmethod
    def loadEarthquakesData(cls, file):
        hivevar = "path='" + file + "'"
        print hivevar
        Log.info("Loading earthquakes data to hive:")
        Log.info(file)
        (ret, out, err) = System.command(['hive','-hivevar', hivevar, '-f', '../hive_ql/load-earthquakes.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.error("error, {}".format(err))
        print ret
        print out
        print err
