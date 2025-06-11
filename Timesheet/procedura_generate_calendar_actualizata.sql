CREATE OR REPLACE PROCEDURE generate_calendar_for_employee (
  p_employee_id IN NUMBER
) AS
  v_start_date   DATE := TO_DATE('2025-01-01', 'YYYY-MM-DD');
  v_end_date     DATE := TO_DATE('2025-12-31', 'YYYY-MM-DD');
  v_curr_date    DATE;
  v_calendar_id  NUMBER;
  v_is_working   CHAR(1);
  v_reason       VARCHAR2(50);
BEGIN
  SELECT NVL(MAX(calendar_id), 0) + 1 INTO v_calendar_id FROM calendar;

  v_curr_date := v_start_date;

  WHILE v_curr_date <= v_end_date LOOP
    IF TO_CHAR(v_curr_date, 'D') IN ('1', '7') THEN
      v_is_working := 'N';
      v_reason := CASE TO_CHAR(v_curr_date, 'D')
                    WHEN '1' THEN 'duminica'
                    WHEN '7' THEN 'sambata'
                    ELSE 'weekend'
                  END;
    ELSE
      v_is_working := 'Y';
      v_reason := 'zi lucrătoare';
    END IF;

    INSERT INTO calendar (
      calendar_id, calendar_date, employee_id, is_working_day, reason
    ) VALUES (
      v_calendar_id, v_curr_date, p_employee_id, v_is_working, v_reason
    );

    v_calendar_id := v_calendar_id + 1;
    v_curr_date := v_curr_date + 1;
  END LOOP;
END;
/
