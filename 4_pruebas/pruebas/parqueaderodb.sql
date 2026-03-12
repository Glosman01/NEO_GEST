/*GA6-220501096-AA2-EV01 – Destrezas y conocimientos en el manejo de sentencias DDL y DML de SQL.*/
drop database if exists parqueadero; 
create database parqueadero; 
USE parqueadero;
-- table client
create table cliente(
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(80), 
cedula VARCHAR(20) UNIQUE,
telefono  VARCHAR(20), 
email VARCHAR(60) 
);
-- table vehiculo
CREATE TABLE vehiculo( 
id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
placa VARCHAR(20) UNIQUE NOT NULL,
modelo_carro varchar(50) NOT NULL,
tipo_carro VARCHAR(50) NOT NULL,
color VARCHAR(20),
estado VARCHAR(50)
);
-- muestra laas tablas existente
SHOW TABLES;
-- visualiza la estructura de la tabla
DESCRIBE cliente;
DESCRIBE vehiculo;
-- se insertan registros a los campos de la tabla cliente
INSERT INTO cliente (nombre, cedula, telefono, email)
VALUES 
('Juan Pérez', '10101010', '3001112233', 'juan.perez@email.com'),
('María García', '20202020', '3104445566', 'maria.garcia@email.com'),
('Carlos López', '30303030', '3207778899', 'carlos.lopez@email.com'),
('Ana Martínez', '40404040', '3152223344', 'ana.martinez@email.com'),
('Luis Rodríguez', '50505050', '3015556677', 'luis.rodriguez@email.com'),
('Elena Gómez', '60606060', '3128889900', 'elena.gomez@email.com'),
('Andrés Castro', '70707070', '3041119988', 'andres.castro@email.com'),
('Sofía Herrera', '80808080', '3183334455', 'sofia.herrera@email.com'),
('Diego Torres', '90909090', '3216667788', 'diego.torres@email.com'),
('Lucía Morales', '11223344', '3009990011', 'lucia.morales@email.com'),
('Ricardo Sánchez', '55667788', '3112224466', 'ricardo.sanchez@email.com'),
('Valentina Ruiz', '99001122', '3145557788', 'valentina.ruiz@email.com');
INSERT INTO vehiculo (placa, modelo_carro,  tipo_carro, color, estado)
VALUES 
("WET564", "tiida", "nissan", "rojo", "nuevo"),
('RTE123', 'sandero', 'renaut', 'negro', 'rayon en puertaa derecha'),
('EQA456', 'allegro', 'mazda', 'azul', 'nuevo');
-- mostrar registros de la tabla
SELECT * FROM cliente;
SELECT * FROM vehiculo;
-- actualizar datos insertados 
UPDATE cliente
SET telefono = 3150765432
WHERE id_cliente = 5; 
SELECT * FROM cliente
WHERE id_cliente = 5;
-- insertar nuevos registros en la tabla vehiculo
INSERT INTO vehiculo (placa, modelo_carro,  tipo_carro, color, estado)
VALUES
('FGH678', 'spark', 'chevrolet', 'verde', 'nuevo'),
('KJH987', 'corolla', 'toyota', 'amarillo', 'nuevo');
SELECT * FROM vehiculo
ORDER BY id_vehiculo DESC
LIMIT 2;
SELECT COUNT(*) AS total_clientes FROM cliente;
 SELECT COUNT(*) AS total_vehiculos FROM vehiculo;
 SELECT 
 (SELECT COUNT(*) FROM cliente) AS total_clientes,
 (SELECT COUNT(*) FROM vehiculo) AS total_vehiculos;







