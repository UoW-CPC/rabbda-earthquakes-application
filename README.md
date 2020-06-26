# rabbda-earthquakes-portal

## Introduction
This is a proof of concept application that aims to demonstrate how Big Data can be used to create complex Big Data solutions.
Additionally, by implementing various releases, we present how a project evolves through multiple iterations.

For instance, in case you have reviewed and tried [Release-0](https://github.com/UoW-CPC/rabbda-earthquakes-portal/tree/release-0.0),
you might have noticed that it is required to perform all steps manually.
Release-1 tries to automate this for you, the only requirement here is to work with a configuration file and start the application.

__RABBDA project:__

RABBDA (Reduce Access Barriers to Big Data Analytics) is created by the [Centre of Parallel Computing](https://www.westminster.ac.uk/research/groups-and-centres/centre-for-parallel-computing) - University of Westminster.

The project objective is to provide students and practitioners access to Big Data technologies and learning material. The earthquakes portal is designed to serve RABBDA project as an illustration on how to utilise Big Data technologies so to build complex architectures.

RABBDA is the first attempt to merge a Science Gateway with a KREL (knowledge repository and learning), called [SMARTEST](https://smartest-repo.herokuapp.com/) to facilitate the comprehension of the various aspects of the portal.
For more information, please review RABBDA [here](https://rabbda.readthedocs.io/).

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

This demonstration utilises earthquakes data, source: [USGS science for a changing world](https://earthquake.usgs.gov).

USGS provides a [Rest API](https://earthquake.usgs.gov/fdsnws/event/1/) which will be using to request earthquakes data.
Sample request in csv format: [earthquakes](https://earthquake.usgs.gov/fdsnws/event/1/query?format=csv&starttime=2020-02-18T00:00:00.000Z&endtime=2020-02-19T00:00:00.000)

To more detail, static data for cities and seismograph stations are being associated with earthquakes data acquired from the Rest API. The result of this process produces information such as earthquakes closest cities and seismographic stations, and links to seismographs.

 __Keywords:__ Big Data, Hadoop, HDFS, Hive, Rest API, Python, Jupyter Notebooks.


 ## Getting started
The following instruction guides you on how to set up the project on your Hadoop environment.

 ### Download the repository
 The initial step is to download the repository in your Hadoop machine. To do so, in terminal run the following command:
 ```
 git clone --single-branch --branch release-1.0 https://github.com/UoW-CPC/rabbda-earthquakes-portal.git
 ```
 This command clones specifically release-1.0 branch.

 ### Running the application
 Having download the repository you can now run the application and perform all the 5 phases mentioned in the introduction section.

 First move to the working directory by executing the command:
 ```
 cd rabbda-earthquakes-portal
```

 Now execute the command:
 ```
 ls
 ```
 There you can see four folders and four files:
  * __conf__ - folder - contains application's configuration file.
  * __data__ - folder - contains all application's data.
    * __earthquakes-history__ - folder - contains earthquakes related data, and a database with information about previous data acquisitions.
    * __hive-etl-pipeline__ - folder - contains datasets for cities and seismograph station, and a database with information about the Hive database creation.
  * __logs__ - folder - contains logs files, one for each three components.
  * __scripts__ - folder - contains the scripts for the various application components.
    * __application__ - folder - contains the scripts for the orchestration component.
    * __earthquakes_history__ - folder - contains the scripts for the earthquakes-history component.
    * __hive_etl_pipeline__ - folder - contains the scripts for the hive-ETl-pipeline component.
    * __hive_ql__ - folder - contains the Hive queries used by the ETL pipeline.
  * __earthquakes-portal-release-1.ppt__ - file - slides with material related to this release, e.g. architecture, results.
  * __earthquakes-portal-release-1-results.ipynb__ - a Jupyter notebook that analyse the results of the ETL pipeline.
  * __README.md__ - file - project information and instructions on how to use the application.
  * __requirements.txt__ - file - Python libraries used by this application.


This application is build to run with Hortonworks Data Platform (HDP) 2.6.5, please download HDP [here](https://www.cloudera.com/downloads/hortonworks-sandbox/hdp.html).

HDP-2.6.5 comes with Python 2.7 pre-installed; therefore, this Python version is being used for our scripts.

Before we start executing the several phases of the application, it is required to install some Python libraries, to do so run the following:
 ```
 sudo pip install -r requirements.txt
 ```
In case pip is not installed, run the following to install it:
```
sudo yum install python-pip
```

__Tip:__ changing directories with terminal commands.
 ```
 ls             #list all folders and files
 cd folder_name #move to folder
 cd ..          #move to parent folder
 pwd            #print working directory
 ```
 #### Now we are ready to go through the various phases:

 #### Edit the configuration file
Move to the conf folder to edit the configuration file:
```
cd conf
# list all file
ls
# view the content of the file
cat earthquakes-application.yaml
```
Edit configuration file according to your requirements. This files allows you to define 6 parameters:
1. hdfs-path: set the path that application's data will be stored.
2. download-list-of-years: define a list of years to request, e.g. 2010,2015,2016.
3. download-group-of-years: define a range of years to request, e.g. 2010 to 2012.
4. download-magnitude-over: set magnitude values to request.
5. download-again-historical-data: in case you want to request again earthquakes data that have been request in the past you mus set this value to True.
6. hive-drop-all-tables: clean all hive tables before executing the ETL pipeline [experimental - not fully implemented].

__Important:__ You must define only one of the options 2 and 3.

Having set the required values in the confugiration file move back to the parent folder:
```
cd..
```
#### Start the application

```
cd scripts/application
python start_application.py
```
When you perform this action the application will start running,
open another terminal and move to the directories data and logs to monitor the various phases.

To more detail you can check the following files:
1. __application.log:__ contains information about the various execution phases of the orchestration component.
2. __earthquakes-history.log:__ contains information about the data acquisition and preparation phases.
3. __earthquakes-history:__ folder under the data folder which contains the requested data,
plus a database with all previous requests.
4. __hive-etl-pipeline.log:__ contains information about the ETL pipeline, e.g. Hive logs.
5. __hive-etl-pipeline:__ folder under the data folder which contains static data for cities and seismograph-stations,
plus a database from which the pipeline decides if it must create the Hive database, tables, and upload static data.

__Warning:__ This process is time consuming and resource intensive. Therefore be patient and be careful how many data you want to process.

#### Data visualisations with Jupyter
An important aspect of every big data solution is the visualisation of the data and the results of each analysis process.

Jupyter Notebooks is a well established data  analytics solutions that allow us to perform advanced analytics and create graphs, visualisations.
Also, Jupyter enables the user to interactively operate with various technologies, in our case we interact with Hive.

In this project Jupyter is being used to query Hive and review the results of the  ETL  pipeline, e.g. closest city, link to the seismograph.

Jupyter is an source tool, free to use. The most common installation is by using [Anaconda](https://www.anaconda.com/).
You can install Anaconda and work with the Notebook earthquakes-portal-release-1-results.ipynb to analyse your own results.

In case you only need to review our sample results click [here](https://github.com/UoW-CPC/rabbda-earthquakes-portal/blob/release-1.0/earthquakes-portal-release-1-results.ipynb).

## Demo completion

 You have now completed this demo, please review the presentation 'earthquakes-portal-release-1.pptx' to understand architecture and functionality of the application.

 ### Clean Data

You can clean the data from Hive by dropping the Database and its content:
```
hive -e 'DROP DATABASE IF EXISTS earthquakes CASCADE;'
```

Also, to  delete application related  data, remove the  following files:
* Under folder data/earthquakes-history remove all CSV files and history_db.json.
* Under folder data/hive-etl-pipeline remove  the pipeline_db.json.
* under folder logs remove all .log  files.

 ### Further development
As a next step you can try extending this application by importing real time data to your system.
1. To see how you can import earthquakes real-time data to HDFS by utilising Apache Flume review [here](https://github.com/UoW-CPC/rabbda-earthquakes-realtime).
2. To see how you can import real-time twitter data by utilising Apache Kafka review [here](https://github.com/UoW-CPC/rabbda-kafka-twitter).