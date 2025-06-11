CREATE USER pontaj IDENTIFIED BY pontaj123;
GRANT CONNECT, RESOURCE TO pontaj;
ALTER USER pontaj DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;

select employee_id from employees

SELECT COUNT(*)
FROM calendar
WHERE employee_id = :emp_id
  AND calendar_date BETWEEN :leave_date AND :return_date
  AND is_working_day = 'Y';