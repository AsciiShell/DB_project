CREATE TYPE ParticipationRole AS enum ('Teacher','Assistant', 'Student');
CREATE TABLE Participation
(
    P_ROLE   ParticipationRole NOT NULL,
    P_CLIENT INTEGER           NOT NULL REFERENCES Client (U_ID),
    P_COURSE INTEGER           NOT NULL REFERENCES Course (C_ID),
    PRIMARY KEY (P_CLIENT, P_COURSE)
);