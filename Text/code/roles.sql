CREATE ROLE course_admin;
COMMENT ON ROLE course_admin IS 'Администраторы курса';
-------------------------------------------------------------------------
CREATE ROLE course_teacher;
COMMENT ON ROLE course_teacher IS 'Преподаватели курса';
-------------------------------------------------------------------------
CREATE ROLE course_assistant;
COMMENT ON ROLE course_assistant IS 'Ассистенты курса';
-------------------------------------------------------------------------
CREATE ROLE course_student;
COMMENT ON ROLE course_student IS 'Студенты курса';
-------------------------------------------------------------------------