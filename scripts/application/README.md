# rabbda-earthquakes-portal

## Introduction
This is a proof of concept application that aims to demonstrate how Big Data can be used to create complex Big Data solutions.
Additionally, by implementing various releases, we present how a project evolves through multiple iterations.

This demonstration utilises earthquakes data, source: [USGS science for a changing world](https://earthquake.usgs.gov).

USGS provides a [Rest API](https://earthquake.usgs.gov/fdsnws/event/1/) which will be using to request earthquakes data.
Sample request in csv format: [earthquakes](https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=2020-02-18T00:00:00.000Z&endtime=2020-02-19T00:00:00.000)

To more detail, static data for cities and seismograph stations are being associated with earthquakes data acquired from the Rest API. The result of this process produces information such as earthquakes closest cities and seismographic stations, and links to seismographs.


__RABBDA project:__

RABBDA (Reduce Access Barriers to Big Data Analytics) is created by the [Centre of Parallel Computing](https://www.westminster.ac.uk/research/groups-and-centres/centre-for-parallel-computing) - University of Westminster.

The project objective is to provide students and practitioners access to Big Data technologies and learning material. The earthquakes portal is designed to serve RABBDA project as an illustration on how to utilise Big Data technologies so to build complex architectures.

RABBDA is the first attempt to merge a Science Gateway with a KREL (knowledge repository and learning), called [SMARTEST](https://smartest-repo.herokuapp.com/) to facilitate the comprehension of the various aspects of the portal.
For more information, please review RABBDA [here](https://rabbda.readthedocs.io/).

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


 __Keywords:__ Big Data, Hadoop, HDFS, Hive, Spark, Rest API, Tableau, Python, Shell.

 ### Release:1.0
This release extends Release-0 by creating a workflow  that automates the various steps, from data  acquisition to Hive queries.
Also, introduces some advanced concepts of Hive.

From architecture's point of view, the application does the same as release-0,
utilises a Hive ETL pipeline (Extract-Transform-Load) that joins data from different sources,
and provides answers to complex research questions.

The following steps are being automated by the application:
 1. Data acquisition: Request data from a Rest API.
 2. Data preparation: Pre-process data with Python.
 3. Data ingestion: Upload data to HDFS.
 4. ETL pipeline: Execute Hive queries to transform and join the data.
 5. ETL pipeline results: Execute Hive query to create seismograph URLs.

To more detail, the application performs the above 5 steps by utilising thrree components:
 1. __orchestration component__ - reads the configuration file and passes control to the other components to perform their tasks.
 2. __earthquakes-history component__ - takes as input parameters like years and magnitude to perform steps 1-3.
 3. __hive-ETl-pipeline component__ -  takes as input parameters like HDFS path to perform step 4-5.

 Additionally, you can perform further analysis, like we did in Release-0.
 In this release we do this through a Jupyter Notebook.

 __Keywords:__ Big Data, Hadoop, HDFS, Hive, Rest API, Python, Jupyter Notebooks.