DECLARE
first_name students.stu_fname%type;
st_code students.stu_code%type:=&st_code;
FUNCTION student_name(reg_num IN varchar2) RETURN varchar2  IS
fname students.stu_fname%type;

BEGIN
SELECT stu_fname INTO fname FROM students WHERE stu_code = reg_num;
return fname;
END;


BEGIN
first_name := student_name(st_code);
dbms_output.put_line('The first name of the student is :'||first_name);

EXCEPTION 
WHEN NO_DATA_FOUND THEN 
DBMS_OUTPUT.put_line(' andre');

END;
/

CREATE OR REPLACE FUNCTION student_name(reg_num STUDENTS.STU_CODE%TYPE) RETURN students.stu_fname%type  IS
fname students.stu_fname%type;
BEGIN
SELECT STU_FNAME INTO fname FROM students WHERE STU_CODE = reg_num;
return fname;
END student_name;
/

DECLARE
first_name students.stu_fname%type;

BEGIN 

first_name := student_name('REGNO_02');
dbms_output.put_line('The first name of the student is : '||first_name);

END;
/