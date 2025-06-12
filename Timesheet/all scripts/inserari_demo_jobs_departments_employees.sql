
INSERT INTO jobs (job_id, job_title, job_grad) VALUES ('DEV', 'Developer', 'Mid');

INSERT INTO departments (department_id, department_name) VALUES (10, 'IT');
-- (ex: CEO)
INSERT INTO employees (
  employee_id, first_name, last_name, email, hire_date, job_id, department_id
) VALUES (
  1, 'Dragos', 'Test', 'dragos@example.com', SYSDATE, 'DEV', 10
);

select * from employees 
commit
select * from departments

INSERT INTO jobs (job_id, job_title, job_grad) VALUES ('QA', 'Tester', 'Junior');
INSERT INTO jobs (job_id, job_title, job_grad) VALUES ('PM', 'Project Manager', 'Senior');

-- ====================
-- Tabela: departments
-- ====================
INSERT INTO departments (department_id, department_name) VALUES (10, 'IT');
INSERT INTO departments (department_id, department_name) VALUES (20, 'Quality Assurance');
INSERT INTO departments (department_id, department_name) VALUES (30, 'Project Management');

-- ====================
-- Tabela: employees
-- Angajat 4 - fără manager 
INSERT INTO employees (
  employee_id, first_name, last_name, email, hire_date, job_id, department_id
) VALUES (
  4, 'Andrei', 'Popescu', 'andrei.popescu@example.com', SYSDATE, 'PM', 30
);

-- Angajat 2 - Developer 
INSERT INTO employees (
  employee_id, first_name, last_name, email, hire_date, job_id, manager_id, department_id
) VALUES (
  2, 'Maria', 'Ionescu', 'maria.ionescu@example.com', SYSDATE, 'DEV', 1, 10
);

-- Angajat 3 - Tester 
INSERT INTO employees (
  employee_id, first_name, last_name, email, hire_date, job_id, manager_id, department_id
) VALUES (
  3, 'George', 'Vasilescu', 'george.vasilescu@example.com', SYSDATE, 'QA', 1, 20
);




