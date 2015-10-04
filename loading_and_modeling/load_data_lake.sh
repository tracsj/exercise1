
#!/bin/bash
# This script loads Hospital care data for Week 4 of w205 project
# 

# Shell into AWS
# ssh -i ~/Downloads/205_key.pem root@ec2-54-86-141-109.compute-1.amazonaws.com


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
unzip hospital_data.zip
ls 
echo file unzipped

#Strip spaces from file names
IFS="\n"
for file in *.csv;
do
    mv "$file" "${file//[[:space:]]}"
done
echo file names spaces removed

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
