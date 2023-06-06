CREATE OR REPLACE TYPE tFamilia AS OBJECT (
    idFamilia int,
    familia varchar(50)
   );


-- 3
CREATE TABLE familia OF tFamilia (
  idFamilia PRIMARY KEY
);

--4
insert into familia values (1, 'Aves');
insert into familia values (2, 'Mamíferos');
insert into familia values (3, 'Peces');

--5
CREATE TYPE tNombres AS VARRAY(20) OF VARCHAR(50);

--6
CREATE TYPE tAnimal AS OBJECT (
  idAnimal INT,
  idFamilia INT,
  Animal VARCHAR2(50),
  nombres tNombres,
  
  MEMBER FUNCTION ejemplares RETURN VARCHAR2
) NOT FINAL;


CREATE TYPE BODY tAnimal AS
  MEMBER FUNCTION ejemplares RETURN VARCHAR2 IS
  BEGIN
    RETURN 'Hay ' || nombres.COUNT || ' animales de la especie ' || Animal;
  END ejemplares;
END;

-- 7
CREATE TABLE Animal OF tAnimal;


--8 
ALTER TABLE Animal ADD PRIMARY KEY (idAnimal);
ALTER TABLE Animal ADD FOREIGN KEY (idFamilia) REFERENCES Familia(idFamilia);

-- 9

INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (1, 1,'Garza Real', tNombres('Calíope', 'Izaro'));
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (2, 1,'Cigueña Blanca', tNombres('Perica', 'Clara', 'Miranda'));
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (3, 1, 'Gorrión', tNombres('coco', 'roco', 'loco', 'peco', 'rico'));


-- Insertar filas de los tres mamíferos
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (4, 2, 'Zorro', tNombres('Lucas', 'Mario'));
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (5, 2, 'Lobo', tNombres('Pedro', 'Pablo'));
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (6, 2, 'Ciervo', tNombres('Bravo', 'Listo', 'Astuto'));

--FIlas de los tres peces
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (7, 3, 'Pez Globo', tNombres('Nemo', 'Dory'));
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (8, 3, 'Pez Payaso', tNombres('Diego', 'Allam'));
INSERT INTO Animal (idAnimal, idFamilia, Animal, nombres) VALUES (9, 3, 'Ángel llama', tNombres('Carla', 'Amelia'));

--10
--Select para obtener listado
SELECT a.Animal, f.familia, a.ejemplares() AS ejemplares
FROM Animal a
JOIN Familia f ON a.idFamilia = f.idFamilia;





