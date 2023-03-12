/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;

CREATE TABLE animals (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
  name  VARCHAR(70),
  date_of_birth DATE,
  escape_attempts INT,
  neutered  BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR;

CREATE TABLE owners (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	full_name VARCHAR(70),
	age        INT
);

CREATE TABLE species (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	name VARCHAR(70)
);

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_animals
FOREIGN KEY(species_id) 
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals  
ADD CONSTRAINT fk_owners
FOREIGN KEY(owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;

CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	name VARCHAR(70),
	age  INT,
	date_of_graduation DATE
);

CREATE TABLE specializations(
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	species_id INT NOT NULL,
	vets_id  INT NOT NULL,
	CONSTRAINT fk_species 
	 FOREIGN KEY (species_id)
	REFERENCES species(id)
	ON UPDATE CASCADE,
	CONSTRAINT fk_vets
	FOREIGN KEY (vets_id)
	REFERENCES vets(id)
	ON UPDATE CASCADE
);

CREATE TABLE visits (
id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	animals_id INT NOT NULL,
	vets_id  INT NOT NULL,
	date_of_visits DATE,
	CONSTRAINT fk_animals
	FOREIGN KEY (animals_id)
	REFERENCES animals(id)
	ON UPDATE CASCADE ,
	CONSTRAINT fk_vets
	FOREIGN KEY (vets_id)
	REFERENCES vets(id)
	ON UPDATE CASCADE
);

-- Add an email column to my owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animals_asc ON visits (animals_id ASC);

CREATE INDEX vets_asc ON visits (vets_id ASC);

CREATE INDEX owners_asc ON owners (email ASC);
