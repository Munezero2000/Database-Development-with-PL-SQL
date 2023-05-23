-- Creating an Interaface
PACKAGE specification
CREATE OR REPLACE PACKAGE EMP_DETAILS IS
PROCEDURE set_record(p_emp_rec EMP_TABLE%ROWTYPE);
PROCEDURE emp_count;
FUNCTION get_record(p_emp_no EMP_TABLE.EMP_CODE%TYPE) RETURN EMP_TABLE%ROWTYPE;
END EMP_DETAILS;
/

-- Creating the package Body
CREATE OR REPLACE PACKAGE BODY EMP_DETAILS AS

-- A procedure that take in an employee record and insert it into a database
PROCEDURE set_record(p_emp_rec EMP_TABLE%ROWTYPE)
is
BEGIN 
    -- A statement to retrive the number of Employe in the table before insertion. 
    emp_count();
    -- A statement to Inset a new Employee
    INSERT INTO EMP_TABLE VALUES (p_emp_rec.EMP_CODE, 
                                p_emp_rec.EMP_FIRST_NAME,
                                p_emp_rec.EMP_LAST_NAME,
                                p_emp_rec.EMP_SALARY,
                                p_emp_rec.EMP_ADDRESS);
    -- Printing the detail of added Employee
    dbms_output.put_line('The Employee: '||p_emp_rec.EMP_FIRST_NAME||' '||p_emp_rec.EMP_LAST_NAME||' with '||p_emp_rec.EMP_CODE||' Code has been added');
    -- A statement to retrive the number of Employee in the table after Instertion.
    emp_count();
END set_record;

-- A function to Retrive an employe  using His/Her Id
FUNCTION get_record(p_emp_no EMP_TABLE.EMP_CODE%TYPE) 
RETURN EMP_TABLE%ROWTYPE
is
Emp_detail EMP_TABLE%ROWTYPE;
BEGIN
SELECT * INTO Emp_detail FROM EMP_TABLE WHERE EMP_CODE = p_emp_no;
RETURN Emp_detail;
END get_record;

-- A procedure to count Employee
PROCEDURE emp_count is 
Emp_num number;
begin
  SELECT count(*) into Emp_num from EMP_TABLE;
    dbms_output.put_line('The number of Employees was '||Emp_num);
end emp_count;

end;



