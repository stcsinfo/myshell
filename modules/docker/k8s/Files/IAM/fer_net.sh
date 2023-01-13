#!/bin/bash
mc admin policy remove pro ap001-bucket-policy
mc admin policy remove pro ap002-bucket-policy
mc admin policy remove pro ssi-bucket-policy
mc admin policy remove pro commvault-bucket-policy
mc rb pro/ap001
mc rb pro/ap002
mc rb pro/ssi
mc rb pro/commvault
rm -rf /home/ssi/llistat_buckets