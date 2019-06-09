CREATE INDEX ON categorycourse (cc_course);
CREATE INDEX ON categorycourse (cc_category);

CREATE INDEX ON block (b_course);

CREATE INDEX ON lecture (l_block);
CREATE INDEX ON testmaterial (t_extend);

CREATE INDEX ON attempt (a_author);
CREATE INDEX ON attempt (a_task);

CREATE INDEX ON participation (p_client);
CREATE INDEX ON participation (p_course);

CREATE INDEX ON lectureread (lr_client);
CREATE INDEX ON lectureread (lr_numlecture);

CREATE INDEX ON block (b_last_id);

CREATE INDEX ON lecture (l_last_id);
