-- удаление устаревших записей о приемке товаров --
-- запускает процедуру delete_outdate_acceptances --
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME => 'DELETE_OUTDATED_ACCEPTANCE_JOB',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'delete_outdate_acceptances;',
        START_DATE => to_date('18-12-23 23:59:59', 'DD-MM-YY HH24:MI:SS'),
        REPEAT_INTERVAL => 'FREQ=MONTHLY; INTERVAL=6',
        END_DATE => to_date('18-12-24 23:58:59', 'DD-MM-YY HH24:MI:SS'),
        COMMENTS => 'Delete outdated acceptance',
        ENABLED => FALSE
    );
END;