SELECT STUDENTS.SNUM, STUDENTS.SFAM 
FROM STUDENTS
WHERE STUDENTS.SNUM IN (
	SELECT USP.SNUM 
	FROM USP
	GROUP BY USP.SNUM
	HAVING COUNT(USP.PNUM) > 1
	);