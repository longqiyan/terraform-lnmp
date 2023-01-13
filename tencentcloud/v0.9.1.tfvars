#images
cloud_glide_record_image = "registry-vpc.cn-hangzhou.aliyuncs.com/idcos-cloudcmp/cloud-glide-record-api:0.9.1-SNAPSHOT_stag_b.1920"
cloud_glide_workflow_image = "registry-vpc.cn-hangzhou.aliyuncs.com/idcos-cloudcmp/cloud-glide-workflow:0.9.1-SNAPSHOT_stag_b.73"
cloud_glide_web_image = "registry-vpc.cn-hangzhou.aliyuncs.com/idcos-cloudcmp/cloud-glide-web:0.9.1_stag_b.1043"
cloud_jet_schedule_job_image = "registry-vpc.cn-hangzhou.aliyuncs.com/idcos-cloudcmp/cloud_jet_schedule_job:2.3.0_dev"


#lego version
cloudlego_version = "v0.9.1"

#公网访问下载
#1，登陆
#docker login registry.cn-hangzhou.aliyuncs.com
#2，移除image中'-vpc'字样

#2，然后用移除'-vpc'之后的路径pull这四个镜像