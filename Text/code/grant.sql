GRANT SELECT ON ALL TABLES IN SCHEMA public TO course_admin;
GRANT INSERT, UPDATE, DELETE ON TABLE
    client, course, category, participation TO course_admin;
-------------------------------------------------------------------------
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    categorycourse, block, lecture, testmaterial, participation,
    lectureread TO course_teacher;
GRANT SELECT, UPDATE, DELETE ON TABLE attempt TO course_teacher;
GRANT SELECT, UPDATE ON TABLE course TO course_teacher;
GRANT SELECT ON TABLE category TO course_teacher;
GRANT INSERT ON TABLE client TO course_teacher;
-------------------------------------------------------------------------
GRANT SELECT, UPDATE ON TABLE attempt TO course_assistant;
-------------------------------------------------------------------------
GRANT SELECT, INSERT ON TABLE lectureread TO course_student;
-------------------------------------------------------------------------