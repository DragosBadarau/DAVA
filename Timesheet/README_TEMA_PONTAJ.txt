# Sistem de Pontare - Tema Oracle SQL
Autor: Dragos Badarau
Livrare: Scripturi SQL + View-uri + Date + Documentatie

## Conținut 

** `creare_schema_pontaj.sql` ** : crearea tuturor tabelelor (timesheets, employees, etc.) + continutul fisierelor urmatoare : 

- `insert_timesheets_employee1.sql`: pontaje demo pentru employee_id = 1
- `insert_3_employees_timesheets.sql`: alți 3 angajați + timesheets
- `free_days_ro_uk.sql`: sărbători legale România și UK
- `locations_si_legaturi.sql`: locații + legătură cu departments
- `propagare_zile_libere_in_calendar.sql`: actualizează calendarul în funcție de țară
- `procedura_generate_calendar_actualizata.sql`: procedură PL/SQL care generează calendarul pentru un angajat
- `materialized_view_ore_proiect.sql`: materialized view cu total ore per proiect + fază
- `selecturi_left_join_si_analitica.sql`: interogări cu LEFT JOIN și funcții analitice

## Ordinea recomandată de rulare

1. `creare_schema_pontaj.sql`
2. `locations_si_legaturi.sql`
3. `free_days_ro_uk.sql`
4. `insert_timesheets_employee1.sql`
5. `insert_3_employees_timesheets.sql`
6. `procedura_generate_calendar_actualizata.sql`
7. Execută procedura pentru fiecare angajat:
   ```
   BEGIN
     generate_calendar_for_employee(1);
     generate_calendar_for_employee(2);
     generate_calendar_for_employee(3);
     generate_calendar_for_employee(4);
     generate_calendar_for_employee(5);
     generate_calendar_for_employee(6);
   END;
   ```
8. `propagare_zile_libere_in_calendar.sql`
9. `materialized_view_ore_proiect.sql`
10. `selecturi_left_join_si_analitica.sql`

## Cerințe acoperite

- toate tipurile de constrainturi
- date semistructurate (JSON în `timesheets`)
- indexuri adiționale (poate fi adăugat `CREATE INDEX ...`)
- view (`vw_total_ore_angajati`)
- materialized view (`mv_ore_proiect`)
- `GROUP BY`, `LEFT JOIN`, funcție analitică (`RANK()`)
- toate interogările au comentarii explicative

