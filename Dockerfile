# 基于 NVIDIA CUDA 镜像（假设你要运行 PyTorch 和 vLLM）
FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    curl \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /workspace

# 安装 PyTorch（使用 CUDA 12.1 版本）
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# 安装 vLLM 和 transformers
RUN pip3 install vllm transformers accelerate sentencepiece

# 复制本地代码到容器
COPY . /workspace

# 设置默认命令为启动 bash
CMD ["bash"]
