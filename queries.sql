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
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owner_id = owners.id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT animals.name FROM animals
JOIN species ON species_id = species.id
JOIN owners ON owner_id = owners.id 
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';
SELECT animals.name FROM animals JOIN owners ON owner_id = owners.id 
JOIN species ON species_id = species.id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';
SELECT owners.full_name, COUNT(animals.name) FROM animals 
JOIN owners ON owner_id = owners.id GROUP BY owners.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;


-- Who was the last animal seen by William Tatcher?

SELECT animals.name, v.date_of_visits FROM visits AS v
JOIN vets  ON v.vets_id = vets.id
JOIN animals ON v.animals_id = animals.id 
WHERE vets.name = 'William Tatcher' 
ORDER BY date_of_visits DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?

SELECT animals.name FROM  visits AS v
JOIN vets ON v.vets_id = vets.id
JOIN animals ON v.animals_id = animals.id 
WHERE vets.name = 'Stephanie Mendez' ;

-- List all vets and their specialties, including vets with no specialties.

SELECT vets.name, species.name FROM specializations AS s
JOIN species ON s.species_id = species.id
RIGHT JOIN vets ON s.vets_id = vets.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT animals.name FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visits BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?

SELECT animals.name, COUNT(animals.id) FROM visits AS v
JOIN animals ON v.animals_id = animals.id 
JOIN vets ON v.vets_id = vets.id
GROUP BY animals.id
ORDER BY COUNT(animals.id) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?

SELECT animals.name, visits.date_of_visits FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visits ASC
LIMIT 1;

SELECT vets.id, vets.name AS vets_name, vets.age AS vets_age, vets.date_of_graduation AS vets_date_of_graduation,
animals.id, animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg,
visits.date_of_visits FROM visits
JOIN animals ON visits.animals_id = animals.id 
JOIN vets ON visits.vets_id = vets.id
ORDER BY visits.date_of_visits DESC
LIMIT 1;

--how many visits were with a vet that did not specialize in that animal's species
SELECT COUNT(*)
FROM visits
LEFT JOIN animals ON visits.animals_id = animals.id
LEFT JOIN vets ON visits.vets_id = vets.id
WHERE animals.species_id NOT IN (
    SELECT species_id FROM specializations
	WHERE specializations.vets_id = vets.id
);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT species.name ,count(*) FROM visits 
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id=vets.id 
JOIN species ON animals.species_id = species.id
WHERE vets.name='Maisy Smith'
GROUP BY species.name
ORDER BY species.name ASC
LIMIT 1;