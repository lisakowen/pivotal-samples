#!/bin/bash 

# this script must be run from the sample_data/ directory

CURDIR=`pwd`
#echo "CURDIR is $CURDIR"
HDFS_BASEDIR="/retail_demo"

# clean up if previous load
echo "running: sudo -u hdfs hdfs -rm -r -skipTrash $HDFS_BASEDIR"
sudo -u hdfs hdfs dfs -rm -r -skipTrash $HDFS_BASEDIR

# create directory on hdfs
sudo -u hdfs hdfs dfs -mkdir $HDFS_BASEDIR

for file in $CURDIR/*.tsv.gz
do
  #echo "file is $file"
  basefile=$(basename $file)
  #echo "basefile is $basefile"
  dir=`echo $basefile | perl -ne 's/^(.+?)\..+$/$1/;print;'`
  #echo "dir is $dir"
  echo "sudo -u hdfs hdfs dfs -mkdir $HDFS_BASEDIR/$dir"
  sudo -u hdfs hdfs dfs -mkdir $HDFS_BASEDIR/$dir
  echo "sudo -u hdfs hdfs dfs -put $file $HDFS_BASEDIR/$dir/"
  sudo -u hdfs hdfs dfs -put $file $HDFS_BASEDIR/$dir/
done

