--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure MAKE_ORDER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."MAKE_ORDER" 
IS 
BEGIN
  INSERT INTO order_prices
  SELECT ORDER_PRICES_SEQ.nextval, pl.price_list_id, pl.goods_id, pl.type_price, pl.total_price, sysdate, pl.regular_price  FROM Price_lists pl
  WHERE trunc(pl.date_list) = trunc(sysdate);
END MAKE_ORDER;

/
