CREATE TABLE Lecture
(
    L_ID         SERIAL PRIMARY KEY,
    L_NAME       VARCHAR(100) NOT NULL,
    L_CONTENT    TEXT,
    L_VISIBILITY BOOLEAN      NOT NULL DEFAULT FALSE,
    L_BLOCK      INTEGER      NOT NULL REFERENCES Block (B_ID),
    L_SORTORDER  INTEGER      NOT NULL
);
-------------------------------------------------------------------------
-- Процедура для автоматического добавления новой лекции
-- в конец текущего блока.
-- Параметр sortorder подбирается автоматически на основе последнего
-- задания текущего блока.
CREATE OR REPLACE PROCEDURE
    create_lecture(name VARCHAR(100),
                   content TEXT,
                   visibility BOOLEAN,
                   block_id INTEGER)
AS
$$
DECLARE
    last_id INTEGER;
BEGIN
    SELECT GREATEST((SELECT MAX(T_SORTORDER)
                     FROM testmaterial
                     WHERE T_BLOCK = block_id),
                    (SELECT MAX(L_SORTORDER)
                     FROM Lecture
                     WHERE L_BLOCK = block_id)) INTO last_id;

    IF last_id IS NULL THEN
        last_id := 1000;
    ELSE
        last_id := (div(last_id, 1000) + 1) * 1000;
    end if;
    INSERT INTO Lecture
    VALUES (DEFAULT, name, content, visibility, block_id, last_id);
END
$$
    LANGUAGE PLPGSQL;