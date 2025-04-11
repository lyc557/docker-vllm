
You: 

rocky服务器如何安装 conda

ChatGPT: 

在 Rocky Linux 服务器上安装 Conda（推荐使用 [Miniconda]() ，因为更轻量），可以按以下步骤操作。这个过程适用于 Rocky Linux 8/9，也同样适用于 RHEL、CentOS 等发行版。


---



### ✅ 步骤一：下载安装脚本 

选择你需要的 Python 版本（大多数情况建议用 `Miniconda3-latest`）：


```bash
# 进入 /tmp 目录下载
cd /tmp

# 下载 Miniconda 安装脚本（这里用的是 Python 3 的最新版）
curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```



---



### ✅ 步骤二：运行安装脚本 



```bash
bash Miniconda3-latest-Linux-x86_64.sh
```


然后按照提示操作：

 
- 按 Enter 查看许可协议
 
- 输入 `yes` 接受协议
 
- 选择安装路径（推荐默认路径，如：`/root/miniconda3` 或 `~/miniconda3`）
 
- 是否初始化 `conda`（建议输入 `yes`）



---



### ✅ 步骤三：激活 Conda 环境 


如果你选择初始化了 Conda，那么安装完成后，重新登录一次 shell 或运行：



```bash
source ~/.bashrc
```


如果你没选初始化，也可以手动执行：



```bash
source ~/miniconda3/etc/profile.d/conda.sh
conda activate
```



---



### ✅ 验证安装 



```bash
conda --version
```


输出应该像：



```nginx
conda 24.1.2
```



---



### ✅ 后续建议 

 
2. 更换 Conda 镜像源（默认的太慢）：



```bash
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
conda config --set show_channel_urls yes
```

 
2. 创建新环境（比如 Python 3.10）：



```bash
conda create -n myenv python=3.10
conda activate myenv
```



---



需要我帮你写个一键安装脚本或 Dockerfile 来封装安装流程吗？
