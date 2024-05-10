# Usa la imagen base de Raspberry Pi OS
FROM --platform=linux/arm/v6 raspbian/raspbian:buster

# Instala Python 3.9 y otras dependencias
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.9 \
    python3-pip \
    build-essential \
    curl \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Configura Python 3.9 como predeterminado
RUN ln -s /usr/bin/python3.9 /usr/bin/python

# Instala Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Configura el PATH para Cargo
ENV PATH="/root/.cargo/bin:${PATH}"

# Crea el directorio de la aplicación
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY . /app

# Instala las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8000

# Comando para iniciar la aplicación FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]