DROP DATABASE PROYECTO;
CREATE DATABASE PROYECTO;
USE PROYECTO;

-- Tabla de Alumnos
CREATE TABLE ALUMNOS (
    NUMMATRICULA INT(6) AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(50),
    APELLIDOS VARCHAR(100),
    FECHANACIMIENTO DATE,
    NIF_A CHAR(9),
    TELEFONO VARCHAR(12),
    CONTRASEÑA VARCHAR(30),
    CORREO VARCHAR(100) UNIQUE
);

CREATE TABLE ADMINISTRADORES(
	IDADMIN INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(50),
    APELLIDOS VARCHAR(100),
    CONTRASEÑA VARCHAR(20),
    AMBITO ENUM('CIENCIAS', 'LETRAS Y ECONOMIA', 'ARTE') NOT NULL,
    TELEFONO VARCHAR(12)
);

-- Tabla de Profesores
CREATE TABLE PROFESOR (
    IDPROFESOR INT AUTO_INCREMENT PRIMARY KEY,
    NIF_P CHAR(9) UNIQUE,
    NOMBRE VARCHAR(50),
    APELLIDOS VARCHAR(100),
    TELEFONO VARCHAR(12),
    TITULOUNIVERSITARIO TEXT,
	CONTRASEÑA VARCHAR(30),
    CORREO VARCHAR(100) UNIQUE
);

ALTER TABLE ALUMNOS AUTO_INCREMENT = 01289;
ALTER TABLE PROFESOR AUTO_INCREMENT = 6272914;
ALTER TABLE ADMINISTRADORES AUTO_INCREMENT = 26518353;

-- Tabla de Tutorías Profesor-Alumno
CREATE TABLE TUTORIA_PA (
    IDTUTORIA INT AUTO_INCREMENT PRIMARY KEY,
    NUMMATRICULA INT(9),
    IDPROFESOR INT,
    FECHA DATE,
    HORA TIME,
    AULA CHAR(4), -- LETRA EDIFICIO + NUMERO CLASE-- 
    TEMA VARCHAR(255),
    FOREIGN KEY (NUMMATRICULA) REFERENCES ALUMNOS(NUMMATRICULA) ON DELETE CASCADE,
    FOREIGN KEY (IDPROFESOR) REFERENCES PROFESOR(IDPROFESOR) ON DELETE CASCADE
);

-- Tabla de Asignaturas
CREATE TABLE ASIGNATURA (
	NOMBRE VARCHAR(50),
    IDASIGNATURA INT AUTO_INCREMENT PRIMARY KEY,
    CURSOASIGNATURA ENUM('PRIMERO', 'SEGUNDO', 'TERCERO', 'CUARTO', 'QUINTO', 'SEXTO') NOT NULL
);

-- Tabla relación alumno-asignatura
CREATE TABLE ALUMNO_ASIGNATURA (
    NUMMATRICULA INT(9),
    IDASIGNATURA INT,
    PRIMARY KEY (NUMMATRICULA, IDASIGNATURA),
    FOREIGN KEY (NUMMATRICULA) REFERENCES ALUMNOS(NUMMATRICULA) ON DELETE CASCADE,
    FOREIGN KEY (IDASIGNATURA) REFERENCES ASIGNATURA(IDASIGNATURA) ON DELETE CASCADE
);

-- Relación entre Profesores y Asignaturas
CREATE TABLE ASIGNATURA_PROFESOR (
    IDPROFESOR INT,
    IDASIGNATURA INT,
    FECHA DATE, --  CUATRIMESTRE QUE DURA LA ASIGNATURA--
    PRIMARY KEY (IDPROFESOR, IDASIGNATURA),
    FOREIGN KEY (IDPROFESOR) REFERENCES PROFESOR(IDPROFESOR) ON DELETE CASCADE,
    FOREIGN KEY (IDASIGNATURA) REFERENCES ASIGNATURA(IDASIGNATURA) ON DELETE CASCADE
);

-- Tabla de Disponibilidad de Profesores
CREATE TABLE DISPONIBILIDAD_PROFESOR (
    IDDISPONIBILIDAD INT AUTO_INCREMENT PRIMARY KEY,
    IDPROFESOR INT,
    DIA_SEMANA ENUM('LUNES', 'MARTES', 'MIÉRCOLES', 'JUEVES', 'VIERNES') NOT NULL,
    HORA_INICIO TIME NOT NULL,
    HORA_FIN TIME NOT NULL,
    FOREIGN KEY (IDPROFESOR) REFERENCES PROFESOR(IDPROFESOR) ON DELETE CASCADE
);


-- Tabla mentoria Alumno-Alumno
CREATE TABLE TUTORIA_ALUMNO (
    IDTUTORIA_ALUMNO INT AUTO_INCREMENT PRIMARY KEY,
    TUTOR INT(9),
    TUTORADO INT(9),
    IDASIGNATURA INT,  -- La asignatura en la que recibe la tutoría
    FECHA DATE NOT NULL,
    HORA TIME NOT NULL,
    TEMA VARCHAR(255) NOT NULL,
    AULA CHAR(4),
    FOREIGN KEY (TUTOR) REFERENCES ALUMNOS(NUMMATRICULA) ON DELETE CASCADE,
    FOREIGN KEY (TUTORADO) REFERENCES ALUMNOS(NUMMATRICULA) ON DELETE CASCADE,
    FOREIGN KEY (IDASIGNATURA) REFERENCES ASIGNATURA(IDASIGNATURA) ON DELETE CASCADE
);


INSERT INTO ALUMNOS (NOMBRE, APELLIDOS, FECHANACIMIENTO, NIF_A, TELEFONO, CONTRASEÑA, CORREO) VALUES
('Luis', 'Fernández García', '2002-05-14', '12345678A', '612345678', 'LuisFG2024', 'luis.fernandez@email.com'),
('Marta', 'López Pérez', '2001-08-22', '87654321B', '623456789', 'MartaLP01', 'marta.lopez@email.com'),
('Ana', 'Sánchez Ruiz', '2000-02-18', '34567890D', '645678901', 'AnaSR2000', 'ana.sanchez@email.com'),
('David', 'González Fernández', '2002-07-05', '45678901E', '656789012', 'DavidGF22', 'david.gonzalez@email.com'),
('Laura', 'Díaz Martínez', '2001-09-12', '56789012F', '667890123', 'LauraDM01', 'laura.diaz@email.com'),
('Alejandro', 'Hernández Torres', '2003-04-25', '67890123G', '678901234', 'AlexHT03', 'alejandro.hernandez@email.com'),
('Sara', 'Jiménez Romero', '2000-06-15', '78901234H', '689012345', 'SaraJR2000', 'sara.jimenez@email.com'),
('Javier', 'Pérez Navarro', '2002-03-08', '89012345I', '690123456', 'JaviPN02', 'javier.perez@email.com'),
('Carmen', 'Torres Castillo', '2001-10-21', '90123456J', '691234567', 'CarmenTC01', 'carmen.torres@email.com'),
('Hugo', 'Ramírez Ortega', '2003-12-07', '01234567K', '692345678', 'HugoRO03', 'hugo.ramirez@email.com'),
('Elena', 'Moreno Herrera', '2000-01-29', '12345678L', '693456789', 'ElenaMH00', 'elena.moreno@email.com'),
('Pablo', 'Domínguez Gil', '2002-05-06', '23456789M', '694567890', 'PabloDG02', 'pablo.dominguez@email.com'),
('Natalia', 'Vargas León', '2001-08-14', '34567890N', '695678901', 'NataliaVL01', 'natalia.vargas@email.com'),
('Fernando', 'Castillo Ramos', '2003-09-17', '45678901O', '696789012', 'FerCR03', 'fernando.castillo@email.com'),
('Beatriz', 'Ortega Flores', '2000-04-11', '56789012P', '697890123', 'BeaOF2000', 'beatriz.ortega@email.com'),
('Adrián', 'Garrido Medina', '2002-11-22', '67890123Q', '698901234', 'AdrianGM02', 'adrian.garrido@email.com'),
('Irene', 'Ríos Ferrer', '2001-07-30', '78901234R', '699012345', 'IreneRF01', 'irene.rios@email.com'),
('Samuel', 'Santos Vega', '2003-06-19', '89012345S', '600123456', 'SamSV03', 'samuel.santos@email.com'),
('Claudia', 'Méndez Pardo', '2000-02-03', '90123456T', '601234567', 'ClauMP2000', 'claudia.mendez@email.com'),
('Ivan', 'Reyes Márquez', '2002-10-09', '01234567U', '602345678', 'IvanRM02', 'ivan.reyes@email.com'),
('Paula', 'Herrera Jiménez', '2001-12-15', '12345678V', '603456789', 'PaulaHJ01', 'paula.herrera@email.com'),
('Rubén', 'Lorenzo Iglesias', '2003-03-28', '23456789W', '604567890', 'RubenLI03', 'ruben.lorenzo@email.com'),
('Verónica', 'Navarro Sánchez', '2000-11-13', '34567890X', '605678901', 'VeroNS2000', 'veronica.navarro@email.com'),
('Oscar', 'Gil Montes', '2002-08-07', '45678901Y', '606789012', 'OscarGM02', 'oscar.gil@email.com'),
('Silvia', 'Carrasco Peña', '2001-05-20', '56789012Z', '607890123', 'SilviaCP01', 'silvia.carrasco@email.com'),
('Emilio', 'Fuentes Rojas', '2003-02-14', '67890123A', '608901234', 'EmilioFR03', 'emilio.fuentes@email.com'),
('Andrea', 'Molina Vargas', '2000-09-26', '78901234B', '609012345', 'AndreaMV2000', 'andrea.molina@email.com'),
('Manuel', 'Serrano Pineda', '2002-06-11', '89012345C', '610123456', 'ManuSP02', 'manuel.serrano@email.com'),
('Patricia', 'Bravo Esteban', '2001-01-05', '90123456D', '611234567', 'PatriBE01', 'patricia.bravo@email.com'),
('Alejandro', 'Fernández López', '2001-05-14', '12345678A', '612345678', 'AlexFL01', 'alejandro.fernandez@email.com'),
('María', 'García Sánchez', '2002-09-23', '23456789B', '623456789', 'MariaGS02', 'maria.garcia@email.com'),
('Carlos', 'Martínez Ruiz', '2000-12-01', '34567890C', '634567890', 'CarlosMR00', 'carlos.martinez@email.com'),
('Laura', 'Hernández Pérez', '2003-07-18', '45678901D', '645678901', 'LauraHP03', 'laura.hernandez@email.com'),
('Javier', 'López Gómez', '2001-03-05', '56789012E', '656789012', 'JaviLG01', 'javier.lopez@email.com'),
('Sofía', 'Díaz Martín', '2002-06-10', '67890123F', '667890123', 'SofiaDM02', 'sofia.diaz@email.com'),
('Daniel', 'Pérez Fernández', '2000-11-22', '78901234G', '678901234', 'DanielPF00', 'daniel.perez@email.com'),
('Elena', 'González Torres', '2003-08-30', '89012345H', '689012345', 'ElenaGT03', 'elena.gonzalez@email.com'),
('Pablo', 'Sánchez Romero', '2001-02-14', '90123456I', '690123456', 'PabloSR01', 'pablo.sanchez@email.com'),
('Lucía', 'Ramírez Jiménez', '2002-04-25', '01234567J', '691234567', 'LuciaRJ02', 'lucia.ramirez@email.com'),
('Hugo', 'Torres Molina', '2000-09-15', '12345001K', '692345678', 'HugoTM00', 'hugo.torres@email.com'),
('Carmen', 'Ortega Delgado', '2003-12-08', '23456002L', '693456789', 'CarmenOD03', 'carmen.ortega@email.com'),
('Adrián', 'Castro Serrano', '2001-01-20', '34567003M', '694567890', 'AdrianCS01', 'adrian.castro@email.com'),
('Marta', 'Rubio Vargas', '2002-05-28', '45678004N', '695678901', 'MartaRV02', 'marta.rubio@email.com'),
('Iván', 'Navarro Iglesias', '2000-07-04', '56789005O', '696789012', 'IvanNI00', 'ivan.navarro@email.com'),
('Patricia', 'Reyes Domínguez', '2003-10-19', '67890006P', '697890123', 'PatriciaRD03', 'patricia.reyes@email.com'),
('Raúl', 'Moreno Álvarez', '2001-06-07', '78901007Q', '698901234', 'RaulMA01', 'raul.moreno@email.com'),
('Silvia', 'Fuentes León', '2002-02-11', '89012008R', '699012345', 'SilviaFL02', 'silvia.fuentes@email.com'),
('Antonio', 'Blanco Guerrero', '2000-08-24', '90123009S', '610123456', 'AntonioBG00', 'antonio.blanco@email.com'),
('Beatriz', 'Rivas Cano', '2003-03-30', '01234010T', '611234567', 'BeatrizRC03', 'beatriz.rivas@email.com'),
('Fernando', 'Vega Morales', '2001-11-12', '12345011U', '612345678', 'FernandoVM01', 'fernando.vega@email.com'),
('Alicia', 'Campos Herrera', '2002-09-03', '23456012V', '613456789', 'AliciaCH02', 'alicia.campos@email.com'),
('David', 'Méndez Pardo', '2000-05-15', '34567013W', '614567890', 'DavidMP00', 'david.mendez@email.com'),
('Cristina', 'Santos Nieto', '2003-12-21', '45678014X', '615678901', 'CristinaSN03', 'cristina.santos@email.com'),
('Jorge', 'Lara Gil', '2001-04-08', '56789015Y', '616789012', 'JorgeLG01', 'jorge.lara@email.com'),
('Natalia', 'Cortés Peña', '2002-07-27', '67890016Z', '617890123', 'NataliaCP02', 'natalia.cortes@email.com'),
('Rubén', 'Soler Méndez', '2000-10-02', '78901017A', '618901234', 'RubenSM00', 'ruben.soler@email.com'),
('Eva', 'Estevez Bravo', '2003-06-13', '89012018B', '619012345', 'EvaEB03', 'eva.estevez@email.com'),
('Oscar', 'Domingo Reyes', '2001-09-05', '90123019C', '620123456', 'OscarDR01', 'oscar.domingo@email.com'),
('Lorena', 'Ferrer Velasco', '2002-03-16', '01234020D', '621234567', 'LorenaFV02', 'lorena.ferrer@email.com');

INSERT INTO PROFESOR (NIF_P, NOMBRE, APELLIDOS, TELEFONO, TITULOUNIVERSITARIO, CONTRASEÑA, CORREO) VALUES
('12345678A', 'Carlos', 'Fernández López', '654321987', 'Ingeniería Informática', 'Prof2024!', 'cfernandez@example.com'),
('87654321B', 'Laura', 'García Martínez', '612345678', 'Matemáticas Aplicadas', 'LauM@th89', 'lgarcia@example.com'),
('13579246C', 'David', 'Pérez Sánchez', '678912345', 'Física Teórica', 'Fisic0s#', 'dperez@example.com'),
('24681357D', 'Ana', 'Rodríguez Gómez', '698745123', 'Ingeniería de Telecomunicaciones', 'AnaTelec99', 'arodriguez@example.com'),
('98765432E', 'Javier', 'López Díaz', '625874963', 'Ingeniería Electrónica', 'Electr0n!', 'jlopez@example.com'),
('65498732F', 'Marta', 'Sánchez Ruiz', '689541237', 'Estadística y Ciencia de Datos', 'MartaD@t4', 'msanchez@example.com'),
('32165498G', 'Sergio', 'Martínez Castro', '611223344', 'Inteligencia Artificial', 'IA_ML_Sergio', 'smartinez@example.com'),
('15975346H', 'Elena', 'Díaz Moreno', '677889900', 'Nanotecnología', 'NanoEl3na', 'ediaz@example.com'),
('75315928I', 'Roberto', 'Gómez Fernández', '633112244', 'Robótica y Automatización', 'Rob0tic!A', 'rgomez@example.com'),
('85236974J', 'Isabel', 'Torres Sánchez', '644556677', 'Ciberseguridad', 'Secur1ty_IZ', 'itorres@example.com');

INSERT INTO ADMINISTRADORES (NOMBRE, APELLIDOS, CONTRASEÑA, AMBITO, TELEFONO) VALUES
('Carlos', 'González Pérez', 'C@rlo$2025!', 'CIENCIAS', '612345678'),
('María', 'López Fernández', 'M@r!a4567*', 'LETRAS Y ECONOMIA', '623456789'),
('Javier', 'Martínez Ruiz', 'J@vi3r!890#', 'ARTE', '634567890');

INSERT INTO ASIGNATURA (NOMBRE, CURSOASIGNATURA) VALUES
('Cálculo numérico', 'PRIMERO'),
('Eficacia personal y profesional', 'PRIMERO'),
('Fundamentos de empresa', 'PRIMERO'),
('Marketing y Ventas', 'PRIMERO'),
('Fundamentos de programación y computadores', 'PRIMERO'),
('Programación orientada a objetos', 'PRIMERO'),
('Bases de datos', 'PRIMERO'),
('Principios básicos de la estadística', 'PRIMERO'),
('Álgebra', 'PRIMERO'),
('Proyecto de sistema de información', 'PRIMERO'),
('Bases de la informática', 'PRIMERO'),
('Fundamentos de redes', 'PRIMERO'),
('Impacto e Influencia Relacional', 'SEGUNDO'),
('Operaciones y RRHH', 'SEGUNDO'),
('Estructuras de Datos', 'SEGUNDO'),
('Inteligencia Artificial', 'SEGUNDO'),
('Gestión de Proyectos', 'SEGUNDO'),
('Matemática Discreta', 'SEGUNDO'),
('Inferencia Estadística', 'SEGUNDO'),
('Estadística Computacional', 'SEGUNDO'),
('Proyecto de Open Data I', 'SEGUNDO'),
('Proyecto de Open Data II', 'SEGUNDO'),
('Estructura de Computadores', 'SEGUNDO'),
('Técnicas de Programación Avanzadas', 'SEGUNDO'),
('Liderazgo Emprendedor', 'TERCERO'),
('Dirección Estratégica y Análisis Financiero', 'TERCERO'),
('Almacenamiento Masivo de Datos', 'TERCERO'),
('Aprendizaje Automático', 'TERCERO'),
('Visualización de Datos', 'TERCERO'),
('Lenguajes de Programación Estadística', 'TERCERO'),
('Análisis de Regresión Multivariable', 'TERCERO'),
('Proyecto de Big Data I', 'TERCERO'),
('Proyecto de Big Data II', 'TERCERO'),
('Proyecto de Big Data III', 'TERCERO'),
('Fundamentos de Física para Ingeniería', 'TERCERO'),
('Proyecto de Ingeniería', 'TERCERO'),
('Trabajo Fin de Grado (Matemática)', 'CUARTO'),
('Sistemas de Información Empresarial', 'CUARTO'),
('Economía y Marketing Digital', 'CUARTO'),
('Virtualización y Seguridad', 'CUARTO'),
('Seguridad y Legislación Profesional', 'CUARTO'),
('Estudio de Datos de Panel', 'CUARTO'),
('Prácticas Externas', 'CUARTO'),
('Actividades Universitarias', 'CUARTO'),
('Ampliación de Prácticas', 'CUARTO'),
('Introducción a la Ingeniería del Software', 'CUARTO'),
('Análisis de Circuitos', 'CUARTO'),
('Aplicaciones y Tendencias del Análisis de Datos', 'CUARTO'),
('Proyecto de Informática I', 'QUINTO'),
('Programación Concurrente y Distribuida', 'QUINTO'),
('Proyecto de informática II', 'QUINTO'),
('Redes de Ordenadores', 'QUINTO'),
('Sistemas Operativos', 'QUINTO'),
('Proyecto de Computación I', 'QUINTO'),
('Proyecto de Computación II', 'QUINTO'),
('Desarrollo Web y de Apps', 'QUINTO'),
('Administración de Sistemas', 'QUINTO'),
('Ingeniería del Software', 'QUINTO'),
('Compiladores y Lenguajes Formales', 'QUINTO'),
('Desarrollo para Dispositivos Móviles', 'QUINTO'),
('Robótica Móvil', 'QUINTO'),
('Trabajo Fin de Grado (Informática)', 'SEXTO'),
('Seguridad Informática', 'SEXTO'),
('Dirección de Transformación Digital', 'SEXTO');

INSERT INTO ALUMNO_ASIGNATURA (NUMMATRICULA, IDASIGNATURA)
SELECT a.NUMMATRICULA, s.IDASIGNATURA
FROM (SELECT NUMMATRICULA FROM ALUMNOS) a
JOIN (SELECT IDASIGNATURA FROM ASIGNATURA ORDER BY RAND() LIMIT 10) s
ON 1=1;

SELECT * FROM ALUMNOS;
SELECT * FROM PROFESOR;
SELECT * FROM ADMINISTRADORES;
SELECT * FROM ASIGNATURA;
SELECT * FROM ALUMNO_ASIGNATURA;