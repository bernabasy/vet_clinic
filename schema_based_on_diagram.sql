CREATE TABLE patients (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
name  VARCHAR(70),
date_of_birth  DATE
);

CREATE TABLE medical_histories (
     id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
     admitted_at  TIMESTAMP,
     patient_id   INT,
     status VARCHAR(250),
    CONSTRAINT fk_patients
	FOREIGN KEY (patient_id)
	REFERENCES patients(id)
	ON UPDATE CASCADE
);

CREATE TABLE treatments (
     id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
     type VARCHAR(70),
     name  VARCHAR(70)
);

CREATE TABLE invoices (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    total_amount  DECIMAL,
    generated_at TIMESTAMP,
    payed_at  TIMESTAMP,
    medical_history_id INT,
    CONSTRAINT fk_medical_histories
	FOREIGN KEY (medical_history_id)
	REFERENCES medical_histories(id)
	ON UPDATE CASCADE
);

CREATE TABLE invoice_items (
 id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
 unit_price   DECIMAL,
 quantity  INT,
 total_price DECIMAL,
 invoice_id  INT,
 treatment_id INT,
  CONSTRAINT fk_invoices
	FOREIGN KEY (invoice_id)
	REFERENCES invoices(id)
	ON UPDATE CASCADE,
  CONSTRAINT fk_treatments
	FOREIGN KEY (treatment_id)
	REFERENCES treatments(id)
	ON UPDATE CASCADE
);

CREATE TABLE medical_histories_treatments (
   id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
   medical_histories_id  INT,
   treatments_id INT,
   CONSTRAINT fk_medical_histories_m2m
	FOREIGN KEY (medical_histories_id)
	REFERENCES medical_histories(id)
	ON UPDATE CASCADE, 
     CONSTRAINT fk_treatments_m2m
	FOREIGN KEY (treatments_id)
	REFERENCES treatments(id)
	ON UPDATE CASCADE
);
