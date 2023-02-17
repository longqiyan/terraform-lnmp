# Stack 介绍：
该 Stack 可以基于阿里云主机部署 Redis 软件。

# 版本特性：
可创建 RHEL/CentOS 操作系统
支持自定义虚拟机规格
支持部署 Redis 服务

# 配置参考
- region - 地区
 
- instance_name - 主机名称

- cpus - 实例CPU配置

- memory - 实例内存配置

- instance_password - 实例密码

为了安装和配置 Redis 服务，还必须设置以下变量：

- redis_version - Redis版本

- service_port - 服务端口

- user_password - Redis管理用户密码

只要设置了上述变量赋值，您应该可以使用阿里云进行ECS实例创建和 Redis 安装和配置。
在 CloudIaC 平台使用 Stack 请查阅：https://docs.cloudiac.org/exchange/install