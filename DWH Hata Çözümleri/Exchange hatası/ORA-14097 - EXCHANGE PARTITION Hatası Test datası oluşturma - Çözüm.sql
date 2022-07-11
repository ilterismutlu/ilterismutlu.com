
--DROP TABLE tbl_customer_hist PURGE;                              
    
CREATE TABLE tbl_customer_hist  NOLOGGING PARALLEL (DEGREE 8 INSTANCES 1) COMPRESS 
PARTITION BY RANGE (AS_OF_DATE)
INTERVAL( NUMTODSINTERVAL(1, 'DAY'))
(  
  PARTITION VALUES LESS THAN (TO_DATE(' 2022-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN'))
)
AS
WITH tbl_dates AS
(
     SELECT TO_DATE('01.01.2022','dd.mm.yyyy')-1 + LEVEL AS AS_OF_DATE
            FROM sys.dual
 CONNECT BY LEVEL <= to_date('01.02.2022','dd.mm.yyyy')-to_date('01.01.2022','dd.mm.yyyy') 
),
tbl_customer AS 
(
    SELECT LEVEL AS customer_id,
           DBMS_RANDOM.STRING('u',10) ||' ' || DBMS_RANDOM.STRING('u',10) AS c_name,
           DBMS_RANDOM.STRING('u',20) adres
      FROM sys.dual
CONNECT BY LEVEL <=100000
),
tbl_customer_branch AS
(
        SELECT LEVEL AS customer_id, 1 AS branch_id, DBMS_RANDOM.VALUE()*100000 AS balance
          FROM sys.dual
    CONNECT BY LEVEL <=50
 UNION ALL 
       SELECT LEVEL AS customer_id, 2 AS branch_id, DBMS_RANDOM.VALUE()*100000 AS balance
         FROM dual
   CONNECT BY LEVEL <=50
 UNION ALL 
       SELECT LEVEL AS customer_id, 3 AS branch_id, DBMS_RANDOM.VALUE()*100000 AS balance
         FROM dual
   CONNECT BY LEVEL <=50
 UNION ALL 
       SELECT LEVEL+50 AS customer_id,4 AS branch_id, DBMS_RANDOM.VALUE()*100000 AS balance
         FROM dual
   CONNECT BY LEVEL <=100000-50
)
SELECT d.as_of_date,
       b.customer_id,
       b.branch_id,
       CAST(c.c_name AS VARCHAR2(21 CHAR)) AS c_name,
       CAST(c.adres AS VARCHAR2(25 CHAR)) AS adres,
       ROUND(b.balance,2) AS balance
  FROM tbl_dates d
       CROSS JOIN tbl_customer c
       INNER JOIN tbl_customer_branch b ON c.customer_id = b.customer_id;       

--SELECT * FROM tbl_customer_hist ORDER BY 1,2,3;

--SELECT COUNT(*) FROM tbl_customer_hist;


--1) exchange partition HATALARI: 
--ORA-14099: all rows in table do not qualify for specified partition

--DROP TABLE tbl_customer_hist_exc PURGE;

CREATE TABLE tbl_customer_hist_exc NOLOGGING PARALLEL ( DEGREE 8 INSTANCES 1 ) COMPRESS AS
SELECT as_of_date+1 as_of_date, customer_id, branch_id, c_name, adres, balance 
  FROM tbl_customer_hist
 WHERE as_of_date = TO_DATE('20220131','YYYYMMDD');
 
 
--ORA-14097: column type or size mismatch in ALTER TABLE EXCHANGE PARTITION
--case 1:
ALTER TABLE tbl_customer_hist_exc MODIFY c_name VARCHAR2(22 CHAR);

LOCK TABLE tbl_customer_hist
  PARTITION FOR (TO_DATE('20220201','YYYYMMDD'))
  IN SHARE MODE;

--tabloyu lock'tan kurtarmak için:   
COMMIT;  --ROLLBACK; de olabilir. 

ALTER TABLE tbl_customer_hist
   EXCHANGE PARTITION FOR (TO_DATE('20220201','YYYYMMDD'))
 WITH TABLE tbl_customer_hist_exc;

--gözlem:
SELECT table_name,column_name, data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
  FROM user_tab_columns 
 WHERE 1=1
       AND table_name IN ( 'TBL_CUSTOMER_HIST','TBL_CUSTOMER_HIST_EXC')
       AND column_id IN (
                            SELECT column_id
                              FROM (
                                    (
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name ='TBL_CUSTOMER_HIST_EXC'
                                     MINUS
                                     SELECT data_type, data_	length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name='TBL_CUSTOMER_HIST'
                                    )
								    UNION ALL
								    (
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name ='TBL_CUSTOMER_HIST'
                                     MINUS
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name='TBL_CUSTOMER_HIST_EXC'
                                    )
                                   )
                          )
ORDER BY column_id;

--çözüm:
ALTER TABLE tbl_customer_hist MODIFY c_name varchar2(22 CHAR);

ALTER TABLE tbl_customer_hist
  EXCHANGE PARTITION FOR (TO_DATE('20220201','YYYYMMDD'))
  WITH TABLE tbl_customer_hist_exc;
--Table altered  
  
  
--ORA-14097: column type or size mismatch in ALTER TABLE EXCHANGE PARTITION
--case 2:

ALTER TABLE tbl_customer_hist_exc ADD dummy_sutun NUMBER;
----ALTER TABLE tbl_customer_hist_exc SET UNUSED COLUMN dummy_sutun;  --exadata kurulu olmadığı için, konunun anlaşılması için alttaki drop'u yapmayıp, bu şekilde simüle ettim. 
ALTER TABLE tbl_customer_hist_exc drop COLUMN dummy_sutun;
--add+drop column yapiliyor. Distan görüntü ayni gibi gözükse de exchange'de hata aliyor.

ALTER TABLE tbl_customer_hist
  EXCHANGE PARTITION FOR (TO_DATE('20220201','YYYYMMDD'))
  WITH TABLE tbl_customer_hist_exc;
--ORA-14097: column type or size mismatch in ALTER TABLE EXCHANGE PARTITION  
  
SELECT * 
  FROM dba_unused_col_tabs 
 WHERE 1=1 AND table_name IN ( 'TBL_CUSTOMER_HIST','TBL_CUSTOMER_HIST_EXC');
--OWNER	      TABLE_NAME	       COUNT
--C##USER2	TBL_CUSTOMER_HIST_EXC	1


--case 2 çözüm:
ALTER TABLE tbl_customer_hist_exc NOCOMPRESS;
ALTER TABLE tbl_customer_hist_exc DROP UNUSED COLUMNS;
ALTER TABLE tbl_customer_hist_exc MOVE PARALLEL 4 NOLOGGING;

SELECT * 
  FROM dba_unused_col_tabs 
 WHERE 1=1 AND table_name IN ( 'TBL_CUSTOMER_HIST','TBL_CUSTOMER_HIST_EXC');
--null

ALTER TABLE tbl_customer_hist
  EXCHANGE PARTITION FOR (TO_DATE('20220201','YYYYMMDD'))
  WITH TABLE tbl_customer_hist_exc;
--Table altered  