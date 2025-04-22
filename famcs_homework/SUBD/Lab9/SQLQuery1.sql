INSERT INTO STUDENTS_25 
VALUES
(3417, N'������', N'����', N'��������', 0),
(3418, N'�������', N'�����', N'����������', 0),
(3419, N'�������', N'�������', N'��������', 0),
(3420, N'��������', N'�����', N'��������', 0),
(3421, N'��������', N'�������', N'���������', 0),
(3422, N'���������', N'�����', N'���������', 0),
(3423, N'������', N'������', N'����������', 0),
(3424, N'��������', N'�������', N'������������', 0),
(3425, N'��������', N'������', N'�������', 0),
(3426, N'��������', N'���������', N'����������', 0);

SELECT * FROM STUDENTS_25;

EXEC sp_help PREDMETS_25;

ALTER TABLE PREDMETS_25
DROP CONSTRAINT CK_PREDMETS_25_PNAME;

SELECT * FROM PREDMETS_25;

INSERT INTO PREDMETS_25
SELECT 
    (SELECT MAX(PNUM) FROM PREDMETS_25) + ROW_NUMBER() OVER(ORDER BY PNAME),
    PNAME,
    NULL,
    HOURS,
    COURS
FROM (
    SELECT N'���� ������' AS PNAME, HOURS, COURS 
    FROM PREDMETS_25
    WHERE PNAME = N'������'
    
    UNION ALL
    
    SELECT N'����� ����������������', HOURS, COURS 
    FROM PREDMETS_25
    WHERE PNAME = N'�����'
    
    UNION ALL
    
    SELECT N'�������������� �������������� ������', HOURS, COURS 
    FROM PREDMETS_25
    WHERE PNAME = N'���������'
) AS temp;

SELECT * FROM PREDMETS_25;