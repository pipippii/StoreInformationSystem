--------------------------------------------------------
--  File created - суббота-апреля-22-2023   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure MAKE_REPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "PROJECT"."MAKE_REPORT" AS 
BEGIN
  INSERT INTO Report (
         personal_id,
         full_name, 
         post, 
         department_id, 
         hours_worked, 
         days_worked, 
         overworked_hours, 
         overworked_days, 
         underworked_hours, 
         underworked_days
  )
  SELECT em.personal_id,
         em.full_name, 
         jb.post, 
         em.department_id, 
         ws.hours_worked, 
         ws.days_worked, 
         ov.overworked_hours, 
         ov.overworked_days, 
         un.underworked_hours,
         un.underworked_days
  FROM employees em
  JOIN job_directory jb ON em.job_directory_id = jb.job_directory_id
  JOIN work_statistic ws ON em.personal_id = ws.personal_id
  JOIN working_date wd ON em.personal_id = wd.personal_id
  JOIN overworked ov ON em.personal_id = ov.personal_id
  JOIN underworked un ON em.personal_id = un.personal_id;
  
  --EXECUTE IMMEDIATE 'TRUNCATE TABLE work_statistic';
  --EXECUTE IMMEDIATE 'TRUNCATE TABLE overworked';
  --EXECUTE IMMEDIATE 'TRUNCATE TABLE underworked';
  
END MAKE_REPORT;

/
