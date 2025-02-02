--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMPLOYEES
--------------------------------------------------------

  CREATE TABLE "PROJECT"."EMPLOYEES" 
   (	"PERSONAL_ID" NUMBER(8,0), 
	"FULL_NAME" VARCHAR2(100 BYTE), 
	"PASSPORT" VARCHAR2(15 BYTE), 
	"BIRTHDAY" DATE, 
	"JOB_DIRECTORY_ID" NUMBER(8,0), 
	"DEPARTMENT_ID" NUMBER(8,0), 
	"MANAGER_ID" NUMBER(8,0), 
	"LOGIN" VARCHAR2(20 BYTE), 
	"PASSWORD" VARCHAR2(20 BYTE), 
	"PHONE_NUMBER" VARCHAR2(20 BYTE), 
	"MAIL" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020946
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020946" ON "PROJECT"."EMPLOYEES" ("PERSONAL_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger INSERT_CAREER_NEW_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."INSERT_CAREER_NEW_EMPLOYEE" 
AFTER INSERT ON EMPLOYEES 
FOR EACH ROW
BEGIN
  insert into career (personal_id, job_directory_id) VALUES (:new.personal_id, :new.job_directory_id);
END;
/
ALTER TRIGGER "PROJECT"."INSERT_CAREER_NEW_EMPLOYEE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger JOP_DIRECTORY_UPATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."JOP_DIRECTORY_UPATE" 
AFTER UPDATE OF JOB_DIRECTORY_ID ON EMPLOYEES 
FOR EACH ROW

BEGIN

    INSERT INTO career (personal_id, job_directory_id, promotion_date, past_job_directory_id)
    VALUES (:new.personal_id, :new.job_directory_id, sysdate, :old.job_directory_id);
END;
/
ALTER TRIGGER "PROJECT"."JOP_DIRECTORY_UPATE" ENABLE;
--------------------------------------------------------
--  Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "PROJECT"."EMPLOYEES" ADD PRIMARY KEY ("PERSONAL_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMPLOYEES
--------------------------------------------------------

  ALTER TABLE "PROJECT"."EMPLOYEES" ADD FOREIGN KEY ("JOB_DIRECTORY_ID")
	  REFERENCES "PROJECT"."JOB_DIRECTORY" ("JOB_DIRECTORY_ID") ENABLE;
  ALTER TABLE "PROJECT"."EMPLOYEES" ADD FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "PROJECT"."DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
