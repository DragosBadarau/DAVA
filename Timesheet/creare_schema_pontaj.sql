-- Sistem de pontare - Creare schema completa
-- Dragos - Tema Oracle SQL/PLSQL
-- Asigura-te ca lucrezi in schema: pontaj

-- ====================
-- Tabela: jobs
-- ====================
CREATE TABLE jobs (
  job_id       VARCHAR2(10) PRIMARY KEY,
  job_title    VARCHAR2(100) NOT NULL,
  job_grad     VARCHAR2(20)
);

-- ====================
-- Tabela: departments
-- ====================
CREATE TABLE departments (
  department_id   NUMBER PRIMARY KEY,
  department_name VARCHAR2(100) NOT NULL,
  manager_id      NUMBER
);

-- ====================
-- Tabela: employees
-- ====================
CREATE TABLE employees (
  employee_id     NUMBER PRIMARY KEY,
  first_name      VARCHAR2(50) NOT NULL,
  last_name       VARCHAR2(50) NOT NULL,
  email           VARCHAR2(100) UNIQUE,
  hire_date       DATE DEFAULT SYSDATE,
  job_id          VARCHAR2(10),
  manager_id      NUMBER,
  department_id   NUMBER NOT NULL,
  status          VARCHAR2(20) DEFAULT 'activ' CHECK (status IN ('activ', 'inactiv')),
  CONSTRAINT fk_emp_job FOREIGN KEY (job_id) REFERENCES jobs(job_id),
  CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES employees(employee_id),
  CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ====================
-- Tabela: employee_absence
-- ====================
CREATE TABLE employee_absence (
  absence_id      NUMBER PRIMARY KEY,
  employee_id     NUMBER UNIQUE REFERENCES employees(employee_id),
  available_days  NUMBER(3) DEFAULT 21 CHECK (available_days BETWEEN 0 AND 365)
);

-- ====================
-- Tabela: leave_days
-- ====================
CREATE TABLE leave_days (
  leave_id        NUMBER PRIMARY KEY,
  absence_id      NUMBER REFERENCES employee_absence(absence_id),
  leave_date      DATE NOT NULL,
  reason          VARCHAR2(30) CHECK (reason IN ('concediu medical', 'odihna', 'eveniment', 'urgent')),
  approved        CHAR(1) CHECK (approved IN ('Y', 'N'))
);

-- ====================
-- Tabela: projects
-- ====================
CREATE TABLE projects (
  project_id      NUMBER PRIMARY KEY,
  project_name    VARCHAR2(100) NOT NULL,
  client_name     VARCHAR2(100),
  start_date      DATE,
  end_date        DATE,
  department_id   NUMBER,
  project_phase   VARCHAR2(50) CHECK (project_phase IN (
    'Requirements', 'Design', 'Implementation', 'Testing', 'Deployment', 'Maintenance', 'Retirement'
  )),
  CONSTRAINT fk_proj_dept FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- ====================
-- Tabela: timesheets
-- ====================
CREATE TABLE timesheets (
  timesheet_id      NUMBER PRIMARY KEY,
  employee_id       NUMBER REFERENCES employees(employee_id),
  project_id        NUMBER REFERENCES projects(project_id),
  work_date         DATE DEFAULT SYSDATE,
  hours_worked      NUMBER(4,2) DEFAULT 8 CHECK (hours_worked BETWEEN 0 AND 8),
  overtime_hours    NUMBER(4,2) DEFAULT 0 CHECK (overtime_hours BETWEEN 0 AND 8),
  overtime_activity CLOB,
  activity_json     CLOB,
  project_phase     VARCHAR2(50) CHECK (project_phase IN (
    'Planning', 'Requirements', 'Design', 'Implementation', 'Testing', 'Deployment', 'Maintenance', 'Retirement'
  )),
  status            VARCHAR2(20) DEFAULT 'inregistrat' CHECK (status IN ('inregistrat', 'validat', 'respins')),
  approved_by       NUMBER,
  CONSTRAINT fk_ts_approver FOREIGN KEY (approved_by) REFERENCES employees(employee_id)
);


CREATE TABLE locations (
  location_id   NUMBER PRIMARY KEY,
  country       VARCHAR2(100) NOT NULL,
  country_id    VARCHAR2(10) UNIQUE
);

-- Tabele pentru gestionarea zilelor lucrătoare și sărbătorilor

-- ====================
-- Tabela: free_days
-- ====================
CREATE TABLE free_days (
  free_day_id   NUMBER PRIMARY KEY,
  free_date     DATE UNIQUE NOT NULL,
  description   VARCHAR2(100)
);

-- ====================
-- Tabela: calendar (unic per employee)
-- ====================
CREATE TABLE calendar (
  calendar_id     NUMBER PRIMARY KEY,
  calendar_date   DATE NOT NULL,
  employee_id     NUMBER REFERENCES employees(employee_id),
  is_working_day  CHAR(1) CHECK (is_working_day IN ('Y','N')),
  reason          VARCHAR2(100),
  CONSTRAINT uq_emp_date UNIQUE (employee_id, calendar_date)
);
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

INSERT INTO jobs (job_id, job_title, job_grad) VALUES ('DEV', 'Developer', 'Mid');
INSERT INTO jobs (job_id, job_title, job_grad) VALUES ('QA', 'Tester', 'Junior');

INSERT INTO departments (department_id, department_name) VALUES (10, 'IT');

INSERT INTO employees (
  employee_id, first_name, last_name, email, hire_date, job_id, department_id
) VALUES (
  1, 'Dragos', 'Test', 'dragos@example.com', SYSDATE, 'DEV', 10
);

-- Exemplu proiect demo
INSERT INTO projects (project_id, project_name, client_name, start_date, end_date, department_id, project_phase)
VALUES (1, 'Sistem Raportare', 'Client Test', TO_DATE('2025-01-01','YYYY-MM-DD'), NULL, 10, 'Implementation');


-- Exemplu proiect baza de date
INSERT INTO projects (project_id, project_name, client_name, start_date, end_date, department_id, project_phase)
VALUES (2, 'Timesheets Project', 'Intern', TO_DATE('2025-06-05','YYYY-MM-DD'),  TO_DATE('2025-06-12','YYYY-MM-DD'), 10, 'Implementation');

INSERT INTO locations (location_id, country, country_id) VALUES (1, 'Romania', 'RO');
INSERT INTO locations (location_id, country, country_id) VALUES (2, 'United Kingdom', 'UK');
INSERT INTO locations (location_id, country, country_id) VALUES (3, 'United States', 'US');

-- Angajați noi

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (2, 'Maria', 'Ionescu', 'maria.ionescu@example.com', SYSDATE, 'DEV', 10);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (3, 'George', 'Vasilescu', 'george.vasilescu@example.com', SYSDATE, 'QA', 10);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (4, 'Irina', 'Voicu', 'irina.voicu@example.com', SYSDATE, 'QA', 10);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (7, 'John', 'Wayne', 'John.John@smth.com', SYSDATE, 'QA', 20);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (5, 'Alex', 'Dumitrescu', 'alex.dumitrescu@example.com', SYSDATE, 'DEV', 10);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (6, 'Mihai', 'Georgescu', 'mihai.georgescu@example.com', SYSDATE, 'DEV', 10);

-- Inserare zile libere adiționale pentru România
INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (7, TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Ziua Copilului', 'RO');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (8, TO_DATE('2025-06-24', 'YYYY-MM-DD'), 'Sânziene', 'RO');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (9, TO_DATE('2025-11-30', 'YYYY-MM-DD'), 'Sf. Andrei', 'RO');

-- Zile libere UK (cod țară: UK)
INSERT INTO locations (location_id, country, country_id)
VALUES (4, 'United Kingdom', 'UK');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (10, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'New Year Day', 'UK');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (11, TO_DATE('2025-04-18', 'YYYY-MM-DD'), 'Good Friday', 'UK');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (12, TO_DATE('2025-04-21', 'YYYY-MM-DD'), 'Easter Monday', 'UK');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (13, TO_DATE('2025-05-05', 'YYYY-MM-DD'), 'Early May Bank Holiday', 'UK');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (14, TO_DATE('2025-12-25', 'YYYY-MM-DD'), 'Christmas Day', 'UK');

INSERT INTO free_days (free_day_id, free_date, description, country_id)
VALUES (15, TO_DATE('2025-12-26', 'YYYY-MM-DD'), 'Boxing Day', 'UK');


-- Pontaje pentru 3 zile consecutive
INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  1, 1, 1, TO_DATE('2025-01-15', 'YYYY-MM-DD'),
  8, 0, NULL,
  '{ "start": "09:00", "end": "17:00", "tasks": "creare backend module" }',
  'Implementation', 'validat', NULL
);

INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  2, 1, 1, TO_DATE('2025-01-16', 'YYYY-MM-DD'),
  8, 2, '{ "reason": "code review urgent" }',
  '{ "start": "09:00", "end": "19:00", "tasks": "optimizare performanță" }',
  'Testing', 'inregistrat', NULL
);

INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  3, 1, 1, TO_DATE('2025-01-17', 'YYYY-MM-DD'),
  6, 0, NULL,
  '{ "start": "10:00", "end": "16:00", "tasks": "fixare buguri minore" }',
  'Maintenance', 'validat', NULL
);

INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  4, 1, 2, TO_DATE('2025-06-11', 'YYYY-MM-DD'),
  8, 0, NULL,
  '{ "start": "10:00", "end": "18:00", "tasks": "populare baza de date" }',
  'Implementation', 'validat', NULL
);

INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  5, 1, 2, TO_DATE('2025-06-10', 'YYYY-MM-DD'),
  8, 0, NULL,
  '{ "start": "10:00", "end": "18:00", "tasks": "definire structura bd" }',
  'Design', 'validat', NULL
);

INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  8, 1, 2, TO_DATE('2025-06-08', 'YYYY-MM-DD'),
  8, 0, NULL,
  '{ "start": "10:00", "end": "18:00", "tasks": "university courses" }',
  'Planning', 'validat', NULL
);

-- Timesheets pentru John (2 zile)
INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  9, 7, 1, TO_DATE('2025-01-10', 'YYYY-MM-DD'),
  8, 0, NULL,
  '{ "start": "09:00", "end": "17:00", "tasks": "testare UI" }',
  'Testing', 'validat', NULL
);

INSERT INTO timesheets (
  timesheet_id, employee_id, project_id, work_date,
  hours_worked, overtime_hours, overtime_activity, activity_json,
  project_phase, status, approved_by
) VALUES (
  10, 7, 1, TO_DATE('2025-01-11', 'YYYY-MM-DD'),
  7, 0, NULL,
  '{ "start": "10:00", "end": "17:00", "tasks": "testare regresie" }',
  'Testing', 'inregistrat', NULL
);

-- Timesheets pentru Alex (3 zile)
INSERT INTO timesheets VALUES (
  11, 5, 1, TO_DATE('2025-01-08', 'YYYY-MM-DD'), 8, 0, NULL,
  '{ "start": "09:00", "end": "17:00", "tasks": "refactorizare cod" }',
  'Implementation', 'validat', NULL
);

INSERT INTO timesheets VALUES (
  12, 5, 1, TO_DATE('2025-01-09', 'YYYY-MM-DD'), 8, 1,
  '{ "reason": "finalizare task urgent" }',
  '{ "start": "09:00", "end": "18:00", "tasks": "integrare API" }',
  'Implementation', 'validat', NULL
);

INSERT INTO timesheets VALUES (
13, 5, 1, TO_DATE('2025-01-10', 'YYYY-MM-DD'), 6, 0, NULL,
  '{ "start": "09:30", "end": "15:30", "tasks": "code review" }',
  'Implementation', 'inregistrat', NULL
);
SET SERVEROUTPUT ON

ALTER SESSION SET NLS_TERRITORY = 'AMERICA';

-- Timesheets pentru Mihai (5 zile)
BEGIN
  FOR i IN 1..5 LOOP
    INSERT INTO timesheets (
      timesheet_id, employee_id, project_id, work_date,
      hours_worked, overtime_hours, overtime_activity, activity_json,
      project_phase, status, approved_by
    ) VALUES (
      13 + i, 6, 1, TO_DATE('2025-01-' || (12 + i), 'YYYY-MM-DD'), 8, 0, NULL,
      '{ "start": "09:00", "end": "17:00", "tasks": "implementare functionalitati" }',
      'Implementation', 'validat', NULL
    );
  END LOOP;
END;
/

SELECT * FROM EMPLOYEES 

BEGIN
     generate_calendar_for_employee(1);
     generate_calendar_for_employee(2);
     generate_calendar_for_employee(3);
     generate_calendar_for_employee(4);
     generate_calendar_for_employee(5);
     generate_calendar_for_employee(6);
     generate_calendar_for_employee(7);
END;
-- Script: Propagare zile libere în calendar pe baza country_id

-- Setează zilele din calendar ca nelucrătoare ('N') dacă există în free_days pentru țara angajatului

MERGE INTO calendar c
USING (
  SELECT
    c.calendar_id,
    f.free_date
  FROM calendar c
  JOIN employees e ON c.employee_id = e.employee_id
  JOIN departments d ON e.department_id = d.department_id
  JOIN locations l ON d.location_id = l.location_id
  JOIN free_days f ON f.free_date = c.calendar_date AND f.country_id = l.country_id
) src
ON (c.calendar_id = src.calendar_id)
WHEN MATCHED THEN
  UPDATE SET c.is_working_day = 'N',
             c.reason = 'sărbătoare națională';


SELECT calendar_date, reason, is_working_day
FROM calendar
WHERE employee_id = 2 AND is_working_day = 'N'
ORDER BY calendar_date;


-- DESC calendar;


-- VIEW with how many hours each employee has worked + its overtime
SELECT
  e.employee_id,
  e.first_name || ' ' || e.last_name AS nume_angajat,
  SUM(t.hours_worked) AS total_ore,
  SUM(t.overtime_hours) AS total_ore_suplimentare
FROM timesheets t
JOIN employees e ON t.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name;

CREATE OR REPLACE VIEW vw_total_ore_angajati AS
SELECT
  e.employee_id,
  e.first_name || ' ' || e.last_name AS nume_angajat,
  SUM(t.hours_worked) AS total_ore,
  SUM(t.overtime_hours) AS total_ore_suplimentare
FROM timesheets t
JOIN employees e ON t.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name



SELECT * FROM vw_total_ore_angajati ORDER BY  total_ore desc;

select * from timesheets


CREATE INDEX idx_status_ts ON timesheets(status);
CREATE INDEX idx_phase_ts ON timesheets(project_phase);
CREATE INDEX idx_work_date_ts ON timesheets(work_date);

SET SERVEROUTPUT ON
ALTER SESSION SET NLS_TERRITORY = 'AMERICA';

BEGIN
  generate_calendar_for_employee(4);
END;

-- DESC calendar;


-- VIEW with how many hours each employee has worked + its overtime

CREATE OR REPLACE VIEW vw_total_ore_angajati AS
SELECT
  e.employee_id,
  e.first_name || ' ' || e.last_name AS nume_angajat,
  SUM(t.hours_worked) AS total_ore,
  SUM(t.overtime_hours) AS total_ore_suplimentare
FROM timesheets t
JOIN employees e ON t.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY  total_ore desc;


SELECT * FROM vw_total_ore_angajati;
-- Selectează toate pontajele cu status validat
SELECT *
FROM timesheets
WHERE status = 'validat';

SELECT project_phase, COUNT(*)
FROM timesheets
WHERE project_phase = 'Implementation'
GROUP BY project_phase;

CREATE MATERIALIZED VIEW mv_ore_proiect
BUILD IMMEDIATE
REFRESH ON DEMAND
AS
SELECT
  t.project_id,
  t.project_phase,
  SUM(t.hours_worked) AS total_ore,
  SUM(t.overtime_hours) AS total_overtime
FROM timesheets t
GROUP BY t.project_id, t.project_phase;

SELECT * FROM mv_ore_proiect;

-- SELECT care afișează toți angajații și dacă au sau nu pontaje
-- Folosește LEFT JOIN între employees și timesheets

SELECT
  e.employee_id,
  e.first_name || ' ' || e.last_name AS nume_angajat,
  t.work_date,
  t.hours_worked,
  t.status
FROM employees e
LEFT JOIN timesheets t ON e.employee_id = t.employee_id
ORDER BY e.employee_id, t.work_date;

-- Afișează doar angajații fără pontaje
SELECT
  e.employee_id,
  e.first_name || ' ' || e.last_name AS nume_angajat
FROM employees e
LEFT JOIN timesheets t ON e.employee_id = t.employee_id
WHERE t.timesheet_id IS NULL;
-- Functia analitica 
-- Afișează angajații în ordinea descrescătoare a orelor totale lucrate
-- Dacă există egalitate, se aplică același rank

SELECT
  employee_id,
  total_ore,
  RANK() OVER (ORDER BY total_ore DESC) AS rank_ore
FROM (
  SELECT
    t.employee_id,
    SUM(t.hours_worked + t.overtime_hours) AS total_ore
  FROM timesheets t
  GROUP BY t.employee_id
);