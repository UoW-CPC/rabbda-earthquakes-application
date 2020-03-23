import getopt
from datetime import datetime

from hdfs import HDFS
from logs import Log


class Input:

    @classmethod
    def getValues(cls, inputArgs):
        Log.info("input arguments: {}".format(inputArgs))
        options = "p:d"
        longOptions = ["hdfs-path=","drop-tables"]
        try:
            opts, args = getopt.getopt(inputArgs, options, longOptions)
        except getopt.GetoptError as err:
            Log.error(err)
            Log.exit()

        hdfsPathFlag = False
        hdfsPathArg = None
        dropTablesFlag = False

        for opt, arg in opts:
            Log.info("processing option: {} with arguments: {}".format(opt, arg))
            if opt in ("-p", "--hdfs-path"):
                if hdfsPathFlag:
                    cls.notUniqueArg()
                else:
                    hdfsPathFlag = True
                    hdfsPathArg = arg
            elif opt in ("-d", "--drop-tables"):
                if dropTablesFlag:
                    cls.notUniqueArg()
                else:
                    dropTablesFlag = True

        if hdfsPathFlag is False:
            Log.error("Input Error. You must specify a valid HDFS path. Exiting the application..")
            Log.exit()
        else:
            HDFS.filesInPath(hdfsPathArg)

        return dropTablesFlag

    @classmethod
    def notUniqueArg(cls):
        Log.error("Input Error. Can't pass one argument twice. Exiting the application..")
        Log.exit()
