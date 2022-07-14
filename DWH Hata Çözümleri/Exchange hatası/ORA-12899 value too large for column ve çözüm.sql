
CREATE TABLE tbl_test AS
SELECT CAST(NULL AS VARCHAR2(20 BYTE)) AS clmn
  FROM sys.dual;

INSERT INTO tbl_test
SELECT '30 karakterlik string ifademiz' AS clmn
  FROM sys.dual; 
--ORA-12899: value too large for column "C##USER2"."TBL_TEST"."CLMN" (actual: 30, maximum: 20)


--çözüm 1: (final tablo ise)
INSERT INTO tbl_test 
SELECT SUBSTR('30 karakterlik string ifademiz',1,20) AS clmn
  FROM dual;
--1 row inserted.  
ROLLBACK;

--çözüm 2: (ara tablo ise)
ALTER TABLE tbl_test MODIFY clmn varchar2(30);
--Table altered

INSERT INTO tbl_test
SELECT '30 karakterlik string ifademiz' AS clmn
  FROM sys.dual; 
--1 row inserted.  
COMMIT;

