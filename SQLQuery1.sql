

CREATE DATABASE TransporteVentas;
GO
USE TransporteVentas;
GO

CREATE TABLE personas(
 id_persona INT IDENTITY(1,1) PRIMARY KEY,
 tipo_documento VARCHAR(15) NOT NULL,
 nro_documento VARCHAR(15) NOT NULL UNIQUE,
 nombre VARCHAR(60) NOT NULL,
 ape_paterno VARCHAR(60) NOT NULL,
 ape_materno VARCHAR(60),
 telefono VARCHAR(9)
);
GO

CREATE TABLE administradores(
 id_administrador INT IDENTITY(1,1) PRIMARY KEY,
 id_persona INT NOT NULL REFERENCES personas(id_persona),
 username VARCHAR(30) NOT NULL UNIQUE,
 password VARCHAR(60) NOT NULL,
 rol VARCHAR(20) NOT NULL CHECK(rol='administrador'),
 activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE supervisores(
 id_supervisor INT IDENTITY(1,1) PRIMARY KEY,
 id_persona INT NOT NULL REFERENCES personas(id_persona),
 username VARCHAR(30) NOT NULL UNIQUE,
 password VARCHAR(60) NOT NULL,
 rol VARCHAR(20) NOT NULL CHECK(rol='supervisor'),
 activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE vendedores(
 id_vendedor INT IDENTITY(1,1) PRIMARY KEY,
 id_persona INT NOT NULL REFERENCES personas(id_persona),
 username VARCHAR(30) NOT NULL UNIQUE,
 password VARCHAR(60) NOT NULL,
 rol VARCHAR(20) NOT NULL CHECK(rol='vendedor'),
 activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE clientes(
 id_cliente INT IDENTITY(1,1) PRIMARY KEY,
 id_persona INT NOT NULL REFERENCES personas(id_persona),
 tipo_cliente VARCHAR(15) NOT NULL CHECK(tipo_cliente IN ('regular','frecuente','corporativo'))
);
GO

CREATE TABLE conductores(
 id_conductor INT IDENTITY(1,1) PRIMARY KEY,
 id_persona INT NOT NULL REFERENCES personas(id_persona),
 nro_licencia VARCHAR(20) NOT NULL UNIQUE,
 categoria_licencia VARCHAR(6) NOT NULL CHECK(categoria_licencia IN ('A-IIa','A-IIb','A-IIIa','A-IIIb','A-IIIc')),
 disponible BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE vehiculos(
 id_vehiculo INT IDENTITY(1,1) PRIMARY KEY,
 tipo VARCHAR(10) NOT NULL CHECK(tipo IN ('Bus','Combi')),
 marca VARCHAR(40) NOT NULL,
 modelo VARCHAR(40) NOT NULL,
 anio INT NOT NULL CHECK(anio BETWEEN 1990 AND 2026),
 placa VARCHAR(8) NOT NULL UNIQUE,
 capacidad_pasajeros INT NOT NULL,
 operativo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE buses(
 id_bus INT IDENTITY(1,1) PRIMARY KEY,
 id_vehiculo INT NOT NULL UNIQUE REFERENCES vehiculos(id_vehiculo),
 tipo_bus VARCHAR(20) NOT NULL CHECK(tipo_bus IN ('interprovincial','urbano','turistico')),
 tiene_aire_acondicionado BIT NOT NULL DEFAULT 0,
 numero_pisos INT NOT NULL CHECK(numero_pisos IN (1,2))
);
GO

CREATE TABLE combis(
 id_combi INT IDENTITY(1,1) PRIMARY KEY,
 id_vehiculo INT NOT NULL UNIQUE REFERENCES vehiculos(id_vehiculo),
 tipo_ruta VARCHAR(20) NOT NULL CHECK(tipo_ruta IN ('urbana','interdistrital','rural')),
 tiene_musica BIT NOT NULL DEFAULT 0
);
GO

CREATE TABLE rutas(
 id_ruta INT IDENTITY(1,1) PRIMARY KEY,
 codigo_ruta VARCHAR(10) NOT NULL UNIQUE,
 origen VARCHAR(60) NOT NULL,
 destino VARCHAR(60) NOT NULL,
 distancia_km FLOAT NOT NULL,
 duracion_minutos INT NOT NULL,
 precio_base FLOAT NOT NULL,
 activa BIT NOT NULL DEFAULT 1,
 CONSTRAINT CK_ruta_origen_destino CHECK(origen<>destino)
);
GO

CREATE TABLE boletos(
 id_boleto INT IDENTITY(1,1) PRIMARY KEY,
 nro_boleto VARCHAR(15) NOT NULL UNIQUE,
 id_ruta INT NOT NULL REFERENCES rutas(id_ruta),
 id_vehiculo INT NOT NULL REFERENCES vehiculos(id_vehiculo),
 id_conductor INT NOT NULL REFERENCES conductores(id_conductor),
 id_cliente INT NOT NULL REFERENCES clientes(id_cliente),
 fecha_viaje DATE NOT NULL,
 hora_viaje TIME NOT NULL,
 asiento VARCHAR(5) NOT NULL,
 descuento FLOAT NOT NULL DEFAULT 0,
 recargo FLOAT NOT NULL DEFAULT 0,
 monto_total FLOAT NOT NULL,
 cancelado BIT NOT NULL DEFAULT 0,
 CONSTRAINT UQ_boleto_asiento UNIQUE(id_vehiculo,id_ruta,fecha_viaje,hora_viaje,asiento)
);
GO

CREATE INDEX IX_vehiculos_placa ON vehiculos(placa);
CREATE INDEX IX_conductores_licencia ON conductores(nro_licencia);
CREATE INDEX IX_rutas_codigo ON rutas(codigo_ruta);
CREATE INDEX IX_boletos_fecha ON boletos(fecha_viaje);
GO

INSERT INTO personas(tipo_documento,nro_documento,nombre,ape_paterno,ape_materno,telefono) VALUES
('DNI','00000001','Administrador','Sistema',NULL,'900000001'),
('DNI','00000002','Juan','Perez','Lopez','900000002'),
('DNI','00000003','Maria','Torres','Diaz','900000003'),
('DNI','40123456','Carlos','Ramirez','Torres','944111222'),
('DNI','41234567','Luis','Flores','Huaman','945222333'),
('DNI','42345678','Jorge','Mendoza','Quispe','946333444'),
('DNI','43456789','Pedro','Vasquez','Lozano','947444555'),
('DNI','44567890','Marco','Salinas','Diaz','948555666');
GO

INSERT INTO administradores(id_persona,username,password,rol,activo)
VALUES (1,'admin','admin123','administrador',1);

INSERT INTO vendedores(id_persona,username,password,rol,activo)
VALUES (2,'vendedor1','venta2024','vendedor',1);

INSERT INTO supervisores(id_persona,username,password,rol,activo)
VALUES (3,'supervisor','super2024','supervisor',1);

INSERT INTO conductores(id_persona,nro_licencia,categoria_licencia,disponible) VALUES
(4,'L001-2020','A-IIIb',1),
(5,'L002-2019','A-IIIb',1),
(6,'L003-2021','A-IIa',1),
(7,'L004-2022','A-IIIa',1),
(8,'L005-2018','A-IIb',1);
GO

INSERT INTO vehiculos(tipo,marca,modelo,anio,placa,capacidad_pasajeros,operativo) VALUES
('Bus','Mercedes-Benz','OF-1721',2020,'ABC-123',50,1),
('Bus','Volvo','B9R',2021,'DEF-456',52,1),
('Bus','Scania','K360',2019,'GHI-789',48,1),
('Combi','Toyota','Hiace',2021,'PQR-678',15,1),
('Combi','Nissan','Urvan',2020,'STU-901',14,1);
GO

INSERT INTO buses(id_vehiculo,tipo_bus,tiene_aire_acondicionado,numero_pisos) VALUES
(1,'interprovincial',1,1),
(2,'interprovincial',1,2),
(3,'turistico',1,1);

INSERT INTO combis(id_vehiculo,tipo_ruta,tiene_musica) VALUES
(4,'urbana',1),
(5,'interdistrital',0);
GO

INSERT INTO rutas(codigo_ruta,origen,destino,distancia_km,duracion_minutos,precio_base,activa) VALUES
('R001','Trujillo','Lima',560,480,50,1),
('R002','Trujillo','Chiclayo',220,180,20,1),
('R003','Trujillo','Piura',450,360,40,1),
('R004','Trujillo','Cajamarca',300,300,30,1),
('R005','Trujillo','Huaraz',330,330,35,1);
GO

PRINT 'Base de datos TransporteVentas creada correctamente.';
GO
