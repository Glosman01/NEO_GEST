-- Limpieza inicial para evitar errores de duplicidad o llaves huérfanas
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `neogest`;
CREATE SCHEMA IF NOT EXISTS `neogest` DEFAULT CHARACTER SET utf8mb4;
USE `neogest`;

-- 1. Rol (Para Admin Master, Empleados y Clientes)
CREATE TABLE `Rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `permisos` TEXT NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;

-- 2. Usuario (Centraliza el acceso)
CREATE TABLE `Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `fecha_registro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `estado` TINYINT DEFAULT 1,
  `Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  CONSTRAINT `fk_Usuario_Rol` FOREIGN KEY (`Rol_idRol`) REFERENCES `Rol` (`idRol`))
ENGINE = InnoDB;

-- 3. Cliente
CREATE TABLE `Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre_completo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `direccion_envio` VARCHAR(150) NOT NULL,
  `direccion_facturacion` VARCHAR(150) NOT NULL,
  `codigo_postal` VARCHAR(20) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  CONSTRAINT `fk_Cliente_Usuario` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE)
ENGINE = InnoDB;

-- 4. Empleado
CREATE TABLE `Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `nombre_empleado` VARCHAR(50) NOT NULL,
  `cargo` VARCHAR(45) NULL,
  `id_jefe_master` INT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `fk_Empleado_Usuario` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `Usuario` (`idUsuario`) ON DELETE CASCADE)
ENGINE = InnoDB;

-- 5. Categoria
CREATE TABLE `Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NOT NULL,
  `descripcion` VARCHAR(250) NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;

-- 6. Producto
CREATE TABLE `Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(80) NOT NULL,
  `descripcion` VARCHAR(250) NULL,
  `precio_unitario` DECIMAL(10,2) NOT NULL,
  `stock_actual` INT NOT NULL DEFAULT 0,
  `dimensiones` VARCHAR(45) NULL,
  `peso` DECIMAL(10,2) NULL,
  `imagen_url` VARCHAR(255) NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `fk_Producto_Categoria` FOREIGN KEY (`Categoria_idCategoria`) REFERENCES `Categoria` (`idCategoria`))
ENGINE = InnoDB;

-- 7. Carrito
CREATE TABLE `Carrito` (
  `idCarrito` INT NOT NULL AUTO_INCREMENT,
  `fecha_actualizacion` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCarrito`),
  CONSTRAINT `fk_Carrito_Cliente` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`) ON DELETE CASCADE)
ENGINE = InnoDB;

-- 8. Item de Carrito
CREATE TABLE `item_carrito` (
  `iditem_carrito` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `Carrito_idCarrito` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`iditem_carrito`),
  CONSTRAINT `fk_item_Carrito` FOREIGN KEY (`Carrito_idCarrito`) REFERENCES `Carrito` (`idCarrito`),
  CONSTRAINT `fk_item_Producto` FOREIGN KEY (`Producto_idProducto`) REFERENCES `Producto` (`idProducto`))
ENGINE = InnoDB;

-- 9. Pedido
CREATE TABLE `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `estado` VARCHAR(45) NOT NULL,
  `total_compra` DECIMAL(10,2) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_Pedido_Cliente` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `Cliente` (`idCliente`))
ENGINE = InnoDB;

-- 10. Detalle del Pedido
CREATE TABLE `Detalle_pedido` (
  `idDetalle_pedido` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NOT NULL,
  `precio_al_momento` DECIMAL(10,2) NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idDetalle_pedido`),
  CONSTRAINT `fk_Detalle_Producto` FOREIGN KEY (`Producto_idProducto`) REFERENCES `Producto` (`idProducto`),
  CONSTRAINT `fk_Detalle_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`))
ENGINE = InnoDB;

-- 11. Movimiento de Inventario
CREATE TABLE `Movimiento_inventario` (
  `idMovimiento_inventario` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('Entrada', 'Salida', 'Ajuste') NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Producto_idProducto` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idMovimiento_inventario`),
  CONSTRAINT `fk_Mov_Producto` FOREIGN KEY (`Producto_idProducto`) REFERENCES `Producto` (`idProducto`),
  CONSTRAINT `fk_Mov_Empleado` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`))
ENGINE = InnoDB;

-- 12. Factura
CREATE TABLE `Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `numero_factura` VARCHAR(45) NOT NULL UNIQUE,
  `ruc_nit_cliente` VARCHAR(45) NOT NULL,
  `url_pdf` VARCHAR(255) NULL,
  `fecha_emision` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  CONSTRAINT `fk_Factura_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`))
ENGINE = InnoDB;

-- 13. Pago
CREATE TABLE `Pago` (
  `idPago` INT NOT NULL AUTO_INCREMENT,
  `metodo` VARCHAR(100) NOT NULL,
  `monto` DECIMAL(10,2) NOT NULL,
  `fecha_pago` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `estado_transaccion` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idPago`),
  CONSTRAINT `fk_Pago_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`))
ENGINE = InnoDB;

-- 14. Envio
CREATE TABLE `Envio` (
  `idEnvio` INT NOT NULL AUTO_INCREMENT,
  `empresa_transporte` VARCHAR(100) NOT NULL,
  `codigo_seguimiento` VARCHAR(45) NOT NULL,
  `fecha_despacho` DATETIME NULL,
  `fecha_entrega_estimada` DATETIME NULL,
  `estado` VARCHAR(60) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idEnvio`),
  CONSTRAINT `fk_Envio_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`),
  CONSTRAINT `fk_Envio_Empleado` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`))
ENGINE = InnoDB;

-- 15. Devolucion
CREATE TABLE `Devolucion` (
  `idDevolucion` INT NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `motivo` VARCHAR(255) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `monto_reembolso` DECIMAL(10,2) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  PRIMARY KEY (`idDevolucion`),
  CONSTRAINT `fk_Devolucion_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `Pedido` (`idPedido`),
  CONSTRAINT `fk_Devolucion_Empleado` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `Empleado` (`idEmpleado`))
ENGINE = InnoDB;

-- Restaurar configuraciones de MySQL
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- INSERTS PARA EMPEZAR A TRABAJAR
INSERT INTO `neogest`.`Rol` (nombre, permisos) VALUES ('Administrador Master', 'TODOS_LOS_PERMISOS');
INSERT INTO `neogest`.`Rol` (nombre, permisos) VALUES ('Empleado', 'GESTION_VENTAS_INVENTARIO');
INSERT INTO `neogest`.`Rol` (nombre, permisos) VALUES ('Cliente', 'SOLO_LECTURA_Y_COMPRA');


