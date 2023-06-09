--Crear Base de Datos
CREATE DATABASE ExamenABD

USE [ExamenABD]
GO

CREATE TABLE PROVEEDORES (
  PROV_ID int PRIMARY KEY,
  PROV_NOM varchar(50),
  PROVOFRECE_PROD bit
 -- Si no ofrece productos entonces llega a encargar y cada encargo se agrega a la tabla de pendientes
);

CREATE TABLE PRODUCTOS (
	PROD_ID int PRIMARY KEY,
	PROD_NOM varchar(50),
	PRODPROV_ID int FOREIGN KEY REFERENCES PROVEEDORES(PROV_ID),
	PRODPRECIO_INICIAL float,
	PRODPROV_PRECIO bit,
	PRODPRECIO_TOTAL float,
	PRODCANT int,
        PROD_ESTADO bit
    -- el estado indica si el producto se sigue vendiendo
	-- cantidad se actualiza con cada venta, despues de completar un pendiente, o registrar producto para la casa
    -- el calculo del precio se realizaria desde el frontend antes de mandar los datos a la base de datos
);

CREATE TABLE PENDIENTES (
	PEND_ID int PRIMARY KEY,
	PENDPROV_ID int FOREIGN KEY REFERENCES PROVEEDORES(PROV_ID),
	PENDFECHA_ENTREGA date,
        PEND_ESTADO bit,
	PENDTOTAL float
    -- pend estado para confirmar si el pendiente se completo o no
    -- al actualizar el estado del pendiente se actualiza la tabla productos desde el frontend
);

CREATE TABLE PENDIENTEDETALLES (
	PENDET_ID int FOREIGN KEY REFERENCES PENDIENTES(PEND_ID),
	PENDET_PROD_ID int FOREIGN KEY REFERENCES PRODUCTOS(PROD_ID),
	PENDET_CANT int,
	PENDET_VALOR float,
	PENDET_TOTAL float
);

CREATE TABLE HORARIO (
	TURNO_ID int PRIMARY KEY,
	TURNO_TIPO varchar(50),
	TURNO_TOTALHR int
);

CREATE TABLE EMPLEADOS (
	EMP_ID int PRIMARY KEY,
	EMP_NOM varchar(50),
        EMP_APELLIDO varchar(50),
	EMP_NACIMIENTO date,
	EMP_ESTADO bit,
	EMP_TURNO int FOREIGN KEY REFERENCES HORARIO(TURNO_ID) 
);

CREATE TABLE CLIENTES (
	CLIENTE_ID int PRIMARY KEY,
	CLIENTE_NOM varchar(50),
    CLIENTE_APELLIDO varchar(50),
	CLIENTE_TELEFONO int,
	CLIENTE_DEUDA float
);

CREATE TABLE CREDITOS (
	CRED_CLIENTEID int FOREIGN KEY REFERENCES CLIENTES(CLIENTE_ID),
	CRED_ABONO float,
	CRED_FECHA date
);

CREATE TABLE VENTASMAESTRO (
	VENTA_ID int PRIMARY KEY,
	VENTA_EMPID int FOREIGN KEY REFERENCES EMPLEADOS(EMP_ID),
	VENTA_FECHA date,
	VENTA_TOTAL float,
	VENTA_TURNO int FOREIGN KEY REFERENCES HORARIO(TURNO_ID)
);

CREATE TABLE VENTASDETALLE (
	VENTADET_ID int  FOREIGN KEY REFERENCES VENTASMAESTRO(VENTA_ID),
	VENTADET_PRODID int FOREIGN KEY REFERENCES PRODUCTOS(PROD_ID),
	VENTADET_FECHA date,
	VENTADET_CANT int,
	VENTA_TOTAL float
);

CREATE TABLE GASTOS (
	GASTO_ID int,
	GASTO_DESC varchar(50),
	GASTO_TOTAL float,
	GASTO_TIPO varchar(50),
	GASTO_FECHA date
);

CREATE TABLE PROD_CASA (
	CASAPROD_ID int FOREIGN KEY REFERENCES PRODUCTOS(PROD_ID),
	CASA_CANT int,
	CASA_VALOR float,
	CASA_TOTAL float,
	CASA_FECHA date
);
