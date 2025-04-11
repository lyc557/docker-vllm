
You: 

如何在rocky9.5的服务器使用vllm部署qwq大模型，先不用docker部署

ChatGPT: 

在 **Rocky Linux 9.5**  上部署 **vLLM**  并运行类似 Qwen（QWQ）的大模型，**不使用 Docker** ，你需要按照如下流程操作。这里我会基于以下前提：
 
- 你已经装好显卡驱动（NVIDIA）；
 
- CUDA 和 cuDNN 环境正确；
 
- Python 环境已经可用（推荐 `conda` 或 `virtualenv`）；
 
- Qwen 模型从 Hugging Face 或本地可加载。



---



### 一、系统与驱动依赖检查 


#### 1. 确保 GPU 驱动和 CUDA 安装无误 



```bash
nvidia-smi
```


如果你能看到 GPU 信息，说明驱动和 CUDA 安装没问题。


vLLM 目前支持的 CUDA 和 PyTorch 要求如下（2024.04）：

 
- CUDA 11.8+
 
- PyTorch >= 2.1
 
- Python >= 3.8



---



### 二、安装 Python 环境 

1. 创建虚拟环境（推荐 `conda`）


```bash
conda create -n vllm-env python=3.10 -y
conda activate vllm-env
```



---



### 三、安装 vLLM 和其依赖 


#### 1. 安装 PyTorch（确保是 GPU 版本） 



```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
```


#### 2. 安装 vLLM 



```bash
pip install vllm
```


#### 3. 安装其他可能需要的依赖（特别是 transformers 和 accelerate） 



```bash
pip install transformers accelerate
```



---



### 四、下载 Qwen 模型（假设你用的是 Qwen/Qwen-7B） 


#### 方法 1：从 Hugging Face 加载（需联网） 



```bash
python3 -m vllm.entrypoints.openai.api_server \
    --model Qwen/Qwen-7B \
    --tokenizer Qwen/Qwen-7B
```


#### 方法 2：使用本地模型 

比如你把模型下载在 `/data/models/Qwen-7B`


```bash
python3 -m vllm.entrypoints.openai.api_server \
    --model /data/models/Qwen-7B \
    --tokenizer /data/models/Qwen-7B
```



---



### 五、测试 API 

vLLM 默认会启动一个 OpenAI 接口兼容的服务在 `http://localhost:8000/v1/completions`。
你可以用 `curl` 测试：


```bash
curl http://localhost:8000/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "Qwen-7B",
    "prompt": "世界上最高的山是？",
    "max_tokens": 50
  }'
```



---



### 六、常见问题 

| 问题 | 可能原因 | 
| --- | --- | 
| CUDA out of memory | 模型太大，显存不足，尝试更小的模型如 Qwen-1.5-1.8B | 
| libcuda.so not found | 没装 NVIDIA 驱动或未配置环境变量 | 
| ImportError: No module named 'vllm' | 虚拟环境未激活或未安装 vllm | 



---



### 七、优化建议（根据显卡资源） 

 
2. 使用 `--tensor-parallel-size` 进行并行（多卡机器时）；
 
4. 设置 `--max-model-len` 限制最大上下文长度；
 
6. 调整 `--gpu-memory-utilization` 控制显存使用比例（默认 0.90）。



---



如果你告诉我具体用哪个 Qwen 模型（7B、14B、1.5 系列？）和服务器的显卡型号，我可以更有针对性地给出启动参数建议。是否要加一个前端界面或 REST 服务封装也可以一起做。
