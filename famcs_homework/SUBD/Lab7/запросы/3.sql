SELECT *
FROM STUDENTS
WHERE STUDENTS.SNUM IN (
    SELECT USP.SNUM
    FROM USP
    WHERE CONVERT(DATE, USP.UDATE) = '1999-06-10'
);
