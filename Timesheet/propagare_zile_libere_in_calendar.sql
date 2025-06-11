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

