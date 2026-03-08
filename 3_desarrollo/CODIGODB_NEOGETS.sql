-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema neogest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema neogest
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Table `neogest`.`Rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rol` (
  `idRol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `permisos` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idRol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `fecha_registro` DATETIME NOT NULL,
  `estado` TINYINT NULL,
  `Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `Rol_idRol`),
  UNIQUE INDEX `password_UNIQUE` (`password` ASC) VISIBLE,
  UNIQUE INDEX `fecha_registro_UNIQUE` (`fecha_registro` ASC) VISIBLE,
  INDEX `fk_Usuario_Rol_idx` (`Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Rol`
    FOREIGN KEY (`Rol_idRol`)
    REFERENCES `Rol` (`idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Cliente` (
  `idCliente` INT NOT NULL,
  `nombre_completo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `direccion_envio` VARCHAR(100) NOT NULL,
  `direccion_facturacion` VARCHAR(100) NOT NULL,
  `codigo_postal` INT(20) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Usuario_idUsuario`, `Usuario_Rol_idRol`),
  INDEX `fk_Cliente_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Rol_idRol`)
    REFERENCES `Usuario` (`idUsuario` , `Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empleado` (
  `idEmpleado` INT NOT NULL,
  `nombre_empleado` VARCHAR(50) NOT NULL,
  `cargo` VARCHAR(45) NULL,
  `id_jefe_master` INT NOT NULL,
  `Empleadocol` VARCHAR(45) NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`, `Empleadocol`, `Usuario_idUsuario`, `Usuario_Rol_idRol`),
  INDEX `fk_Empleado_Usuario1_idx` (`Usuario_idUsuario` ASC, `Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Empleado_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario` , `Usuario_Rol_idRol`)
    REFERENCES `Usuario` (`idUsuario` , `Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Carrito` (
  `idCarrito` INT NOT NULL AUTO_INCREMENT,
  `fecha_actualizacion` DATETIME NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Cliente_Usuario_idUsuario` INT NOT NULL,
  `Cliente_Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idCarrito`, `Cliente_idCliente`, `Cliente_Usuario_idUsuario`, `Cliente_Usuario_Rol_idRol`),
  INDEX `fk_Carrito_Cliente1_idx` (`Cliente_idCliente` ASC, `Cliente_Usuario_idUsuario` ASC, `Cliente_Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Carrito_Cliente1`
    FOREIGN KEY (`Cliente_idCliente` , `Cliente_Usuario_idUsuario` , `Cliente_Usuario_Rol_idRol`)
    REFERENCES `Cliente` (`idCliente` , `Usuario_idUsuario` , `Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Categoria` (
  `idCategoria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `descripcion` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(80) NOT NULL,
  `descripcionn` VARCHAR(250) NULL,
  `precio_unitario` DECIMAL(2) NOT NULL,
  `stock_actual` INT NOT NULL,
  `dimensiones` VARCHAR(45) NULL,
  `peso` DECIMAL(2) NULL,
  `imagen_url` VARCHAR(45) NULL,
  `Categoria_idCategoria` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_idCategoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES `Categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`item_carrito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `item_carrito` (
  `iditem_carrito` INT NOT NULL AUTO_INCREMENT,
  `cantidaad` INT(10) NULL,
  `Carrito_idCarrito` INT NOT NULL,
  `Carrito_Cliente_idCliente` INT NOT NULL,
  `Carrito_Cliente_Usuario_idUsuario` INT NOT NULL,
  `Carrito_Cliente_Usuario_Rol_idRol` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`iditem_carrito`, `Carrito_idCarrito`, `Carrito_Cliente_idCliente`, `Carrito_Cliente_Usuario_idUsuario`, `Carrito_Cliente_Usuario_Rol_idRol`, `Producto_idProducto`),
  INDEX `fk_item_carrito_Carrito1_idx` (`Carrito_idCarrito` ASC, `Carrito_Cliente_idCliente` ASC, `Carrito_Cliente_Usuario_idUsuario` ASC, `Carrito_Cliente_Usuario_Rol_idRol` ASC) VISIBLE,
  INDEX `fk_item_carrito_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  CONSTRAINT `fk_item_carrito_Carrito1`
    FOREIGN KEY (`Carrito_idCarrito` , `Carrito_Cliente_idCliente` , `Carrito_Cliente_Usuario_idUsuario` , `Carrito_Cliente_Usuario_Rol_idRol`)
    REFERENCES `Carrito` (`idCarrito` , `Cliente_idCliente` , `Cliente_Usuario_idUsuario` , `Cliente_Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_carrito_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Movimiento_inventario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Movimiento_inventario` (
  `idMovimiento_inventario` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NULL,
  `cantidad` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Empleado_Empleadocol` VARCHAR(45) NOT NULL,
  `Empleado_Usuario_idUsuario` INT NOT NULL,
  `Empleado_Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idMovimiento_inventario`, `Producto_idProducto`, `Empleado_idEmpleado`, `Empleado_Empleadocol`, `Empleado_Usuario_idUsuario`, `Empleado_Usuario_Rol_idRol`),
  INDEX `fk_Movimiento_inventario_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  INDEX `fk_Movimiento_inventario_Empleado1_idx` (`Empleado_idEmpleado` ASC, `Empleado_Empleadocol` ASC, `Empleado_Usuario_idUsuario` ASC, `Empleado_Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Movimiento_inventario_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimiento_inventario_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado` , `Empleado_Empleadocol` , `Empleado_Usuario_idUsuario` , `Empleado_Usuario_Rol_idRol`)
    REFERENCES `Empleado` (`idEmpleado` , `Empleadocol` , `Usuario_idUsuario` , `Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `fecha_creacion` DATETIME NOT NULL,
  `estado` VARCHAR(45) NULL,
  `total_compra` DECIMAL(2) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Cliente_Usuario_idUsuario` INT NOT NULL,
  `Cliente_Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`, `Cliente_Usuario_idUsuario`, `Cliente_Usuario_Rol_idRol`),
  UNIQUE INDEX `idPedido_UNIQUE` (`idPedido` ASC) VISIBLE,
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC, `Cliente_Usuario_idUsuario` ASC, `Cliente_Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente` , `Cliente_Usuario_idUsuario` , `Cliente_Usuario_Rol_idRol`)
    REFERENCES `Cliente` (`idCliente` , `Usuario_idUsuario` , `Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Detalle_pedido` (
  `idDetalle_pedido` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT NULL,
  `precio_al_momento` DECIMAL(2) NULL,
  `Producto_idProducto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idDetalle_pedido`, `Producto_idProducto`, `Pedido_idPedido`),
  INDEX `fk_Detalle_pedido_Producto1_idx` (`Producto_idProducto` ASC) VISIBLE,
  INDEX `fk_Detalle_pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Detalle_pedido_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `numero_factura` VARCHAR(45) NOT NULL,
  `ruc_nit_cliente` VARCHAR(45) NOT NULL,
  `url_pdf` VARCHAR(45) NOT NULL,
  `fecha_emision` DATETIME NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idFactura`, `Pedido_idPedido`),
  UNIQUE INDEX `idFactura_UNIQUE` (`idFactura` ASC) VISIBLE,
  UNIQUE INDEX `numero_factura_UNIQUE` (`numero_factura` ASC) VISIBLE,
  UNIQUE INDEX `ruc_nit_cliente_UNIQUE` (`ruc_nit_cliente` ASC) VISIBLE,
  INDEX `fk_Factura_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Factura_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pago` (
  `idPago` INT NOT NULL AUTO_INCREMENT,
  `metodo` VARCHAR(100) NOT NULL,
  `monto` DECIMAL(2) NOT NULL,
  `fecha_pago` DATETIME NULL,
  `estado_transaccion` VARCHAR(45) NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idPago`, `Pedido_idPedido`),
  UNIQUE INDEX `idPago_UNIQUE` (`idPago` ASC) VISIBLE,
  INDEX `fk_Pago_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pago_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Envio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Envio` (
  `idEnvio` INT NOT NULL AUTO_INCREMENT,
  `empresa_transporte` VARCHAR(10) NOT NULL,
  `codigo_seguimiento` VARCHAR(45) NOT NULL,
  `fecha_despacho` DATETIME NOT NULL,
  `fecha_entrega_estimada` DATETIME NOT NULL,
  `estado` VARCHAR(60) NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Pedido_Cliente_Usuario_idUsuario` INT NOT NULL,
  `Pedido_Cliente_Usuario_Rol_idRol` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Empleado_Empleadocol` VARCHAR(45) NOT NULL,
  `Empleado_Usuario_idUsuario` INT NOT NULL,
  `Empleado_Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idEnvio`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Pedido_Cliente_Usuario_idUsuario`, `Pedido_Cliente_Usuario_Rol_idRol`, `Empleado_idEmpleado`, `Empleado_Empleadocol`, `Empleado_Usuario_idUsuario`, `Empleado_Usuario_Rol_idRol`),
  UNIQUE INDEX `Enviocol_UNIQUE` (`empresa_transporte` ASC) VISIBLE,
  UNIQUE INDEX `idEnvio_UNIQUE` (`idEnvio` ASC) VISIBLE,
  INDEX `fk_Envio_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC, `Pedido_Cliente_Usuario_idUsuario` ASC, `Pedido_Cliente_Usuario_Rol_idRol` ASC) VISIBLE,
  INDEX `fk_Envio_Empleado1_idx` (`Empleado_idEmpleado` ASC, `Empleado_Empleadocol` ASC, `Empleado_Usuario_idUsuario` ASC, `Empleado_Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Envio_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente` , `Pedido_Cliente_Usuario_idUsuario` , `Pedido_Cliente_Usuario_Rol_idRol`)
    REFERENCES `Pedido` (`idPedido` , `Cliente_idCliente` , `Cliente_Usuario_idUsuario` , `Cliente_Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Envio_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado` , `Empleado_Empleadocol` , `Empleado_Usuario_idUsuario` , `Empleado_Usuario_Rol_idRol`)
    REFERENCES `Empleado` (`idEmpleado` , `Empleadocol` , `Usuario_idUsuario` , `Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `neogest`.`Devolucion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Devolucion` (
  `idDevolucion` INT NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` DATETIME NOT NULL,
  `motivo` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `monto_reembolso` DECIMAL(2) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Pedido_Cliente_idCliente` INT NOT NULL,
  `Pedido_Cliente_Usuario_idUsuario` INT NOT NULL,
  `Pedido_Cliente_Usuario_Rol_idRol` INT NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Empleado_Empleadocol` VARCHAR(45) NOT NULL,
  `Empleado_Usuario_idUsuario` INT NOT NULL,
  `Empleado_Usuario_Rol_idRol` INT NOT NULL,
  PRIMARY KEY (`idDevolucion`, `Pedido_idPedido`, `Pedido_Cliente_idCliente`, `Pedido_Cliente_Usuario_idUsuario`, `Pedido_Cliente_Usuario_Rol_idRol`, `Empleado_idEmpleado`, `Empleado_Empleadocol`, `Empleado_Usuario_idUsuario`, `Empleado_Usuario_Rol_idRol`),
  UNIQUE INDEX `idDevolucion_UNIQUE` (`idDevolucion` ASC) VISIBLE,
  INDEX `fk_Devolucion_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_Cliente_idCliente` ASC, `Pedido_Cliente_Usuario_idUsuario` ASC, `Pedido_Cliente_Usuario_Rol_idRol` ASC) VISIBLE,
  INDEX `fk_Devolucion_Empleado1_idx` (`Empleado_idEmpleado` ASC, `Empleado_Empleadocol` ASC, `Empleado_Usuario_idUsuario` ASC, `Empleado_Usuario_Rol_idRol` ASC) VISIBLE,
  CONSTRAINT `fk_Devolucion_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_Cliente_idCliente` , `Pedido_Cliente_Usuario_idUsuario` , `Pedido_Cliente_Usuario_Rol_idRol`)
    REFERENCES `Pedido` (`idPedido` , `Cliente_idCliente` , `Cliente_Usuario_idUsuario` , `Cliente_Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Devolucion_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado` , `Empleado_Empleadocol` , `Empleado_Usuario_idUsuario` , `Empleado_Usuario_Rol_idRol`)
    REFERENCES `Empleado` (`idEmpleado` , `Empleadocol` , `Usuario_idUsuario` , `Usuario_Rol_idRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
