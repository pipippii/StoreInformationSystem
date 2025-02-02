--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table BATCHES
--------------------------------------------------------

  CREATE TABLE "PROJECT"."BATCHES" 
   (	"BATCH_ID" NUMBER(15,0), 
	"GOODS_CARD_ID" NUMBER(10,0), 
	"ACCEPTANCE_ID" NUMBER(10,0), 
	"CATEGORY" VARCHAR2(100 BYTE), 
	"AMOUNT" NUMBER(5,0), 
	"PRODUCTION_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020102
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020102" ON "PROJECT"."BATCHES" ("BATCH_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger DEL_UNACCEPTED_GOODS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_UNACCEPTED_GOODS" 
BEFORE DELETE ON BATCHES 
FOR EACH ROW
BEGIN
  DELETE FROM unaccepted_goods ug
    WHERE ug.batch_id = :old.batch_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_UNACCEPTED_GOODS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEL_ACCEPTED_GOODS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_ACCEPTED_GOODS" 
BEFORE DELETE ON BATCHES 
FOR EACH ROW
BEGIN
  DELETE FROM accepted_goods ag
    WHERE ag.batch_id = :old.batch_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_ACCEPTED_GOODS" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEL_INCOMING_OPERATION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_INCOMING_OPERATION" 
BEFORE DELETE ON BATCHES 
FOR EACH ROW
BEGIN
  DELETE FROM incoming_operation io
    WHERE io.batch_id = :old.batch_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_INCOMING_OPERATION" ENABLE;
--------------------------------------------------------
--  Constraints for Table BATCHES
--------------------------------------------------------

  ALTER TABLE "PROJECT"."BATCHES" ADD PRIMARY KEY ("BATCH_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table BATCHES
--------------------------------------------------------

  ALTER TABLE "PROJECT"."BATCHES" ADD FOREIGN KEY ("GOODS_CARD_ID")
	  REFERENCES "PROJECT"."GOODS_CARD_COMPANY" ("GOODS_CARD_ID") ENABLE;
  ALTER TABLE "PROJECT"."BATCHES" ADD FOREIGN KEY ("ACCEPTANCE_ID")
	  REFERENCES "PROJECT"."ACCEPTANCE" ("ACCEPTANCE_ID") ENABLE;
