# Use an ARM-compatible base image
FROM arm32v6/python:3.9-slim

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Install Rust and Cargo
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly && \
    $HOME/.cargo/bin/rustup target add armv6-unknown-linux-gnueabihf && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install Python dependencies
RUN pip install -r requirements.txt

# Copy the content of the local src directory to the working directory
COPY . .

# Command to run on container start
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
