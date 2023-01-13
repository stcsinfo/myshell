#!/bin/bash
echo "Copia estructura buckets"
mkdir /home/ssi/buckets
cp -rfv /mnt/IAM/ap001 /home/ssi/buckets
cp -rfv /mnt/IAM/ap002 /home/ssi/buckets
cp -rfv /mnt/IAM/commvault /home/ssi/buckets
cp -rfv /mnt/IAM/ssi /home/ssi/buckets
dos2unix /home/ssi/buckets/**/*
ls /home/ssi/buckets >> /home/ssi/llistat_buckets
echo "Els buckets son els següents"
cat /home/ssi/llistat_buckets