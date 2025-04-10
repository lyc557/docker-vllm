## Docker Hub 镜像拉取问题
Docker Hub 本身可能遇到临时问题，导致无法拉取镜像。你可以尝试以下方法：

使用 Docker Hub 镜像加速器
如果你在中国，Docker Hub 的访问可能较慢或不稳定。你可以使用国内的 Docker 镜像加速器来加速拉取镜像。常见的加速器包括：

阿里云加速器：

``` bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://<your-aliyun-key>.mirror.aliyuncs.com"]
}
```

Docker 官方加速器（如果你在中国境内）：

``` bash
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://registry.docker-cn.com"]
}
``` 
然后重启 Docker 服务：

``` bash
sudo systemctl restart docker
```
再试一次构建镜像。