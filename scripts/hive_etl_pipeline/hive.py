from logs import Log
from system import System

class Hive:

    @classmethod
    def create_database(cls):
        Log.info("Creating hive database: 'earthquakes'")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/create-database.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.info("error, {}".format(err))

    @classmethod
    def clear_tables(cls):
        Log.warning("Option 'drop-tables' is enabled. All data will be removed.")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/drop-tables.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.info("error, {}".format(err))

    @classmethod
    def create_tables(cls):
        Log.info("Creating hive tables:")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/create-tables.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.info("error, {}".format(err))
        print ret
        print out
        print err

    @classmethod
    def load_cities(cls):
        Log.info("Loading cities data to hive:")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/load-cities.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.info("error, {}".format(err))
        print ret
        print out
        print err

    @classmethod
    def load_seismographic_stations(cls):
        Log.info("Loading seismographic stations data to hive:")
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/load-seismographic-stations.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.info("error, {}".format(err))
        print ret
        print out
        print err

    @classmethod
    def load_earthquakes_data(cls, file):
        Log.info("Loading earthquakes data to hive: {}",format(file))
        (ret, out, err) = System.command(['hive', '-f', '../hive_ql/load-earthquakes.hql'])
        Log.info("return, {}".format(ret))
        Log.info("output, {}".format(out))
        Log.info("error, {}".format(err))
        print ret
        print out
        print err

