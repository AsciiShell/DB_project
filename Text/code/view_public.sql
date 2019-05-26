CREATE OR REPLACE VIEW public_course AS
SELECT c_id, c_name
FROM course
WHERE c_visibility;
COMMENT ON VIEW public_course IS 'Представление доступных курсов';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW public_user AS
SELECT u_id                                        AS id,
       u_lname || ' ' || u_fname || ' ' || u_patro AS name,
       u_gender                                    AS gender
FROM client;
COMMENT ON VIEW public_user IS
    'Представление публичной информации о пользователях';
-------------------------------------------------------------------------