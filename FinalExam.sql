CREATE OR REPLACE PACKAGE student_registration as 
FUNCTION intake_allocation(s_code students.STU_CODE%type) return varchar;
FUNCTION start_date(s_code students.STU_CODE%type) Return date;
PROCEDURE assign_department(code students.STU_CODE%type);
End student_registration;
/

CREATE OR REPLACE PACKAGE BODY student_registration as
FUNCTION intake_allocation(s_code students.stu_code%type) RETURN varchar(40)
is 
intake varchar(40);
reg_date DATE;
STUDENT STUDENTS%ROWTYPE;
STR  STUDENTS%ROWTYPE;
ST  STUDENTS%ROWTYPE;
CURSOR FIRST IS SELECT * FROM STUDENTS
JOIN DEPARTMENT ON DEPARTMENT.ID = STUDENTS.DEPARTMENT_ID
WHERE REGISTRATION_DATE BETWEEN '1-JAN-2022' AND '28-FEB-2022';

CURSOR SECOND IS SELECT * FROM STUDENTS
JOIN DEPARTMENT ON DEPARTMENT.ID = STUDENTS.DEPARTMENT_ID
WHERE REGISTRATION_DATE  BETWEEN '1-MAR-2022' AND '28-FEB-2022';

CURSOR THIRD IS SELECT * FROM STUDENTS
JOIN DEPARTMENT ON DEPARTMENT.ID = STUDENTS.DEPARTMENT_ID
WHERE REGISTRATION_DATE BETWEEN '16-APR-2022' AND '30-JUN-202';
begin
FOR STUDENT IN FIRST loop
if STUDENT.STU_CODE = S_CODE then
    intake := 'First Intake';
end if;
END LOOP;

FOR STR IN SECOND loop
if STR.STU_CODE = S_CODE then
    intake := 'Second Intake';
end if;
END LOOP;

FOR ST IN THIRD loop
if ST.STU_CODE = S_CODE then
    intake := 'Third Intake';
end if;
END LOOP;
return intake;
end intake_allocation;

FUNCTION start_date(s_code students.STU_CODE%type) RETURN DATE
is
check_intake varchar(30);
startdate DATE;
begin
check_intake := intake_allocation(s_code);
if check_intake = 'First Intake' then
    startdate := TO_DATE('2023-01-01','YYYY-MM-DD');
elsif check_intake = 'Second Intake' then
    startdate := TO_DATE('2023-03-01','YYYY-MM-DD');
elsif check_intake = 'Third Intake' then
    startdate := TO_DATE('2023-05-01','YYYY-MM-DD');
end if;
RETURN startdate;
END start_date;

PROCEDURE assign_department(code students.STU_CODE%type)
is
intake VARCHAR(30);
STARTD DATE;
dept varchar(20);
STUD STUDENTS%ROWTYPE;
begin
intake := intake_allocation(code);
STARTD := start_date(code); 
SELECT * INTO STUD FROM STUDENTS WHERE STU_CODE = code;

if intake = 'First Intake' then
    dept := 'Computer science';
elsif intake = 'Second Intake' then
    dept := 'Information Technology';
elsif intake = 'Second Intake' then
    dept := 'Arts';
END IF;
dbms_output.put_line('student Code: '||STUD.STU_CODE);
dbms_output.put_line('student Name: '||STUD.STU_FNAME||' '||STUD.STU_LNAME);
dbms_output.put_line('Department Code: '||STUD.DEPARTMENT_ID);
dbms_output.put_line('Department Name: '||dept);
dbms_output.put_line('Student Age: '||STUD.STU_AGE);
dbms_output.put_line('REGISTRATION DATE: '||STUD.REGISTRATION_DATE);
dbms_output.put_line('Student intake: '||intake);
dbms_output.put_line('Intake startdate : '||STARTD);

end assign_department;
end;






begin
  
end;







EXECUTE STUDENT_REGISTRATION.ASSIGN_DEPARTMENT('REGNO_03');



