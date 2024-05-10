# Usa la imagen base de Alpine Linux para ARM v6
FROM arm32v6/alpine:3.14

# Instala bash y otras dependencias
RUN apk add --no-cache \
    bash \
    python3 \
    py3-pip \
    build-base \
    curl \
    openssl-dev

# Instala Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Configura el PATH para Cargo
ENV PATH="/root/.cargo/bin:${PATH}"

# Crea el directorio de la aplicación
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY . /app

# Instala las dependencias de Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8000

# Comando para iniciar la aplicación FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]