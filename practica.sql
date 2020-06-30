SHOW search_path;
SET search_path TO practica_mia;

DROP TABLE IF EXISTS "DISCIPLINA_ATLETA";
DROP TABLE IF EXISTS "COSTO_EVENTO";
DROP TABLE IF EXISTS "TELEVISORA";
DROP TABLE IF EXISTS "EVENTO_ATLETA";
DROP TABLE IF EXISTS "EVENTO";
DROP TABLE IF EXISTS "SEDE";
DROP TABLE IF EXISTS "TIPO_PARTICIPACION";
DROP TABLE IF EXISTS "CATEGORIA";
DROP TABLE IF EXISTS "ATLETA";
DROP TABLE IF EXISTS "DISCIPLINA";
DROP TABLE IF EXISTS "MEDALLERO";
DROP TABLE IF EXISTS "TIPO_MEDALLA";
DROP TABLE IF EXISTS "PUESTO_MIEMBRO";
DROP TABLE IF EXISTS "MIEMBRO";
DROP TABLE IF EXISTS "DEPARTAMENTO";
DROP TABLE IF EXISTS "PUESTO";
DROP TABLE IF EXISTS "PAIS";
DROP TABLE IF EXISTS "PROFESION";

/*******************************************************************/
/* INCISO 1 ********************************************************/
/*******************************************************************/
/*Generar el script que crea cada una de las tablas que conforman la base de
datos propuesta por el Comité Olímpico.*/

/* TABLA 1: PROFESION */
CREATE TABLE "PROFESION"(
    cod_prof INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PROFESION_pk PRIMARY KEY(cod_prof),
    CONSTRAINT PROFESION_nombre UNIQUE(nombre)
);



/* TABLA 2: PAIS */
CREATE TABLE "PAIS"(
    cod_pais INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PAIS_pk PRIMARY KEY(cod_pais),
    CONSTRAINT PAIS_nombre UNIQUE(nombre)
);



/* TABLA 3: PUESTO */
CREATE TABLE "PUESTO"(
    cod_puesto INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PUESTO_pk PRIMARY KEY(cod_puesto),
    CONSTRAINT PUESTO_nombre UNIQUE(nombre)
);



/* TABLA 4: DEPARTAMENTO */
CREATE TABLE "DEPARTAMENTO"(
    cod_depto INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT DEPTO_pk PRIMARY KEY(cod_depto),
    CONSTRAINT DEPTO_nombre UNIQUE(nombre)
);



/* TABLA 5: MIEMBRO */
CREATE TABLE "MIEMBRO"(
    cod_miembro INTEGER NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    edad INTEGER NOT NULL,
    telefono INTEGER NULL,
    residencia VARCHAR(100) NULL,
    PAIS_cod_pais INTEGER NOT NULL,
    PROFESION_cod_prof INTEGER NOT NULL,
    CONSTRAINT MIEMBRO_pk PRIMARY KEY(cod_miembro),
    CONSTRAINT PAIS_cod_pais FOREIGN KEY (PAIS_cod_pais)
        REFERENCES "PAIS" (cod_pais),
    CONSTRAINT PROFESION_cod_prof FOREIGN KEY (PROFESION_cod_prof)
        REFERENCES "PROFESION" (cod_prof)        
);



/* TABLA 6: PUESTO_MIEMBRO */
CREATE TABLE "PUESTO_MIEMBRO"(
    MIEMBRO_cod_miembro INTEGER NOT NULL,
    PUESTO_cod_puesto INTEGER NOT NULL,
    DEPARTAMENTO_cod_depto INTEGER NOT NULL,    
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    CONSTRAINT PUESTO_MIEMBRO_PK PRIMARY KEY(MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto),
    CONSTRAINT MIEMBRO_cod_miembro FOREIGN KEY (MIEMBRO_cod_miembro)
        REFERENCES "MIEMBRO" (cod_miembro),
    CONSTRAINT PUESTO_cod_puesto FOREIGN KEY (PUESTO_cod_puesto)
        REFERENCES "PUESTO" (cod_puesto),    
    CONSTRAINT DEPARTAMENTO_cod_depto FOREIGN KEY (DEPARTAMENTO_cod_depto)
        REFERENCES "DEPARTAMENTO" (cod_depto)         
);



/* TABLA 7: TIPO_MEDALLA */
CREATE TABLE "TIPO_MEDALLA"(
    cod_tipo INTEGER NOT NULL,
    medalla VARCHAR(20) NOT NULL,
    CONSTRAINT TIPO_MEDALLA_pk PRIMARY KEY(cod_tipo),
    CONSTRAINT TIPO_MEDALLA_medalla UNIQUE(medalla)
);



/* TABLA 8: MEDALLERO */
CREATE TABLE "MEDALLERO"(
    PAIS_cod_pais INTEGER NOT NULL,
    cantidad_medallas INTEGER NOT NULL,
    TIPO_MEDALLA_cod_tipo INTEGER NOT NULL,
    CONSTRAINT MEDALLERO_pk PRIMARY KEY(PAIS_cod_pais, TIPO_MEDALLA_cod_tipo),
    CONSTRAINT PAIS_cod_pais_fk FOREIGN KEY (PAIS_cod_pais)
        REFERENCES "PAIS" (cod_pais),
    CONSTRAINT TIPO_MEDALLA_cod_tipo_fk FOREIGN KEY (TIPO_MEDALLA_cod_tipo)
        REFERENCES "TIPO_MEDALLA" (cod_tipo)        
    
);



/* TABLA 9: DISCIPLINA */
CREATE TABLE "DISCIPLINA"(
    cod_disciplina INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(150) NULL,    
    CONSTRAINT DISCIPLINA_pk PRIMARY KEY(cod_disciplina)
);



/* TABLA 10: ATLETA */
CREATE TABLE "ATLETA"(
    cod_atleta INTEGER NOT NULL,
    nombre CHARACTER(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,    
    edad INTEGER NOT NULL,
    participaciones VARCHAR(100) NOT NULL,    
    DISCIPLINA_cod_disciplina INTEGER NOT NULL,
    PAIS_cod_pais INTEGER NOT NULL,
    CONSTRAINT ATLETA PRIMARY KEY(cod_atleta),
    CONSTRAINT ATLETA_fk1 FOREIGN KEY (DISCIPLINA_cod_disciplina)
        REFERENCES "DISCIPLINA" (cod_disciplina),
    CONSTRAINT ATLETA_fk2 FOREIGN KEY (PAIS_cod_pais)
        REFERENCES "PAIS" (cod_pais)          
);



/* TABLA 11: CATEGORIA */
CREATE TABLE "CATEGORIA"(
    cod_categoria INTEGER NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    CONSTRAINT CATEGORIA_pk PRIMARY KEY(cod_categoria)
);



/* TABLA 12: TIPO_PARTICIPACION */
CREATE TABLE "TIPO_PARTICIPACION"(
    cod_participacion INTEGER NOT NULL,
    tipo_participacion VARCHAR(100) NOT NULL,
    CONSTRAINT TIPO_PARTICIPACION_pk PRIMARY KEY(cod_participacion)
);



/* TABLA 13: EVENTO */
CREATE TABLE "EVENTO"(
    cod_evento INTEGER NOT NULL,
    fecha DATE NOT NULL,
    ubicacion VARCHAR(50) NOT NULL,
    hora DATE NOT NULL,   
    DISCIPLINA_cod_disciplina INTEGER NOT NULL,
    TIPO_PARTICIPACION_cod_participacion INTEGER NOT NULL,
    CATEGORIA_cod_categoria INTEGER NOT NULL,
    CONSTRAINT EVENTO PRIMARY KEY(cod_evento),
    CONSTRAINT EVENTO_fk1 FOREIGN KEY (DISCIPLINA_cod_disciplina)
        REFERENCES "DISCIPLINA" (cod_disciplina),
    CONSTRAINT EVENTO_fk2 FOREIGN KEY (TIPO_PARTICIPACION_cod_participacion)
        REFERENCES "TIPO_PARTICIPACION" (cod_participacion),
    CONSTRAINT EVENTO_fk3 FOREIGN KEY (CATEGORIA_cod_categoria)
        REFERENCES "CATEGORIA" (cod_categoria) 
);



/* TABLA 14: EVENTO_ATLETA */
CREATE TABLE "EVENTO_ATLETA"(
    ATLETA_cod_atleta INTEGER NOT NULL,
    EVENTO_cod_evento INTEGER NOT NULL,	
    CONSTRAINT EVENTO_ATLETA_pk PRIMARY KEY(ATLETA_cod_atleta, EVENTO_cod_evento),
    CONSTRAINT EVENTO_ATLETA_fk1 FOREIGN KEY (ATLETA_cod_atleta)
        REFERENCES "ATLETA" (cod_atleta),
    CONSTRAINT EVENTO_ATLETA_fk2 FOREIGN KEY (EVENTO_cod_evento)
        REFERENCES "EVENTO" (cod_evento)
);



/* TABLA 15: TELEVISORA */
CREATE TABLE "TELEVISORA"(
    cod_televisora INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,	
    CONSTRAINT TELEVISORA_pk PRIMARY KEY(cod_televisora)
);



/* TABLA 16: COSTO_EVENTO */
CREATE TABLE "COSTO_EVENTO"(
    EVENTO_cod_evento INTEGER NOT NULL,
    TELEVISORA_cod_televisora INTEGER NOT NULL,
	tarifa INTEGER NOT NULL,
    CONSTRAINT COSTO_EVENTO_pk PRIMARY KEY(EVENTO_cod_evento, TELEVISORA_cod_televisora),
    CONSTRAINT COSTO_EVENTO_fk1 FOREIGN KEY (EVENTO_cod_evento)
        REFERENCES "EVENTO" (cod_evento),
    CONSTRAINT COSTO_EVENTO_fk2 FOREIGN KEY (TELEVISORA_cod_televisora)
        REFERENCES "TELEVISORA" (cod_televisora)
);



/*******************************************************************/
/* INCISO 2 ********************************************************/
/*******************************************************************/
ALTER TABLE "EVENTO" 
DROP COLUMN fecha,
DROP COLUMN hora,
ADD COLUMN fecha_hora timestamp;



/*******************************************************************/
/* INCISO 3 ********************************************************/
/*******************************************************************/
ALTER TABLE "EVENTO"
ADD CONSTRAINT ck_fecha_evento CHECK (fecha_hora BETWEEN '2020/07/24 9:00:00' AND '2020/08/09 20:00:00');



/*******************************************************************/
/* INCISO 4 ********************************************************/
/*******************************************************************/
/*A) Crear la tabla llamada "SEDE" que tendra los campos CODIGO, SEDE
TABLA 17: COSTO_EVENTO */
CREATE TABLE "SEDE"(
    codigo INTEGER NOT NULL,
    sede VARCHAR(50) NOT NULL,
    CONSTRAINT SEDE_pk PRIMARY KEY(codigo)
);

/*B) Cambiar el tipo de dato de la columna Ubicación de la tabla Evento por un tipo entero.*/
ALTER TABLE "EVENTO"
ALTER COLUMN ubicacion TYPE INTEGER USING ubicacion::INTEGER,
ALTER COLUMN ubicacion SET NOT NULL;

/*C) Crear una llave foránea en la columna Ubicación de la tabla Evento y
referenciarla a la columna código de la tabla Sede, la que fue creada
en el paso anterior.*/
ALTER TABLE "EVENTO"
ADD CONSTRAINT EVENTO_fk4 FOREIGN KEY (ubicacion)
	REFERENCES "SEDE" (codigo);



/*******************************************************************/
/* INCISO 5 ********************************************************/
/*******************************************************************/
ALTER TABLE "MIEMBRO"
ALTER COLUMN telefono SET DEFAULT 0;



/*******************************************************************/
/* INCISO 6 ********************************************************/
/*******************************************************************/
/*Generar el script necesario para hacer la inserción de datos a las tablas
requeridas.*/
INSERT INTO "PAIS"(cod_pais, nombre) VALUES 
(1, 'Guatemala'),
(2, 'Francia'),
(3, 'Argentina'),
(4, 'Alemania'),
(5, 'Italia'),
(6, 'Brasil'),
(7, 'Estados Unidos');

INSERT INTO "PROFESION" (cod_prof, nombre) VALUES
(1, 'Médico'),
(2, 'Arquitecto'),
(3, 'Ingeniero'),
(4, 'Secretaria'),
(5, 'Auditor');

INSERT INTO "MIEMBRO" (cod_miembro, nombre, apellido , edad, telefono, residencia, pais_cod_pais, profesion_cod_prof) VALUES
(1, 'Scott', 'Mitchell', 32, null, '1092 Highland Drive Manitowoc, WI 54220', 7, 3),
(2, 'Fanette', 'Poulin', 25, 25075853, '49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY', 2, 4),
(3, 'Laura', 'Cunha Silva', 55, null, 'Rua Onze, 86 Uberaba-MG', 6, 5),
(4, 'Juan José', 'López', 38, 36985247, '26 calle 4-10 zona 11', 1, 2),
(5, 'Arcangel', 'Panicucci', 39, 391664921, 'Via Santa Teresa, 114 90010-Geraci Siculo PA', 5, 1),
(6, 'Jeuel', 'Villalpando', 31, null, 'Acuña de Figeroa 6106 80101 Playa Pascual', 3, 5);

INSERT INTO "DISCIPLINA" (cod_disciplina, nombre, descripcion) VALUES
(1, 'Atletismo', 'Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martilo, jabalina y disco.'),
(2, 'Bádminton', null),
(3, 'Ciclismo', null),
(4, 'Judo', 'Es un arte marcial que se originó en Japón alrededor de 1880'),
(5, 'Lucha', null),
(6, 'Tenis de Mesa', null),
(7, 'Boxeo', null),
(8, 'Natación', 'Está presente como deporte en los juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.'),
(9, 'Esgrima', null),
(10, 'Vela', null);

INSERT INTO "TIPO_MEDALLA" (cod_tipo, medalla) VALUES
(1, 'Oro'),
(2, 'Plata'),
(3, 'Bronce'),
(4, 'Platino');

INSERT INTO "CATEGORIA" (cod_categoria, categoria) VALUES
(1, 'Clasificatorio'),
(2, 'Eliminatorio'),
(3, 'Final');

INSERT INTO "TIPO_PARTICIPACION" (cod_participacion, tipo_participacion) VALUES
(1, 'Individuales'),
(2, 'Parejas'),
(3, 'Equipos');

INSERT INTO "MEDALLERO" (pais_cod_pais, tipo_medalla_cod_tipo, cantidad_medallas) VALUES
(5, 1, 3),
(2, 1, 5),
(6, 3, 4),
(4, 4, 3),
(7, 3, 10),
(3, 2, 8),
(1, 1, 2),
(1, 4, 5),
(5, 2, 7);

INSERT INTO "SEDE" (codigo, sede) VALUES
(1, 'Gimnasio Metropolitano de Tokio'),
(2, 'Jardín del Palacio Imperial de Tokio'),
(3, 'Gimnasio Nacional Yoyogi'),
(4, 'Nippon Budokan'),
(5, 'Estadio Olímpico');

INSERT INTO "EVENTO" (cod_evento, fecha_hora, ubicacion, disciplina_cod_disciplina, tipo_participacion_cod_participacion, categoria_cod_categoria) VALUES
(1, '2020/07/24 11:00:00', 3, 2, 2, 1),
(2, '2020/07/26 10:30:00', 1, 6, 1, 3),
(3, '2020/07/30 18:45:00', 5, 7, 1, 2),
(4, '2020/08/01 12:15:00', 2, 1, 1, 1),
(5, '2020/08/08 19:35:00', 4, 10, 3, 1);



/*******************************************************************/
/* INCISO 7 ********************************************************/
/*******************************************************************/
/*Después de que se implementó el script el cuál creó todas las tablas de las
bases de datos, el Comité Olímpico Internacional tomó la decisión de
eliminar la restricción “UNIQUE” de las siguientes tablas:
Elabore el script que elimine las restricciones “UNIQUE” de las columnas
antes mencionadas.*/
ALTER TABLE "PAIS"
DROP CONSTRAINT PAIS_nombre;

ALTER TABLE "TIPO_MEDALLA"
DROP CONSTRAINT TIPO_MEDALLA_medalla;

ALTER TABLE "DEPARTAMENTO"
DROP CONSTRAINT DEPTO_nombre;



/*******************************************************************/
/* INCISO 8 ********************************************************/
/*******************************************************************/
/*A). Script que elimine la llave foránea de “cod_disciplina” que se
encuentra en la tabla “Atleta”.*/
ALTER TABLE "ATLETA"
DROP CONSTRAINT ATLETA_fk1,
DROP COLUMN DISCIPLINA_cod_disciplina;

/*B) Script que cree una tabla con el nombre “Disciplina_Atleta” que
contendrá los siguiente campos: La llave primaria será la unión de las llaves foráneas “cod_atleta” y
“cod_disciplina”.*/
/* TABLA 18: DISCIPLINA_ATLETA */
CREATE TABLE "DISCIPLINA_ATLETA"(
    ATLETA_cod_atleta INTEGER NOT NULL,
    DISCIPLINA_cod_disciplina INTEGER NOT NULL,
    CONSTRAINT DISCIPLINA_ATLETA_pk PRIMARY KEY(ATLETA_cod_atleta, DISCIPLINA_cod_disciplina),
    CONSTRAINT DISCIPLINA_ATLETA_fk1 FOREIGN KEY (ATLETA_cod_atleta)
        REFERENCES "ATLETA" (cod_atleta),
    CONSTRAINT DISCIPLINA_ATLETA_fk2 FOREIGN KEY (DISCIPLINA_cod_disciplina)
        REFERENCES "DISCIPLINA" (cod_disciplina)        
);



/*******************************************************************/
/* INCISO 9 ********************************************************/
/*******************************************************************/
/*En la tabla “Costo_Evento” se determinó que la columna “tarifa” no debe
ser entero sino un decimal con 2 cifras de precisión.
Generar el script correspondiente para modificar el tipo de dato que se le
pide.*/
ALTER TABLE "COSTO_EVENTO"
ALTER COLUMN tarifa SET DATA TYPE numeric(20, 2);



/*******************************************************************/
/* INCISO 10 ********************************************************/
/*******************************************************************/
/*Generar el Script que borre de la tabla “Tipo_Medalla”, el registro siguiente:*/
DELETE FROM "MEDALLERO" WHERE tipo_medalla_cod_tipo=4;
DELETE FROM "TIPO_MEDALLA" WHERE cod_tipo=4;



/*******************************************************************/
/* INCISO 11 ********************************************************/
/*******************************************************************/
/*La fecha de las olimpiadas está cerca y los preparativos siguen, pero de
último momento se dieron problemas con las televisoras encargadas de
transmitir los eventos, ya que no hay tiempo de solucionar los problemas
que se dieron, se decidió no transmitir el evento a través de las televisoras
por lo que el Comité Olímpico pide generar el script que elimine la tabla
“TELEVISORAS” y “COSTO_EVENTO”.*/
DROP TABLE "COSTO_EVENTO";
DROP TABLE "TELEVISORA";



/*******************************************************************/
/* INCISO 12 ********************************************************/
/*******************************************************************/
/*El comité olímpico quiere replantear las disciplinas que van a llevarse a cabo,
por lo cual pide generar el script que elimine todos los registros contenidos
en la tabla “DISCIPLINA”.*/
TRUNCATE "EVENTO_ATLETA","DISCIPLINA_ATLETA", "DISCIPLINA","EVENTO";



/*******************************************************************/
/* INCISO 13 *******************************************************/
/*******************************************************************/
/*Los miembros que no tenían registrado su número de teléfono en sus
perfiles fueron notificados, por lo que se acercaron a las instalaciones de
Comité para actualizar sus datos.*/
UPDATE "MIEMBRO" SET telefono = 55464601 WHERE nombre = 'Laura' AND apellido = 'Cunha Silva';
UPDATE "MIEMBRO" SET telefono = 91514243 WHERE nombre = 'Jeuel' AND apellido = 'Villalpando';
UPDATE "MIEMBRO" SET telefono = 92068667 WHERE nombre = 'Scott' AND apellido = 'Mitchell';



/*******************************************************************/
/* INCISO 14 *******************************************************/
/*******************************************************************/
/*El Comité decidió que necesita la fotografía en la información de los atletas
para su perfil, por lo que se debe agregar la columna “Fotografía” a la tabla
Atleta, debido a que es un cambio de última hora este campo deberá ser
opcional.
Utilice el tipo de dato que crea*/
ALTER TABLE "ATLETA"
	ADD COLUMN fotografia VARCHAR(50) NULL;



/*******************************************************************/
/* INCISO 15 *******************************************************/
/*******************************************************************/
/*Todos los atletas que se registren deben cumplir con ser menores a 25 años.
De lo contrario no se debe poder registrar a un atleta en la base de datos.*/
ALTER TABLE "ATLETA"
	ADD CONSTRAINT ATLETA_EDAD_ck CHECK (edad < 25);




