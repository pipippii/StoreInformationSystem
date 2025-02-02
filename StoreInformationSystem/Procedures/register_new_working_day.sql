--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure REGISTER_NEW_WORKING_DAY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."REGISTER_NEW_WORKING_DAY" 
IS 
BEGIN
    UPDATE work_statistic ws
    SET (
        ws.hours_worked,
        ws.days_worked
    ) = (
        SELECT ws.hours_worked + wd.working_time, ws.days_worked + 1 FROM working_date wd
        WHERE wd.personal_id = ws.personal_id and trunc(wd.working_day) = trunc(sysdate)
    )
    WHERE EXISTS (
        SELECT * FROM working_date wd
        WHERE wd.personal_id = ws.personal_id and trunc(wd.working_day) = trunc(sysdate)
    );
    
    
    UPDATE overworked ov
    SET (
        ov.overworked_hours
    ) = (
        SELECT ov.overworked_hours + (wd.working_time - 8) FROM working_date wd
        WHERE wd.personal_id = ov.personal_id and wd.working_time - 8 > 0.5 and trunc(wd.working_day) = trunc(sysdate)
    )
    WHERE EXISTS (
        SELECT * FROM working_date wd
        WHERE wd.personal_id = ov.personal_id and wd.working_time - 8 > 0.5 and trunc(wd.working_day) = trunc(sysdate)
    );
    
    
    UPDATE underworked un
    SET (
        un.underworked_hours
    ) = (
        SELECT un.underworked_hours + abs(wd.working_time - 8) FROM working_date wd
        WHERE wd.personal_id = un.personal_id and wd.working_time - 8 < 0 and trunc(wd.working_day) = trunc(sysdate)
    )
    WHERE EXISTS (
        SELECT * FROM working_date wd
        WHERE wd.personal_id = un.personal_id and wd.working_time - 8 < 0 and trunc(wd.working_day) = trunc(sysdate)
    );
    
    --EXECUTE IMMEDIATE 'TRUNCATE TABLE working_date';
END REGISTER_NEW_WORKING_DAY;

/
