from logs import Log

import subprocess
import time

class HDFS:

    path = ""
    files = []

    @classmethod
    def command(cls,args_list):
        Log.info('Running system command: {0}'.format(' '.join(args_list)))
        proc = subprocess.Popen(args_list, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        s_output, s_err = proc.communicate()
        s_return = proc.returncode
        return s_return, s_output, s_err

    @classmethod
    def put(cls,file,path):
        (ret, out, err) = cls.command(['hdfs', 'dfs', '-put', file, path])
        Log.info("return: {}".format(ret))
        Log.info("output: {}".format(out))
        if ret == 1:
            Log.error("Error while uploading the file to HDFS: ")
            Log.error(err)
        else:
            Log.info("File successfully uploaded to HDFS")


    @classmethod
    def filesInPath(cls, path):
        cls.path = path
        Log.info("HDFS path validation:")
        (ret, out, err) = cls.command(['hdfs', 'dfs', '-ls', path])
        if ret ==1:
            Log.error("HDFS path Error. Exiting the Application..")
            Log.error(err)
            Log.exit()
        else:
            Log.info("Valid HDFS path")
            Log.info("Files to be proccessed:")
            lines = out.splitlines()
            for line in lines:
                line_split = line.split(' ')
                line_len = len(line_split)
                cls.files.append(line_split[line_len - 1])

    @classmethod
    def getPath(cls):
        return cls.path

    @classmethod
    def getFiles(cls):
        cls.files.pop(0)
        return cls.files