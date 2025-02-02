--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ADD_PRICE_LISTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."ADD_PRICE_LISTS" 
IS
BEGIN

    FOR i IN (SELECT pl1.temp_goods_id, pl1.type_price, pl1.entry_price, pl1.total_price FROM (
            SELECT go.goods_id as temp_goods_id, pl.*, min(pl.total_price) over (PARTITION BY pl.goods_id) as mn,
                   row_number() over (PARTITION BY pl.goods_id ORDER BY pl.total_price) as rn
            FROM price_lists_hc pl
            JOIN goods_outlet go ON go.goods_card_id = pl.goods_id
        ) pl1
        WHERE pl1.rn = 1
    )
    LOOP
        INSERT INTO price_lists (goods_id, type_price, entry_price, total_price)
            VALUES (i.temp_goods_id, i.type_price, i.entry_price, i.total_price);
    END LOOP;
    
    
END ADD_PRICE_LISTS;

/
