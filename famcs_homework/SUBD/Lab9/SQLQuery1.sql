INSERT INTO STUDENTS_25 
VALUES
(3417, N'Иванов', N'Иван', N'Иванович', 0),
(3418, N'Петрова', N'Мария', N'Алексеевна', 0),
(3419, N'Сидоров', N'Алексей', N'Петрович', 0),
(3420, N'Смирнова', N'Ольга', N'Игоревна', 0),
(3421, N'Кузнецов', N'Дмитрий', N'Сергеевич', 0),
(3422, N'Васильева', N'Елена', N'Андреевна', 0),
(3423, N'Волков', N'Андрей', N'Николаевич', 0),
(3424, N'Соколова', N'Наталья', N'Владимировна', 0),
(3425, N'Михайлов', N'Сергей', N'Юрьевич', 0),
(3426, N'Федорова', N'Екатерина', N'Дмитриевна', 0);

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
    SELECT N'Базы данных' AS PNAME, HOURS, COURS 
    FROM PREDMETS_25
    WHERE PNAME = N'Физика'
    
    UNION ALL
    
    SELECT N'Языки программирования', HOURS, COURS 
    FROM PREDMETS_25
    WHERE PNAME = N'Химия'
    
    UNION ALL
    
    SELECT N'Проектирование информационных систем', HOURS, COURS 
    FROM PREDMETS_25
    WHERE PNAME = N'Философия'
) AS temp;

SELECT * FROM PREDMETS_25;