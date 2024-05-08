# Utiliza la imagen oficial de Python como imagen base
FROM python:3.9-slim

# Instala FastAPI y Uvicorn
RUN pip install fastapi uvicorn

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo requirements.txt al contenedor
COPY requirements.txt .

# Instala las dependencias desde requirements.txt
RUN pip install -r requirements.txt

# Copia el código de la aplicación al contenedor
COPY ./app /app

# Expone el puerto 80
EXPOSE 80

# Comando para ejecutar la aplicación con Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
