FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    wget \
    git \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 安装 Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# 设置环境变量
ENV PATH="/opt/conda/bin:${PATH}"

# 创建并激活环境
RUN conda create -n vllm python=3.10 -y
SHELL ["conda", "run", "-n", "vllm", "/bin/bash", "-c"]

# 安装 PyTorch
RUN conda install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia -y

# 安装 vLLM 和其他依赖
RUN conda install -c conda-forge transformers accelerate sentencepiece -y
RUN pip install vllm

WORKDIR /workspace

# 设置默认命令
CMD ["conda", "run", "--no-capture-output", "-n", "vllm", "bash"]