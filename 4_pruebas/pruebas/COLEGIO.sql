use b7sego4j37kpkfwtims6;
CREATE TABLE usuarios(
id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50),
telefono VARCHAR(10),
correo VARCHAR(50)
);

CREATE TABLE cursos(
id_cursos INT AUTO_INCREMENT PRIMARY KEY,
nombre_curso VARCHAR(50),
duracion_curso INT
);

CREATE TABLE matricula(
id_matricula INT AUTO_INCREMENT PRIMARY KEY,
id_usuarios INT,
id_cursos INT,
fecha DATE,
 CONSTRAINT FOREIGN KEY (id_usuarios) REFERENCES usuarios(id_usuarios),
 CONSTRAINT FOREIGN  KEY (id_cursos) REFERENCES cursos(id_cursos)
 );
 




