# roles 介绍
该 roles 可以在 rhel/centos 操作系统上安装 nginx 服务，支持1.14.2、1.16.1、1.22.0三个版本。  

使用方法：
如果使用该 roles ，需要对 tasks 步骤涉及的变量进行赋值。  
- SoftwareIp:                  # 存放 nginx 软件介质的服务器ip  
- SoftwarePath:                # nginx 软件介质在服务器的路径  
- nginxVersion:                # nginx版本  
- servicePort:                 # nginx服务端口  
- pidPath:                     # pid文件路径  
- Process:                     # 运行进程数  
- rootPath:                    # nginx站点根目录  
- maxConnections:              # 最大连接数  
- userPassword:                # nginx管理用户密码  

该 roles 安装 nginx 依赖开发环境，因此需要配置基础 yum 仓库，您可以在 playbook 的 pre_tasks 中添加以下任务：  
  pre_tasks:  
    - name: 配置nginx yum仓库  
      yum_repository:  
        name: nginx-base  
        description: nginx base repo  
        baseurl: "{{ SoftwareServerIpPath }}/packages"  
        enabled: yes  
        gpgcheck: no  
        
示例剧本:  
```
---  
- name: install Nginx
  hosts: nginx
  gather_facts: no
  vars:
    - SoftwareIp: "{{ software_ip }}"
    - SoftwarePath: "{{ software_nginx_path }}"
    - SoftwareServerIpPath: http://{{ SoftwareIp }}/{{ SoftwarePath }}
    - nginxVersion: "{{ nginx_version }}"
    - servicePort: "{{ service_port }}"
    - pidPath: "{{ pid_path }}"
    - Process: "{{ process }}"
    - rootPath: "{{ root_path }}"
    - maxConnections: "{{ max_connections }}"
    - userPassword: "{{ user_password }}"
  pre_tasks:
    - name: 配置nginx yum仓库
      yum_repository:
        name: nginx-base
        description: nginx base repo
        baseurl: "{{ SoftwareServerIpPath }}/packages"
        enabled: yes
        gpgcheck: no
  roles:
    - role: nginx
```