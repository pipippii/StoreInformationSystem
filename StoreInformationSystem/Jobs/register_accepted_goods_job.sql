-- добавление принятых товаров на ТТ --
-- запускает процедуру add_new_goods --
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME => 'register_accepted_goods_job',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'add_new_goods;',
        START_DATE => to_date('18-12-22 23:59:59', 'DD-MM-YY HH24:MI:SS'),
        REPEAT_INTERVAL => 'FREQ=HOURLY; INTERVAL=1',
        END_DATE => to_date('18-12-23 23:58:59', 'DD-MM-YY HH24:MI:SS'),
        COMMENTS => 'Add new goods to outlet',
        ENABLED => FALSE
    );
END;