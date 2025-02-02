-- удаление устаревших записей о прайс-листах и чеках. --
-- запускает процедуры: delete_outdated_pl, delete_outdated_checks --
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME => 'DELETE_OUTDATED_LISTS_CHECKS',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'delete_outdated_pl; delete_outdated_checks;',
        START_DATE => to_date('18-12-22 23:59:59', 'DD-MM-YY HH24:MI:SS'),
        REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=2',
        END_DATE => to_date('18-12-23 23:58:59', 'DD-MM-YY HH24:MI:SS'),
        COMMENTS => 'DELETE OUTDATED CHECKS',
        ENABLED => FALSE
    );
END;