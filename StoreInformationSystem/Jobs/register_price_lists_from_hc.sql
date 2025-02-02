-- выборка и добавление новых прайс-листов на ТТ, выставление и проверка лимитов, а также регистрация купонов --
-- Запускает процедуры: add_price_lists, update_price_list, register_new_coupons --
BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME => 'register_price_lists_from_hc',
        JOB_TYPE => 'PLSQL_BLOCK',
        JOB_ACTION => 'add_price_lists; update_price_list; register_new_coupons;',
        START_DATE => to_date('18-12-22 07:00:00', 'DD-MM-YY HH24:MI:SS'),
        REPEAT_INTERVAL => 'FREQ=DAILY; INTERVAL=1',
        END_DATE => to_date('18-12-23 23:58:00', 'DD-MM-YY HH24:MI:SS'),
        COMMENTS => 'Register new price lists from HC',
        ENABLED => FALSE
    );
END;