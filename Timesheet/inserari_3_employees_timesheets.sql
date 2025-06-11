-- Angajați noi
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (7, 'John', 'Wayne', 'John.John@smth.com', SYSDATE, 'QA', 20);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (5, 'Alex', 'Dumitrescu', 'alex.dumitrescu@example.com', SYSDATE, 'DEV', 10);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id)
VALUES (6, 'Mihai', 'Georgescu', 'mihai.georgescu@example.com', SYSDATE, 'DEV', 10);

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
