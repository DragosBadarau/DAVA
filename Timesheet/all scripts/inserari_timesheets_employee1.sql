-- Inserare pontaje demo în tabela timesheets pentru employee_id = 1

-- Asigură-te că există un proiect cu project_id = 1
-- Dacă nu, inserează-l mai întâi în tabela projects

-- Exemplu proiect demo
INSERT INTO projects (project_id, project_name, client_name, start_date, end_date, department_id, project_phase)
VALUES (1, 'Sistem Raportare', 'Client Test', TO_DATE('2025-01-01','YYYY-MM-DD'), NULL, 10, 'Implementation');


-- Exemplu proiect baza de date
INSERT INTO projects (project_id, project_name, client_name, start_date, end_date, department_id, project_phase)
VALUES (2, 'Timesheets Project', 'Intern', TO_DATE('2025-06-05','YYYY-MM-DD'),  TO_DATE('2025-06-12','YYYY-MM-DD'), 10, 'Implementation');


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

