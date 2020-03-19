import getopt
from datetime import datetime

from hdfs import HDFS
from logs import Log

class Input:

    @classmethod
    def getValues(cls, inputArgs):
        Log.info("input arguments: {}".format(inputArgs))
        options = "y:f:t:m:p:d"
        longOptions = ["year=", "from-year=", "to-year=", "magnitude-over=", "download-again","hdfs-path="]
        try:
            opts, args = getopt.getopt(inputArgs, options, longOptions)
        except getopt.GetoptError as err:
            Log.error(err)
            Log.exit()

        yearFlag = False
        yearArg = None
        fromYearFlag = False
        fromYearArg = None
        toYearFlag = False
        toYearArg = None
        magnOverFlag = False
        magnOverArg = None
        overwriteFlag = False
        hdfsPathFlag = False
        hdfsPathArg = None

        for opt, arg in opts:
            Log.info("processing option: {} with arguments: {}".format(opt,arg))
            if opt in ("-p", "--hdfs-path"):
                if hdfsPathFlag:
                    cls.notUniqueArg()
                else:
                    hdfsPathFlag = True
                    hdfsPathArg = arg
            elif opt in ("-y", "--year"):
                if yearFlag:
                    cls.notUniqueArg()
                else:
                    yearFlag = True
                    yearArg = arg
            elif opt in ("-f", "--from-year"):
                if fromYearFlag:
                    cls.notUniqueArg()
                else:
                    fromYearFlag = True
                    fromYearArg = arg
            elif opt in ("-t", "--to-year"):
                if toYearFlag:
                    cls.notUniqueArg()
                else:
                    toYearFlag = True
                    toYearArg = arg
            elif opt in ("-m", "--magnitude-over"):
                if magnOverFlag:
                    cls.notUniqueArg()
                else:
                    magnOverFlag = True
                    magnOverArg = arg
            elif opt in ("-o", "--download-again"):
                if overwriteFlag:
                    cls.notUniqueArg()
                else:
                    overwriteFlag = True

        if hdfsPathFlag is False:
            Log.exit("Input Error. You must specify a valid HDFS path. Exiting the application..")
            Log.exit()
        else:
            HDFS.pathValidation(hdfsPathArg)

        fromToOption = False
        yearOption = False
        if fromYearFlag and toYearFlag and not yearFlag:
            fromToOption = True
        elif not fromYearFlag and not toYearFlag and yearFlag:
            yearOption = True
        else:
            Log.error("Input Parameters Error.\r\n" \
                  "You must pass parameters in one of the following formats:\r\n" \
                  "Example with a range of values:       '--from-year=2010 --to-year=2020'\r\n" \
                  "Example with a list of unique values: '--year=2010,2011,2012'\r\n" \
                  "Exiting the application..")
            Log.exit()

        if fromToOption:
            fromYearInt = cls.validateYear(fromYearArg)
            toYearInt = cls.validateYear(toYearArg)
            yearsList = cls.toList(fromYearInt, toYearInt)
        elif yearOption:
            yearsList = cls.toList(yearArg, None)

        if magnOverArg is None:
            magnOverArg = 0
        magnitudeOver = cls.validateMagnitude(magnOverArg)

        return yearsList, magnitudeOver, overwriteFlag

    @classmethod
    def notUniqueArg(cls):
        Log.error("Input Error. Can't pass one argument twice. Exiting the application..")
        Log.exit()

    @classmethod
    def toList(cls, args1, args2):
        yearsList = []
        if args2 is None:
            yearsTempList = str(args1).split(",")
            for year in yearsTempList:
                yearInt = cls.validateYear(year)
                if yearInt not in yearsList:
                    yearsList.append(yearInt)
            yearsList.sort()
        elif args2 is not None:
            fromYear = cls.validateYear(args1)
            toYear = cls.validateYear(args2)
            if fromYear > toYear:
                Log.error("Input Error. 'from-year' value must be less that 'to-year' value. Exiting the application..")
                Log.exit()
            else:
                for year in range(fromYear, toYear + 1):
                    yearsList.append(year)
        return yearsList

    @classmethod
    def validateYear(cls, arg):
        now = datetime.utcnow()
        currentYear = now.year
        try:
            year = int(arg)
            if 1900 <= year <= currentYear:
                return year
            else:
                Log.exit()
        except:
            Log.error(
                "invalid year input, value: '{}'. You can only pass year values from '1900' to '{}'. Exciting the application..".format(
                    arg, currentYear))
            Log.exit()

    @classmethod
    def validateMagnitude(cls, arg):
        try:
            magnutide = float(arg)
            if 0 <= magnutide <= 8:
                return magnutide
            else:
                Log.exit()
        except:
            Log.error(
                "invalid magnitude input, value: '{}'. You can only pass magnitude values from '0.0' to '8.0'. Exciting the application..".format(
                    arg))
            Log.exit()
