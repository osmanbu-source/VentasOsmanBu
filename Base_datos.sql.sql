DROP DATABASE IF EXISTS ventas;
CREATE DATABASE IF NOT EXISTS ventas;
USE ventas;
CREATE TABLE empresa(
    idempresa INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(900) NULL,
    rtn VARCHAR(20) NULL,
    telefono VARCHAR(15) NULL,
    correo VARCHAR(50) NULL,
    contacto VARCHAR(50) NULL,
    fecha_creacion DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_empresa PRIMARY KEY(idempresa)
);
CREATE TABLE sucursales(
    idsuc INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    sucursal VARCHAR(50) NULL,
    dirsuc VARCHAR(500) NULL,
    telefono VARCHAR(15) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_sucursales PRIMARY KEY(idsuc)
);
ALTER TABLE sucursales ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
CREATE TABLE proveedor(
    idprov INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    proveedor VARCHAR(100) NOT NULL,
    direccion VARCHAR(900) NULL,
    telefono VARCHAR(15) NULL,
    responsable VARCHAR(50) NULL,
    fecha_creacion DATE,
    observaciones VARCHAR(900) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_proveedor PRIMARY KEY(idprov)
);
ALTER TABLE proveedor ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
CREATE TABLE areas_trabajo(
    idarea INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    area VARCHAR(50) NULL,
    fecha_creacion DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_areas_trabajo PRIMARY KEY(idarea)
);
ALTER TABLE areas_trabajo ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE areas_trabajo ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
CREATE TABLE empleados(
    idemp INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    idarea INT NOT NULL,
    identidad VARCHAR(20) NULL,
    fecha_nac DATE,
    nombres VARCHAR(50) NULL,
    apellidos VARCHAR(50) NULL,
    femenino BIT,
    masculino BIT,
    soltero BIT,
    casado BIT,
    unionlibre BIT,
    direccion VARCHAR(900) NULL,
    fecha_creacion DATE,
    CONSTRAINT pk_empleados PRIMARY KEY(idemp)
);
ALTER TABLE empleados ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE empleados ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE empleados ADD FOREIGN KEY (idarea) REFERENCES areas_trabajo(idarea);
CREATE TABLE tipousuario(
    idtpusuario INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    tipo VARCHAR(50) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_tipousuario PRIMARY KEY(idtpusuario)
);
ALTER TABLE tipousuario ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
CREATE TABLE usuario(
    userid INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    idtpusuario INT NOT NULL,
    idemp INT NOT NULL,
    usuario VARCHAR(100) NOT NULL,
    clave VARCHAR(100) NULL,
    tipo VARCHAR(50) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_usuario PRIMARY KEY(userid)
);
ALTER TABLE usuario ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE usuario ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE usuario ADD FOREIGN KEY (idtpusuario) REFERENCES tipousuario(idtpusuario);
ALTER TABLE usuario ADD FOREIGN KEY (idemp) REFERENCES empleados(idemp);
CREATE TABLE clientes(
    num_clie INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    identidad VARCHAR(20) NULL,
    rtn VARCHAR(20) NULL,
    fecha_nac DATE,
    nombre VARCHAR(50) NULL,
    telefono VARCHAR(15) NULL,
    direccion VARCHAR(500) NULL,
    correo VARCHAR(50) NULL,
    fecha_creacion DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_clientes PRIMARY KEY(num_clie)
);
ALTER TABLE clientes ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE clientes ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
CREATE TABLE tipoproducto(
    idtpprod INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    tipo VARCHAR(50) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_tipoproducto PRIMARY KEY(idtpprod)
);
ALTER TABLE tipoproducto ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
CREATE TABLE producto(
    num_prod INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    idtpprod INT NOT NULL,
    descripcion VARCHAR(50) NULL,
    presentacion VARCHAR(50) NULL,
    marca VARCHAR(50) NULL,
    valor NUMERIC(10,2) NULL,
    precioventa NUMERIC(10,2) NULL,
    existencia NUMERIC(10) NULL,
    fecha_ingreso DATE,
    fecha_actualiza DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_producto PRIMARY KEY(num_prod)
);
ALTER TABLE producto ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE producto ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE producto ADD FOREIGN KEY (idtpprod) REFERENCES tipoproducto(idtpprod);

CREATE TABLE formapago(
    idfpago INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    formapago VARCHAR(50),
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_formapago PRIMARY KEY(idfpago)
);
ALTER TABLE formapago ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
CREATE TABLE encabezado_compra(
    num_compra INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    idprov INT NOT NULL,
    userid INT NOT NULL,
    idfpago INT NOT NULL,
    fecha_compra DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_encabezado_compra PRIMARY KEY(num_compra)
);
ALTER TABLE encabezado_compra ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE encabezado_compra ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE encabezado_compra ADD FOREIGN KEY (idprov) REFERENCES proveedor(idprov);
ALTER TABLE encabezado_compra ADD FOREIGN KEY (userid) REFERENCES usuario(userid);
ALTER TABLE encabezado_compra ADD FOREIGN KEY (idfpago) REFERENCES formapago(idfpago);

CREATE TABLE detalle_compra(
    iddetcomp INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    num_compra INT NOT NULL,
    num_prod INT NOT NULL,
    cantidad NUMERIC(10,0) NULL,
    precio NUMERIC(10,2) NULL,
    subtotal NUMERIC(10,2) NULL,
    isv NUMERIC(10,2) NULL,
    total NUMERIC(10,2) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT detalle_compra PRIMARY KEY(iddetcomp)
);
ALTER TABLE detalle_compra ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE detalle_compra ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE detalle_compra ADD FOREIGN KEY (num_compra) REFERENCES encabezado_compra(num_compra);
ALTER TABLE detalle_compra ADD FOREIGN KEY (num_prod) REFERENCES producto(num_prod);

CREATE TABLE encabezado_venta(
    num_venta INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    num_clie INT NOT NULL,
    userid INT NOT NULL,
    idfpago INT NOT NULL,
    fecha_venta DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_encabezado_venta PRIMARY KEY(num_venta)
);
ALTER TABLE encabezado_venta ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE encabezado_venta ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE encabezado_venta ADD FOREIGN KEY (userid) REFERENCES usuario(userid);
ALTER TABLE encabezado_venta ADD FOREIGN KEY (idfpago) REFERENCES formapago(idfpago);

CREATE TABLE detalleventa(
    iddetventa INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    num_clie INT NOT NULL,
    num_venta INT NOT NULL,
    num_prod INT NOT NULL,
    cantidad NUMERIC(10,0) NULL,
    precio NUMERIC(10,2) NULL,
    isv NUMERIC(10,2) NULL,
    descuento NUMERIC(10,2) NULL,
    total NUMERIC(10,2) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_detalleventa PRIMARY KEY(iddetventa)
);
ALTER TABLE detalleventa ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE detalleventa ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE detalleventa ADD FOREIGN KEY (num_clie) REFERENCES clientes(num_clie);
ALTER TABLE detalleventa ADD FOREIGN KEY (num_venta) REFERENCES encabezado_venta(num_venta);
ALTER TABLE detalleventa ADD FOREIGN KEY (num_prod) REFERENCES producto(num_prod);

CREATE TABLE cxcobrar(
    idcxc INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    num_venta INT NOT NULL,
    idsuc INT NOT NULL,
    num_clie INT NOT NULL,
    userid INT NOT NULL,
    idfpago INT NOT NULL,
    fecha_venta DATE,
    num_prod INT NOT NULL,
    cantidad NUMERIC(10,0) NULL,
    precio NUMERIC(10,2) NULL,
    isv NUMERIC(10,2) NULL,
    descuento NUMERIC(10,2) NULL,
    total NUMERIC(10,2) NULL,
    fecha_pago DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_cxcobrar PRIMARY KEY(idcxc)
);
ALTER TABLE cxcobrar ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE cxcobrar ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE cxcobrar ADD FOREIGN KEY (num_clie) REFERENCES clientes(num_clie);
ALTER TABLE cxcobrar ADD FOREIGN KEY (num_venta) REFERENCES encabezado_venta(num_venta);
ALTER TABLE cxcobrar ADD FOREIGN KEY (num_prod) REFERENCES producto(num_prod);
ALTER TABLE cxcobrar ADD FOREIGN KEY (idfpago) REFERENCES formapago(idfpago);
ALTER TABLE cxcobrar ADD FOREIGN KEY (userid) REFERENCES usuario(userid);

CREATE TABLE cxpagar(
    idcxp INT AUTO_INCREMENT NOT NULL,
    num_compra INT NOT NULL,
    idempresa INT NOT NULL,
    idsuc INT NOT NULL,
    idprov INT NOT NULL,
    userid INT NOT NULL,
    idfpago INT NOT NULL,
    fecha_compra DATE,
    num_prod INT NOT NULL,
    cantidad NUMERIC(10,0) NULL,
    precio NUMERIC(10,2) NULL,
    subtotal NUMERIC(10,2) NULL,
    isv NUMERIC(10,2) NULL,
    total NUMERIC(10,2) NULL,
    fecha_pago DATE,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_cxpagar PRIMARY KEY(idcxp)
);
ALTER TABLE cxpagar ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE cxpagar ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE cxpagar ADD FOREIGN KEY (idprov) REFERENCES proveedor(idprov);
ALTER TABLE cxpagar ADD FOREIGN KEY (userid) REFERENCES usuario(userid);
ALTER TABLE cxpagar ADD FOREIGN KEY (idfpago) REFERENCES formapago(idfpago);
ALTER TABLE cxpagar ADD FOREIGN KEY (num_prod) REFERENCES producto(num_prod);
ALTER TABLE cxpagar ADD FOREIGN KEY (num_compra) REFERENCES encabezado_compra(num_compra);

CREATE TABLE pagos(
    idpago INT AUTO_INCREMENT NOT NULL,
    idempresa INT NOT NULL,
    num_venta INT NOT NULL,
    idsuc INT NOT NULL,
    num_clie INT NOT NULL,
    userid INT NOT NULL,
    idfpago INT NOT NULL,
    fecha_pago DATE,
    num_prod INT NOT NULL,
    cantidad NUMERIC(10,0) NULL,
    precio NUMERIC(10,2) NULL,
    isv NUMERIC(10,2) NULL,
    descuento NUMERIC(10,2) NULL,
    total NUMERIC(10,2) NULL,
    estado VARCHAR(10) NULL,
    CONSTRAINT pk_pagos PRIMARY KEY(idpago)
);
ALTER TABLE pagos ADD FOREIGN KEY (idempresa) REFERENCES empresa(idempresa);
ALTER TABLE pagos ADD FOREIGN KEY (idsuc) REFERENCES sucursales(idsuc);
ALTER TABLE pagos ADD FOREIGN KEY (num_clie) REFERENCES clientes(num_clie);
ALTER TABLE pagos ADD FOREIGN KEY (num_venta) REFERENCES encabezado_venta(num_venta);
ALTER TABLE pagos ADD FOREIGN KEY (num_prod) REFERENCES producto(num_prod);
ALTER TABLE pagos ADD FOREIGN KEY (idfpago) REFERENCES formapago(idfpago);
ALTER TABLE pagos ADD FOREIGN KEY (userid) REFERENCES usuario(userid);

INSERT INTO empresa (nombre, direccion, rtn, telefono, correo, contacto, fecha_creacion, estado) VALUES
('Empresa A', 'Tegucigalpa', '0801199000001', '22330001', 'a@empresa.hn', 'Juan Perez', '2026-01-10', 'Activo'),
('Empresa B', 'San Pedro Sula', '0501199000002', '25500002', 'b@empresa.hn', 'Maria Lopez', '2026-01-11', 'Activo'),
('Empresa C', 'La Ceiba', '0101199000003', '24400003', 'c@empresa.hn', 'Carlos Gomez', '2026-01-12', 'Activo'),
('Empresa D', 'Choluteca', '0601199000004', '27700004', 'd@empresa.hn', 'Ana Martinez', '2026-01-13', 'Activo'),
('Empresa E', 'Comayagua', '0301199000005', '27710005', 'e@empresa.hn', 'Luis Rodriguez', '2026-01-14', 'Activo'),
('Empresa F', 'Copan', '0401199000006', '26510006', 'f@empresa.hn', 'Pedro Sanchez', '2026-01-15', 'Activo'),
('Empresa G', 'Danli', '0701199000007', '27630007', 'g@empresa.hn', 'Sofia Cruz', '2026-01-16', 'Activo'),
('Empresa H', 'Juticalpa', '1501199000008', '27850008', 'h@empresa.hn', 'Jorge Reyes', '2026-01-17', 'Activo'),
('Empresa I', 'Progreso', '1801199000009', '26470009', 'i@empresa.hn', 'Elena Flores', '2026-01-18', 'Activo'),
('Empresa J', 'Puerto Cortes', '0502199000010', '26650010', 'j@empresa.hn', 'Mario Diaz', '2026-01-19', 'Activo');

UPDATE empresa SET telefono = '99998888' WHERE idempresa = 1;
UPDATE empresa SET estado = 'Inactivo' WHERE idempresa = 2;

DELETE FROM empresa WHERE idempresa = 10;