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

 INSERT INTO vets (name, age, date_of_graduation)
 VALUES 
 ('William Tatcher', 45, '2000-04-23'),
 ('Maisy Smith', 26, '2019-01-17'),
 ('Stephanie Mendez', 64, '1981-05-04'),
 ('Jack Harkness', 38, '2008-06-08');
 

INSERT INTO specializations(vets_id, species_id) 
VALUES((SELECT id FROM vets WHERE name = 'William Tatcher'), 
(SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations(vets_id, species_id) 
VALUES((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO specializations(vets_id, species_id)
VALUES((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations(vets_id, species_id)
VALUES((SELECT id FROM vets WHERE name = 'Jack Harkness'), 
(SELECT id FROM species WHERE name = 'Digimon'));


INSERT INTO visits (animals_id, vets_id, date_of_visits) VALUES
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-05-14'),
((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-05-04'),
((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-04'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vets_id, date_of_visits)
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) 
select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
