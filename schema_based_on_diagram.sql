CREATE TABLE patients (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth DATE
);

CREATE TABLE treatments (
	id SERIAL PRIMARY KEY,
	type VARCHAR(100),
	name VARCHAR(100)
);

CREATE TABLE medical_histories (
	id SERIAL PRIMARY KEY,
	admitted_at TIMESTAMP,
	patient_id INT REFERENCES patients(id),
	status VARCHAR(100),
);

CREATE TABLE invoices (
	id SERIAL PRIMARY KEY,
	total_amount DECIMAL,
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
	id SERIAL PRIMARY KEY,
	unit_price DECIMAL,
	quantity INT,
  total_price DECIMAL,
	invoice_id INT REFERENCES invoices(id),
	treatment INT REFERENCES treatments(id)
);

CREATE TABLE treatment_history (
	medical_history_id INT REFERENCES medical_histories(id),
	treatment_id INT REFERENCES treatments(id)
);

We need a separate table to handle the many-to-many relationship between medical_histories and treatments.
CREATE TABLE treatment_history (
	medical_history_id INT REFERENCES medical_histories(id),
	treatment_id INT REFERENCES treatments(id)
);
CREATE INDEX ON invoices (medical_history_id);
CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON treatment_history (medical_history_id);
CREATE INDEX ON treatment_history (treatment_id);
