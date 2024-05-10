# Etapa 1: Instalación de Rust
FROM mdirkse/rust_armv6:latest as rust_builder

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY . /app

# Instala las dependencias de Rust si es necesario
# Ejemplo:
# RUN cargo build --release

# Etapa 2: Instalación de Python
FROM arm32v6/python:3.11-alpine

# Copia los archivos de la etapa anterior
COPY --from=rust_builder /app /app

# Instala las dependencias de Python si es necesario
# Ejemplo:
RUN pip install --no-cache-dir -r requirements.txt

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Comando para iniciar la aplicación
CMD ["python", "app.py"]
