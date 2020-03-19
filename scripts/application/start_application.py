from configuration import Configuration
from logs import Log
from system import System
import os

from scripts.earthquakes_history import start_download


def main():
    Log.info('------------------------------')
    Log.info('Earthquakes application starts')
    Log.info('------------------------------')
    history_args, hive_args = Configuration.Read()
    hdfs_path =""
    year =""
    from_year = ""
    to_year = ""
    mangitude_over = ""
    download_again = ""
    for arg,value in history_args.items():
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
    if mangitude_over is not "" and download_again is not "" and year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, year, mangitude_over, download_again])
    elif mangitude_over is not "" and download_again is "" and year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, year, download_again])
    elif mangitude_over is "" and download_again is not "" and year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, year, mangitude_over])
    elif mangitude_over is "" and download_again is "" and year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, year])
    elif mangitude_over is not "" and download_again is not "" and from_year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, from_year,to_year, mangitude_over, download_again])
    elif mangitude_over is not "" and download_again is "" and from_year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, from_year,to_year, download_again])
    elif mangitude_over is "" and download_again is not "" and from_year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, from_year,to_year, mangitude_over])
    elif mangitude_over is "" and download_again is "" and from_year is not "":
        (ret, out, err) = System.command(
            ['python', '../earthquakes_history/start_download.py', hdfs_path, from_year,to_year])
    Log.info("Download process finished. For more information see 'earthquakes-history.log'")
    Log.info('------------------------------')
    Log.info('Earthquakes application ends')
    Log.info('------------------------------')



if __name__ == "__main__":
    main()