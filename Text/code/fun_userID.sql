-- Функция, возвращающая ID текущего польователя
CREATE FUNCTION userID()
    RETURNS INTEGER AS
$$
BEGIN
    return (SELECT u_id FROM client WHERE u_login = user);
END;
$$
    LANGUAGE PLPGSQL;