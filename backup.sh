#! /bin/bash

if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

targetDirectory=$1
destinationDirectory=$2

currentTS=$(date +%s)

backupFileName="backup-$currentTS.tar.gz"


origAbsPath=$(pwd)


cd "$destinationDirectory"

destDirAbsPath=$(pwd)

cd "$targetDirectory"

yesterdayTS=$((currentTS - 24 * 60 * 60))
  


declare -a toBackup


for file in * 
do
  currentFileDate=$(date -r "$file" +%s)

  if [[ "$currentFileDate" -gt "$yesterdayTS" ]] 
  then
    toBackup+=($file)
    
   fi
done
  
tar -czvf "$backupFileName" "${toBackup[@]}"

mv "$backupFileName" "$destDirAbsPath"


