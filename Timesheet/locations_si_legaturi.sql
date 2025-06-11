-- Tabela: locations
CREATE TABLE locations (
  location_id   NUMBER PRIMARY KEY,
  country       VARCHAR2(100) NOT NULL,
  country_id    VARCHAR2(10) UNIQUE
);

-- Modificare tabel: departments → adăugare locație
ALTER TABLE departments
ADD location_id NUMBER;

-- Adăugare constrângere FK
ALTER TABLE departments
ADD CONSTRAINT fk_dept_location FOREIGN KEY (location_id)
REFERENCES locations(location_id);

-- Inserare locații demo
INSERT INTO locations (location_id, country, country_id) VALUES (1, 'Romania', 'RO');
INSERT INTO locations (location_id, country, country_id) VALUES (2, 'United Kingdom', 'UK');
INSERT INTO locations (location_id, country, country_id) VALUES (3, 'United States', 'US');

UPDATE departments SET location_id = 1 WHERE department_id = 10;
UPDATE departments SET location_id = 2 WHERE department_id = 20;
UPDATE departments SET location_id = 3 WHERE department_id = 30;

select * from employees 
select * from calendar
UPDATE employees SET department_id = 10 where employee_id in (3,4)


 -- hours worked by every employee 
select sum(hours_worked) from timesheets group by employee_id

