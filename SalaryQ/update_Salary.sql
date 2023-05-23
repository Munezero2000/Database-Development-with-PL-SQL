DECLARE
--Variable Declaration
id employes.code%type:=&value;
Salary employes.sal%type;
Increased_salary employes.sal%type;
Min_salary employes.sal%type;
Max_salary employes.sal%type;
salary_is_corrected EXCEPTION;
PRAGMA exception_init(salary_is_corrected,-20001);

BEGIN
-- Querring the database
select sal into salary from Employes WHERE CODE=id; 
select min(sal) into  Min_salary from Employes;
select max(sal) into  Max_salary from Employes;

--Increasing the salary basing on the condition
increased_salary := salary + (salary*0.1);
dbms_output.put_line('The Minimum Salary is: ' ||Min_salary);
dbms_output.put_line('The Maxmum Salary is: ' ||Max_salary);
dbms_output.put_line('The new Salary is: '||increased_salary);

--Updating the salary with the new values
update employes set sal = increased_salary where code = id;

--Calculating the salary range
IF Increased_salary > Min_salary and Increased_salary < Max_salary
Then
raise_application_error(-20001,'Salary_is_corrected');
ELSE 
dbms_output.put_line('Additional bonus is needed');
END IF;

--Error handling
EXCEPTION
WHEN salary_is_corrected THEN
dbms_output.put_line(sqlerrm);
WHEN Others Then
dbms_output.put_line('There is an error');
END;
/