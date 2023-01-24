/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals ADD species VARCHAR(100);

CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(100),
  age INT
);

CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vets_id INT references vets(id),
  species_id INT references species(id)
);

CREATE TABLE visits (
  vets_id INT references vets(id),
  animals_id INT references animals(id),
  date_of_visits DATE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX ind_animals_id ON visits (animals_id);
CREATE INDEX ind_vets_id ON visits (vets_id);
CREATE INDEX ind_email ON owners (email);
