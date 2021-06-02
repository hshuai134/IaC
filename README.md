## 使用说明

该样板间用来创建三台ecs云服务器，并为其挂载公网弹性IP。

该样本间会创建如下资源:
- vpc专有网络。
- 交换机。
- 安全组以及安全组规则。
- 三台阿里云云服务器（无公网ip）
- 弹性公网ip，并分别挂载到三台ecs云服务器上。

### 参考
关于阿里云更多terraform支持资源，请参考其官方文档 [Refer to details](https://github.com/aliyun/terraform-provider-alicloud)
