--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure WRITE_DOWN_GOODS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."WRITE_DOWN_GOODS" 
    (goods_id IN NUMBER, batch_id IN NUMBER, module_id IN NUMBER, dept_id IN NUMBER, reason_id IN NUMBER, amount NUMBER)
as
    goods_id_copy NUMBER (8);
    amount_copy NUMBER (6);
    dept_id_copy NUMBER (6);
    last_exp_date DATE;
BEGIN

    goods_id_copy:= goods_id;
    amount_copy:= amount;
    dept_id_copy:= dept_id;

  IF dept_id is NULL THEN
    INSERT INTO write_downs 
    SELECT WRITE_DOWNS_SEQ.nextval, io.incoming_id, null, reason_id, goods_id, amount FROM incoming_operation io
    WHERE io.goods_id = goods_id and io.batch_id = batch_id and io.module_id = module_id;
  ELSE
    SELECT max(eo1.datetime) into last_exp_date FROM expense_operation eo1;
    INSERT INTO write_downs
    SELECT WRITE_DOWNS_SEQ.nextval, eo.incoming_id, eo.expense_id, reason_id, goods_id, amount_copy FROM expense_operation eo
    WHERE eo.dept_id = dept_id_copy and trunc(eo.datetime) = trunc(last_exp_date);
  END IF;
  
  UPDATE goods_outlet go SET go.amount = go.amount - amount_copy
  WHERE go.goods_id = goods_id_copy; 
  
  
END WRITE_DOWN_GOODS;

/
