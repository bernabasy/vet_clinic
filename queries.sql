/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name from animalS WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered = true and escape_attempts <3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name,escape_attempts from animals WHERE weight_kg >10.5;
SELECT * from animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT  delete_with_birth;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK to delete_with_birth;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

SELECT count(*) from animals;
SELECT count(*) from animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals  WHERE date_of_birth > '1990-01-01' AND date_of_birth <'2000-12-31'  GROUP BY species;

SELECT animals.name FROM animals JOIN owners ON owner_id = owners.id WHERE owners.id = 4;
SELECT animals.name FROM animals Join species ON species_id = species.id WHERE species.id = 1;
SELECT owners.full_name, animals.name FROM owners RIGHT JOIN animals ON owner_id = owners.id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT animals.name FROM animals
JOIN species ON species_id = species.id
JOIN owners ON owner_id = owners.id 
WHERE owners.full_name = 'Jennifer Orwell';
SELECT animals.name FROM animals JOIN owners ON owner_id = owners.id 
JOIN species ON species_id = species.id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
SELECT owners.full_name, COUNT(animals.name) FROM animals 
JOIN owners ON owner_id = owners.id GROUP BY owners.full_name;

