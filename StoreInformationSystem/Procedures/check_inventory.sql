--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure CHECK_INVENTORY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."CHECK_INVENTORY" 
IS
BEGIN

    INSERT INTO residue
    SELECT residue_seq.nextval, null, (go.amount - inv.total_amount), go.goods_id FROM inventory inv
    JOIN goods_outlet go ON inv.goods_card_id = go.goods_card_id
    WHERE go.amount - inv.total_amount > 0;
    
    
    INSERT INTO write_downs
    SELECT write_downs_seq.nextval, null, null, 5, go.goods_id, abs(go.amount - inv.total_amount) FROM inventory inv
    JOIN goods_outlet go ON inv.goods_card_id = go.goods_card_id
    WHERE go.amount - inv.total_amount < 0;
    
END CHECK_INVENTORY;

/
