from configuration import Configuration
from logs import Log
from system import System


from scripts.history import start_download


def main():
    Log.info('------------------------------')
    Log.info('Earthquakes application starts')
    Log.info('------------------------------')
    download_history_args, hive_args = Configuration.Read()
    hdfs_path =""
    year =""
    from_year = ""
    to_year = ""
    mangitude_over = ""
    download_again = ""
    for arg,value in download_history_args.items():
        if arg == '--hdfs-path=':
            hdfs_path = arg+value
        elif arg == '--year=':
            year = arg+value
        elif arg == '--from-year=':
            from_year = arg+value
        elif arg == '--to-year=':
            to_year = arg+value
        elif arg == '--magnitude-over=':
            mangitude_over = arg+value
        elif arg == '--download-again':
            download_again = arg
    Log.info('Start downloading earthquakes data from USGS Rest API.')
    (ret, out, err) = System.command(['python', '../history/start_download.py',hdfs_path,year,from_year,to_year,download_again])
    print out
    print ret
    print err
    if ret == 1:
        print "Error while uploading the file to HDFS: "
        print err
    else:
        print "File successfully uploaded to HDFS."
    #start_download.main(download_history_args)



if __name__ == "__main__":
    main()
