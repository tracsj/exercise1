
#!/bin/bash
# This script loads Hospital care data for Week 4 of w205 project
# 

# Shell into AWS
# ssh -i ~/Downloads/205_key.pem root@ec2-52-23-170-66.compute-1.amazonaws.com

echo "Loading data lake for w205 medicare project"

#Make directory to save data, -p creates necessary parent directories
mkdir -p /user/root/hospital_compare
cd /user/root/hospital_compare/

#Get flat file from URL, and -P specifies location to place file
# -O renames the file to something more pallatable
FILE_URL="https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"
wget   $FILE_URL -O hospital_data.zip

#mv hospital_data.zip /user/root/hospital_compare/
echo file downloaded and renamed 

# Check file downloaded correctly
ls - l 


# Unzip file
unzip hospital_data.zip -d unzipped
ls 
echo file unzipped

#Strip spaces from file names
IFS="\n"
for file in unzipped/*.csv;
do
    mv "$file" "${file//[[:space:]]}"
done
echo file names spaces removed


mv unzipped/HospitalGeneralInformation.csv hospitals.csv
mv unzipped/TimelyandEffectiveCare-Hospital.csv effective_care.csv
mv unzipped/ReadmissionsandDeaths-Hospital.csv readmissions.csv
mv unzipped/MeasureDates.csv measures.csv
mv unzipped/hvbp_hcahps_05_28_2015.csv surveys_responses.csv
echo Important files moved and renamed


#remove headers
rm -r no_header_tables; mkdir no_header_tables
for file in *.csv;
do
   tail -n +2 "$file" > "no_header_tables/$file"
done
echo header removed

cd no_header_tables


#Create hadoop Directory
hadoop fs -mkdir /hdfs

#Place all files into HDFS
hadoop fs -put * /hdfs

#Check
hadoop fs -ls /hdfs

echo Files loaded into HDFS

#scp -i ~/Downloads/205_key.pem  ~/Documents/git/exercise1/loading_and_modeling/load_data_lake.sh  root@ec2-52-23-170-66.compute-1.amazonaws.com:/root
#scp -i ~/Downloads/205_key.pem  ~/Documents/git/exercise1/loading_and_modeling/hive_base_ddl.sql root@ec2-52-23-170-66.compute-1.amazonaws.com:/user/root/hospital_compare
 

hive –f hive_base_ddl.sql

