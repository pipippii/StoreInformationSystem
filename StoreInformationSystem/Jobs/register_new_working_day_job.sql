-- внесение данных об отработанном дне сотрудника --
-- «апускает процедуру register_new_working_day --
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME => 'register_new_working_day_job',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'register_new_working-day;',
        START_DATE => to_date('18-12-22 07:00:00', 'DD-MM-YY HH24:MI:SS'),
        REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=1',
        END_DATE => to_date('18-12-23 23:58:00', 'DD-MM-YY HH24:MI:SS'),
        COMMENTS => 'Register new working day',
        ENABLED => FALSE
    );
END;