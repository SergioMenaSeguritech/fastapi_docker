# Usa una imagen base compatible con la arquitectura de Raspberry Pi 1 (armv6)
FROM arm32v7/python:3.11.9-slim-bookworm

# Instala las dependencias necesarias
# Instala Rust y Cargo desde la imagen arm32v7/rust
RUN apt-get update && \
    apt-get install -y \
        curl \
        build-essential \
        libssl-dev \
        libffi-dev \
        cargo \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


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
