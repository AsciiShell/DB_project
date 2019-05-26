CREATE OR REPLACE VIEW course_teachers AS
SELECT *
FROM public_user
         INNER JOIN participation ON id = p_client
WHERE p_role = 'Teacher';
COMMENT ON VIEW course_teachers IS 'Представление преподавателей курса';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW course_assistant AS
SELECT *
FROM public_user
         INNER JOIN participation ON id = p_client
WHERE p_role = 'Assistant';
COMMENT ON VIEW course_teachers IS 'Представление ассистентов курса';
-------------------------------------------------------------------------
CREATE OR REPLACE VIEW course_student AS
SELECT *
FROM public_user
         INNER JOIN participation ON id = p_client
WHERE p_role = 'Student';
COMMENT ON VIEW course_teachers IS 'Представление студентов курса';
-------------------------------------------------------------------------