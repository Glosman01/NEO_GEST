SELECT * FROM neogest.Empleado;

INSERT INTO neogest.Usuario (`email`, `password`, `Rol_idRol`) 
VALUES ('juan.perez@neogest.com', 'clave123', 1);
INSERT INTO neogest.Empleado (nombre_empleado, cargo, Usuario_idUsuario) 
VALUES ('JUAN PEREZ', 'INGENIERO MECANICO', 1);
SELECT * FROM neogest.Usuario;
SELECT * FROM neogest.Empleado;
DELETE FROM `neogest`.`Empleado` WHERE `idEmpleado` = 1;
DELETE FROM `neogest`.`Usuario` WHERE `idUsiuario` = 1;
SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `neogest`.`Empleado`;
TRUNCATE TABLE `neogest`.`Usuario`;
TRUNCATE TABLE `neogest`.`Cliente`; -- Opcional, si insertaste alguno

SET FOREIGN_KEY_CHECKS = 1;
