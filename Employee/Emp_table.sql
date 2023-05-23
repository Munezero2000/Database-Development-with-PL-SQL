-- EMP_TABLE CREATION
CREATE TABLE EMP_TABLE (EMP_CODE CHAR(4), 
                        EMP_FIRST_NAME VARCHAR(50),
                        EMP_LAST_NAME VARCHAR(50),
                        EMP_SALARY INT,
                        EMP_ADDRESS VARCHAR(20)
                        );


-- INSERTING SAMPLE DATA INTO EMP_TABLE
INSERT INTO EMP_TABLE  VALUES('E001', 'Richard', 'Cipher', 245000, 'Rwanda');
INSERT INTO EMP_TABLE  VALUES('E002', 'John', 'Wick', 345000, 'Burundi');
INSERT INTO EMP_TABLE  VALUES('E003', 'Anna', 'Frank', 123400, 'Kenya');
INSERT INTO EMP_TABLE  VALUES('E004', 'Louise', 'Newton', 768900, 'Uganda');
INSERT INTO EMP_TABLE  VALUES('E005', 'Marie', 'Currie', 678900, 'Tanzanie');