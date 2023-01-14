#!/bin/sh
cd '/cloudiac/workspace/code/alicloud-cloudiac' && \

cd '/cloudiac/workspace/code/alicloud-cloudiac' && \
terraform plan -input=false -out=_cloudiac.tfplan \
-var-file=v1.3.tfvars -var-file=../../_cloudiac.tfvars.json \
-destroy && \
terraform show -no-color -json _cloudiac.tfplan >../../tfplan.json