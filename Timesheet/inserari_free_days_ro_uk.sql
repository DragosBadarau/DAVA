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
