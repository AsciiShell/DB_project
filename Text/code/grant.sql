GRANT SELECT ON TABLE client, course, category, categorycourse, block,
    lecture, testmaterial, attempt, participation, lectureread
    TO course_admin;

GRANT INSERT, UPDATE, DELETE ON TABLE
    client, course, category, participation TO course_admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE
    categorycourse, block, lecture, testmaterial, participation,
    lectureread TO course_teacher;

GRANT SELECT, UPDATE, DELETE ON TABLE attempt TO course_teacher;

GRANT SELECT, UPDATE ON TABLE course TO course_teacher;

GRANT SELECT ON TABLE category, categorycourse
    TO course_teacher, course_assistant, course_student;

GRANT INSERT ON TABLE client TO course_teacher;

GRANT SELECT, UPDATE ON TABLE attempt TO course_assistant;

GRANT SELECT, INSERT ON TABLE lectureread TO course_student;
-------------------------------------------------------------------------
GRANT SELECT ON TABLE public_blocks, public_courses, public_lectures,
    public_tests, my_courses, my_blocks, my_lectures, my_tests,
    my_attempts, my_read_lectures, public_user, course_teachers,
    course_assistant, course_student
    TO course_admin, course_teacher, course_assistant, course_student;

GRANT INSERT, UPDATE ON TABLE my_attempts TO course_student;