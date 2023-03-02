/* Populate database with sample data. */

INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts)
values
('Agumon', 'Feb 3, 2020', 10.23,'true', 0 ),
('Gabumon', 'Nov 15, 2018', 8, 'true', 2),
('Pikachu', 'Jan 7, 2021', 15.04, 'false', 1),
('Devimon', 'May 12, 2017', 11, 'true', 5);
INSERT INTO animals(name, date_of_birth, weight_kg, neutered, escape_attempts)
values
('Charmander', 'Feb 8, 2020', 11,'false', 0 ),
('Plantmon', 'Nov 15, 2021', 5.7,'true', 2 ),
('Squirtle', 'Apr 2, 1993', 12.13, 'false', 3 ),
('Angemon',  'Jun 12, 2005', 45,  'true', 1),
('Boarmon', 'Jun 7, 2005', 20.4, 'true', 7),
('Blossom', 'Oct 13, 1998', 17, 'true', 3),
('Ditto', 'May 14, 2022', 22, 'true', 4);

INSERT INTO owners(full_name, age)
values
 ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES
('Pokemon'),
 ('Digimon');

 UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id= 1 WHERE species_id IS NULL; 

UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

