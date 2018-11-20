1.宿主机安装open-iscsi
Debian/Ubuntu
apt-get install open-iscsi
systemctl enable open-iscsi
systemctl start open-iscsi
Centos
yum -y install iscsi-initiator-utils
systemctl enable iscsid
systemctl start iscsid

2.使用Operator运行OpenEBS服务
宿主机数据存储目录: /var/openebs
kubectl apply -f openebs-operator.yaml

3.使用默认或自定义的storageclass
kubectl apply -f openebs-storageclasses.yaml
