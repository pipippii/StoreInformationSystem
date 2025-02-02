--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table EMPLOYMENT_DATE
--------------------------------------------------------

  CREATE TABLE "PROJECT"."EMPLOYMENT_DATE" 
   (	"PERSONAL_ID" NUMBER(8,0), 
	"DEPARTMENT_ID" NUMBER(8,0), 
	"JOB_DIRECTORY_ID" NUMBER(6,0), 
	"HIRE_DATE" DATE, 
	"DISMISSAL_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020954
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020954" ON "PROJECT"."EMPLOYMENT_DATE" ("PERSONAL_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger DISSMISSAL_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DISSMISSAL_EMPLOYEE" 
AFTER UPDATE OF DISMISSAL_DATE ON EMPLOYMENT_DATE 
FOR EACH ROW
BEGIN
    INSERT INTO career (personal_id, job_directory_id, promotion_date, past_job_directory_id)
        VALUES (:new.personal_id, 18, :new.dismissal_date, :old.job_directory_id);  
END;
/
ALTER TRIGGER "PROJECT"."DISSMISSAL_EMPLOYEE" ENABLE;
--------------------------------------------------------
--  DDL for Trigger HIRE_EMPLOYEE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."HIRE_EMPLOYEE" 
AFTER INSERT ON EMPLOYMENT_DATE 
FOR EACH ROW
BEGIN
  INSERT INTO career (personal_id, job_directory_id, promotion_date)
    VALUES (:new.personal_id, :new.job_directory_id, :new.hire_date);
END;
/
ALTER TRIGGER "PROJECT"."HIRE_EMPLOYEE" ENABLE;
--------------------------------------------------------
--  Constraints for Table EMPLOYMENT_DATE
--------------------------------------------------------

  ALTER TABLE "PROJECT"."EMPLOYMENT_DATE" MODIFY ("HIRE_DATE" NOT NULL ENABLE);
  ALTER TABLE "PROJECT"."EMPLOYMENT_DATE" ADD PRIMARY KEY ("PERSONAL_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EMPLOYMENT_DATE
--------------------------------------------------------

  ALTER TABLE "PROJECT"."EMPLOYMENT_DATE" ADD FOREIGN KEY ("PERSONAL_ID")
	  REFERENCES "PROJECT"."EMPLOYEES" ("PERSONAL_ID") ENABLE;
  ALTER TABLE "PROJECT"."EMPLOYMENT_DATE" ADD FOREIGN KEY ("DEPARTMENT_ID")
	  REFERENCES "PROJECT"."DEPARTMENTS" ("DEPARTMENT_ID") ENABLE;
  ALTER TABLE "PROJECT"."EMPLOYMENT_DATE" ADD FOREIGN KEY ("JOB_DIRECTORY_ID")
	  REFERENCES "PROJECT"."JOB_DIRECTORY" ("JOB_DIRECTORY_ID") ENABLE;
