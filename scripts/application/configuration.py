from logs import Log

import yaml
import sys


class Configuration:

    @classmethod
    def Read(cls):
        try:
            with open(r'../../conf/earthquakes-application.yaml') as file:
                configuration = yaml.load(file, Loader=yaml.FullLoader)
                Log.info("Loading configuration from earthquakes-application.yaml")
                Log.info("values: {}".format(configuration))
                history_args, hive_args = cls.Evaluate(configuration)
                return history_args, hive_args
        except EnvironmentError as error:
            Log.error("Configuration can not be loaded.")
            Log.error(error)
            Log.exit()

    @classmethod
    def Evaluate(cls, configuration):
        history_args = {}
        hive_args = {}
        for config, values in configuration.items():
            if config == 'hdfs-path':
                history_args['--hdfs-path='] = values
                hive_args['--hdfs-path='] = values
            elif config == 'download-list-of-years':
                list_of_years = ""
                if values is not None:
                    for value in values:
                        if list_of_years == "":
                            list_of_years = str(value)
                        else:
                            list_of_years = list_of_years + "," + str(value)
                if list_of_years is not "":
                    history_args['--year='] = list_of_years
            elif config == 'download-group-of-years':
                if values is not None:
                    if len(values) == 2:
                        history_args['--from-year='] = str(values[0])
                        history_args['--to-year='] = str(values[1])
                    else:
                        Log.error("Property 'download-group-of-years' can take only two values, from-year, to-year")
                        Log.exit()
            elif config == 'download-magnitude-over':
                history_args['--magnitude-over='] = str(values)
            elif config == 'download-again-historical-data':
                if values is True:
                    history_args['--download-again'] = ""
            elif config == 'hive-drop-all-tables':
                hive_args['--drop-tables'] = values

        if '--hdfs-path=' in history_args.keys():
            if history_args['--hdfs-path='] is None:
                Log.error("You must specify an HDFS path for the data to be stored.")
                Log.exit()
        else:
            Log.error("You must specify an HDFS path for the data to be stored.")
            Log.exit()

        if '--year=' in history_args.keys() and (
                '--from-year=' in history_args.keys() or '--to-year=' in history_args.keys()):
            Log.error(
                "You can not pass values for both 'download-list-of-years' and 'download-group-of-years'. Chose one of this options.")
            Log.exit()

        return history_args, hive_args

