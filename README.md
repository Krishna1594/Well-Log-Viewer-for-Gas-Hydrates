# Well Log Viewer 
This repository contains various versions of the 'Well Log Viewer".  The intention of these tools is to utilize them in well-log interpretation and evaluation of formations quickly at the same time remembering the calculations, theory and pertinent assumptions behind the each tool. Please refer to the report.
## Table of Contents
[Introduction](#Introduction)

[Importing the recorded data](#Importing-the-recorded-Data)

### Installation and Running the codes
Please note that the following codes are written in MATLAB (.m) files and can be loaded through matlab software installed in your computer.
### Usage
These can be used to generate well logs for various types of data storage formats and are strictly structural based record of the data in a log file. These codes can also be used to import, read, analyze and categorize the data depending on the type of data format (for example, for excel '.csv' and for text/ASCII files '.txt' or '.las'.) in any new tool. A very quick way and easy than searching for 'import' button.
### Introduction
A service company has its own format of recording and storing data. The data is either stored in '.las' file format or '.xlsx','.xlsm' format. Sometimes companies also store the raw data in log-ASCII format but as a separate file for each loging tool or sonde. The data in the file can be in a structured manner or unstructured manner. Analyzing the data recorded/stored in a structured manner is a bit easy as a trend can be deduced but, it is tedious for the unstructured data. Identifying a trend or the the way the data is stored or written into a file is important. 
A user-friendly interface was created in MATLAB that can read, analyse and generate the well logs from the well log data recorded at drill site- “Well Log Viewer”. Depending on the type of file format, user can select the file type and import the data.
### Importing the well logs

> **Note: In MATLAB, a well log viewer was developed to analyze the Gas Hydrate formations.**

The well logs were available in the form of .las and .csv file formats and were imported into MATLAB workspace using an U/I; user will be asked to choosee the file during the analysis at appropriate steps.  
