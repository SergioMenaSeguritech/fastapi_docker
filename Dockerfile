# Usa la imagen base de Alpine Linux para ARM v6
FROM arm32v6/alpine:3.14

# Instala las dependencias necesarias
RUN apk add --no-cache \
    bash \
    curl \
    openssl-dev \
    libffi-dev \
    build-base \
    python3-dev \
    py3-pip \
    musl-dev

# Descarga e instala Rust para ARM v6
RUN curl -LO https://static.rust-lang.org/dist/rust-1.69.0-arm-unknown-linux-gnueabihf.tar.gz && \
    tar xzf rust-1.69.0-arm-unknown-linux-gnueabihf.tar.gz && \
    rm rust-1.69.0-arm-unknown-linux-gnueabihf.tar.gz

# Configura el PATH para Cargo
ENV PATH="/rust-1.69.0-arm-unknown-linux-gnueabihf/cargo/bin:${PATH}"

# Crea el directorio de la aplicación
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY . /app/

# Instala las dependencias de Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8000

# Comando para iniciar la aplicación FastAPI
CMD ["python", "main.py"]