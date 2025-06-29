ALTER TABLE USP_25
ADD CONSTRAINT FK_USP_STUDENTS
FOREIGN KEY (SNUM)
REFERENCES STUDENTS_25(SNUM)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE USP_25
ADD CONSTRAINT FK_USP_PREDMETS
FOREIGN KEY (PNUM)
REFERENCES PREDMETS_25(PNUM)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE PREDMETS_25
ADD CONSTRAINT FK_PREDMETS_TEACHERS
FOREIGN KEY (TNUM)
REFERENCES TEACHERS_25(TNUM)
ON UPDATE CASCADE
ON DELETE CASCADE;
