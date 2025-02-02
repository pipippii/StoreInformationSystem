--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table COUPONS_OUTLET
--------------------------------------------------------

  CREATE TABLE "PROJECT"."COUPONS_OUTLET" 
   (	"COUPON_ID" NUMBER(5,0), 
	"PRICE_LIST_ID" NUMBER(8,0), 
	"START_DATE" DATE, 
	"END_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020158
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020158" ON "PROJECT"."COUPONS_OUTLET" ("COUPON_ID", "PRICE_LIST_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger REGISTER_COUPONS_OUTLET
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."REGISTER_COUPONS_OUTLET" BEFORE INSERT ON coupons_outlet 
FOR EACH ROW

DECLARE
    expiration_date number (5);
    
BEGIN
    SELECT c.expiration_date into expiration_date FROM coupons c
        WHERE :new.coupon_id = c.coupon_id;
        
    :new.start_date:= sysdate;
    :new.end_date:= sysdate + expiration_date;
    
END;
/
ALTER TRIGGER "PROJECT"."REGISTER_COUPONS_OUTLET" ENABLE;
--------------------------------------------------------
--  Constraints for Table COUPONS_OUTLET
--------------------------------------------------------

  ALTER TABLE "PROJECT"."COUPONS_OUTLET" ADD PRIMARY KEY ("COUPON_ID", "PRICE_LIST_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table COUPONS_OUTLET
--------------------------------------------------------

  ALTER TABLE "PROJECT"."COUPONS_OUTLET" ADD FOREIGN KEY ("COUPON_ID")
	  REFERENCES "PROJECT"."COUPONS" ("COUPON_ID") ENABLE;
  ALTER TABLE "PROJECT"."COUPONS_OUTLET" ADD FOREIGN KEY ("PRICE_LIST_ID")
	  REFERENCES "PROJECT"."PRICE_LISTS" ("PRICE_LIST_ID") ENABLE;
