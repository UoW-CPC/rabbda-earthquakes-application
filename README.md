# rabbda-earthquakes-portal

## Introduction
This is a proof of concept application that aims to demonstrate how Big Data can be used to create complex Big Data solutions.
Additionally, by implementing various releases, someone can understand how a project evolves through multiple iterations.

__RABBDA project:__

RABBDA (Reduce Access Barriers to Big Data Analytics) is created by the Centre of Parallel Computing - University of Westminster https://www.westminster.ac.uk/research/groups-and-centres/centre-for-parallel-computing.

The project objective is to provide students and practitioners, access to Big Data technologies and learning material. The earthquakes portal is designed to serve RABBDA project as an illustration on how to utilise Big Data technologies so to build complex architectures.

For more information, please review RABBDA context at readthedocs.io

### Release:0.0
This release introduces technologies like Rest APIs, Hadoop HDFS, Hive, Spark, and Tableau.
Additionally, Shell and Python scripts are being used to perform several tasks, e.g. data acquisition and preparation.

From architecture's point of view, the application utilises a Hive ETL pipeline (Extract-Transform-Load) that joins data from different sources, and provides answers to complex research questions.

This is a step-by-step guide that describes all application phases:
 1. Data acquisition: Request data from a Rest API.
 2. Data preparation: Pre-process data with Python.
 3. Data ingestion: Upload data to HDFS.
 4. ETL pipeline: Execute Hive queries.
 5. ETL pipeline results: Download data from HDFS and post-process them with Python.
 6. Further analysis:
    * Spark in memory data processing.
    * Complex research questions with Hive.
    * Data presentation with Tableau.
For extra information on the various phases, please refer to related repository folders.


The data source for this demo is related to earthquakes, source: [USGS science for a changing world](https://earthquake.usgs.gov).

USGS provides a [Rest API](https://earthquake.usgs.gov/fdsnws/event/1/) which will be using to request earthquakes data.
Sample request in csv format: [earthquakes](https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=2020-02-18T00:00:00.000Z&endtime=2020-02-19T00:00:00.000)

To more detail, static data related to cities and seismograph stations are being associated with earthquakes data acquired from the Rest API. The result of this process produces information such as earthquakes closest cities and seismographic stations, and links to seismographs.

 __Keywords:__ Big Data, Hadoop, HDFS, Hive, Spark, Rest API, Tableau, Python, Shell.


 ## Getting started
The following instructions guide you on how to set up the project on your Hadoop environment.

 ### Download the repository
 The initial step is to download the repository in your Hadoop machine. To do so, in terminal run the following command:
 ```
 git clone --single-branch --branch release-0.0 https://github.com/UoW-CPC/rabbda-earthquakes-portal.git
 ```
 This command clone specifically release-0.0 branch.

 ### Running the application
 Having download the repository you can now run the application and perform all the 6 steps mentioned in the introduction section.

 First move to the working directory by executing the command:
 ```
 cd rabbda-earthquakes-portal
 ```
 Now execute the command:
 ```
 ls
 ```
 There you can see eight folders:
  * _data_, datasets for cities and seismographic station.
  * _hiveql_, queries to execute the ETL pipeline, phase 3, and perform further analysis, phase 6.
  * _sample_data_, data produced in a demo execution.
  * _sample_output_, terminal output for a damo execution.
  * _sample_tableau_, visualisations for a demo execution, phase 6.
  * _spricts_python_, scripts to perform phases 2 and 5.
  * _scripts_shell_, shell scripts used to used to download the earthquakes from the Rest API, phase 1.
  * _scripts_spark_, scripts to perform further analysis in phase 6.
  * _slides_, contain material related to this release, e.g. architecture, results.

__Tip:__ changing directories with terminal commands.
 ```
 ls             #list all folders and files
 cd folder_name #move to folder
 cd ..          #move to parent folder
 pwd            #pring working directory
 ```

 #### 1. Data acquisition: Request data from a Rest API.

Move the bash folder to download the earthquakes by executing the command:

 ```
 cd bash
 ```
 In this folder you can see the bash script that requests the data from the Rest API. To see its content run the following:

 ```
 cat downloadEarthquakesData.sh
 ```

 The script is develop to download earthquakes data for a single year, and you can also define minimum magnitude.
 In this demo we will download data for the year 2019 and minimum magnitude of 6.
 The script is already configured, so we only need to run the following command:

 ```
 bash downloadEarthquakesData.sh
 ```
 To see the first rows of the data run the following command:
  ```
 head ../data/earthquakes.csv
 ```
 Move back to the project folder:
 ```
 cd ..
 ```
 #### 2. Data preparation: Pre-process data with Python.

 As you can see the data contain multiple header rows, this is because every request returned also the headers.
 Therefore, it is required to clear those rows. We do so by executing a Python script.

 Move to the python folder:
 ```
 cd python
 ```
 and execute the following command:
 ```
 python ClearTitles.py
 ```

 No if you check the data folder, there are two new files:
 * _titles.csv_, file that contains the headers of the requests.
 * _earthquakes-no-titles.csv_, file that contains earthquakes data without the headers.

 Last step in the preparation phase is to split the earthquake datetime  column to more columns, like, year, date, and time.
 Again, we use a Python script.

```
 python SplitDateTime.py
 ```

  No if you check the data folder, there is two new file:
  * _earthquakes-final.csv_, file that contains earthquakes data that will be using in the ETL pipeline

 Move again to the project folder:
 ```
 cd ..
 ```
 #### 3. Data ingestion: Upload data to HDFS.

 In this phase we simple have to upload the three data sets, earthquakes, cities, seismographic stations to HDFS.

 ```
#Command: hdfs dfs -put /"your_local_dir_path/file" /"your_hdfs_dir_path"
 ```

 #### 4. ETL pipeline: Execute Hive queries.

 This is the most important part of the application, that import the data sets to hive and join them to create new data sets.

 Move the hive folder:
 ```
 cd hive
 ```
 and start executing the ETL pipeline:
 ```
 # 1. Create the database
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f create-db.sql
 # 2. Create table cities
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f cities.sql
 # 3. Create table seasmographic stations
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f seismographic-stations.sql
 # 4. create table earthquakes_full_dataset
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 1.sql
 # 4. create table earthquakes with columns: id, time, day, latitude, longitude, magnitude
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 2.sql
 # create table earthquakes_distance_to_all_cities with cross join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 3.sql
 # create table earthquakes_closest_city inner join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 4.sql
 # create table earthquakes_closest_city_discance_to_all_stations cross join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 5.sql
 # create table earthquakes_closest_city_station inner join
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f 6.sql
 # export table earthquakes_closest_city_station to HDFS
 beeline -u jdbc:hive2://"your hive metastore server":10000 -n hive -f export-to-hdfs.sql
 ```

 #### 5. Output data: Download data from HDFS and post-process them with Python.

 Now we need to create the Seismograph
 ```
 cd /data
 HDFS
 hdfs dfs -get /user/dkagialis/file localfile
 ```

 ```
 python BuildSeismograph.py
 ```
 ####  6. Further analysis:
 ##### Spark in memory data processing.


 ##### Complex research questions with Hive.
 ##### Data visualisation with Tableau.

