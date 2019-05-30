CREATE SEQUENCE course_sortorder START 1000 INCREMENT 1000;
CREATE TABLE Course
(
    C_ID         SERIAL PRIMARY KEY,
    C_NAME       VARCHAR(100) NOT NULL,
    C_VISIBILITY BOOLEAN      NOT NULL DEFAULT FALSE,
    C_SORTORDER  INTEGER      NOT NULL DEFAULT nextval('course_sortorder')
);