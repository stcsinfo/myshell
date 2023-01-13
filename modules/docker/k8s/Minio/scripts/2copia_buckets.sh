#!/bin/bash
echo "Copia estructura buckets"
cp -rfv $CI_PROJECT_DIR/$DIR_MINIO/buckets/ /
dos2unix /buckets/**/*
ls /buckets >> /llistat_buckets
echo "Els buckets son els següents"
cat /llistat_buckets