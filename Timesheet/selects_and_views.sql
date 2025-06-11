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