DROP TABLE IF EXISTS coasters.rollercoasterElement;
DROP TABLE IF EXISTS coasters.rollercoaster;
DROP TABLE IF EXISTS coasters.element;
DROP TABLE IF EXISTS coasters.manufacturer;
DROP TABLE IF EXISTS coasters.themePark;
DROP TABLE IF EXISTS coasters.parentCompany;
DROP TABLE IF EXISTS coasters.country;
DROP TABLE IF EXISTS coasters.status;
DROP TABLE IF EXISTS coasters.material;

DROP SCHEMA IF EXISTS coasters;
CREATE SCHEMA coasters;

CREATE TABLE coasters.material (
	materialID serial PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE coasters.status (
	statusID serial PRIMARY KEY,
    name varchar(50) NOT NULL
);

CREATE TABLE coasters.country (
	countryID serial PRIMARY KEY,
    name varchar(50) NOT NULL,
	ISOCode varchar(5) NOT NULL
);

CREATE TABLE coasters.parentCompany (
	parentCompanyID serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    website varchar(250),
    countryID int NOT NULL,
    CONSTRAINT FK_parentCompany_country
		FOREIGN KEY (countryID)
		REFERENCES coasters.country(countryID)
);

CREATE TABLE coasters.themePark (
	themeParkID serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    openingDate date,
    city varchar(100) NOT NULL,
    website varchar(250),
    countryID int NOT NULL,
    parentCompanyID int,
    CONSTRAINT FK_themePark_country
		FOREIGN KEY (countryID)
		REFERENCES coasters.country(countryID),
	CONSTRAINT FK_themePark_parentCompany
		FOREIGN KEY (parentCompanyID)
		REFERENCES coasters.parentCompany(parentCompanyID)
);

CREATE TABLE coasters.manufacturer (
	manufacturerID serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    countryID int NOT NULL,
    CONSTRAINT FK_manufacturer_country
		FOREIGN KEY (countryID)
		REFERENCES coasters.country(countryID)
);

CREATE TABLE coasters.element (
	elementID serial PRIMARY KEY,
    name varchar(100) NOT NULL
);

CREATE TABLE coasters.rollercoaster (
	rollercoasterID serial PRIMARY KEY,
    name varchar(100) NOT NULL,
    openingDate date NOT NULL,
    closureDate date,
    length DOUBLE PRECISION,
    height DOUBLE PRECISION,
    maximumSpeed DOUBLE PRECISION,
    inversions int NOT NULL,
    durationInSeconds int,
    materialID int NOT NULL,
    manufacturerID int NOT NULL,
    themeParkID int NOT NULL,
    statusID int NOT NULL,
    CONSTRAINT FK_rollercoaster_material
		FOREIGN KEY (materialID)
		REFERENCES coasters.material(materialID),
	CONSTRAINT FK_rollercoaster_manufacturer
		FOREIGN KEY (manufacturerID)
		REFERENCES coasters.manufacturer(manufacturerID),
	CONSTRAINT FK_rollercoaster_themePark
		FOREIGN KEY (themeParkID)
		REFERENCES coasters.themePark(themeParkID),
	CONSTRAINT FK_rollercoaster_status
		FOREIGN KEY (statusID)
		REFERENCES coasters.status(statusID)
);

CREATE TABLE coasters.rollercoasterElement (
	rollercoasterID int,
    elementID int,
    comment varchar(250),
    CONSTRAINT PK_rollercoasterElement PRIMARY KEY(rollercoasterID, elementID),
    CONSTRAINT FK_rollercoasterElement_rollercoaster
		FOREIGN KEY (rollercoasterID)
		REFERENCES coasters.rollercoaster(rollercoasterID),
	CONSTRAINT FK_rollercoasterElement_element
		FOREIGN KEY (elementID)
		REFERENCES coasters.element(elementID)
);

INSERT INTO coasters.status VALUES (1, 'Operating');
INSERT INTO coasters.status VALUES (2, 'Removed');
INSERT INTO coasters.status VALUES (3, 'In storage (never operational)');

INSERT INTO coasters.country VALUES (1, 'Belgium', 'BE');
INSERT INTO coasters.country VALUES (2, 'Netherlands', 'NL');
INSERT INTO coasters.country VALUES (3, 'Germany', 'DE');
INSERT INTO coasters.country VALUES (4, 'France', 'FR');
INSERT INTO coasters.country VALUES (5, 'United States of America', 'US');
INSERT INTO coasters.country VALUES (6, 'Italy', 'IT');
INSERT INTO coasters.country VALUES (7, 'Switzerland', 'CH');
INSERT INTO coasters.country VALUES (8, 'Liechtenstein', 'LI');
INSERT INTO coasters.country VALUES (9, 'Austria', 'AT');
INSERT INTO coasters.country VALUES (10, 'Spain', 'ES');
INSERT INTO coasters.country VALUES (11, 'United Kingdom', 'UK');
INSERT INTO coasters.country VALUES (12, 'Türkiye', 'TR');

INSERT INTO coasters.material VALUES (1, 'Steel');
INSERT INTO coasters.material VALUES (2, 'Wood');

INSERT INTO coasters.manufacturer VALUES (1, 'Vekoma', 2);
INSERT INTO coasters.manufacturer VALUES (2, 'Mack Rides GmbH & Co KG', 3);
INSERT INTO coasters.manufacturer VALUES (3, 'Gerstlauer Amusement Rides GmbH', 3);
INSERT INTO coasters.manufacturer VALUES (4, 'Maurer Rides GmbH', 3);
INSERT INTO coasters.manufacturer VALUES (5, 'Schwarzkopf', 3);
INSERT INTO coasters.manufacturer VALUES (6, 'Zierer', 3);
INSERT INTO coasters.manufacturer VALUES (7, 'Great Coasters International', 5);
INSERT INTO coasters.manufacturer VALUES (8, 'Reverchon', 4);
INSERT INTO coasters.manufacturer VALUES (9, 'Pinfari', 6);
INSERT INTO coasters.manufacturer VALUES (10, 'Caripro', 2);
INSERT INTO coasters.manufacturer VALUES (11, 'Bolliger & Mabillard', 7);
INSERT INTO coasters.manufacturer VALUES (12, 'KumbaK "The Amusement Engineers"', 2);
INSERT INTO coasters.manufacturer VALUES (13, 'Intamin Amusement Rides', 8);
INSERT INTO coasters.manufacturer VALUES (14, 'Wiegand', 3);
INSERT INTO coasters.manufacturer VALUES (15, 'Doppelmayr', 9);
INSERT INTO coasters.manufacturer VALUES (16, 'Rocky Mountain Construction', 5);
INSERT INTO coasters.manufacturer VALUES (17, 'Zamperla', 6);
INSERT INTO coasters.manufacturer VALUES (18, 'SBF Visa Group', 6);
INSERT INTO coasters.manufacturer VALUES (19, 'Sunkid GmbH', 3);
INSERT INTO coasters.manufacturer VALUES (20, 'DAL Amusement Rides Company', 12);
INSERT INTO coasters.manufacturer VALUES (21, 'ART Engineering GmbH', 3);
INSERT INTO coasters.manufacturer VALUES (22, 'Preston & Barbieri', 6);
INSERT INTO coasters.manufacturer VALUES (23, 'Premier Rides', 5);
INSERT INTO coasters.manufacturer VALUES (24, 'Roller Coaster Corporation of America', 5);
INSERT INTO coasters.manufacturer VALUES (25, 'abc rides', 7);
INSERT INTO coasters.manufacturer VALUES (26, 'Ride Engineers Switzerland', 7);

INSERT INTO coasters.parentCompany VALUES (1, 'Parques Reunidos', 'https://www.parquesreunidos.com/', 10);
INSERT INTO coasters.parentCompany VALUES (2, 'Compagnie des Alpes', 'https://www.compagniedesalpes.com/', 4);
INSERT INTO coasters.parentCompany VALUES (3, 'Studio 100', 'https://studio100.com/', 1);
INSERT INTO coasters.parentCompany VALUES (4, 'Merlin Entertainments', 'https://www.merlinentertainments.biz/', 11);
INSERT INTO coasters.parentCompany VALUES (5, 'Aspro Parks', 'https://www.asproparks.com/', 10);
INSERT INTO coasters.parentCompany VALUES (6, 'Looping Group', 'https://www.looping-group.com/', 4);

INSERT INTO coasters.themePark VALUES(1, 'Bobbejaanland', '1961-12-31', 'Lichtaart', 'https://www.bobbejaanland.be/', 1, 1);
INSERT INTO coasters.themePark VALUES(2, 'Walibi Belgium', '1975-07-26', 'Wavre', 'https://www.walibi.be/', 1, 2);
INSERT INTO coasters.themePark VALUES(3, 'Bellewaerde Park', '1954-07-03', 'Ypres', 'https://www.bellewaerde.be/', 1, 2);
INSERT INTO coasters.themePark VALUES(4, 'Boudewijn Seapark', '1963-01-01', 'Bruges', 'https://www.boudewijnseapark.be/', 1, 2);
INSERT INTO coasters.themePark VALUES(5, 'Plopsa Coo', '1976-01-01', 'Stavelot', 'https://www.plopsacoo.be/', 1, 3);
INSERT INTO coasters.themePark VALUES(6, 'Plopsa Indoor Hasselt', '2005-12-24', 'Hasselt', 'https://www.plopsaindoorhasselt.be/', 1, 3);
INSERT INTO coasters.themePark VALUES(7, 'Plopsaland De Panne', '1935-04-21', 'Adinkerke-De Panne', 'https://www.plopsalanddepanne.be/', 1, 3);
INSERT INTO coasters.themePark VALUES(8, 'Avonturenpark Hellendoorn', '1936-01-01', 'Hellendoorn', 'https://www.avonturenpark.nl/', 2, 6);
INSERT INTO coasters.themePark VALUES(9, 'Drievliet Family Park', '1938-01-01', 'The Hague', 'https://www.drievliet.nl/', 2, null);
INSERT INTO coasters.themePark VALUES(10, 'Duinrell', '1935-04-19', 'Wassenaar', 'https://www.duinrell.nl/', 2, null);
INSERT INTO coasters.themePark VALUES(11, 'Efteling', '1952-05-31', 'Kaatsheuvel', 'https://www.efteling.com/', 2, null);
INSERT INTO coasters.themePark VALUES(12, 'Julianatoren', '1910-04-15', 'Apeldoorn', 'https://www.julianatoren.nl/', 2, null);
INSERT INTO coasters.themePark VALUES(13, 'Plopsa Indoor Coevorden', '2010-04-30', 'Dalen', 'https://www.plopsaindoorcoevorden.nl/', 2, 3);
INSERT INTO coasters.themePark VALUES(14, 'Slagharen themePark & Resort', '1963-01-01', 'Slagharen', 'https://www.slagharen.com/', 2, 1);
INSERT INTO coasters.themePark VALUES(15, 'Toverland', '2001-05-19', 'Sevenum', 'https://www.toverland.com/', 2, null);
INSERT INTO coasters.themePark VALUES(16, 'Walibi Holland', '1971-05-21', 'Biddinghuizen', 'https://www.walibi.nl/', 2, 2);
INSERT INTO coasters.themePark VALUES(17, 'Wildlands Adventure Zoo Emmen', '2016-03-26', 'Emmen', 'https://www.wildlands.nl/', 2, null);
INSERT INTO coasters.themePark VALUES(18, 'Belantis', '2003-04-05', 'Leipzig', 'https://www.belantis.de/', 3, 1);
INSERT INTO coasters.themePark VALUES(19, 'Eifelpark', '1964-01-01', 'Gondorf', 'https://www.eifelpark.de/', 3, null);
INSERT INTO coasters.themePark VALUES(20, 'Europa Park', '1975-07-12', 'Rust', 'https://www.europapark.de/', 3, null);
INSERT INTO coasters.themePark VALUES(21, 'Fort Fun Abenteuerland', '1972-01-01', 'Wasserfall', 'https://fortfun.de/', 3, 6);
INSERT INTO coasters.themePark VALUES(22, 'Hansa-Park', '1973-01-01', 'Sierksdorf', 'https://www.hansapark.de/', 3, null);
INSERT INTO coasters.themePark VALUES(23, 'Holiday Park', '1971-01-01', 'Hassloch', 'https://www.holidaypark.de/', 3, 3);
INSERT INTO coasters.themePark VALUES(24, 'Legoland Deutschland', '2002-05-17', 'Günzburg', 'https://www.legoland.de/', 3, 4);
INSERT INTO coasters.themePark VALUES(25, 'Movie Park Germany', '1967-07-07', 'Bottrop', 'https://www.movieparkgermany.de/', 3, 1);
INSERT INTO coasters.themePark VALUES(26, 'Phantasialand', '1967-04-30', 'Brühl', 'https://www.phantasialand.de/', 3, null);
INSERT INTO coasters.themePark VALUES(27, 'Potts Park', '1969-01-01', 'Minden', 'https://www.pottspark-minden.de/', 3, null);
INSERT INTO coasters.themePark VALUES(28, 'Schwaben Park', '1972-01-01', 'Kaisersbach', 'https://www.schwabenpark.de/', 3, null);

INSERT INTO coasters.element VALUES (1, 'Chain Lift Hill');
INSERT INTO coasters.element VALUES (2, 'Turntable');
INSERT INTO coasters.element VALUES (3, 'LSM Launch (multi-pass)');
INSERT INTO coasters.element VALUES (4, 'Jr. Scorpion Tail');
INSERT INTO coasters.element VALUES (5, 'Top Hat - Outside');
INSERT INTO coasters.element VALUES (6, 'Wraparound Corkscrew');
INSERT INTO coasters.element VALUES (7, 'Corkscrew');
INSERT INTO coasters.element VALUES (8, 'Booster Wheel Lift Hill');
INSERT INTO coasters.element VALUES (9, 'Vertical Chain Lift Hill');
INSERT INTO coasters.element VALUES (10, 'Loop');
INSERT INTO coasters.element VALUES (11, 'Double Heartline Roll');
INSERT INTO coasters.element VALUES (12, 'Helix');
INSERT INTO coasters.element VALUES (13, 'Heartline Roll');
INSERT INTO coasters.element VALUES (14, 'Catch Car Lift Hill');
INSERT INTO coasters.element VALUES (15, 'Cobra Roll');
INSERT INTO coasters.element VALUES (16, 'Hill');
INSERT INTO coasters.element VALUES (17, 'Outward Banked Airtime Hill');
INSERT INTO coasters.element VALUES (18, 'Non Inverting Cobra Roll');
INSERT INTO coasters.element VALUES (19, 'LIM Launch');
INSERT INTO coasters.element VALUES (20, 'Vertical Rollback');
INSERT INTO coasters.element VALUES (21, 'Splash Track');
INSERT INTO coasters.element VALUES (22, 'Roll Over');
INSERT INTO coasters.element VALUES (23, 'Sidewinder');
INSERT INTO coasters.element VALUES (24, 'Double In-Line Twist');
INSERT INTO coasters.element VALUES (25, 'Electric Spiral Lift');
INSERT INTO coasters.element VALUES (26, 'Double Corkscrew');
INSERT INTO coasters.element VALUES (27, 'Elevator Lift');
INSERT INTO coasters.element VALUES (28, 'Dark/Show Section');
INSERT INTO coasters.element VALUES (29, 'Dive Loop');
INSERT INTO coasters.element VALUES (30, 'Immelmann');
INSERT INTO coasters.element VALUES (31, 'LSM Launch (rolling)');
INSERT INTO coasters.element VALUES (32, 'LSM Launch');
INSERT INTO coasters.element VALUES (33, 'Banana Roll');
INSERT INTO coasters.element VALUES (34, 'Zero-G Roll');
INSERT INTO coasters.element VALUES (35, 'LSM Boost');
INSERT INTO coasters.element VALUES (36, 'Step-Up Under Flip');
INSERT INTO coasters.element VALUES (37, 'Over-Banked Curve');
INSERT INTO coasters.element VALUES (38, 'Cutback');
INSERT INTO coasters.element VALUES (39, 'Tunnel');
INSERT INTO coasters.element VALUES (40, 'Hydraulic Launch');
INSERT INTO coasters.element VALUES (41, 'Dive Drop');
INSERT INTO coasters.element VALUES (42, 'Cable Lift Hill');
INSERT INTO coasters.element VALUES (43, 'Stengel Dive');
INSERT INTO coasters.element VALUES (44, 'Double Inverting Stall');
INSERT INTO coasters.element VALUES (45, 'Over-Banked Inversion');
INSERT INTO coasters.element VALUES (46, 'Barrel Roll');
INSERT INTO coasters.element VALUES (47, 'Sea Serpent');
INSERT INTO coasters.element VALUES (48, 'Interlocking Corkscrews');
INSERT INTO coasters.element VALUES (49, 'Splash Down');
INSERT INTO coasters.element VALUES (50, 'Water Channel');
INSERT INTO coasters.element VALUES (51, 'Block Brake');
INSERT INTO coasters.element VALUES (52, 'Twisted Horseshoe Roll');
INSERT INTO coasters.element VALUES (53, 'In-Line Twist');
INSERT INTO coasters.element VALUES (54, 'Spiral Lift');
INSERT INTO coasters.element VALUES (55, 'Non Inverting Loop');
INSERT INTO coasters.element VALUES (56, 'Twisted Vertical Rollback');
INSERT INTO coasters.element VALUES (57, 'Tire Propelled Launch');
INSERT INTO coasters.element VALUES (58, 'Tire Propelled Launch (rolling)');
INSERT INTO coasters.element VALUES (59, 'Jr. Immelmann');
INSERT INTO coasters.element VALUES (60, 'Horseshoe');

/* Bobbejaanland */
INSERT INTO coasters.rollercoaster VALUES(1, 'Bob Express', '2000-05-15', null, 521, 10, 36, 0, 150, 1, 2, 1, 1);
INSERT INTO coasters.rollercoaster VALUES(2, 'Dreamcatcher', '1987-04-30', null, 600, 25, null, 0, 164, 1, 1, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(2, 1, null);
INSERT INTO coasters.rollercoaster VALUES(3, 'Fury', '2019-06-24', null, 600, 43, 106.6, 2, 90, 1, 3, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(3, 2, 'Riders of ''Fury'' have a button on which they can vote which direction the ride should go: forwards or backwards. The majority of the votes decides. The train seats 12 so when the votes are tied, the ride''s CPU chooses random.');
INSERT INTO coasters.rollercoasterElement VALUES(3, 3, 'forward/backward/forward-launch');
INSERT INTO coasters.rollercoasterElement VALUES(3, 4, null);
INSERT INTO coasters.rollercoasterElement VALUES(3, 5, null);
INSERT INTO coasters.rollercoasterElement VALUES(3, 6, null);
INSERT INTO coasters.rollercoasterElement VALUES(3, 7, null);
INSERT INTO coasters.rollercoaster VALUES(4, 'Naga Bay', '2011-04-09', null, 430, 17, 55, 0, null, 1, 4, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(4, 1, null);
INSERT INTO coasters.rollercoaster VALUES(5, 'Oki Doki', '2004-04-03', null, 436, 16.3, 58, 0, 62, 1, 1, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(5, 8, null);
INSERT INTO coasters.rollercoaster VALUES(6, 'Revolution', '1989-05-01', null, 720, 18.5, 50, 0, 140, 1, 1, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(6, 8, null);
INSERT INTO coasters.rollercoaster VALUES(7, 'Speedy Bob', '1998-07-02', null, 370, 14, 45, 0, 85, 1, 2, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(7, 1, null);
INSERT INTO coasters.rollercoaster VALUES(8, 'Typhoon', '2004-04-10', null, 670, 25.7, 80, 4, 90, 1, 3, 1, 1);
INSERT INTO coasters.rollercoasterElement VALUES(8, 9, null);
INSERT INTO coasters.rollercoasterElement VALUES(8, 10, '19m tall');
INSERT INTO coasters.rollercoasterElement VALUES(8, 11, null);
INSERT INTO coasters.rollercoasterElement VALUES(8, 12, '540°');
INSERT INTO coasters.rollercoasterElement VALUES(8, 13, null);
INSERT INTO coasters.rollercoaster VALUES(9, 'Alpenblitz', '1979-01-01', '1981-12-31', null, null, null, 0, null, 1, 5, 1, 2);
INSERT INTO coasters.rollercoaster VALUES(10, 'Looping Star', '1979-01-01', '2003-11-02', 592, 24.5, 77, 1, null, 1, 5, 1, 2);
INSERT INTO coasters.rollercoasterElement VALUES(10, 10, null);
INSERT INTO coasters.rollercoaster VALUES(11, 'Wervelwind', '1982-01-01', '1999-12-31', 350, 19.5, 60, 2, null, 1, 1, 1, 2);
INSERT INTO coasters.rollercoasterElement VALUES(11, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(11, 7, '2 times');
/* Walibi Belgium */
INSERT INTO coasters.rollercoaster VALUES(12, 'Calamity Mine', '1992-07-16', null, 785, 14, 48.4, 0, 140, 1, 1, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(12, 1, '2 times, 12m tall and 14m tall');
INSERT INTO coasters.rollercoaster VALUES(13, 'Cobra', '2001-04-28', null, 285, 35.5, 75.6, 3, 108, 1, 1, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(13, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(13, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(13, 14, null);
INSERT INTO coasters.rollercoasterElement VALUES(13, 15, null);
INSERT INTO coasters.rollercoaster VALUES(14, 'Fun Pilot', '2019-05-25', null, 190, 9.5, 40, 0, null, 1, 6, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(14, 8, null);
INSERT INTO coasters.rollercoaster VALUES(15, 'Kondaa', '2021-05-08', null, 1200, 50, 113, 0, 90, 1, 13, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(15, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(15, 16, '38m tall');
INSERT INTO coasters.rollercoasterElement VALUES(15, 17, null);
INSERT INTO coasters.rollercoasterElement VALUES(15, 18, null);
INSERT INTO coasters.rollercoaster VALUES(16, 'Loup-Garou', '2001-04-28', null, 1035, 28, 80, 0, 125, 2, 1, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(16, 1, null);
INSERT INTO coasters.rollercoaster VALUES(17, 'Psyké Underground', '1982-01-01', null, 220.1, 42, 85.3, 1, 35, 1, 5, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(17, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(17, 19, null);
INSERT INTO coasters.rollercoaster VALUES(18, 'Pulsar', '2016-06-04', null, 217, 45, 101, 0, 78, 1, 2, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(18, 3, null);
INSERT INTO coasters.rollercoasterElement VALUES(18, 20, '2 times');
INSERT INTO coasters.rollercoasterElement VALUES(18, 21, null);
INSERT INTO coasters.rollercoaster VALUES(19, 'Tiki-Waka', '2018-04-07', null, 564, 21, 55, 0, null, 1, 3, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(19, 1, null);
INSERT INTO coasters.rollercoaster VALUES(20, 'Vampire', '1999-01-01', null, 689, 33.3, 80, 5, 96, 1, 1, 2, 1);
INSERT INTO coasters.rollercoasterElement VALUES(20, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(20, 22, null);
INSERT INTO coasters.rollercoasterElement VALUES(20, 23, null);
INSERT INTO coasters.rollercoasterElement VALUES(20, 24, null);
INSERT INTO coasters.rollercoaster VALUES(21, 'Coccinelle', '1999-01-01', '2017-09-11', 60.2, 3.3, 26, 0, null, 1, 6, 2, 2);
INSERT INTO coasters.rollercoasterElement VALUES(21, 8, null);
INSERT INTO coasters.rollercoaster VALUES(22, 'Grand 8', '1975-01-01', '1983-12-31', null, null, null, 0, null, 1, 9, 2, 2);
INSERT INTO coasters.rollercoasterElement VALUES(22, 1, null);
INSERT INTO coasters.rollercoaster VALUES(23, 'Jumbo Jet', '1978-01-01', '1991-12-31', null, null, null, 0, null, 1, 5, 2, 2);
INSERT INTO coasters.rollercoasterElement VALUES(23, 25, null);
INSERT INTO coasters.rollercoaster VALUES(24, 'Tornado', '1979-01-01', '2002-12-31', 731, 22.9, 64.4, 2, null, 1, 1, 2, 2);
INSERT INTO coasters.rollercoasterElement VALUES(24, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(24, 26, null);
INSERT INTO coasters.rollercoaster VALUES(25, 'Vertigo', '2007-06-14', '2008-05-19', 721.8, 54.9, 60, 0, 94, 1, 15, 2, 2);
INSERT INTO coasters.rollercoasterElement VALUES(25, 27, null);
/* Bellewaerde Park */
INSERT INTO coasters.rollercoaster VALUES(26, 'Boomerang', '1984-01-01', null, 285, 35.5, 75.6, 3, 108, 1, 1, 3, 1);
INSERT INTO coasters.rollercoasterElement VALUES(26, 14, null);
INSERT INTO coasters.rollercoasterElement VALUES(26, 15, null);
INSERT INTO coasters.rollercoasterElement VALUES(26, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(26, 1, null);
INSERT INTO coasters.rollercoaster VALUES(27, 'Dawson Duel', '2017-05-05', null, 490, 25, 40, 0, null, 1, 14, 3, 1);
INSERT INTO coasters.rollercoaster VALUES(28, 'Huracan', '2013-03-30', null, 500, 15, 50, 0, 120, 1, 6, 3, 1);
INSERT INTO coasters.rollercoasterElement VALUES(28, 8, null);
INSERT INTO coasters.rollercoasterElement VALUES(28, 28, null);
INSERT INTO coasters.rollercoaster VALUES(29, 'Wakala', '2020-07-01', null, 660, 21, 50, 0, null, 1, 3, 3, 1);
INSERT INTO coasters.rollercoasterElement VALUES(29, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(29, 8, null);
INSERT INTO coasters.rollercoasterElement VALUES(29, 20, null);
INSERT INTO coasters.rollercoaster VALUES(30, 'Keverbaan', '1981-01-01', '2022-11-06', 360, 8, 36, 0, null, 1, 6, 3, 2);
INSERT INTO coasters.rollercoasterElement VALUES(30, 8, null);
/* Boudewijn Seapark */
INSERT INTO coasters.rollercoaster VALUES(31, 'Orca Ride', '2000-01-01', null, null, null, null, 0, null, 1, 6, 4, 1);
INSERT INTO coasters.rollercoasterElement VALUES(31, 8, null);
/* Plopsa Coo */
INSERT INTO coasters.rollercoaster VALUES(32, 'Schtroumpfeur', '1989-01-01', null, 540, null, null, 0, null, 1, 1, 5, 1);
INSERT INTO coasters.rollercoasterElement VALUES(32, 1, null);
INSERT INTO coasters.rollercoaster VALUES(33, 'Vicky The Ride', '2011-06-25', null, 400, 17, 55, 0, null, 1, 3, 5, 1);
INSERT INTO coasters.rollercoasterElement VALUES(33, 1, null);
INSERT INTO coasters.rollercoaster VALUES(34, 'Wild Mouse', '2006-07-15', '2006-08-31', 420, 13, 48.6, 0, 90, 1, 8, 5, 2);
/* Plopsa Indoor Hasselt */
INSERT INTO coasters.rollercoaster VALUES(35, 'Wickie Coaster', '2005-12-24', null, 222, 9, 39, 0, null, 1, 6, 6, 1);
INSERT INTO coasters.rollercoasterElement VALUES(35, 8, null);
/* Plopsaland De Panne */
INSERT INTO coasters.rollercoaster VALUES(36, '#LikeMe Coaster', '1976-01-01', null, 360, 8, 36, 0, null, 1, 6, 7, 1);
INSERT INTO coasters.rollercoasterElement VALUES(36, 8, null);
INSERT INTO coasters.rollercoaster VALUES(37, 'Anubis: The Ride', '2009-04-05', null, 600, 34, 90, 3, null, 1, 3, 7, 1);
INSERT INTO coasters.rollercoasterElement VALUES(37, 7, null);
INSERT INTO coasters.rollercoasterElement VALUES(37, 29, null);
INSERT INTO coasters.rollercoasterElement VALUES(37, 30, null);
INSERT INTO coasters.rollercoasterElement VALUES(37, 31, null);
INSERT INTO coasters.rollercoaster VALUES(38, 'Draak', '2004-04-03', null, 450, 14, 36, 0, null, 1, 2, 7, 1);
INSERT INTO coasters.rollercoaster VALUES(39, 'Heidi The Ride', '2017-04-02', null, 627, 22, 71.3, 0, null, 2, 7, 7, 1);
INSERT INTO coasters.rollercoasterElement VALUES(39, 1, null);
INSERT INTO coasters.rollercoaster VALUES(40, 'K3 Roller Skater', '1991-01-01', null, 335, 13, 45.9, 0, 66, 1, 1, 7, 1);
INSERT INTO coasters.rollercoasterElement VALUES(40, 8, null);
INSERT INTO coasters.rollercoaster VALUES(41, 'Ride to Happiness', '2021-07-01', null, 920, 33, 90, 5, null, 1, 2, 7, 1);
INSERT INTO coasters.rollercoasterElement VALUES(41, 13, null);
INSERT INTO coasters.rollercoasterElement VALUES(41, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(41, 32, null);
INSERT INTO coasters.rollercoasterElement VALUES(41, 33, null);
INSERT INTO coasters.rollercoasterElement VALUES(41, 34, null);
INSERT INTO coasters.rollercoasterElement VALUES(41, 35, null);
INSERT INTO coasters.rollercoasterElement VALUES(41, 36, null);
INSERT INTO coasters.rollercoaster VALUES(42, 'Jubilé', '1995-01-01', '2000-01-01', null, null, null, 0, null, 1, 9, 7, 2);
INSERT INTO coasters.rollercoaster VALUES(43, 'Vleermuis', '2000-01-01', '2018-01-07', null, null, null, 0, null, 1, 10, 7, 2);
INSERT INTO coasters.rollercoasterElement VALUES(43, 27, null);
/* Avonturenpark Hellendoorn */
INSERT INTO coasters.rollercoaster VALUES(44, 'Balagos - Flying Flame', '1990-01-01', null, 460, 25, 60, 2, 68, 1, 1, 8, 1);
INSERT INTO coasters.rollercoasterElement VALUES(44, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(44, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(44, 7, null);
INSERT INTO coasters.rollercoaster VALUES(45, 'Donderstenen', '2005-04-09', null, 222, 9, 39, 0, null, 1, 6, 8, 1);
INSERT INTO coasters.rollercoasterElement VALUES(45, 8, '2 times');
INSERT INTO coasters.rollercoaster VALUES(46, 'Rioolrat', '1996-01-01', null, 305, null, 45, 0, 98, 1, 1, 8, 1);
INSERT INTO coasters.rollercoasterElement VALUES(46, 8, null);
INSERT INTO coasters.rollercoaster VALUES(47, 'Avonturenslang', '1978-01-01', '2004-12-31', 199, 6, 32, 0, null, 1, 6, 8, 2);
INSERT INTO coasters.rollercoasterElement VALUES(47, 8, null);
/* Drievliet Family Park */
INSERT INTO coasters.rollercoaster VALUES(48, 'Dynamite Express', '2005-06-09', null, 262, 11, null, 0, 57, 1, 2, 9, 1);
INSERT INTO coasters.rollercoaster VALUES(49, 'Formule X', '2007-04-06', null, 355, 15, 70, 2, 47, 1, 4, 9, 1);
INSERT INTO coasters.rollercoasterElement VALUES(49, 32, 'from 0,0 km/h - 70,0 km/h in 2,0s');
INSERT INTO coasters.rollercoasterElement VALUES(49, 30, null);
INSERT INTO coasters.rollercoasterElement VALUES(49, 13, null);
INSERT INTO coasters.rollercoasterElement VALUES(49, 37, '135°');
INSERT INTO coasters.rollercoaster VALUES(50, 'Kopermijn', '1996-01-01', null, 370, 15, 45, 0, 95, 1, 4, 9, 1);
INSERT INTO coasters.rollercoasterElement VALUES(50, 1, null);
INSERT INTO coasters.rollercoaster VALUES(51, 'Twistrix', '2001-01-01', null, null, null, null, 0, 75, 1, 4, 9, 1);
INSERT INTO coasters.rollercoasterElement VALUES(51, 8, null);
INSERT INTO coasters.rollercoaster VALUES(52, 'Xtreme', '2004-04-03', '2006-12-31', 424, 15.5, 60, 0, 86, 1, 4, 9, 2);
INSERT INTO coasters.rollercoasterElement VALUES(52, 1, null);
/* Duinrell */
INSERT INTO coasters.rollercoaster VALUES(53, 'Dragon Fly', '2012-03-31', null, 361, 15, null, 0, null, 1, 3, 10, 1);
INSERT INTO coasters.rollercoasterElement VALUES(53, 1, null);
INSERT INTO coasters.rollercoaster VALUES(54, 'Falcon', '2009-05-14', null, 361, 22, 70, 3, null, 1, 3, 10, 1);
INSERT INTO coasters.rollercoasterElement VALUES(54, 9, null);
INSERT INTO coasters.rollercoasterElement VALUES(54, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(54, 13, null);
INSERT INTO coasters.rollercoasterElement VALUES(54, 38, null);
INSERT INTO coasters.rollercoaster VALUES(55, 'Kikkerachtbaan', '1985-01-01', null, 360, 8, 36, 0, 135, 1, 6, 10, 1);
INSERT INTO coasters.rollercoasterElement VALUES(55, 8, null);
INSERT INTO coasters.rollercoaster VALUES(56, 'Batflyer', '1997-01-01', '2002-12-31', null, null, null, 0, null, 1, 10, 10, 3);
INSERT INTO coasters.rollercoasterElement VALUES(56, 27, null);
/* Efteling */
INSERT INTO coasters.rollercoaster VALUES(57, 'Baron 1898', '2015-07-01', null, 501, 30, 90, 2, 130, 1, 11, 11, 1);
INSERT INTO coasters.rollercoasterElement VALUES(57, 28, null);
INSERT INTO coasters.rollercoasterElement VALUES(57, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(57, 39, null);
INSERT INTO coasters.rollercoasterElement VALUES(57, 30, null);
INSERT INTO coasters.rollercoasterElement VALUES(57, 34, null);
INSERT INTO coasters.rollercoasterElement VALUES(57, 12, '360°');
INSERT INTO coasters.rollercoaster VALUES(58, 'Joris en de Draak', '2010-07-01', null, 787.9, 22.1, 75, 0, null, 2, 7, 11, 1);
INSERT INTO coasters.rollercoasterElement VALUES(58, 1, null);
INSERT INTO coasters.rollercoaster VALUES(59, 'Max + Moritz', '2020-06-20', null, 300, 6, 36, 0, 150, 1, 2, 11, 1);
INSERT INTO coasters.rollercoaster VALUES(60, 'Python', '1981-04-12', null, 750, 29, 75, 4, 128, 1, 1, 11, 1);
INSERT INTO coasters.rollercoasterElement VALUES(60, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(60, 10, '2 times');
INSERT INTO coasters.rollercoasterElement VALUES(60, 26, null);
INSERT INTO coasters.rollercoaster VALUES(61, 'Vliegende Hollander', '2007-04-01', null, 420, 22.5, 70, 0, 225, 1, 12, 11, 1);
INSERT INTO coasters.rollercoasterElement VALUES(61, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(61, 21, null);
INSERT INTO coasters.rollercoaster VALUES(62, 'Vogel Rok', '1998-04-09', null, 750, 20, 65, 0, 101, 1, 1, 11, 1);
INSERT INTO coasters.rollercoasterElement VALUES(62, 8, null);
INSERT INTO coasters.rollercoaster VALUES(63, 'Bob', '1985-09-01', '2019-09-01', 524, 20, 60, 0, 100, 1, 13, 11, 2);
INSERT INTO coasters.rollercoaster VALUES(64, 'Pegasus', '1991-07-01', '2009-06-19', 492.3, 15, 55, 0, 103, 1, 13, 11, 2);
INSERT INTO coasters.rollercoasterElement VALUES(64, 1, null);
/* Julianatoren */
INSERT INTO coasters.rollercoaster VALUES(65, 'Jul''s RollerSkates', '1993-04-04', null, 207, 8.5, 34.9, 0, 104, 1, 1, 12, 1);
INSERT INTO coasters.rollercoasterElement VALUES(65, 8, null);
INSERT INTO coasters.rollercoaster VALUES(66, 'Texas Twister', '2022-04-15', null, null, null, null, 0, null, 1, 18, 12, 1);
INSERT INTO coasters.rollercoasterElement VALUES(66, 8, null);
INSERT INTO coasters.rollercoaster VALUES(67, 'Vlinder', '2000-01-01', null, null, 6.1, null, 0, 104, 1, 19, 12, 1);
/* Plopsa Indoor Coevorden */
INSERT INTO coasters.rollercoaster VALUES(68, 'Wickiebaan', '2010-04-30', null, null, null, null, 0, null, 1, 6, 13, 1);
INSERT INTO coasters.rollercoasterElement VALUES(68, 8, null);
/* Slagharen themePark & Resort */
INSERT INTO coasters.rollercoaster VALUES(69, 'Gold Rush', '2017-04-13', null, 400, 33, 95, 2, null, 1, 3, 14, 1);
INSERT INTO coasters.rollercoasterElement VALUES(69, 3, null);
INSERT INTO coasters.rollercoasterElement VALUES(69, 29, null);
INSERT INTO coasters.rollercoasterElement VALUES(69, 23, null);
INSERT INTO coasters.rollercoaster VALUES(70, 'Mine Train', '2001-04-01', null, 335, 13, 45.9, 0, 62, 1, 1, 14, 1);
INSERT INTO coasters.rollercoasterElement VALUES(70, 8, null);
INSERT INTO coasters.rollercoaster VALUES(71, 'Keverbaan', '1976-01-01', '2000-12-31', 360, 8, 36, 0, null, 1, 6, 14, 2);
INSERT INTO coasters.rollercoasterElement VALUES(71, 8, null);
INSERT INTO coasters.rollercoaster VALUES(72, 'Thunder Loop', '1979-06-26', '2016-10-02', 592, 24.5, 77, 1, 102, 1, 5, 14, 2);
INSERT INTO coasters.rollercoasterElement VALUES(72, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(72, 10, null);
/* Toverland */
INSERT INTO coasters.rollercoaster VALUES(73, 'Booster Bike', '2004-07-27', null, 606, 15, 75, 0, 68, 1, 1, 15, 1);
INSERT INTO coasters.rollercoasterElement VALUES(73, 40, 'from 0,0 km/h - 75,0 km/h in 3,0s');
INSERT INTO coasters.rollercoaster VALUES(74, 'Dwervelwind', '2012-09-29', null, 500, 20, 70, 0, 112, 1, 2, 15, 1);
INSERT INTO coasters.rollercoasterElement VALUES(74, 1, null);
INSERT INTO coasters.rollercoaster VALUES(75, 'Fénix', '2018-07-07', null, 813, 40, 95, 3, 105, 1, 11, 15, 1);
INSERT INTO coasters.rollercoasterElement VALUES(75, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(75, 28, null);
INSERT INTO coasters.rollercoasterElement VALUES(75, 41, null);
INSERT INTO coasters.rollercoasterElement VALUES(75, 30, null);
INSERT INTO coasters.rollercoasterElement VALUES(75, 12, null);
INSERT INTO coasters.rollercoasterElement VALUES(75, 34, null);
INSERT INTO coasters.rollercoaster VALUES(76, 'Toos-Express', '2001-05-09', null, 320, 12, 60, 0, 52, 1, 1, 15, 1);
INSERT INTO coasters.rollercoasterElement VALUES(75, 8, null);
INSERT INTO coasters.rollercoaster VALUES(77, 'Troy', '2007-06-29', null, 1077.2, 31.9, 86.9, 0, 110, 2, 7, 15, 1);
INSERT INTO coasters.rollercoasterElement VALUES(77, 1, null);
INSERT INTO coasters.rollercoaster VALUES(78, 'Wilde Maus', '2004-07-03', '2004-08-02', 370, 14, 45, 0, 110, 1, 2, 15, 2);
INSERT INTO coasters.rollercoasterElement VALUES(78, 1, null);
/* Walibi Holland */
INSERT INTO coasters.rollercoaster VALUES(79, 'Condor', '1994-05-07', null, 662, 31, 80, 5, 122, 1, 1, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(79, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(79, 22, null);
INSERT INTO coasters.rollercoasterElement VALUES(79, 23, null);
INSERT INTO coasters.rollercoasterElement VALUES(79, 24, null);
INSERT INTO coasters.rollercoaster VALUES(80, 'Drako', '1992-05-15', null, 199, 6, 32, 0, null, 1, 6, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(80, 8, null);
INSERT INTO coasters.rollercoaster VALUES(81, 'Eat My Dust', '2023-04-07', null, 200, 11.8, 40, 0, null, 1, 17, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(81, 8, null);
INSERT INTO coasters.rollercoasterElement VALUES(81, 12, '540°');
INSERT INTO coasters.rollercoaster VALUES(82, 'Goliath', '2002-03-29', null, 1214, 46.8, 106, 0, 92, 1, 13, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(82, 42, null);
INSERT INTO coasters.rollercoasterElement VALUES(82, 43, '121°');
INSERT INTO coasters.rollercoaster VALUES(83, 'Lost Gravity', '2016-03-24', null, 680, 32, 87, 2, 143, 1, 2, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(83, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(83, 41, null);
INSERT INTO coasters.rollercoasterElement VALUES(83, 34, null);
INSERT INTO coasters.rollercoaster VALUES(84, 'Speed of Sound', '2000-04-22', null, 285, 35.5, 75.6, 3, 108, 1, 1, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(84, 14, null);
INSERT INTO coasters.rollercoasterElement VALUES(84, 15, null);
INSERT INTO coasters.rollercoasterElement VALUES(84, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(84, 1, null);
INSERT INTO coasters.rollercoaster VALUES(85, 'Untamed', '2019-07-01', null, 1085, 36.5, 92, 4, 106, 1, 16, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(85, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(85, 44, '270°');
INSERT INTO coasters.rollercoasterElement VALUES(85, 36, null);
INSERT INTO coasters.rollercoasterElement VALUES(85, 45, '140°');
INSERT INTO coasters.rollercoasterElement VALUES(85, 46, null);
INSERT INTO coasters.rollercoaster VALUES(86, 'Xpress: Platform 13', '2000-04-01', null, 996, 25.8, 90, 3, 75, 1, 1, 16, 1);
INSERT INTO coasters.rollercoasterElement VALUES(86, 32, 'from 0,0 km/h - 90,0 km/h in 2,8s');
INSERT INTO coasters.rollercoasterElement VALUES(86, 7, null);
INSERT INTO coasters.rollercoasterElement VALUES(86, 47, null);
INSERT INTO coasters.rollercoaster VALUES(87, 'Flying Dutchman Gold Mine', '2000-01-01', '2010-12-31', 370, 14, 45, 0, 85, 1, 2, 16, 2);
INSERT INTO coasters.rollercoasterElement VALUES(87, 1, null);
INSERT INTO coasters.rollercoaster VALUES(88, 'Robin Hood', '2000-01-01', '2018-10-28', 1035, 32, 80, 0, 145, 2, 1, 16, 2);
INSERT INTO coasters.rollercoasterElement VALUES(88, 1, null);
/* Wildlands Adventure Zoo Emmen */
INSERT INTO coasters.rollercoaster VALUES(89, 'Tweestryd', '2018-03-28', null, 222.5, 20, 60, 0, 65, 1, 1, 17, 1);
/* Belantis */
INSERT INTO coasters.rollercoaster VALUES(90, 'Cobra des Amun Ra', '2015-07-04', null, 360, 15, null, 0, null, 1, 3, 18, 1);
INSERT INTO coasters.rollercoasterElement VALUES(90, 1, null);
INSERT INTO coasters.rollercoaster VALUES(91, 'Drachenritt', '2003-04-05', null, null, null, null, 0, null, 1, 3, 18, 1);
INSERT INTO coasters.rollercoasterElement VALUES(91, 1, null);
INSERT INTO coasters.rollercoaster VALUES(92, 'Huracan', '2010-06-26', null, 560, 32, 85, 5, 90, 1, 3, 18, 1);
INSERT INTO coasters.rollercoasterElement VALUES(92, 9, null);
INSERT INTO coasters.rollercoasterElement VALUES(92, 34, null);
INSERT INTO coasters.rollercoasterElement VALUES(92, 15, null);
INSERT INTO coasters.rollercoasterElement VALUES(92, 48, null);
INSERT INTO coasters.rollercoaster VALUES(93, 'Huracanito', '2014-04-19', null, 23, 1.8, null, 0, null, 1, 3, 18, 1);
INSERT INTO coasters.rollercoasterElement VALUES(93, 1, null);
/* Eifelpark */
INSERT INTO coasters.rollercoaster VALUES(94, 'Eifel Blitz', '2014-04-05', null, null, null, null, 0, null, 1, 20, 19, 1);
INSERT INTO coasters.rollercoasterElement VALUES(94, 1, null);
INSERT INTO coasters.rollercoaster VALUES(95, 'Eifel-Coaster', '2006-01-01', null, 765, null, null, 0, null, 1, 14, 19, 1);
INSERT INTO coasters.rollercoasterElement VALUES(95, 42, null);
INSERT INTO coasters.rollercoaster VALUES(96, 'Käpt''n Jack''s Wilde Maus', '2017-04-08', null, 370, 15, 45, 0, 94, 1, 4, 19, 1);
INSERT INTO coasters.rollercoasterElement VALUES(96, 1, null);
INSERT INTO coasters.rollercoaster VALUES(97, 'Familien-Achterbahn', '1995-01-01', '2012-12-31', 126, 4.5, 30, 0, null, 1, 6, 19, 2);
INSERT INTO coasters.rollercoasterElement VALUES(97, 8, null);
/* Europa Park */
INSERT INTO coasters.rollercoaster VALUES(98, 'Alpenexpress Enzian', '1984-01-01', null, 264, 6, 45, 0, null, 1, 2, 20, 1);
INSERT INTO coasters.rollercoaster VALUES(99, 'Arthur', '2014-07-01', null, 505, 13.5, 31, 0, null, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(99, 28, '6 sections');
INSERT INTO coasters.rollercoaster VALUES(100, 'Atlantica SuperSplash', '2005-03-19', null, 390, 30, 80, 0, 200, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(100, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(100, 2, '2 times');
INSERT INTO coasters.rollercoasterElement VALUES(100, 49, null);
INSERT INTO coasters.rollercoasterElement VALUES(100, 50, null);
INSERT INTO coasters.rollercoaster VALUES(101, 'Ba-a-a-Express', '2016-07-13', null, 67, 3, null, 0, null, 1, 21, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(101, 8, null);
INSERT INTO coasters.rollercoaster VALUES(102, 'blue fire Megacoaster', '2009-04-04', null, 1056, 38, 100, 4, 150, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(102, 28, null);
INSERT INTO coasters.rollercoasterElement VALUES(102, 32, 'from 0,0 km/h - 100,0 km/h in 2,5s');
INSERT INTO coasters.rollercoasterElement VALUES(102, 10, '32m tall');
INSERT INTO coasters.rollercoasterElement VALUES(102, 51, null);
INSERT INTO coasters.rollercoasterElement VALUES(102, 52, null);
INSERT INTO coasters.rollercoasterElement VALUES(102, 53, null);
/* INSERT INTO coasters.rollercoaster VALUES(ID, name, opening, closure, length, height, speed, inversions, duration, materialID, manufacturerID, themeParkID, statusID); */
INSERT INTO coasters.rollercoaster VALUES(103, 'Euro Mir', '1997-06-12', null, 980, 28, 80, 0, 273, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(103, 54, null);
INSERT INTO coasters.rollercoaster VALUES(104, 'Eurosat - CanCan Coaster', '1989-08-05', null, 922, 25.5, 60, 0, 198, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(104, 54, null);
INSERT INTO coasters.rollercoaster VALUES(105, 'Matterhorn Blitz', '1999-03-25', null, 383, 16, 56.3, 0, 185, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(105, 27, null);
INSERT INTO coasters.rollercoaster VALUES(106, 'Pegasus', '2006-05-25', null, 400, 13, 65, 0, 131, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(106, 8, null);
INSERT INTO coasters.rollercoaster VALUES(107, 'Poseidon', '2000-07-12', null, 836, 23, 70, 0, 240, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(107, 50, '3 times');
INSERT INTO coasters.rollercoasterElement VALUES(107, 1, '2 times, respectively 23m and 20m tall');
INSERT INTO coasters.rollercoasterElement VALUES(107, 49, '2 times');
INSERT INTO coasters.rollercoaster VALUES(108, 'Schweizer Bobbahn', '1985-01-01', null, 487, 19, 50, 0, 105, 1, 2, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(108, 1, null);
INSERT INTO coasters.rollercoaster VALUES(109, 'Silver Star', '2002-03-23', null, 1620, 73, 127, 0, null, 1, 11, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(109, 1, '73m tall with a 67m drop');
INSERT INTO coasters.rollercoasterElement VALUES(109, 16, '2 times, respectively with a 49m and 41m drop');
INSERT INTO coasters.rollercoasterElement VALUES(109, 37, null);
INSERT INTO coasters.rollercoasterElement VALUES(109, 51, null);
INSERT INTO coasters.rollercoaster VALUES(110, 'Wodan Timbur Coaster', '2012-03-31', null, 1050, 40, 100, 0, 205, 2, 7, 20, 1);
INSERT INTO coasters.rollercoasterElement VALUES(110, 1, null);
/* Fort Fun Abenteuerland */
INSERT INTO coasters.rollercoaster VALUES(111, 'Devil''s Mine', '1996-01-01', null, 410, 19.5, null, 0, 75, 1, 1, 21, 1);
INSERT INTO coasters.rollercoasterElement VALUES(111, 8, null);
INSERT INTO coasters.rollercoaster VALUES(112, 'Marienkäferbahn', '1986-01-01', null, 360, 8, 36, 0, null, 1, 6, 21, 1);
INSERT INTO coasters.rollercoasterElement VALUES(112, 8, null);
INSERT INTO coasters.rollercoaster VALUES(113, 'SpeedSnake FREE', '1981-06-01', null, 350, 19.5, 60, 2, 60, 1, 1, 21, 1);
INSERT INTO coasters.rollercoasterElement VALUES(113, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(113, 7, '2 times');
INSERT INTO coasters.rollercoaster VALUES(114, 'Trapper Slider', '2001-01-01', null, 1250, null, null, 0, null, 1, 14, 21, 1);
INSERT INTO coasters.rollercoasterElement VALUES(114, 42, null);
/* Hansa-Park */
INSERT INTO coasters.rollercoaster VALUES(115, 'Crazy Mine', '1997-01-01', null, 370, 15, 45, 0, 70, 1, 4, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(115, 1, null);
INSERT INTO coasters.rollercoaster VALUES(116, 'Flucht von Novgorod', '2009-04-09', null, 700, 40, 100, 1, null, 1, 3, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(116, 28, null);
INSERT INTO coasters.rollercoasterElement VALUES(116, 31, 'from 0,0 km/h - 100,0 km/h in 1,4s');
INSERT INTO coasters.rollercoasterElement VALUES(116, 13, null);
INSERT INTO coasters.rollercoasterElement VALUES(116, 9, null);
INSERT INTO coasters.rollercoaster VALUES(117, 'Kleine Zar', '2017-04-07', null, 53.8, 3.3, 19.8, 0, null, 1, 22, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(117, 8, null);
INSERT INTO coasters.rollercoaster VALUES(118, 'Nessie', '1980-04-01', null, 741, 26, 79, 1, 130, 1, 5, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(118, 10, null);
INSERT INTO coasters.rollercoaster VALUES(119, 'Royal Scotsman', '1993-01-01', null, 522, 16, 50, 0, 70, 1, 1, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(119, 8, null);
INSERT INTO coasters.rollercoaster VALUES(120, 'Schlange von Midgard', '2011-04-15', null, 200, 10, 45, 0, null, 1, 3, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(120, 28, null);
INSERT INTO coasters.rollercoasterElement VALUES(120, 1, null);
INSERT INTO coasters.rollercoaster VALUES(121, 'Schwur des Kärnan', '2015-07-01', null, 1235, 73, 127, 1, null, 1, 3, 22, 1);
INSERT INTO coasters.rollercoasterElement VALUES(121, 9, null);
INSERT INTO coasters.rollercoasterElement VALUES(121, 13, null);
INSERT INTO coasters.rollercoaster VALUES(122, 'Seeschlange', '1977-01-01', '1992-12-31', 360, 8, 36, 0, null, 1, 6, 22, 2);
INSERT INTO coasters.rollercoasterElement VALUES(122, 8, null);
/* Holiday Park */
INSERT INTO coasters.rollercoaster VALUES(123, 'Expedition GeForce', '2001-06-18', null, 1220, 53, 120, 0, 75, 1, 13, 23, 1);
INSERT INTO coasters.rollercoasterElement VALUES(123, 42, null);
INSERT INTO coasters.rollercoasterElement VALUES(123, 37, null);
INSERT INTO coasters.rollercoaster VALUES(124, 'Sky Scream', '2014-04-12', null, 263, 45.7, 99.8, 1, 47, 1, 23, 23, 1);
INSERT INTO coasters.rollercoasterElement VALUES(124, 3, null);
INSERT INTO coasters.rollercoasterElement VALUES(124, 53, null);
INSERT INTO coasters.rollercoasterElement VALUES(124, 55, null);
INSERT INTO coasters.rollercoaster VALUES(125, 'Tabalugas Achterbahn', '2018-07-21', null, 222, 9, 39, 0, 90, 1, 6, 23, 1);
INSERT INTO coasters.rollercoaster VALUES(126, 'Holly''s Wilde Autofahrt', '2010-08-10', '2016-11-01', 370, 15, 45, 0, 94, 1, 4, 23, 2);
INSERT INTO coasters.rollercoasterElement VALUES(126, 1, null);
INSERT INTO coasters.rollercoaster VALUES(127, 'Super Wirbel', '1979-01-01', '2013-10-31', 731, 22.9, 64.4, 2, 85, 1, 1, 23, 2);
INSERT INTO coasters.rollercoasterElement VALUES(127, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(127, 26, null);
/* Legoland Deutschland */
INSERT INTO coasters.rollercoaster VALUES(128, 'Das Große LEGO Rennen', '2002-01-01', null, 400, 15.8, 56.3, 0, 90, 1, 2, 24, 1);
INSERT INTO coasters.rollercoasterElement VALUES(128, 1, null);
INSERT INTO coasters.rollercoaster VALUES(129, 'Drachenjagd', '2003-06-01', null, 510, 5.5, 33, 0, 35, 1, 3, 24, 1);
INSERT INTO coasters.rollercoasterElement VALUES(129, 8, null);
INSERT INTO coasters.rollercoaster VALUES(130, 'Feuerdrache', '2002-01-01', null, 450, 16, 56.5, 0, null, 1, 6, 24, 1);
INSERT INTO coasters.rollercoasterElement VALUES(130, 8, null);
INSERT INTO coasters.rollercoaster VALUES(131, 'Maximus - Der Flug des Wächters', '2023-03-25', null, 457, 17, 54, 2, 77, 1, 11, 24, 1);
INSERT INTO coasters.rollercoasterElement VALUES(131, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(131, 12, '360°');
INSERT INTO coasters.rollercoasterElement VALUES(131, 7, null);
INSERT INTO coasters.rollercoasterElement VALUES(131, 13, null);
/* Movie Park Germany */
INSERT INTO coasters.rollercoaster VALUES(132, 'Backyardigans: Mission to Mars', '1996-01-01', null, 207, 8.5, 34.9, 0, 44, 1, 1, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(132, 8, null);
INSERT INTO coasters.rollercoaster VALUES(133, 'Bandit', '1999-05-07', null, 1099, 27.8, 80, 0, 90, 2, 24, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(133, 1, null);
INSERT INTO coasters.rollercoaster VALUES(134, 'Ghost Chasers', '2000-01-01', null, 370, 14, 45, 0, 110, 1, 2, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(134, 1, null);
INSERT INTO coasters.rollercoaster VALUES(135, 'Iron Claw', '2001-04-06', null, 689, 33.3, 80, 5, 96, 1, 1, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(135, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(135, 22, null);
INSERT INTO coasters.rollercoasterElement VALUES(135, 23, null);
INSERT INTO coasters.rollercoasterElement VALUES(135, 24, null);
INSERT INTO coasters.rollercoaster VALUES(136, 'Jimmy Neutron''s Atomic Flyer', '2007-03-01', null, 295, 13, null, 0, 48, 1, 1, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(136, 8, null);
INSERT INTO coasters.rollercoaster VALUES(137, 'Star Trek: Operation Enterprise', '2017-06-14', null, 720, null, 90, 3, null, 1, 2, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(137, 3, null);
INSERT INTO coasters.rollercoasterElement VALUES(137, 56, '40m tall 180°');
INSERT INTO coasters.rollercoasterElement VALUES(137, 5, '30m tall');
INSERT INTO coasters.rollercoasterElement VALUES(137, 30, null);
INSERT INTO coasters.rollercoasterElement VALUES(137, 13, null);
INSERT INTO coasters.rollercoasterElement VALUES(137, 37, '100°');
INSERT INTO coasters.rollercoasterElement VALUES(137, 12, '270°');
INSERT INTO coasters.rollercoasterElement VALUES(137, 34, null);
INSERT INTO coasters.rollercoaster VALUES(138, 'Studio Tour', '2021-06-23', null, 532, 12, 60, 0, 120, 1, 13, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(138, 28, '3 times');
INSERT INTO coasters.rollercoasterElement VALUES(138, 57, null);
INSERT INTO coasters.rollercoasterElement VALUES(138, 2, null);
INSERT INTO coasters.rollercoasterElement VALUES(138, 58, null);
INSERT INTO coasters.rollercoaster VALUES(139, 'Van Helsing''s Factory', '2021-06-18', null, 400, 8, 36, 0, null, 1, 3, 25, 1);
INSERT INTO coasters.rollercoasterElement VALUES(139, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(139, 8, null);
INSERT INTO coasters.rollercoaster VALUES(140, 'Blauer Enzian', '1987-06-01', '1991-08-31', 264, 12, null, 0, null, 1, 2, 25, 2);
INSERT INTO coasters.rollercoaster VALUES(141, 'Cop Car Chase', '1996-06-01', '2006-12-31', 609.6, null, null, 2, 80, 1, 13, 25, 2);
INSERT INTO coasters.rollercoasterElement VALUES(141, 1, '2 times');
INSERT INTO coasters.rollercoasterElement VALUES(141, 10, null);
INSERT INTO coasters.rollercoasterElement VALUES(141, 13, null);
INSERT INTO coasters.rollercoaster VALUES(142, 'Marienkäferbahn', '1979-01-01', '1985-12-31', 360, 8, 36, 0, null, 1, 6, 25, 2);
INSERT INTO coasters.rollercoasterElement VALUES(142, 8, null);
INSERT INTO coasters.rollercoaster VALUES(143, 'Super Spirale', '1979-09-01', '1986-12-31', 731, 22.9, 64.4, 2, null, 1, 1, 25, 2);
INSERT INTO coasters.rollercoasterElement VALUES(143, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(143, 26, null);
INSERT INTO coasters.rollercoaster VALUES(144, 'Traumlandbahn', '1987-01-01', '1991-12-31', 850, 24, 85.3, 0, null, 1, 5, 25, 2);
/* Phantasialand */
INSERT INTO coasters.rollercoaster VALUES(145, 'Black Mamba', '2006-05-24', null, 768, 26, 80, 4, null, 1, 11, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(145, 1, null);
INSERT INTO coasters.rollercoasterElement VALUES(145, 10, '20m tall');
INSERT INTO coasters.rollercoasterElement VALUES(145, 34, null);
INSERT INTO coasters.rollercoasterElement VALUES(145, 59, null);
INSERT INTO coasters.rollercoasterElement VALUES(145, 7, '2 times');
INSERT INTO coasters.rollercoaster VALUES(146, 'Colorado Adventure', '1996-05-11', null, 1280, 26, 50, 0, 175, 1, 1, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(146, 8, '3 times');
INSERT INTO coasters.rollercoaster VALUES(147, 'Crazy Bats', '1988-04-01', null, 1175, 11.7, 46.5, 0, 240, 1, 1, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(147, 1, '3 times');
INSERT INTO coasters.rollercoaster VALUES(148, 'F.L.Y.', '2020-09-17', null, 1236, null, 78, 2, null, 1, 1, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(148, 28, null);
INSERT INTO coasters.rollercoasterElement VALUES(148, 31, null);
INSERT INTO coasters.rollercoasterElement VALUES(148, 7, '2 times');
INSERT INTO coasters.rollercoasterElement VALUES(148, 35, null);
INSERT INTO coasters.rollercoaster VALUES(149, 'Raik', '2016-06-30', null, 209, 25, 62, 0, null, 1, 1, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(149, 8, null);
INSERT INTO coasters.rollercoaster VALUES(150, 'Taron', '2016-06-30', null, 1320, 30, 117, 0, null, 1, 13, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(150, 32, null);
INSERT INTO coasters.rollercoasterElement VALUES(150, 35, null);
INSERT INTO coasters.rollercoaster VALUES(151, 'Winja''s', '2002-03-30', null, 465, 17.4, 66, 0, null, 1, 4, 26, 1);
INSERT INTO coasters.rollercoasterElement VALUES(151, 27, null);
INSERT INTO coasters.rollercoasterElement VALUES(151, 12, '360°');
INSERT INTO coasters.rollercoasterElement VALUES(151, 60, null);
INSERT INTO coasters.rollercoaster VALUES(152, 'Gebirgsbahn', '1975-01-01', '2001-05-01', 979.9, 28.1, null, 0, null, 1, 5, 26, 2);
INSERT INTO coasters.rollercoaster VALUES(153, 'Grand Canyon Bahn', '1978-01-01', '2001-05-01', null, null, null, 0, null, 1, 5, 26, 2);
/* Potts Park */
INSERT INTO coasters.rollercoaster VALUES(154, 'Kiddy-Racer', '2017-04-08', null, 23, 1.8, null, 0, null, 1, 3, 27, 1);
INSERT INTO coasters.rollercoaster VALUES(155, 'Potts Blitz', '1993-01-01', null, 222, 9, 39, 0, null, 1, 6, 27, 1);
INSERT INTO coasters.rollercoasterElement VALUES(155, 8, null);
INSERT INTO coasters.rollercoaster VALUES(156, 'Säbelsaurus', '2019-04-13', null, 7.5, null, null, 0, null, 1, 19, 27, 1);
INSERT INTO coasters.rollercoaster VALUES(157, 'Turbo-Drachen', '2009-10-04', null, 470, null, 36, 0, null, 1, 25, 27, 1);
/* Schwaben Park */
INSERT INTO coasters.rollercoaster VALUES(158, 'Force One', '2010-05-18', null, 530, 22, 65, 0, 38, 1, 6, 28, 1);
INSERT INTO coasters.rollercoasterElement VALUES(158, 1, null);
INSERT INTO coasters.rollercoaster VALUES(159, 'Hummel Brummel', '2020-08-15', null, 500, null, null, 0, null, 1, 14, 28, 1);
INSERT INTO coasters.rollercoaster VALUES(160, 'Raupen Express', '2003-01-01', null, 70, 4, 24, 0, null, 1, 6, 28, 1);
INSERT INTO coasters.rollercoasterElement VALUES(160, 8, null);
INSERT INTO coasters.rollercoaster VALUES(161, 'Wilde Hilde', '2018-10-13', null, 88, 21, null, 0, 90, 1, 26, 28, 1);
INSERT INTO coasters.rollercoaster VALUES(162, 'Himalayabahn', '1989-01-01', '2015-12-31', 460, 13.5, null, 0, null, 1, 5, 28, 2);