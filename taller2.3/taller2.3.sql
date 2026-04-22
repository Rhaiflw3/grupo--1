
-- 1. ELIMINACIÓN DE TABLAS EXISTENTES (Guía 10)
DROP TABLE tEnfermedadEnElDiagnostico CASCADE CONSTRAINTS;
DROP TABLE tEspecialidadDelMedico CASCADE CONSTRAINTS;
DROP TABLE tDiagnostico CASCADE CONSTRAINTS;
DROP TABLE tEnfermedad CASCADE CONSTRAINTS;
DROP TABLE tEspecialidad CASCADE CONSTRAINTS;
DROP TABLE tMedico CASCADE CONSTRAINTS;
DROP TABLE tPaciente CASCADE CONSTRAINTS;

-- 2. CREACIÓN DEL MODELO FÍSICO (Base Diagnosticos)
CREATE TABLE tPaciente (
    codP VARCHAR2(4) PRIMARY KEY,
    tipoDocP VARCHAR2(15),
    nroDocP VARCHAR2(12),
    paternoP VARCHAR2(50),
    maternoP VARCHAR2(50),
    nombresP VARCHAR2(50),
    fechaNacimientoP DATE,
    generoP CHAR(1)
);

CREATE TABLE tMedico (
    codM VARCHAR2(4) PRIMARY KEY,
    tipoDocM VARCHAR2(15),
    nroDocM VARCHAR2(12),
    paternoM VARCHAR2(50),
    maternoM VARCHAR2(50),
    nombresM VARCHAR2(50),
    celularM VARCHAR2(12),
    fechaNacimientoM DATE,
    generoM CHAR(1)
);

CREATE TABLE tEspecialidad (
    codEsp VARCHAR2(4) PRIMARY KEY,
    nombreEsp VARCHAR2(70),
    descripcionEsp VARCHAR2(100)
);

CREATE TABLE tEnfermedad (
    codE VARCHAR2(4) PRIMARY KEY,
    nombreE VARCHAR2(50),
    descricionE VARCHAR2(100)
); 

CREATE TABLE tDiagnostico (
    codD VARCHAR2(4) PRIMARY KEY,
    fechaHoraD TIMESTAMP,
    descripcionD VARCHAR2(100),
    codP VARCHAR2(4),
    codM VARCHAR2(4),
    FOREIGN KEY (codP) REFERENCES tPaciente (codP),
    FOREIGN KEY (codM) REFERENCES tMedico (codM)
); 

CREATE TABLE tEspecialidadDelMedico (
    codEspM VARCHAR2(4) PRIMARY KEY,
    codEsp VARCHAR2(4),
    codM VARCHAR2(4),
    fechaDeObtencionDeLaEspecialidadEspM DATE,
    FOREIGN KEY (codEsp) REFERENCES tEspecialidad (codEsp),
    FOREIGN KEY (codM) REFERENCES tMedico (codM)
); 

CREATE TABLE tEnfermedadEnElDiagnostico (
    CodED VARCHAR2(4) PRIMARY KEY,
    codE VARCHAR2(4),
    codD VARCHAR2(4),
    FOREIGN KEY (codE) REFERENCES tEnfermedad (code),
    FOREIGN KEY (codD) REFERENCES tDiagnostico (codD)
); 

-- 3. INSERCIÓN DE DATOS
-- Pacientes
INSERT INTO tPaciente VALUES('P01', 'DNI', '11111111', 'Salas', 'Rivas', 'Juan', TO_DATE('02-02-2000', 'DD-MM-YYYY'), 'M'); 
INSERT INTO tPaciente VALUES('P02', 'DNI', '22222222', 'Pérez', 'Rozas', 'Elena', TO_DATE('01-10-2020', 'DD-MM-YYYY'), 'F');

-- Médicos
INSERT INTO tMedico VALUES('M1', 'DNI', '33333333', 'Zela', 'Ramírez', 'Javier', '999999999', TO_DATE('10-10-1970', 'DD-MM-YYYY'), 'M');
INSERT INTO tMedico VALUES ('M2', 'Carnet', '7777', 'Cabral', 'Desousa', 'Alejandra', '988888877', TO_DATE('06-12-1975', 'DD-MM-YYYY'), 'F'); 

-- Especialidades
INSERT INTO tEspecialidad VALUES('Esp1', 'Otorrinolagingología', 'Ojos, nariz y boca'); 
INSERT INTO tEpecialidad VALUES ('Esp2', 'Pediatría', 'Neonato, niño y adolescente'); 
INSERT INTO tEspecialidad VALUES ('Esp3', 'Cardiología', 'Corazón, sistema circulatorio'); 
INSERT INTO tEspecialidad VALUES ('Esp4', 'Odontología', 'Dientes, encías'); 

-- Enfermedades
INSERT INTO tEnfermedad VALUES('E1', 'Alergia respiratoria', 'Alergias en el sistema respiratorio'); 
INSERT INTO tEnfermedad VALUES ('E2', 'Sinusitis', 'Gripe crónica'); 
INSERT INTO tEnfermedad VALUES ('E3', 'Artritis', 'Enfermedad crónica de los huesos'); 

-- Diagnósticos
INSERT INTO tDiagnostico VALUES('D1', TO_TIMESTAMP('25-02-2022 10:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'Sinusitis aguda y alergia', 'P01', 'M1');
INSERT INTO tDiagnostico VALUES ('D2', TO_TIMESTAMP('28-02-2022 12:00:00', 'DD-MM-YYYY HH24:MI:SS'), 'Niña sana', 'P02', 'M2');

-- Relación Especialidad-Médico
INSERT INTO tEspecialidaddelmedico VALUES('EM1', 'Esp1', 'M1', TO_DATE('12-12-2010', 'DD-MM-YYYY')); 
INSERT INTO tEspecialidaddelmedico VALUES('EM2', 'Esp2', 'M2', TO_DATE('02-02-2009', 'DD-MM-YYYY'));
INSERT INTO tEspecialidaddelmedico VALUES ('EM3', 'Esp3', 'M2', TO_DATE('21-11-2019', 'DD-MM-YYYY')); 

-- Relación Enfermedad-Diagnóstico
INSERT INTO tEnfermedadeneldiagnostico VALUES('ED1', 'E1', 'D1');
INSERT INTO tEnfermedadeneldiagnostico VALUES ('ED2', 'E2', 'D1'); 

COMMIT;

-- muuestra de datos 
SELECT * FROM tPaciente;

SELECT * FROM tMedico;

SELECT * FROM tEspecialidad;

SELECT * FROM tEnfermedad;

SELECT * FROM tDiagnostico;
    
SELECT * FROM tEspecialidadDelMedico;

SELECT * FROM tEnfermedadEnElDiagnostico;


-- mostrar los nombres de los pacientes con las enfermedades que tengan

SELECT tpaciente.codP, tpaciente.nombresP, tpaciente.paternoP,
    tpaciente.maternoP, tdiagnostico.codD, tdiagnostico.descripcionD,
    tenfermedad.nombreE
FROM tpaciente
    JOIN tdiagnostico ON tpaciente.codP = tdiagnostico.codP
    JOIN tenfermedadeneldiagnostico 
    ON tdiagnostico.codD=tenfermedadeneldiagnostico.codD
    JOIN tenfermedad ON tenfermedadeneldiagnostico.codE = tenfermedad.codE;

-- uso de vista
CREATE VIEW v_pacienteEnfermedad(codigoP, nombresP, paternoP, maternoP, codigoD, nombreD, nombreE) 
    AS 
SELECT tpaciente.codP, tpaciente.nombresP, tpaciente.paternoP, tpaciente.maternoP, 
       tdiagnostico.codD, tdiagnostico.descripcionD, tenfermedad.nombreE 
FROM tpaciente 
    JOIN tdiagnostico ON tpaciente.codP = tdiagnostico.codP 
    JOIN tenfermedadeneldiagnostico 
    ON tdiagnostico.codD=tenfermedadeneldiagnostico.codD 
    JOIN tenfermedad ON tenfermedadeneldiagnostico.codE = tenfermedad.codE;
    
-- acceso a la vista como una tabla
SELECT * FROM V_PACIENTEENFERMEDAD;

---- visualizacion de cuántas enfermedades ha tenido un paciente con una consulta sencilla.
SELECT COUNT(*)cantidad_de_enfermedades, nombresP, paternoP, maternoP
FROM v_pacienteenfermedad
GROUP BY nombresP, paternoP, maternoP;

-------construccion de ejercicios adicionales 
--2.1. Crear una vista para mostrar todos los datos de los médicos y sus especialidades.
CREATE VIEW v_MedicoEspecialidad AS
SELECT m.codM, m.nombresM, m.paternoM, m.maternoM, m.tipoDocM, m.nroDocM, m.celularM, 
       e.codEsp, e.nombreEsp, 
       em.fechaDeObtencionDeLaEspecialidadEspM
FROM tMedico m
JOIN tEspecialidadDelMedico em ON m.codM = em.codM
JOIN tEspecialidad e ON em.codEsp = e.codEsp;
--visualizacion 
SELECT * FROM v_MedicoEspecialidad;

--2.2. A partir de la vista anterior, mostrar cuántas especialidades tiene cada médico.
SELECT nombresM, paternoM, maternoM, COUNT(codEsp) AS cantidad_especialidades
FROM v_MedicoEspecialidad
GROUP BY nombresM, paternoM, maternoM;
--visualizacion
SELECT nombresM, cantidad_especialidades FROM (
    SELECT nombresM, COUNT(codEsp) as cantidad_especialidades 
    FROM v_MedicoEspecialidad GROUP BY nombresM
);

--2.3. A partir de la vista anterior, mostrar solamente a los médicos que tengan 2 a más especialidades.
SELECT nombresM, paternoM, maternoM, COUNT(codEsp) AS cantidad_especialidades
FROM v_MedicoEspecialidad
GROUP BY nombresM, paternoM, maternoM
HAVING COUNT(codEsp) >= 2;
-- visualizacion 
SELECT * FROM v_EnfermedadesNoDetectadas;

--2.4. Crear una vista que muestre solamente a las enfermedades que aún no se hayan detectado en los diagnósticos de la Clínica.
CREATE VIEW v_EnfermedadesNoDetectadas AS
SELECT * FROM tEnfermedad
WHERE code NOT IN (SELECT codE FROM tEnfermedadEnElDiagnostico);

--2.5. Crear una vista que muestre a todas las especialidades para las cuales aún no se tengan médicos en la Clínica.
CREATE VIEW v_EspecialidadesSinMedico AS
SELECT *
FROM tEspecialidad
WHERE codEsp NOT IN (SELECT codEsp FROM tEspecialidadDelMedico);
--visualizacion:
SELECT * FROM v_EspecialidadesSinMedico;

--2.6. A partir de la vista anterior, mostrar cuántas especialidades aún no tienen médico en la Clínica.
SELECT COUNT(*) AS cantidad_sin_medico
FROM v_EspecialidadesSinMedico;

--2.7. Crear una vista que muestre los nombres de los pacientes cuyos diagnósticos no estén relacionados con ninguna enfermedad.
CREATE VIEW v_PacientesDiagSinEnfermedad AS
SELECT p.nombresP, p.paternoP, p.maternoP, d.descripcionD
FROM tPaciente p
JOIN tDiagnostico d ON p.codP = d.codP
WHERE d.codD NOT IN (SELECT codD FROM tEnfermedadEnElDiagnostico);
-- visualizacion
SELECT * FROM v_PacientesDiagSinEnfermedad;


--resumen estructura de vistas:
SELECT view_name, text FROM user_views;