# rabbda-earthquakes-portal

## Introduction
This is a proof of concept application that aims to demonstrate how Big Data can be used to create complex Big Data solutions.
Additionally, by implementing various releases, we present how a project evolves through multiple iterations.

__RABBDA project:__

RABBDA (Reduce Access Barriers to Big Data Analytics) is created by the [Centre of Parallel Computing](https://www.westminster.ac.uk/research/groups-and-centres/centre-for-parallel-computing) - University of Westminster.

The project objective is to provide students and practitioners access to Big Data technologies and learning material. The earthquakes portal is designed to serve RABBDA project as an illustration on how to utilise Big Data technologies so to build complex architectures.

For more information, please review RABBDA at readthedocs.io

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
    * Advanced research questions with Hive.
    * Data visualisations with Tableau.

For extra information on the various phases, please refer to related folders.


This demonstration utilises earthquakes data, source: [USGS science for a changing world](https://earthquake.usgs.gov).

USGS provides a [Rest API](https://earthquake.usgs.gov/fdsnws/event/1/) which will be using to request earthquakes data.
Sample request in csv format: [earthquakes](https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=2020-02-18T00:00:00.000Z&endtime=2020-02-19T00:00:00.000)

To more detail, static data for cities and seismograph stations are being associated with earthquakes data acquired from the Rest API. The result of this process produces information such as earthquakes closest cities and seismographic stations, and links to seismographs.

 __Keywords:__ Big Data, Hadoop, HDFS, Hive, Spark, Rest API, Tableau, Python, Shell.


 ## Getting started
The following instructions guide you on how to set up the project on your Hadoop environment.

 ### Download the repository
 The initial step is to download the repository in your Hadoop machine. To do so, in terminal run the following command:
 ```
 git clone --single-branch --branch release-0.0 https://github.com/UoW-CPC/rabbda-earthquakes-portal.git
 ```
 This command clones specifically release-0.0 branch.

 ### Running the application
 Having download the repository you can now run the application and perform all the 6 phases mentioned in the introduction section.

 First move to the working directory by executing the command:
 ```
 cd rabbda-earthquakes-portal
 ```
 Now execute the command:
 ```
 ls
 ```
 There you can see seven folders and three files:
  * __data__ - folder - contains datasets for cities and seismograph station.
  * __hiveql__ - folder - contains queries to execute the ETL pipeline, phase 3, and perform further analysis, phase 6.
  * __sample_data__ - folder - contains data produced in a demo execution.
  * __sample_output__ - folder - contains terminal output for a demo execution.
  * __sample_tableau__ - folder - contains visualisations for a demo execution, phase 6.
  * __spricts_python__ - folder - contains scripts to perform phases 2 and 5.
  * __scripts_shell__ - folder - contains a shell script used to download the earthquakes from the Rest API, phase 1.
  * __scripts_spark__ - folder - contains scripts to perform further analysis in phase 6.
  * __release-0.ppt__ - file - slides with material related to this release, e.g. architecture, results.
  * __README.md__ - file - project information and instructions on how to use the application.
  * __requirements.txt__ - file - Python libraries used by this application.


This application is build to run with Hortonworks Data Platform (HDP) 2.6.5, please download HDP [here](https://www.cloudera.com/downloads/hortonworks-sandbox/hdp.html).

HDP-2.6.5 comes with Python 2.7 pre-installed; therefore, this Python version is being used for our scripts. However, it can run to every Hadoop environment that

Before we start executing the several phases of the application, it is required to install some Python libraries, to do so run the following:
that runs the utilised services.
 ```
 pip install -r requirements.txt
 ```


__Tip:__ changing directories with terminal commands.
 ```
 ls             #list all folders and files
 cd folder_name #move to folder
 cd ..          #move to parent folder
 pwd            #pring working directory
 ```
 #### Now we are ready to go through the various phases.
 #### 1. Data acquisition: Request data from a Rest API.

Move to the scripts_shell folder to download the earthquakes by executing the command:

 ```
 cd scripts_shell
 ```
 In this folder you can see the shell script that requests the data from the Rest API. To see its content run the following:

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

 As you can see the dataset contains multiple header rows, this is because every request returns also the headers.
 Therefore, it is required to clear those rows. We do so by executing a Python script.

 Move to the scripts_python folder:
 ```
 cd scripts_python
 ```
 and execute the following command:
 ```
 python ClearTitles.py
 ```

 No if you check the data folder, there are two new files:
 * _titles.csv_, file that contains the headers of the requests.
 * _earthquakes-no-titles.csv_, file that contains earthquakes data without the headers.

 Last step in the preparation phase is to split the earthquake datetime column to more columns, like, year, date, and time.
 Again, we use a Python script.

```
 python SplitDateTime.py
 ```

  No if you check the data folder, there is one new file:
  * _earthquakes-final.csv_, file that contains earthquakes data that will be using in the ETL pipeline.

 Move again to the project folder:
 ```
 cd ..
 ```
 #### 3. Data ingestion: Upload data to HDFS.

 In this phase we simple upload the three data sets, earthquakes, cities, seismographic stations to HDFS.

 ```
# Command: hdfs dfs -put /"your_local_dir_path/file" /"your_hdfs_dir_path"
# Sample commands:
hdfs dfs -put /data/earthquakes_final.csv /earthquakes_portal
hdfs dfs -put /data/cities.csv /earthquakes_portal
hdfs dfs -put /data/seismograph_stations.csv /earthquakes_portal
# Warning: you must specify a valid HDFS path
 ```

 #### 4. ETL pipeline: Execute Hive queries.

 This is the most important part of the application, which imports the datasets to hive and joins them to create new datasets.

 Move the hiveql folder:
 ```
 cd hiveql
 ```
 and start executing the ETL pipeline:
 ```
 # DATABASE PREPARATION
 # 1. Create the database
 hive -f create-db.sql
 # 2. Create table cities
 #    Important: edit the cities.sql file so to point to the right HDFS path.
 hive -f cities.sql
 # 3. Create table seasmograph stations
 #    Important: edit the seismograph-stations.sql file so to point to the right HDFS path.
 hive -f seismograph-stations.sql

  # ETL PIPELINE
 # 4. Create table earthquakes_full_dataset
 #    Important: edit the 1.sql file so to point to the right HDFS path.
 hive -f 1.sql
 # 5. Create table earthquakes with columns: id, time, day, latitude, longitude, magnitude
 hive -f 2.sql
 # 6. Create table earthquakes_distance_to_all_cities with a cross join
 #    Warning: Cartesian join - compute intensive task.
 hive -f 3.sql
 # 7. Create table earthquakes_closest_city inner join
 hive -f 4.sql
 # 8. Create table earthquakes_closest_city_distance_to_all_stations cross join
 #    Warning: Cartesian join - compute intensive task.
 hive -f 5.sql
 # 9. Create table earthquakes_closest_city_station inner join
 hive -f 6.sql
 # 10. Export table earthquakes_closest_city_station to HDFS
 #    Important: edit the export-to-hdfs.sql file so to point to the right HDFS path.
 hive -f export-to-hdfs.sql
 ```

 #### 5. Output data: Download data from HDFS and post-process them with Python.

 Now we need to create the Seismograph
 ```
 cd ../data
 # HDFS commands:
 # locate the CSV file created at step 10 of the ETL pipeline.
 hdfs dfs -ls /YOUR_HDFS_PATH
 # download the file file from the HDFS.
 hdfs dfs -get /YOUR_HDFS_PATH/earthquakes_closest_city_station.csv earthquakes_closest_city_station.csv
 # Make sure the fils is in the data folder.
 ls
 # Move to the scripts_python folder.
 cd ../scripts_python
 # Create the seismographs.
 python BuildSeismograph.py
 # Move to the data folder to see if the seismographs file is created.
 cd ../data
 ls # check for a file named as results.csv
 head results.csv # see a sample of the data
 # Upload the results to the HDFS
 # Command: hdfs dfs -put /"your_local_dir_path/file" /"your_hdfs_dir_path"
 # Sample commands:
 hdfs dfs -put /data/results.csv /earthquakes_portal
 # Warning: you must specify a valid HDFS path
 # Import the results to Hive
 # Important: edit the results.sql file so to point to the right HDFS path.
 cd ../hiveql
 hive -f results.sql
 ```
 ####  6. Further analysis:


 ##### Spark in memory data processing.
Apache Spark is a powerful technology that can be utilised to perform several computational task, from streaming to machine learning or even to run SQL queries.
This example demonstrates that we can use several technologies in our solution and also we can analyse our dataset with several perspectives.

Therefore, as an introduction to Spark will answer questions like:
* How many earthquakes there were for each month?
* How many earthquakes there were for each country?

Spark has two major releases Spark and Spark2.
For question one we use Spark and for question two we use Spark2.
```
cd ../scripts_spark
spark-submit earthquakes_per_mount.py
spark-submit earthquakes_per_year.py
```

##### Advanced research questions with Hive.
In this example demonstrates that we can further analyse the output of the ETL pipeline and every table created can provide information useful to our research.

For instance to find how many people are affected by an earthquake is required to query Hive table earthquakes_distance_to_all_cities
```
cd ../hiveql
hive -f earthquake-population.csv
```

 ##### Data visualisations with Tableau.
An important aspect of every big data solution is the visualisation of the data and the results of each analysis process.

Tableau is a well established tool that allow us to perform advanced analytics and create graphs and visualisations.
Also, Tableau enables the user to connect to several data sources, and Apache Hive is among them.

To this project Tableau is being used to create a world map that provides information related to the result of the ETL pipeline, e.g. closest city, linkk to the seismograph.

Tableau is a proprietary tool and requires a license to use.
Folder sample_tableau has a Tableau file that can be use as an example.
Sample visualisation in Tableau.

## Architecture

