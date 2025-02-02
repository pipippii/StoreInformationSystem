--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TOTAL_PRICE_INFO
--------------------------------------------------------

  CREATE GLOBAL TEMPORARY TABLE "PROJECT"."TOTAL_PRICE_INFO" 
   (	"GOODS_ID" NUMBER(7,0), 
	"LAST_TOTAL_PRICE" NUMBER(7,0), 
	"DIFFERENCE" NUMBER(7,0), 
	"CHANGE_SUM" NUMBER(7,0)
   ) ON COMMIT PRESERVE ROWS ;
--------------------------------------------------------
--  DDL for Index SYS_C0020626
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020626" ON "PROJECT"."TOTAL_PRICE_INFO" ("GOODS_ID") ;
--------------------------------------------------------
--  Constraints for Table TOTAL_PRICE_INFO
--------------------------------------------------------

  ALTER TABLE "PROJECT"."TOTAL_PRICE_INFO" ADD PRIMARY KEY ("GOODS_ID") ENABLE;
