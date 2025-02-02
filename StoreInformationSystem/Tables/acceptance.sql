--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ACCEPTANCE
--------------------------------------------------------

  CREATE TABLE "PROJECT"."ACCEPTANCE" 
   (	"ACCEPTANCE_ID" NUMBER(8,0), 
	"PERSONAL_ID" NUMBER(8,0), 
	"DATETIME" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020101
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020101" ON "PROJECT"."ACCEPTANCE" ("ACCEPTANCE_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger DEL_ACCEPTANCE_TRUCK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_ACCEPTANCE_TRUCK" 
BEFORE DELETE ON ACCEPTANCE 
FOR EACH ROW
BEGIN
  DELETE FROM acceptance_truck act
    WHERE act.acceptance_id = :old.acceptance_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_ACCEPTANCE_TRUCK" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEL_BATCHES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_BATCHES" 
BEFORE DELETE ON ACCEPTANCE 
FOR EACH ROW
BEGIN
  DELETE FROM batches ba
    WHERE ba.acceptance_id = :old.acceptance_id; 
END;
/
ALTER TRIGGER "PROJECT"."DEL_BATCHES" ENABLE;
--------------------------------------------------------
--  Constraints for Table ACCEPTANCE
--------------------------------------------------------

  ALTER TABLE "PROJECT"."ACCEPTANCE" ADD PRIMARY KEY ("ACCEPTANCE_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ACCEPTANCE
--------------------------------------------------------

  ALTER TABLE "PROJECT"."ACCEPTANCE" ADD CONSTRAINT "ACCEPTANCE_FK1" FOREIGN KEY ("PERSONAL_ID")
	  REFERENCES "PROJECT"."EMPLOYEES" ("PERSONAL_ID") ENABLE;
