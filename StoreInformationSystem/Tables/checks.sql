--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CHECKS
--------------------------------------------------------

  CREATE TABLE "PROJECT"."CHECKS" 
   (	"CHECK_ID" NUMBER(10,0), 
	"CASHIER_ID" NUMBER, 
	"DATETIME" DATE, 
	"TOTAL_SUM" NUMBER(9,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020149
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020149" ON "PROJECT"."CHECKS" ("CHECK_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger DEL_CHECK_POSITION_CHECK
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_CHECK_POSITION_CHECK" 
BEFORE DELETE ON CHECKS
FOR EACH ROW
BEGIN
  DELETE FROM check_position cp
    WHERE cp.check_id = :old.check_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_CHECK_POSITION_CHECK" ENABLE;
--------------------------------------------------------
--  Constraints for Table CHECKS
--------------------------------------------------------

  ALTER TABLE "PROJECT"."CHECKS" ADD PRIMARY KEY ("CHECK_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table CHECKS
--------------------------------------------------------

  ALTER TABLE "PROJECT"."CHECKS" ADD CONSTRAINT "CHECKS_FK1" FOREIGN KEY ("CHECK_ID")
	  REFERENCES "PROJECT"."EMPLOYEES" ("PERSONAL_ID") ENABLE;
