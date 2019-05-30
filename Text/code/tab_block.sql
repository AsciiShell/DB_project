CREATE TABLE Block
(
    B_ID         SERIAL PRIMARY KEY,
    B_THEME      VARCHAR(100) NOT NULL,
    B_VISIBILITY BOOLEAN      NOT NULL DEFAULT FALSE,
    B_COURSE     INTEGER      NOT NULL REFERENCES Course (C_ID),
    B_SORTORDER  INTEGER      NOT NULL
);
-------------------------------------------------------------------------
-- Процедура для автоматического добавления нового блока
-- в конец текущего курса.
-- Параметр sortorder подбирается автоматически на основе последнего
-- блока текущего курса.
CREATE OR REPLACE PROCEDURE
    create_block(theme VARCHAR(100),
                 visibility BOOLEAN,
                 course_id INTEGER)
AS
$$
DECLARE
    last_id INTEGER;
BEGIN
    SELECT MAX(B_SORTORDER) INTO last_id
    FROM Block
    WHERE B_COURSE = course_id;

    IF last_id IS NULL THEN
        last_id := 1000;
    ELSE
        last_id := (div(last_id, 1000) + 1) * 1000;
    end if;
    INSERT INTO Block
    VALUES (DEFAULT, theme, visibility, course_id, last_id);
END
$$
    LANGUAGE PLPGSQL;