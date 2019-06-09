CREATE OR REPLACE VIEW public_user AS
SELECT u_id                                        AS id,
       u_lname || ' ' || u_fname || ' ' || u_patro AS name,
       u_gender                                    AS gender
FROM client;
COMMENT ON VIEW public_user IS
    'Представление публичной информации о пользователях';
-------------------------------------------------------------------------
-- Далее идут представления, которые содержат тяжелые запросы к БД:
-- соединение трёх и более таблиц, группировка данных, соединение
-- запросов. При этом каждый последующий запрос основан на предыдущих.
-- Кроме того, информация о курсах на проде не будет обновляться часто;
-- исходя из вышесказанного, будет логично создать материализованные
-- представления для ускорения доступа к данным, что позволяет сделать
-- PostgreSQL
-------------------------------------------------------------------------
CREATE MATERIALIZED VIEW public_tests AS
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
         JOIN lecture ON t_extend = l_id
         RIGHT JOIN Block ON l_block = b_id
         RIGHT JOIN course ON b_course = c_id
WHERE c_visibility
  AND b_visibility
  AND l_visibility;
COMMENT ON MATERIALIZED VIEW public_tests
    IS 'Список тестов, которые могут выполнить пользователи';
-------------------------------------------------------------------------
CREATE MATERIALIZED VIEW public_lectures AS
SELECT c_id,
       c_name,
       b_id,
       b_theme,
       l_id,
       l_name,
       l_content,
       -- 25 - средняя скорость чтения символов в секунду
       make_interval(secs := char_length(l_content) / 25.0) as l_duration
FROM lecture
         RIGHT JOIN Block ON l_block = b_id
         RIGHT JOIN course ON b_course = c_id
WHERE c_visibility
  AND b_visibility
  AND l_visibility;
COMMENT ON MATERIALIZED VIEW public_lectures
    IS 'Список лекций, которые могут выполнить пользователи';
-------------------------------------------------------------------------
CREATE MATERIALIZED VIEW public_blocks AS
SELECT c_id, c_name, b_id, b_theme, SUM(_duration) AS b_duration
FROM (
         SELECT c_id, c_name, b_id, b_theme, t_duration as _duration
         FROM public_tests
         UNION ALL
         SELECT c_id, c_name, b_id, b_theme, l_duration as _duration
         FROM public_lectures
     ) u
GROUP BY b_id, b_theme, c_id, c_name;
COMMENT ON MATERIALIZED VIEW public_blocks
    IS 'Список блоков, которые могут выполнить пользователи';
-------------------------------------------------------------------------
CREATE MATERIALIZED VIEW public_courses AS
SELECT c_id, c_name, SUM(b_duration) AS c_duration
FROM public_blocks
GROUP BY c_id, c_name;
COMMENT ON MATERIALIZED VIEW public_courses
    IS 'Список курсов, которые могут выполнить пользователи';
-------------------------------------------------------------------------