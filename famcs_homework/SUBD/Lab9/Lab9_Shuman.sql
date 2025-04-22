-- 1. В таблицу STUDENTS_N (N – Ваш номер по журналу) вставьте записи о 10-ти новых студентах (по своему усмотрению) со значением стипендии - 0.

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

--  2. В таблице PREDMET_N удалите ранее созданное в ЛР-8 ограничение наназвания предметов и вставьте новые записи о предметах «Базы данных»,
-- «Языки программирования», «Проектирование информационных систем» с количеством часов, равных предметам «Физика», «Химия», «Философия»
-- соответственно. В поле TNUM внесите значения NULL
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

-- 3. В таблицу PREDMET_N внесите изменения в поле TNUM для вставленных
-- на предыдущем шаге записей, соответствующие тому, что преподаватель,
-- который ведет предмет «Физика» будет вести и предмет «Базы данных», кто вел
-- «Химия» - «Языки программирования» и соответственно «Философия» -
-- «Проектирование информационных систем»
UPDATE PREDMETS_25
SET TNUM = (
	SELECT TNUM
	FROM PREDMETS_25
	WHERE PNAME = N'Физика'
)
WHERE PNAME = N'Базы данных';

UPDATE PREDMETS_25
SET TNUM = (
	SELECT TNUM
	FROM PREDMETS_25
	WHERE PNAME = N'Химия'
)
WHERE PNAME = N'Языки программирования';

UPDATE PREDMETS_25
SET TNUM = (
	SELECT TNUM
	FROM PREDMETS_25
	WHERE PNAME = N'Философия'
)
WHERE PNAME = N'Проектирование информационных систем';

SELECT * FROM PREDMETS_25;

-- 4. Внесите новые записи в таблицу USP_N об оценках по всем новым предметам
-- для всех студентов, имеющих стипендию 0 (оценки по собственному
-- усмотрению) 

INSERT INTO USP_25
SELECT 
	(SELECT MAX(UNUM) FROM USP_25) + ROW_NUMBER() OVER(ORDER BY SNUM),
	4, 
	CAST(GETDATE() AS smalldatetime),
	SNUM,
	(SELECT PNUM FROM PREDMETS_25 WHERE PNAME = N'Базы данных')
FROM STUDENTS_25
WHERE STIP = 0;

INSERT INTO USP_25
SELECT 
	(SELECT MAX(UNUM) FROM USP_25) + ROW_NUMBER() OVER(ORDER BY SNUM),
	3,
	CAST(GETDATE() AS smalldatetime),
	SNUM,
	(SELECT PNUM FROM PREDMETS_25 WHERE PNAME = N'Языки программирования')
FROM STUDENTS_25
WHERE STIP = 0;

INSERT INTO USP_25
SELECT 
	(SELECT MAX(UNUM) FROM USP_25) + ROW_NUMBER() OVER(ORDER BY SNUM),
	5, 
	CAST(GETDATE() AS smalldatetime),
	SNUM,
	(SELECT PNUM FROM PREDMETS_25 WHERE PNAME = N'Проектирование информационных систем')
FROM STUDENTS_25
WHERE STIP = 0;

select * from USP_25;

-- 5. Измените размер стипендии до 30 всем студентам, имеющим оценки «5» по более чем двум предметам 
select * from STUDENTS_25;

SELECT * 
FROM STUDENTS_25
WHERE SNUM IN (
	SELECT SNUM
	FROM USP_25
	WHERE OCENKA = 5
	GROUP BY SNUM
	HAVING COUNT(*) > 2
);

INSERT INTO USP_25
VALUES 
(
	 (SELECT MAX(UNUM) FROM USP_25) + 1, 5, CAST(GETDATE() AS smalldatetime), 3412, 2008
);

UPDATE STUDENTS_25
SET STIP = 30
WHERE SNUM IN (
    SELECT SNUM
    FROM USP_25
    WHERE OCENKA = 5
    GROUP BY SNUM
    HAVING COUNT(*) > 2 
);

select * from STUDENTS_25 where SNUM = 3412;

-- 6. Измените размер стипендии до 5 всем студентам, имеющим хотя бы одну оценку «3» по предметам, при этом если у него стипендия не была равна «0» 

SELECT *
FROM STUDENTS_25 s
WHERE EXISTS (
    SELECT 1 
    FROM USP_25 u 
    WHERE u.SNUM = s.SNUM 
    AND u.OCENKA = 3
)
AND s.STIP <> 0;

SELECT DISTINCT SNUM FROM USP_25 WHERE OCENKA = 3;
SELECT SNUM, STIP FROM STUDENTS_25 WHERE STIP <> 0;
INSERT INTO USP_25
VALUES 
(
	 (SELECT MAX(UNUM) FROM USP_25) + 1, 3, CAST(GETDATE() AS smalldatetime), 3416, 2008
);

UPDATE STUDENTS_25
SET STIP = 5
WHERE SNUM IN (
    SELECT DISTINCT SNUM
    FROM USP_25
    WHERE OCENKA = 3
)
AND STIP <> 0;

select * from STUDENTS_25 where SNUM = 3416;

-- 7. Удалите записи из таблицы STUDENTS_N о студентах, имеющих более 3-х оценок (2) по любым предметам. 

SELECT SNUM, COUNT(*)
FROM USP_25
WHERE OCENKA = 2
GROUP BY SNUM
HAVING COUNT(*) > 3;


INSERT INTO USP_25
VALUES 
    ((SELECT MAX(UNUM) FROM USP_25) + 1, 2, CAST(GETDATE() AS smalldatetime), 3417, 2007);


SELECT * FROM STUDENTS_25;

DELETE FROM STUDENTS_25
WHERE SNUM IN (
    SELECT SNUM
    FROM USP_25
    WHERE OCENKA = 2
    GROUP BY SNUM
    HAVING COUNT(*) > 3
);
