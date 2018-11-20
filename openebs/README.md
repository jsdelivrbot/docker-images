1.宿主机安装open-iscsi
Debian/Ubuntu
apt-get install open-iscsi
Centos
yum -y install iscsi-initiator-utils
systemctl enable iscsid
systemctl start iscsid
2.使用Operator运行OpenEBS服务
kubectl apply -f openebs-operator.yaml
3.使用默认或自定义的storageclass
kubectl apply -f openebs-storageclasses.yaml
4.使用OpenEBS官方文档中的[示例]()，安装Jenkins测试
kubectl apply -f jenkins.yml
