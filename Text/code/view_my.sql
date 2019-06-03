CREATE OR REPLACE VIEW my_tests AS
SELECT *
FROM public_tests
WHERE c_id IN (SELECT p_course
               FROM participation
               WHERE p_client = userid());
COMMENT ON VIEW my_tests
    IS 'Список тестов, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_lectures AS
SELECT *
FROM public_lectures
WHERE c_id IN (SELECT p_course
               FROM participation
               WHERE p_client = userid());
COMMENT ON VIEW my_lectures
    IS 'Список лекций, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_blocks AS
SELECT *
FROM public_blocks
WHERE c_id IN (SELECT p_course
               FROM participation
               WHERE p_client = userid());
COMMENT ON VIEW my_blocks IS 'Список блоков, доступных пользователю';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW my_courses AS
SELECT *
FROM public_courses
WHERE c_id IN (SELECT p_course
               FROM participation
               WHERE p_client = userid());
COMMENT ON VIEW my_courses IS 'Список курсов, доступных пользователю';
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