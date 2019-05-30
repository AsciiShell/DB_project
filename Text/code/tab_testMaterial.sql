CREATE TABLE TestMaterial
(
    T_ID         SERIAL PRIMARY KEY,
    T_NAME       VARCHAR(100) NOT NULL,
    T_TASK       TEXT         NOT NULL,
    T_MAX        INTEGER      NOT NULL CHECK ( T_MAX >= 0 ),
    T_DURATION   INTERVAL CHECK ( T_DURATION > '0'::INTERVAL ),
    T_VISIBILITY BOOLEAN      NOT NULL DEFAULT FALSE,
    T_BLOCK      INTEGER      NOT NULL REFERENCES Block (B_ID),
    T_SORTORDER  INTEGER      NOT NULL
);
-------------------------------------------------------------------------
-- Процедура для автоматического добавления новой лекции
-- в конец текущего блока.
-- Параметр sortorder подбирается автоматически на основе последнего
-- задания текущего блока.
CREATE OR REPLACE PROCEDURE
    create_testmaterial(name VARCHAR(100),
                        task TEXT,
                        max_score INTEGER,
                        duration INTERVAL,
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
    INSERT INTO TestMaterial
    VALUES (DEFAULT, name, task, max_score, duration, visibility, block_id, last_id);
END
$$
    LANGUAGE PLPGSQL;