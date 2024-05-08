# Use the official Python image for ARMv6 as a base image
FROM arm32v7/debian:bullseye-slim

# Instalar Rust y Cargo
RUN apt-get update && apt-get install -y curl gnupg
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Instalar las dependencias de Python
RUN apt-get install -y python3 python3-pip

# Instalar las dependencias de Python
RUN pip install --no-cache-dir fastapi uvicorn

# Establecer las variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el código fuente al contenedor
COPY . .

# Comando para ejecutar al iniciar el contenedor
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
