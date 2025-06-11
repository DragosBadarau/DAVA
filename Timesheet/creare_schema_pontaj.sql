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

