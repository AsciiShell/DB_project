CREATE OR REPLACE VIEW my_courses AS
SELECT c_id, c_name
FROM course
WHERE c_visibility
  AND c_id IN (SELECT p_course
               FROM participation
               WHERE p_client = userid());
COMMENT ON VIEW my_courses IS 'Список курсов, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_blocks AS
SELECT c_id, c_name, b_id, b_theme
FROM block
         INNER JOIN my_courses on block.b_course = c_id
WHERE block.b_visibility;
COMMENT ON VIEW my_blocks IS 'Список блоков, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_lectures AS
SELECT c_id,
       c_name,
       b_id,
       b_theme,
       l_id,
       l_name,
       l_content,
       make_interval(secs := char_length(l_content) / 25.0) as l_duration
FROM lecture
         INNER JOIN my_blocks ON l_block = b_id
WHERE l_visibility;
COMMENT ON VIEW my_lectures IS 'Список лекций, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_tests AS
SELECT c_id,
       c_name,
       b_id,
       b_theme,
       t_id,
       t_name,
       t_task,
       t_max,
       t_duration
FROM testmaterial
         INNER JOIN my_blocks ON t_block = b_id
WHERE t_visibility;
COMMENT ON VIEW my_tests IS 'Список тестов, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_attempts AS
SELECT *
FROM attempt
WHERE a_author = userid();
COMMENT ON VIEW my_attempts IS 'Список попыток пользователя';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_read_lectures AS
SELECT lecture.*
FROM lecture
         JOIN lectureread on l_id = lr_numlecture
WHERE lr_client = userid();
COMMENT ON VIEW my_read_lectures IS 'Список прочитанных лекций';
-------------------------------------------------------------------------