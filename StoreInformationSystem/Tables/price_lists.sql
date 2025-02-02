--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table PRICE_LISTS
--------------------------------------------------------

  CREATE TABLE "PROJECT"."PRICE_LISTS" 
   (	"PRICE_LIST_ID" NUMBER(8,0) DEFAULT "PROJECT"."PRICE_LISTS_SEQ"."NEXTVAL", 
	"GOODS_ID" NUMBER(8,0), 
	"TYPE_PRICE" NUMBER(5,0), 
	"ENTRY_PRICE" NUMBER(8,0), 
	"TOTAL_PRICE" NUMBER(8,0), 
	"REGULAR_PRICE" NUMBER(10,0), 
	"MARGIN_LIMIT" NUMBER(5,0) DEFAULT 1000, 
	"CHANGE_LIMIT" NUMBER(5,0) DEFAULT 90, 
	"DATE_LIST" DATE DEFAULT sysdate
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index SYS_C0020143
--------------------------------------------------------

  CREATE UNIQUE INDEX "PROJECT"."SYS_C0020143" ON "PROJECT"."PRICE_LISTS" ("PRICE_LIST_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger DEL_CHECK_POSITION_PR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_CHECK_POSITION_PR" 
BEFORE DELETE ON PRICE_LISTS
FOR EACH ROW
BEGIN
  DELETE FROM check_position cp
    WHERE cp.price_list_id = :old.price_list_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_CHECK_POSITION_PR" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEL_COUPONS_OUTLET
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_COUPONS_OUTLET" 
BEFORE DELETE ON PRICE_LISTS 
FOR EACH ROW
BEGIN
  DELETE FROM coupons_outlet co
    WHERE co.price_list_id = :old.price_list_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_COUPONS_OUTLET" ENABLE;
--------------------------------------------------------
--  DDL for Trigger CHECK_REGULAR_PRICE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."CHECK_REGULAR_PRICE" 
BEFORE INSERT ON PRICE_LISTS 
FOR EACH ROW

DECLARE
    last_reg_price NUMBER(7);

BEGIN

  IF :new.regular_price = null THEN
    SELECT pl.regular_price into last_reg_price FROM Price_lists pl
        WHERE pl.goods_id = :new.goods_id and trunc(pl.date_list) = trunc(:new.date_list - 1);
    :new.regular_price:= last_reg_price;
  ELSIF :new.type_price = -1 AND :new.regular_price != :new.total_price THEN
    :new.regular_price:= :new.total_price;
  END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        :new.regular_price:= :new.regular_price;
END;
/
ALTER TRIGGER "PROJECT"."CHECK_REGULAR_PRICE" DISABLE;
--------------------------------------------------------
--  DDL for Trigger CHECK_TOTAL_PRICE_CHANGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."CHECK_TOTAL_PRICE_CHANGE" 
BEFORE INSERT ON PRICE_LISTS 
FOR EACH ROW

FOLLOWS CHECK_TOTAL_PRICE_MARGIN

DECLARE 
    last_total_price NUMBER(7);
    difference NUMBER (7);
    change_sum NUMBER(7);

BEGIN
    SELECT pl.total_price into last_total_price FROM Price_lists pl
        WHERE pl.goods_id = :new.goods_id and trunc(pl.date_list) = trunc(:new.date_list - 1);
    
    difference:= (:new.total_price - last_total_price);
    change_sum:= (last_total_price / 100) * :new.change_limit;
    
    IF :new.type_price != 0 THEN
        IF difference > 0 and difference > change_sum THEN
            :new.total_price:= last_total_price + change_sum;
        ELSIF difference < 0 and difference * (-1) > change_sum THEN
            :new.total_price:= last_total_price - change_sum;
        END IF;
    END IF; 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            :new.total_price:= :new.regular_price;
END;
/
ALTER TRIGGER "PROJECT"."CHECK_TOTAL_PRICE_CHANGE" DISABLE;
--------------------------------------------------------
--  DDL for Trigger CHECK_TOTAL_PRICE_MARGIN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."CHECK_TOTAL_PRICE_MARGIN" 
BEFORE INSERT ON PRICE_LISTS 
FOR EACH ROW

FOLLOWS SET_LIMITS

DECLARE 
    last_total_price NUMBER (7);

BEGIN
  IF (:new.total_price - :new.entry_price) > (:new.entry_price / 100) * :new.margin_limit THEN
    SELECT pl.total_price into last_total_price FROM Price_lists pl
        WHERE pl.goods_id = :new.goods_id and trunc(pl.date_list) = trunc(:new.date_list - 1);
    :new.total_price:= last_total_price;
    INSERT INTO stop_lists VALUES(:new.price_list_id);
  END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        :new.total_price:= :new.regular_price;
END;
/
ALTER TRIGGER "PROJECT"."CHECK_TOTAL_PRICE_MARGIN" DISABLE;
--------------------------------------------------------
--  DDL for Trigger SET_LIMITS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."SET_LIMITS" 
BEFORE INSERT ON PRICE_LISTS 
FOR EACH ROW


DECLARE
    goods_margin_limit NUMBER(10);
    goods_change_limit NUMBER(10);
    checkt BOOLEAN:= FALSE;
    last_total_price NUMBER(7);
    difference NUMBER (7);
    change_sum NUMBER(7);
    last_reg_price NUMBER(7);
    
BEGIN

    --set limits--
    FOR c IN (SELECT go.goods_id FROM goods_outlet go
        WHERE go.goods_card_id in (SELECT gg.goods_card_id FROM good_group gg))
    LOOP
        IF :new.goods_id = c.goods_id THEN 
            checkt:= TRUE;
            EXIT;
        END IF;
    END LOOP;
    
    IF checkt = TRUE THEN
        SELECT ggl.margin_limit, ggl.change_limit into goods_margin_limit, goods_change_limit FROM group_goods_limits ggl
        JOIN goods_outlet go ON :new.goods_id = go.goods_id
        JOIN good_group gg ON go.goods_card_id = gg.goods_card_id
        WHERE ggl.group_id = gg.group_id;
        
        IF :new.margin_limit is null THEN
            :new.margin_limit:= goods_margin_limit;
        END IF;
        
        IF :new.change_limit is null THEN
            :new.change_limit:= goods_change_limit;
        END IF;
    END IF;
    
    
    --check regular price--
    IF :new.type_price = -1 AND :new.regular_price != :new.total_price THEN
        :new.regular_price:= :new.total_price;
    ELSIF :new.regular_price is null THEN
        SELECT pl.regular_price into last_reg_price FROM Price_lists pl
        WHERE pl.goods_id = :new.goods_id and trunc(pl.date_list) = trunc(:new.date_list - 1);
        :new.regular_price:= last_reg_price;
    END IF;
    
    
    --check total price margin--
    IF (:new.total_price - :new.entry_price) > (:new.entry_price / 100) * :new.margin_limit THEN
        SELECT pl.total_price into last_total_price FROM Price_lists pl
        WHERE pl.goods_id = :new.goods_id and trunc(pl.date_list) = trunc(:new.date_list - 1);
        :new.total_price:= last_total_price;
        --INSERT INTO stop_lists VALUES(:new.price_list_id);
    END IF;
        
    
    
    --check total price change--
    SELECT pl.total_price into last_total_price FROM Price_lists pl
        WHERE pl.goods_id = :new.goods_id and trunc(pl.date_list) = trunc(:new.date_list - 1);
    
    difference:= (:new.total_price - last_total_price);
    change_sum:= (last_total_price / 100) * :new.change_limit;
    
    IF :new.type_price != 0 THEN
        IF difference > 0 and difference > change_sum THEN
            :new.total_price:= last_total_price + change_sum;
        ELSIF difference < 0 and difference * (-1) > change_sum THEN
            :new.total_price:= last_total_price - change_sum;
        END IF;
    END IF;
    
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            :new.total_price:= :new.regular_price;
END;
/
ALTER TRIGGER "PROJECT"."SET_LIMITS" DISABLE;
--------------------------------------------------------
--  DDL for Trigger DEL_ORDER_PRICES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_ORDER_PRICES" 
BEFORE DELETE ON PRICE_LISTS 
FOR EACH ROW
BEGIN
  DELETE FROM order_prices op
    WHERE op.price_list_id = :old.price_list_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_ORDER_PRICES" ENABLE;
--------------------------------------------------------
--  DDL for Trigger DEL_STOP_LISTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TRIGGER "PROJECT"."DEL_STOP_LISTS" 
BEFORE DELETE ON PRICE_LISTS 
FOR EACH ROW
BEGIN
  DELETE FROM stop_lists sl
    WHERE sl.price_list_id = :old.price_list_id;
END;
/
ALTER TRIGGER "PROJECT"."DEL_STOP_LISTS" ENABLE;
--------------------------------------------------------
--  Constraints for Table PRICE_LISTS
--------------------------------------------------------

  ALTER TABLE "PROJECT"."PRICE_LISTS" ADD PRIMARY KEY ("PRICE_LIST_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PRICE_LISTS
--------------------------------------------------------

  ALTER TABLE "PROJECT"."PRICE_LISTS" ADD CONSTRAINT "GOODS_ID_FK1" FOREIGN KEY ("GOODS_ID")
	  REFERENCES "PROJECT"."GOODS_OUTLET" ("GOODS_ID") ENABLE;
