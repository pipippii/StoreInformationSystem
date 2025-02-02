--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure ADD_NEW_GOODS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."ADD_NEW_GOODS" 
IS 
BEGIN
    UPDATE goods_outlet go
    SET (
        go.amount
    ) = (
        SELECT go.amount + ba.amount FROM accepted_goods ag
        JOIN batches ba ON ba.batch_id = ag.batch_id and go.goods_card_id = ba.goods_card_id
        JOIN acceptance ac ON ac.acceptance_id = ba.acceptance_id
        WHERE trunc(cast(ac.datetime as date)) = trunc(sysdate)
    )
    WHERE EXISTS (
        SELECT * FROM accepted_goods ag
        JOIN batches ba ON ba.batch_id = ag.batch_id and go.goods_card_id = ba.goods_card_id
        JOIN acceptance ac ON ac.acceptance_id = ba.acceptance_id
        WHERE ba.goods_card_id in (SELECT go.goods_card_id FROM goods_outlet go) and trunc(cast(ac.datetime as date)) = trunc(sysdate)
    );
    
    INSERT INTO goods_outlet (goods_card_id, amount)
        SELECT ba.goods_card_id, ba.amount FROM accepted_goods ag
        JOIN batches ba ON ba.batch_id = ag.batch_id
        WHERE ba.goods_card_id not in (SELECT go.goods_card_id FROM goods_outlet go);
    
    INSERT INTO incoming_operation (goods_id, batch_id, expiration_date)
        SELECT go.goods_id, ba.batch_id, ba.production_date + gcc.technical_expiration_date FROM accepted_goods ag
        JOIN batches ba ON ba.batch_id = ag.batch_id
        JOIN goods_card_company gcc ON gcc.goods_card_id = ba.goods_card_id
        JOIN goods_outlet go ON go.goods_card_id = gcc.goods_card_id
        JOIN acceptance ac ON ac.acceptance_id = ba.acceptance_id
        WHERE trunc(cast(ac.datetime as date)) = trunc(sysdate);
    
    
    --EXECUTE IMMEDIATE 'TRUNCATE TABLE accepted_goods';

END ADD_NEW_GOODS;

/
