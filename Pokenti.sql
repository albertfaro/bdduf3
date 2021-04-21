DROP TABLE IF EXISTS currentpokentis_currentstats;
DROP TABLE IF EXISTS catchedpokentis_currentstats;
DROP TABLE IF EXISTS currentpokentis;
DROP TABLE IF EXISTS catchedpokentis;
DROP TABLE IF EXISTS pokentis_evolutions;
DROP TABLE IF EXISTS pokentis_types;
DROP TABLE IF EXISTS evolutions_types;
DROP TABLE IF EXISTS evolutions;
DROP TABLE IF EXISTS startingstats;
DROP TABLE IF EXISTS currentstats;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS pokentis;
CREATE TABLE pokentis (
	id_pokenti INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(24) NOT NULL,
	pokentinumber INT NOT NULL);

INSERT INTO pokentis (name,pokentinumber) VALUES
('Bulbasaur',2),
('Charmander',11),
('Squirtle',1),
('Caterpie',4),
('Weedle',3),
('Pidgey',13),
('Rattata',6),
('Spearow',12),
('Ekans',7),
('Sandshrew',5),
('Nidoran',14),
('Vulpix',10),
('Zubat',8),
('Oddish',15),
('Paras',9),
('Diglett',6);

CREATE TABLE currentpokentis(
id_currentpokenti INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_pokenti INT UNSIGNED NOT NULL,
FOREIGN KEY (id_pokenti) REFERENCES pokentis(id_pokenti)
);

INSERT INTO currentpokentis(id_pokenti) VALUES
(2),
(11);

CREATE TABLE catchedpokentis(
id_catchedpokenti INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_pokenti INT UNSIGNED NOT NULL,
FOREIGN KEY (id_pokenti) REFERENCES pokentis(id_pokenti)
);

INSERT INTO catchedpokentis(id_pokenti) VALUES
(9),
(15),
(6);

CREATE TABLE startingstats(
id_stat INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
hp INT NOT NULL,
attack INT NOT NULL,
defense INT NOT NULL,
id_pokenti INT UNSIGNED NOT NULL,
FOREIGN KEY (id_pokenti) REFERENCES pokentis(id_pokenti)
);

INSERT INTO startingstats (hp,attack,defense,id_pokenti) VALUES
(100,10,20,1),
(120,20,10,2),
(180,50,30,3),
(10,10,50,4),
(230,30,20,5),
(20,25,100,6),
(70,35,250,7),
(500,55,10,8),
(200,25,60,9),
(10,100,80,10),
(190,10,100,11),
(200,100,70,12),
(130,120,25,13),
(150,50,80,14),
(300,200,900,15),
(210,150,120,16);

CREATE TABLE currentstats(
id_currentstat INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
level INT NOT NULL,
hp INT NOT NULL,
attack INT NOT NULL,
defense INT NOT NULL
);

INSERT INTO currentstats(level,hp,attack,defense) VALUES
(30,20,80,50),
(28,185,80,200),
(15,250,60,120),
(10,350,300,1000),
(3,22,30,110);

CREATE TABLE currentpokentis_currentstats(
id_currentpokenti_currentstat INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_currentpokenti INT UNSIGNED NOT NULL,
id_currentstat INT UNSIGNED NOT NULL,
FOREIGN KEY(id_currentpokenti) REFERENCES currentpokentis(id_currentpokenti),
FOREIGN KEY(id_currentstat) REFERENCES currentstats(id_currentstat)
);

INSERT INTO currentpokentis_currentstats(id_currentpokenti,id_currentstat) VALUES
(1,1),
(2,2);

CREATE TABLE catchedpokentis_currentstats(
id_catchedpokenti_currentstat INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_catchedpokenti INT UNSIGNED NOT NULL,
id_currentstat INT UNSIGNED NOT NULL,
FOREIGN KEY(id_catchedpokenti) REFERENCES catchedpokentis(id_catchedpokenti),
FOREIGN KEY(id_currentstat) REFERENCES currentstats(id_currentstat)
);
INSERT INTO catchedpokentis_currentstats(id_catchedpokenti,id_currentstat) VALUES
(1,3),
(2,4),
(3,5);

CREATE TABLE types(
id_type INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
type VARCHAR(16) NOT NULL
);

INSERT INTO types(type) VALUES
('Fire'),
('Water'),
('Earth'),
('Air'),
('Demon'),
('JacintoLike');

CREATE TABLE pokentis_types(
id_pokenti_type INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_pokenti INT UNSIGNED NOT NULL,
id_type INT UNSIGNED NOT NULL,
FOREIGN KEY(id_pokenti) REFERENCES pokentis(id_pokenti),
FOREIGN KEY(id_type) REFERENCES types(id_type)
);

INSERT INTO pokentis_types(id_pokenti,id_type) VALUES
(1,2),
(2,1),
(3,4),
(4,5),
(5,5),
(6,3),
(7,1),
(8,2),
(9,3),
(10,2),
(11,5),
(12,3),
(13,4),
(14,1),
(15,6),
(16,2);


CREATE TABLE evolutions(
id_evolution INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
evolution VARCHAR(16) NOT NULL
);

INSERT INTO evolutions(evolution) VALUES
('Dugtrio'),
('Parasect'),
('Gloom'),
('Golbat'),
('Ninetales'),
('Nidoqueen'),
('Sandslash'),
('Arbok'),
('Fearow'),
('Raticate'),
('Pidgeotto'),
('Kakuna'),
('Metapod'),
('Wartortle'),
('Charmeleon'),
('Ivysaur');


CREATE TABLE evolutions_types(
id_evolution_type INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_evolution INT UNSIGNED NOT NULL,
id_type INT UNSIGNED NOT NULL,
FOREIGN KEY(id_evolution) REFERENCES evolutions(id_evolution),
FOREIGN KEY(id_type) REFERENCES types(id_type)
);

INSERT INTO evolutions_types(id_evolution,id_type) VALUES
(1,2),
(2,6),
(3,5),
(4,1),
(5,2),
(6,4),
(7,2),
(8,3),
(9,2),
(10,1),
(11,5),
(12,4),
(13,3),
(14,2),
(15,1),
(16,4);




CREATE TABLE pokentis_evolutions(
id_pokenti_evolution INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_pokenti INT UNSIGNED NOT NULL,
id_evolution INT UNSIGNED NOT NULL,
FOREIGN KEY(id_pokenti) REFERENCES pokentis(id_pokenti),
FOREIGN KEY(id_evolution) REFERENCES evolutions(id_evolution)
);

INSERT INTO pokentis_evolutions(id_pokenti,id_evolution) VALUES
(1,16),
(2,15),
(3,14),
(4,13),
(5,12),
(6,11),
(7,10),
(8,9),
(9,8),
(10,7),
(11,6),
(12,5),
(13,4),
(14,3),
(15,2),
(16,1);


DELIMITER ;
DROP PROCEDURE IF EXISTS usepokenti;

DELIMITER //

CREATE PROCEDURE usepokenti(
IN in_id_pokenti INT UNSIGNED)
BEGIN
INSERT INTO currentpokentis (id_pokenti) VALUES (in_id_pokenti);
DELETE FROM catchedpokentis WHERE id_pokenti=in_id_pokenti LIMIT 1;
END //


DELIMITER ;
DROP PROCEDURE IF EXISTS storepokenti;

DELIMITER //

CREATE PROCEDURE storepokenti(
IN in_id_pokenti INT UNSIGNED)
BEGIN
INSERT INTO catchedpokentis (id_pokenti) VALUES (in_id_pokenti);
DELETE FROM currentpokentis WHERE id_pokenti=in_id_pokenti LIMIT 1;
END //



