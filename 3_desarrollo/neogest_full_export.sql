-- ============================================
-- NEOGEST DATABASE EXPORT
-- Fecha de exportación: 2026-03-31 12:14:32
-- ============================================

SET FOREIGN_KEY_CHECKS=0;

-- Table: carrito
DROP TABLE IF EXISTS `carrito`;

CREATE TABLE `carrito` (
  `idCarrito` int NOT NULL AUTO_INCREMENT,
  `fecha_actualizacion` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Cliente_idCliente` int NOT NULL,
  PRIMARY KEY (`idCarrito`),
  KEY `fk_Carrito_Cliente` (`Cliente_idCliente`),
  CONSTRAINT `fk_Carrito_Cliente` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: categoria
DROP TABLE IF EXISTS `categoria`;

CREATE TABLE `categoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: cliente
DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion_envio` varchar(150) NOT NULL,
  `direccion_facturacion` varchar(150) NOT NULL,
  `codigo_postal` varchar(20) NOT NULL,
  `Usuario_idUsuario` int NOT NULL,
  PRIMARY KEY (`idCliente`),
  KEY `fk_Cliente_Usuario` (`Usuario_idUsuario`),
  CONSTRAINT `fk_Cliente_Usuario` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `cliente` (`idCliente`, `nombre_completo`, `telefono`, `direccion_envio`, `direccion_facturacion`, `codigo_postal`, `Usuario_idUsuario`) VALUES (1, 'hamilton', '323', 'calle123', 'owdehqiwuh', '123uhihu', 3);

-- --------------------------------------------

-- Table: detalle_pedido
DROP TABLE IF EXISTS `detalle_pedido`;

CREATE TABLE `detalle_pedido` (
  `idDetalle_pedido` int NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `precio_al_momento` decimal(10,2) NOT NULL,
  `Producto_idProducto` int NOT NULL,
  `Pedido_idPedido` int NOT NULL,
  PRIMARY KEY (`idDetalle_pedido`),
  KEY `fk_Detalle_Producto` (`Producto_idProducto`),
  KEY `fk_Detalle_Pedido` (`Pedido_idPedido`),
  CONSTRAINT `fk_Detalle_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`),
  CONSTRAINT `fk_Detalle_Producto` FOREIGN KEY (`Producto_idProducto`) REFERENCES `producto` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: devolucion
DROP TABLE IF EXISTS `devolucion`;

CREATE TABLE `devolucion` (
  `idDevolucion` int NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` datetime DEFAULT CURRENT_TIMESTAMP,
  `motivo` varchar(255) NOT NULL,
  `estado` varchar(45) NOT NULL,
  `monto_reembolso` decimal(10,2) NOT NULL,
  `Pedido_idPedido` int NOT NULL,
  `Empleado_idEmpleado` int NOT NULL,
  PRIMARY KEY (`idDevolucion`),
  KEY `fk_Devolucion_Pedido` (`Pedido_idPedido`),
  KEY `fk_Devolucion_Empleado` (`Empleado_idEmpleado`),
  CONSTRAINT `fk_Devolucion_Empleado` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  CONSTRAINT `fk_Devolucion_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: empleado
DROP TABLE IF EXISTS `empleado`;

CREATE TABLE `empleado` (
  `idEmpleado` int NOT NULL AUTO_INCREMENT,
  `nombre_empleado` varchar(50) NOT NULL,
  `cargo` varchar(45) DEFAULT NULL,
  `id_jefe_master` int DEFAULT NULL,
  `Usuario_idUsuario` int NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `fk_Empleado_Usuario` (`Usuario_idUsuario`),
  CONSTRAINT `fk_Empleado_Usuario` FOREIGN KEY (`Usuario_idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: envio
DROP TABLE IF EXISTS `envio`;

CREATE TABLE `envio` (
  `idEnvio` int NOT NULL AUTO_INCREMENT,
  `empresa_transporte` varchar(100) NOT NULL,
  `codigo_seguimiento` varchar(45) NOT NULL,
  `fecha_despacho` datetime DEFAULT NULL,
  `fecha_entrega_estimada` datetime DEFAULT NULL,
  `estado` varchar(60) DEFAULT NULL,
  `Pedido_idPedido` int NOT NULL,
  `Empleado_idEmpleado` int NOT NULL,
  PRIMARY KEY (`idEnvio`),
  KEY `fk_Envio_Pedido` (`Pedido_idPedido`),
  KEY `fk_Envio_Empleado` (`Empleado_idEmpleado`),
  CONSTRAINT `fk_Envio_Empleado` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  CONSTRAINT `fk_Envio_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: factura
DROP TABLE IF EXISTS `factura`;

CREATE TABLE `factura` (
  `idFactura` int NOT NULL AUTO_INCREMENT,
  `numero_factura` varchar(45) NOT NULL,
  `ruc_nit_cliente` varchar(45) NOT NULL,
  `url_pdf` varchar(255) DEFAULT NULL,
  `fecha_emision` datetime DEFAULT CURRENT_TIMESTAMP,
  `Pedido_idPedido` int NOT NULL,
  PRIMARY KEY (`idFactura`),
  UNIQUE KEY `numero_factura` (`numero_factura`),
  KEY `fk_Factura_Pedido` (`Pedido_idPedido`),
  CONSTRAINT `fk_Factura_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: item_carrito
DROP TABLE IF EXISTS `item_carrito`;

CREATE TABLE `item_carrito` (
  `iditem_carrito` int NOT NULL AUTO_INCREMENT,
  `cantidad` int NOT NULL,
  `Carrito_idCarrito` int NOT NULL,
  `Producto_idProducto` int NOT NULL,
  PRIMARY KEY (`iditem_carrito`),
  KEY `fk_item_Carrito` (`Carrito_idCarrito`),
  KEY `fk_item_Producto` (`Producto_idProducto`),
  CONSTRAINT `fk_item_Carrito` FOREIGN KEY (`Carrito_idCarrito`) REFERENCES `carrito` (`idCarrito`),
  CONSTRAINT `fk_item_Producto` FOREIGN KEY (`Producto_idProducto`) REFERENCES `producto` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: movimiento_inventario
DROP TABLE IF EXISTS `movimiento_inventario`;

CREATE TABLE `movimiento_inventario` (
  `idMovimiento_inventario` int NOT NULL AUTO_INCREMENT,
  `tipo` enum('Entrada','Salida','Ajuste') NOT NULL,
  `cantidad` int NOT NULL,
  `fecha` datetime DEFAULT CURRENT_TIMESTAMP,
  `Producto_idProducto` int NOT NULL,
  `Empleado_idEmpleado` int NOT NULL,
  PRIMARY KEY (`idMovimiento_inventario`),
  KEY `fk_Mov_Producto` (`Producto_idProducto`),
  KEY `fk_Mov_Empleado` (`Empleado_idEmpleado`),
  CONSTRAINT `fk_Mov_Empleado` FOREIGN KEY (`Empleado_idEmpleado`) REFERENCES `empleado` (`idEmpleado`),
  CONSTRAINT `fk_Mov_Producto` FOREIGN KEY (`Producto_idProducto`) REFERENCES `producto` (`idProducto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: pago
DROP TABLE IF EXISTS `pago`;

CREATE TABLE `pago` (
  `idPago` int NOT NULL AUTO_INCREMENT,
  `metodo` varchar(100) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_pago` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado_transaccion` varchar(45) DEFAULT NULL,
  `Pedido_idPedido` int NOT NULL,
  PRIMARY KEY (`idPago`),
  KEY `fk_Pago_Pedido` (`Pedido_idPedido`),
  CONSTRAINT `fk_Pago_Pedido` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: pedido
DROP TABLE IF EXISTS `pedido`;

CREATE TABLE `pedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(45) NOT NULL,
  `total_compra` decimal(10,2) NOT NULL,
  `Cliente_idCliente` int NOT NULL,
  PRIMARY KEY (`idPedido`),
  KEY `fk_Pedido_Cliente` (`Cliente_idCliente`),
  CONSTRAINT `fk_Pedido_Cliente` FOREIGN KEY (`Cliente_idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: producto
DROP TABLE IF EXISTS `producto`;

CREATE TABLE `producto` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `stock_actual` int NOT NULL DEFAULT '0',
  `dimensiones` varchar(45) DEFAULT NULL,
  `peso` decimal(10,2) DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL,
  `Categoria_idCategoria` int NOT NULL,
  PRIMARY KEY (`idProducto`),
  KEY `fk_Producto_Categoria` (`Categoria_idCategoria`),
  CONSTRAINT `fk_Producto_Categoria` FOREIGN KEY (`Categoria_idCategoria`) REFERENCES `categoria` (`idCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------

-- Table: rol
DROP TABLE IF EXISTS `rol`;

CREATE TABLE `rol` (
  `idRol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `permisos` text NOT NULL,
  PRIMARY KEY (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `rol` (`idRol`, `nombre`, `permisos`) VALUES (1, 'Administrador Master', 'TODOS_LOS_PERMISOS');
INSERT INTO `rol` (`idRol`, `nombre`, `permisos`) VALUES (2, 'Empleado', 'GESTION_VENTAS_INVENTARIO');
INSERT INTO `rol` (`idRol`, `nombre`, `permisos`) VALUES (3, 'Cliente', 'SOLO_LECTURA_Y_COMPRA');

-- --------------------------------------------

-- Table: usuario
DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint DEFAULT '1',
  `Rol_idRol` int NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_Usuario_Rol` (`Rol_idRol`),
  CONSTRAINT `fk_Usuario_Rol` FOREIGN KEY (`Rol_idRol`) REFERENCES `rol` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `usuario` (`idUsuario`, `email`, `password_hash`, `fecha_registro`, `estado`, `Rol_idRol`) VALUES (1, 'test1@gmail.com', '$2b$12$qqrkh2.uhIp9rzb7yPKdrepUm0x8Z2X4KZTfE3vmsCAeXtPci4Ypy', '2026-03-11 10:30:53', 1, 3);
INSERT INTO `usuario` (`idUsuario`, `email`, `password_hash`, `fecha_registro`, `estado`, `Rol_idRol`) VALUES (2, 'admin@neogest.com', '$2b$12$xfZiWffhMtieBoF1rQDDuudi2iPj5cTYmoImvJd/7MyTg1k/eQMqW', '2026-03-12 16:19:56', 1, 1);
INSERT INTO `usuario` (`idUsuario`, `email`, `password_hash`, `fecha_registro`, `estado`, `Rol_idRol`) VALUES (3, 'glosman_21@hotmai.com', '$2b$12$PE3wsGQ8YJJbBFPApBPCc.MFBkzU0kjCXKCVvrlc/d.K.X3JXLpDi', '2026-03-12 16:26:38', 1, 3);

-- --------------------------------------------

SET FOREIGN_KEY_CHECKS=1;
