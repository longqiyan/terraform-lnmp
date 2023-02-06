#/bin/bash
export ANSIBLE_HOST_KEY_CHECKING="False"
export ANSIBLE_TF_DIR="."
export ANSIBLE_NOCOWS="1"

ansible-playbook \
--inventory /cloudiac/assets/terraform.py \
--user "root" \
--private-key "/cloudiac/workspace/ssh_key" \
--extra @/cloudiac/workspace/_cloudiac_play_vars.yml \
ansible/$1