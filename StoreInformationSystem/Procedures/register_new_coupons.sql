--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure REGISTER_NEW_COUPONS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."REGISTER_NEW_COUPONS" 
IS 
BEGIN
  INSERT INTO coupons_outlet 
  SELECT co.coupon_id, pl.price_list_id, sysdate, sysdate + co.expiration_date FROM price_lists pl
  JOIN coupons co ON pl.type_price > 0 and pl.type_price = co.coupon_id
  WHERE trunc(pl.date_list) = trunc(sysdate);
END REGISTER_NEW_COUPONS;

/
