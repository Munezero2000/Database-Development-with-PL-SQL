CREATE OR REPLACE TRIGGER code_control
BEFORE INSERT ON emp_table
FOR EACH ROW
DECLARE
CODE CHAR(4);
BEGIN
    SELECT EMP_CODE INTO CODE FROM emp_table;
    IF  CODE = NEW.EMP_CODE THEN
    dbms_output.put_line('THERE IS ANOTHER USER WITH THE SAME CODE');
    END IF;
END;

CREATE OR REPLACE TRIGGER EMP_CONFIRM
AFTER INSERT ON EMP_TABLE 
begin
  DBMS_OUTPUT.PUT_LINE('A New Employee has been added');
end;
/

CREATE OR REPLACE TRIGGER restrcit_insert
BEFORE INSERT ON EMP_TABLE
begin
  IF (TO_CHAR(SYSDATE, 'HH24:MI')NOT BETWEEN '09:00' AND '18:00') THEN
    raise_application_error(-20123, 'You can add employye only between
    09:00 am and 6:00 pm');
 END IF;
end;

-- CHECKING THE CODE FOR THE EMPLOYEE
CREATE OR REPLACE TRIGGER CHECK_CODE
BEFORE INSERT ON EMP_TABLE
FOR EACH ROW
DECLARE
ROWCOUNT NUMBER;
begin
  SELECT COUNT(*) INTO ROWCOUNT FROM EMP_TABLE WHERE EMP_CODE = :NEW.EMP_CODE;
  IF ROWCOUNT > 0 THEN
   raise_application_error(-20002, 'CODE ALREADY EXISTS');
   END IF;
end;

-- TABLE FOR AUDITING UPDATES ON STUDENT
CREATE TABLE AUDIT_TABLE(
    OLD_STU_CODE VARCHAR(10),
    NEW_STU_CODE VARCHAR(10),
    CHANGE_TIME varchar(10),
    N_UPDATED NUMBER);

-- AUDIT STUDENTS TRIGGER
CREATE OR REPLACE TRIGGER AUDIT_ST
BEFORE UPDATE ON STUDENTS
FOR EACH ROW
WHEN (NEW.stu_code <> OLD.stu_code)
DECLARE
COUNTER number;
OLD_CODE VARCHAR(10);
NUM_UP NUMBER;
begin
    SELECT NEW_STU_CODE, N_UPDATED INTO OLD_CODE, NUM_UP FROM AUDIT_TABLE WHERE NEW_STU_CODE = :OLD.STU_CODE;
  IF OLD_CODE = :OLD.STU_CODE THEN
    COUNTER := NUM_UP + 1;
  ELSE
    COUNTER := 1;
  END IF;
    INSERT INTO AUDIT_TABLE VALUES(:OLD.STU_CODE, :NEW.STU_CODE, TO_CHAR(SYSDATE, 'HH24:MI'), COUNTER);
    DBMS_OUTPUT.PUT_LINE('Recorded');
  exception
    when no_data_found then
      COUNTER := 1;
      INSERT INTO AUDIT_TABLE VALUES(:OLD.STU_CODE, :NEW.STU_CODE, TO_CHAR(SYSDATE, 'HH24:MI'), COUNTER);
      DBMS_OUTPUT.PUT_LINE('Recorded');

    when too_many_rows then
      COUNTER := NUM_UP + 1;
      INSERT INTO AUDIT_TABLE VALUES(:OLD.STU_CODE, :NEW.STU_CODE, TO_CHAR(SYSDATE, 'HH24:MI'), COUNTER);
      DBMS_OUTPUT.PUT_LINE('Recorded');
  
end;

-- TEST CASE FOR UPDATING STUDENTS
update STUDENTS
set STU_CODE ='REGNO_02'
WHERE STU_FNAME = 'Rick';


