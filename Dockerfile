# Usa una imagen base compatible con la arquitectura de Raspberry Pi 1 (armv6)
FROM arm32v6/python:3.11-alpine

# Instala las dependencias necesarias
RUN apk add --no-cache \
        curl \
        build-base \
        openssl-dev \
        libffi-dev \
        && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Agrega Rust al PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Establece las variables de entorno necesarias
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo de dependencias al directorio de trabajo
COPY requirements.txt .

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Copia el contenido del directorio fuente local al directorio de trabajo
COPY . .

# Comando para ejecutar al iniciar el contenedor
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
