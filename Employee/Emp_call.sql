-- Calling Program
DECLARE
Emp_detail EMP_TABLE%ROWTYPE;
NEW_EMP EMP_TABLE%ROWTYPE;
begin
-- Inserting data into the NEw_EMP a rowtype attr 
-- NEW_EMP.EMP_CODE := 'E008';
-- NEW_EMP.EMP_FIRST_NAME := 'Mbarushimana';
-- NEW_EMP.EMP_LAST_NAME := 'Etienne';
-- NEW_EMP.EMP_SALARY := 1000000;
-- NEW_EMP.EMP_ADDRESS := 'Canada';

-- -- passing the NEw_EMP into the set_record Procdure 
-- EMP_DETAILS.set_record(NEW_EMP); 
-- Using the getrecord to get the employee Details
Emp_detail := EMP_DETAILS.get_record('E001');
dbms_output.put_line('Retrievd Employee''s name is '||Emp_detail.EMP_FIRST_NAME||' '||Emp_detail.EMP_LAST_NAME);
end;