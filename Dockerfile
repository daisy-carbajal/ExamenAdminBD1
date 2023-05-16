# ------------------------------ SQLExamen ---------------------------------------
# Imagen de Docker Hub
FROM mcr.microsoft.com/mssql/server:2022-CU3-ubuntu-20.04 AS SQLExamen

# Variables de entorno del contenedor
ENV MSSQL_SA_PASSWORD=david.17* ACCEPT_EULA=Y MSSQL_PID=Developer 

# Puerto SQL
EXPOSE 1433
