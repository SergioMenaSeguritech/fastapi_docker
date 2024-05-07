# Use Alpine Linux as a base image
FROM arm32v6/alpine:latest

# Install dependencies
RUN apk update && \
    apk add --no-cache python3 python3-dev py3-pip build-base

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Upgrade pip
RUN pip3 install --upgrade pip

# Set the working directory in the container
WORKDIR /app

# Copy the dependencies file to the working directory
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install -r requirements.txt

# Copy the content of the local src directory to the working directory
COPY . .

# Command to run on container start
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
