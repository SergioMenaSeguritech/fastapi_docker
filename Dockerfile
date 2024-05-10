# Etapa 1: Instalación de Rust, Python y Cargo
FROM arm32v6/alpine:3.14

# Instala Rust, Python, Cargo y cualquier otra dependencia necesaria
RUN apk update && \
    apk add --no-cache rust cargo

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY . /app

# Etapa 2: Instalación de Python
FROM arm32v6/python:3.11-alpine

# Copia los archivos de la etapa anterior
COPY --from=0 /app /app

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo requirements.txt si existe
COPY requirements.txt /app/requirements.txt

# Instala las dependencias de Python si es necesario
# Comprueba si el archivo requirements.txt existe antes de intentar instalar
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Comando para iniciar la aplicación
CMD ["python", "app.py"]
