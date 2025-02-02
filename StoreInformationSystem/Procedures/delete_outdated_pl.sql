--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure DELETE_OUTDATED_PL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."DELETE_OUTDATED_PL" 
is
BEGIN
    DELETE FROM price_lists pl 
        WHERE trunc(sysdate) - trunc(pl.date_list) >= 2;
END DELETE_OUTDATED_PL;

/
