ARG CUDA_VERSION=12.4.1
FROM nvidia/cuda:${CUDA_VERSION}-devel-ubuntu20.04 AS base

# Set working directory
WORKDIR /

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    nodejs \
    npm \
    && npm install -g node@latest \
    && npm install -g yarn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements (assuming there's a requirements.txt file in the project)
COPY . .

# Set up Python environment
RUN python -m venv .venv \
    && . .venv/bin/activate \
    && pip install --upgrade pip

# Expose ports for the web interface and swarm communication
EXPOSE 3000 8080

# Command to run the swarm
CMD ["bash", "./run_rl_swarm.sh"]
