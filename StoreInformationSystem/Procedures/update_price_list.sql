--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure UPDATE_PRICE_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."UPDATE_PRICE_LIST" 
IS
BEGIN

    --set limits--    
    
    UPDATE price_lists pl
    SET (
        pl.margin_limit,
        pl.change_limit
    ) = (
        SELECT ggl.margin_limit, ggl.change_limit FROM group_goods_limits ggl
        JOIN goods_outlet go ON pl.goods_id = go.goods_id
        JOIN good_group gg ON go.goods_card_id = gg.goods_card_id
        WHERE ggl.group_id = gg.group_id
    )
    WHERE trunc(pl.date_list) = trunc(sysdate);
    
    
    --check total price margin--
    
    INSERT INTO stop_lists 
        SELECT pl.price_list_id FROM Price_lists pl
        WHERE abs(pl.total_price - pl.entry_price) > (pl.entry_price / 100) * pl.margin_limit and trunc(pl.date_list) = trunc(sysdate);
    
    
    UPDATE price_lists pl
    SET (
        pl.total_price
    ) = (
        SELECT pl1.total_price FROM Price_lists pl1
        WHERE pl1.goods_id = pl.goods_id and trunc(pl1.date_list) = trunc(pl.date_list - 1)
    )
    WHERE (pl.total_price - pl.entry_price) > (pl.entry_price / 100) * pl.margin_limit and trunc(pl.date_list) = trunc(sysdate);

    
    --check total price change--
    
    INSERT INTO total_price_info
        SELECT pl1.goods_id, pl1.total_price, pl.total_price - pl1.total_price, (pl1.total_price / 100) * pl.change_limit FROM Price_lists pl
        JOIN Price_lists pl1 ON pl1.goods_id = pl.goods_id and trunc(pl1.date_list) = trunc(pl.date_list - 1)
        WHERE trunc(pl.date_list) = trunc(sysdate);
        
    UPDATE price_lists pl
    SET (
        pl.total_price
    ) = (
        SELECT  tpi.last_total_price + tpi.change_sum * (tpi.difference / abs(tpi.difference)) FROM total_price_info tpi
        WHERE abs(tpi.difference) > tpi.change_sum and pl.goods_id = tpi.goods_id
    )
    WHERE pl.type_price != 0 and trunc(pl.date_list) = trunc(sysdate) and 
    EXISTS (
        SELECT * FROM total_price_info tpi
        WHERE abs(tpi.difference) > tpi.change_sum and pl.goods_id = tpi.goods_id 
    );
 
 
    --set regular price--
    
    UPDATE price_lists pl
    SET (
        pl.regular_price
    ) = (
        SELECT pl1.regular_price FROM Price_lists pl1
        WHERE pl1.goods_id = pl.goods_id and trunc(pl1.date_list) = trunc(pl.date_list - 1)
    )
    WHERE pl.regular_price is null and trunc(pl.date_list) = trunc(sysdate);
    
    
    UPDATE price_lists pl
    SET (
        pl.regular_price
    ) = (
        SELECT pl1.total_price FROM Price_lists pl1
        WHERE pl1.price_list_id = pl.price_list_id
    )
    WHERE pl.type_price = -1 and trunc(pl.date_list) = trunc(sysdate);
 
 
    EXECUTE IMMEDIATE 'TRUNCATE TABLE total_price_info';
    
    
END UPDATE_PRICE_LIST;

/
