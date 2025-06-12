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

select * from timesheets
