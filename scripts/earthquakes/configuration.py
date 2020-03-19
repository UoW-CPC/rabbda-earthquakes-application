from logs import Log

import yaml
import sys

class Configuration:

    @classmethod
    def Read(cls):
        try:
            print "test"
            with open(r'../../conf/earthquakes-applications.yaml') as file:
                print "test2"
                configuration = yaml.load(file, Loader=yaml.FullLoader)
                return configuration
        except OSError:
            print "Configuration can not be loaded"
            Log.error("Configuration can not be loaded")
            Log.error(OSError)
            sys.exit(2)


