-- формирует данные для еженедельного отчета директору --
-- запускает процедуру make_report --
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME => 'MAKE_REPORT_JOB',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'make_report;',
        START_DATE => to_date('18-12-22 23:59:59', 'DD-MM-YY HH24:MI:SS'),
        REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=7',
        END_DATE => to_date('18-12-23 23:58:59', 'DD-MM-YY HH24:MI:SS'),
        COMMENTS => 'Make new report',
        ENABLED => FALSE
    );
END;