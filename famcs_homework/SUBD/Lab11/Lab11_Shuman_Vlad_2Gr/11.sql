-- задание 0 -- сделать и предварительно заполнить таблицы
CREATE TABLE CUSTOMERS (
    IDCUST NUMERIC(9) NOT NULL,
    CUST_NUM CHAR(10) NULL,
    COMPANY CHAR(20) NULL,
    CUST_REP CHAR(10) NULL,
    CREDIT_LIMIT MONEY NULL,
    DATA_ORDER SMALLDATETIME NULL,
    AMOUNT MONEY NULL
);

INSERT INTO CUSTOMERS
VALUES
    (1, '211', 'Фишер', '121', 80000, '2005-12-12', 9000),
    (2, '212', 'Графт', '124', 167890, '2005-02-01', 145678),
    (3, '212', 'Графт', '124', 2000, '2005-06-04', 1000),
    (4, '213', 'Шредер', '121', 12, '2004-02-06', 2000);
-- хотелось бы сделать так, чтобы не нужно было вводить самому
-- ID, для этого я бы мог воспользоваться IDCUST INT IDENTITY(1,1) PRIMARY KEY

CREATE TABLE SALESPERS (
    FIO CHAR(20) NULL,
    EMPL_NYM CHAR(10) NOT NULL PRIMARY KEY,
    QUOTA FLOAT(8) NULL
);

INSERT INTO SALESPERS
VALUES
    ('Петров', '121', 105000),
    ('Иванов', '122', 14),
    ('Сидоров', '123', 0),
    ('Васечкин', '124', 150000);


CREATE TABLE OFFICES (
    IDOFF INT NOT NULL PRIMARY KEY CHECK (IDOFF BETWEEN 0 AND 9999),
    TARGET FLOAT(8) NULL,
    CITY CHAR(10) NULL,
    CUST_NUM CHAR(10) NULL,
    STATUS CHAR(30) NULL
);
-- в фотографии для IDOFF стоит длина до 4
-- если речь идет о количестве цифр, то -- такого синтаксиса как бы и нет
-- но можно обойти это путем, каким я воспользовался выше

INSERT INTO OFFICES 
VALUES
    (1, 1000000, 'Лондон', '211', NULL),
    (2, 120000, 'Берлин', '212', NULL),
    (3, 3450000, 'Прага', '213', NULL);

SELECT * FROM CUSTOMERS;
SELECT * FROM SALESPERS;
SELECT * FROM OFFICES;

-- Задание 1
CREATE PROCEDURE GET_CUST -- написать хранимую процедуру GET_CUST
	-- первый параметр входной
    @IDCUST NUMERIC(9), -- которая получает идентификатор клиента
	-- остальные три выходные
    @COMPANY CHAR(20) OUTPUT, -- и возвращает его имя
    @FIO CHAR(20) OUTPUT, -- имя закрепленного за ним служащего
    @CITY CHAR(10) OUTPUT -- название города: в котором расположен офис его клиента
AS
BEGIN
    SELECT 
        @COMPANY = CUSTOMERS.COMPANY,
        @FIO = SALESPERS.FIO,
        @CITY = OFFICES.CITY
    FROM CUSTOMERS
    LEFT JOIN SALESPERS ON CUSTOMERS.CUST_REP = SALESPERS.EMPL_NYM
    LEFT JOIN OFFICES ON CUSTOMERS.CUST_NUM = OFFICES.CUST_NUM
    WHERE CUSTOMERS.IDCUST = @IDCUST;
END;

-- Продемонстрировать вызов данной процедуры из другой процедуры Transact-SQL. Например, GET_CUST1 (идентификатор_клиента).
CREATE PROCEDURE GET_CUST1
    @IDCUST NUMERIC(9)
AS
BEGIN
    DECLARE @COMPANY CHAR(20), @FIO CHAR(20), @CITY CHAR(10); -- объявляем три переменные

    EXEC GET_CUST @IDCUST, @COMPANY OUTPUT, @FIO OUTPUT, @CITY OUTPUT; -- получаем все необходимые данные

	-- и выводим их
    PRINT 'Компания: ' + @COMPANY;
    PRINT 'Служащий: ' + @FIO;
    PRINT 'Город офиса: ' + @CITY;
END;

EXEC GET_CUST1 1;


-- Задание 2
-- нужно учесть то, что у нас есть одинаковые CUST_NUM
-- Написать хранимую процедуру CHK_TOT
CREATE OR ALTER PROCEDURE CHK_TOT
    @IDCUST NUMERIC(9) -- которая получает идентификатор клиента
AS
BEGIN
	-- объявляем переменные
    DECLARE @TotalAmount MONEY = 0;
    DECLARE @CUST_NUM CHAR(10);
    DECLARE @COMPANY CHAR(20);
    DECLARE @StatusMessage NVARCHAR(100);
    DECLARE @OfficeCount INT;
    DECLARE @CurrentStatus CHAR(50);

    -- Получаем данные клиента
    SELECT @CUST_NUM = CUST_NUM, 
           @COMPANY = COMPANY
    FROM CUSTOMERS
    WHERE IDCUST = @IDCUST;

    -- учтем, а есть ли клиент
    IF @CUST_NUM IS NOT NULL
    BEGIN
        --  и вычисляет общую стоимость его заказов
        SELECT @TotalAmount = COALESCE(SUM(AMOUNT), 0)
        FROM CUSTOMERS
        WHERE CUST_NUM = @CUST_NUM;

        -- и в зависимости от того, превысит ли эта сумма 30 000$, 
		-- заносит в поле STATUS таблицы OFFICES 
		-- одно из двух примечаний – “большой объем заказов”, ”малый объем заказов”
        IF @TotalAmount > 30000
            SET @CurrentStatus = 'большой объем заказов';
        ELSE
            SET @CurrentStatus = 'малый объем заказов';

        UPDATE OFFICES
        SET STATUS = @CurrentStatus
        WHERE CUST_NUM = @CUST_NUM;

        -- Получаем количество обновленных офисов
        SELECT @OfficeCount = @@ROWCOUNT;

        -- вывод (для отладки)
        PRINT '===================================';
        PRINT 'Обработка клиента:';
        PRINT 'ID клиента: ' + CAST(@IDCUST AS NVARCHAR);
        PRINT 'Номер клиента: ' + @CUST_NUM;
        PRINT 'Компания: ' + @COMPANY;
        PRINT 'Общая сумма заказов: ' + CAST(@TotalAmount AS NVARCHAR) + '$';
        PRINT 'Установлен статус: ' + @CurrentStatus;
        PRINT 'Обновлено офисов: ' + CAST(@OfficeCount AS NVARCHAR);
        PRINT '===================================';
    END
    ELSE -- если клиент не найден
    BEGIN
        PRINT '===================================';
        PRINT 'Ошибка: Клиент с ID ' + CAST(@IDCUST AS NVARCHAR) + ' не найден';
        PRINT '===================================';
    END
END;

-- проверяем выполнение
EXEC CHK_TOT 1;
EXEC CHK_TOT 2;
EXEC CHK_TOT 3;
EXEC CHK_TOT 4;

SELECT * FROM OFFICES;

-- Задание 3
-- 3.	Написать хранимую процедуру для добавления данных о новом клиенте в таблицу OFFICES
-- по заданию нужно будет воспользоваться функцией из задания 2
-- и я бы ей воспользвался бы для подсчета @TotalAmount, но -- у нее нет OUTPUT параметра
-- поэтому я решил сделать новую процедуру, что имеет в себе этот параметр
-- и более легкую
CREATE OR ALTER PROCEDURE CHK_TOT_WITH_TOTAL_AMOUNT_OUTPUT
    @IDCUST NUMERIC(9), -- которая получает идентификатор клиента
	@TotalAmount MONEY OUTPUT
AS
BEGIN
	-- объявляем переменные
    DECLARE @CUST_NUM CHAR(10);
    DECLARE @COMPANY CHAR(20);
    DECLARE @StatusMessage NVARCHAR(100);
    DECLARE @OfficeCount INT;
    DECLARE @CurrentStatus CHAR(50);

    -- Получаем данные клиента
    SELECT @CUST_NUM = CUST_NUM
    FROM CUSTOMERS
    WHERE IDCUST = @IDCUST;

    -- учтем, а есть ли клиент
    IF @CUST_NUM IS NOT NULL
    BEGIN
        --  и вычисляет общую стоимость его заказов
        SELECT @TotalAmount = COALESCE(SUM(AMOUNT), 0)
        FROM CUSTOMERS
        WHERE CUST_NUM = @CUST_NUM;

        -- вывод (для отладки)
        PRINT '===================================';
        PRINT 'Общая сумма заказов: ' + CAST(@TotalAmount AS NVARCHAR) + '$';
        PRINT '===================================';
    END
    ELSE -- если клиент не найден
    BEGIN
        PRINT '===================================';
        PRINT 'Ошибка: Клиент с ID ' + CAST(@IDCUST AS NVARCHAR) + ' не найден';
        PRINT '===================================';
    END
END;

EXEC CHK_TOT_WITH_TOTAL_AMOUNT_OUTPUT 2, null;
---

-- теперь сама функция
CREATE OR ALTER PROCEDURE ADD_OFFICE_RECORD
    @IDOFF INT, -- параметры как атрибуты таблицы OFFICES
    @TARGET FLOAT(8),
    @CITY CHAR(10),
    @CUST_NUM CHAR(10),
    @STATUS CHAR(30) = NULL
AS
BEGIN
    DECLARE @TotalAmount MONEY;
    DECLARE @CUST_REP CHAR(10);
    DECLARE @COMPANY CHAR(20);
    DECLARE @IDCUST NUMERIC(9);
    DECLARE @Message NVARCHAR(200);

    -- Находим ID клиента по CUST_NUM (для вызова CHK_TOT)
	-- в CUSTOMERS просто может быть несколько записей с одинаковым CUST_NUM
	-- И если без MIN -- то будет множество строк
    SELECT @IDCUST = MIN(IDCUST) -- можно было бы и MAX
    FROM CUSTOMERS  
    WHERE CUST_NUM = @CUST_NUM;
    
    -- Проверяем существование клиента
    IF @IDCUST IS NULL
    BEGIN
        PRINT 'Ошибка: Клиент с номером ' + @CUST_NUM + ' не существует в таблице CUSTOMERS';
        RETURN;
    END
    
    -- Получаем сумму заказов через наш модицифицированный метод
    EXEC CHK_TOT_WITH_TOTAL_AMOUNT_OUTPUT 
        @IDCUST = @IDCUST, 
        @TotalAmount = @TotalAmount OUTPUT;
    
    -- Получаем информацию о клиенте (CUST_REP и COMPANY)
    SELECT @CUST_REP = CUST_REP, @COMPANY = COMPANY
    FROM CUSTOMERS
    WHERE CUST_NUM = @CUST_NUM;
    
    -- Предусмотреть промежуточный вывод суммы заказов рассматриваемого клиента
    PRINT 'Обработка клиента: ' + @COMPANY + ' (CUST_NUM: ' + @CUST_NUM + ')';
    PRINT 'Сумма заказов: ' + CAST(@TotalAmount AS NVARCHAR) + '$';
    
    -- Проверяем условия для добавления записи
    IF @TotalAmount < 20000
    BEGIN
        -- Добавляем запись в OFFICES
        INSERT INTO OFFICES (IDOFF, TARGET, CITY, CUST_NUM, STATUS)
        VALUES (@IDOFF, @TARGET, @CITY, @CUST_NUM, @STATUS);
        
        -- Обновляем QUOTA в SALESPERS (добавляем TARGET)
        UPDATE SALESPERS
        SET QUOTA = QUOTA + @TARGET
        WHERE EMPL_NYM = @CUST_REP;
        
        PRINT 'Добавлена запись в OFFICES. QUOTA служащего увеличен на ' + CAST(@TARGET AS NVARCHAR) + '$';
    END
    ELSE IF @TotalAmount = 20000 -- если я правильно понял, то нужно выделить в отдельный блок
	-- иначе бы я просто реализовал бы один <= 20000
    BEGIN
        -- Добавляем запись в OFFICES
        INSERT INTO OFFICES (IDOFF, TARGET, CITY, CUST_NUM, STATUS)
        VALUES (@IDOFF, @TARGET, @CITY, @CUST_NUM, @STATUS);
        
        -- Обновляем QUOTA 
        UPDATE SALESPERS
        SET QUOTA = QUOTA + 20000 -- (фиксированная сумма 20000)
        WHERE EMPL_NYM = @CUST_REP;
        
        PRINT 'Добавлена запись в OFFICES. QUOTA служащего увеличен на 20000$';
    END
    ELSE
    BEGIN
        PRINT 'Ошибка: Сумма заказов клиента (' + CAST(@TotalAmount AS NVARCHAR) + '$) превышает 20000$. Добавление запрещено.';
        RETURN;
    END
    
    -- Выводим итоговую информацию о служащем
    SELECT @Message = 'Итоговый QUOTA служащего: ' + FIO + ' (' + EMPL_NYM + ') = ' + CAST(QUOTA AS NVARCHAR) + '$'
    FROM SALESPERS
    WHERE EMPL_NYM = @CUST_REP;
    
    PRINT @Message;
END;

-- чтобы проверить симитируем несколько случаев

-- Добавляем офис для клиента с CUST_NUM='211' (сумма заказов = 9000$)
EXEC ADD_OFFICE_RECORD 
    @IDOFF = 4, 
    @TARGET = 50000, 
    @CITY = 'Париж', 
    @CUST_NUM = '211';

-- Проверяем данные:
SELECT * FROM OFFICES WHERE IDOFF = 4;  -- Должна появиться новая запись
SELECT * FROM SALESPERS WHERE EMPL_NYM = '121';  -- QUOTA должен увеличиться на 50000

-- Временно обновляем сумму заказов клиента '213' до 20000 (было 2000)
UPDATE CUSTOMERS SET AMOUNT = 20000 WHERE IDCUST = 4;

-- Теперь вызываем процедуру
EXEC ADD_OFFICE_RECORD 
    @IDOFF = 6, 
    @TARGET = 10000, 
    @CITY = 'Рим', 
    @CUST_NUM = '213';

-- Проверяем:
SELECT * FROM OFFICES WHERE IDOFF = 6
SELECT * FROM SALESPERS WHERE EMPL_NYM = '121';  -- QUOTA должен увеличиться на 20000 (фиксированная сумма)


-- Пытаемся добавить офис
EXEC ADD_OFFICE_RECORD 
    @IDOFF = 7, 
    @TARGET = 30000, 
    @CITY = 'Берлин', 
    @CUST_NUM = '212';

SELECT * FROM OFFICES WHERE IDOFF = 7;


-- Задание 4
-- Создать триггер, распространяющий любое обновление столбца EMPL_NUM в таблице SALESPERS на столбец CUST_REP таблицы CUSTOMERS.
CREATE OR ALTER TRIGGER UPDATE_SALESPERS_EMPL_NYM -- создать или изменить
ON SALESPERS -- на таблицу
AFTER UPDATE -- после Обнавления
AS
BEGIN
    -- Проверяем, изменился ли именно EMPL_NUM
    IF UPDATE(EMPL_NYM)
    BEGIN
        -- Обновляем CUST_REP в CUSTOMERS для всех записей,
        -- где старый EMPL_NYM был указан как CUST_REP
        UPDATE CUSTOMERS
        SET CUST_REP = inserted.EMPL_NYM
        FROM CUSTOMERS 
        INNER JOIN deleted ON CUSTOMERS.CUST_REP = deleted.EMPL_NYM
        INNER JOIN inserted ON deleted.FIO = inserted.FIO  -- Предполагаем, что FIO не меняется
        WHERE deleted.EMPL_NYM <> inserted.EMPL_NYM;  -- Только если EMPL_NUM действительно изменился
    END
END;

-- напомню сам себе: deleted и inserted — это специальные временные таблицы,
-- которые автоматически создаются и управляются системой при выполнении триггеров.
-- Они содержат данные, затронутые операцией, вызвавшей срабатывание триггера.

-- проверяем

SELECT * FROM SALESPERS;
SELECT * FROM CUSTOMERS;

UPDATE SALESPERS 
SET EMPL_NYM = '125' 
WHERE FIO = 'Петров' AND EMPL_NYM = '121';

-- Задание 5
-- Создать триггер, который запускается каждый раз, когда запись вставляется в таблицу CUSTOMERS или модифицируется. 
-- Если заказ сделан не в первые 15 дней месяца, то запись не принимается. 

CREATE OR ALTER TRIGGER CUSTOMERS_DATE_CHECK  -- Создать триггер
ON CUSTOMERS -- когда запись вставляется в таблицу CUSTOMERS или модифицируется
AFTER INSERT, UPDATE
AS
BEGIN
    -- Проверяем записи с датой заказа не в первые 15 дней месяца
    IF EXISTS (
        SELECT 1 
        FROM inserted
        WHERE DATA_ORDER IS NOT NULL
        AND DATEPART(day, DATA_ORDER) > 15
    )
    BEGIN
        -- Откатываем транзакцию и выводим сообщение об ошибке
        ROLLBACK TRANSACTION;
        RAISERROR('Заказы принимаются только в первые 15 дней месяца!', 16, 1); -- (сообщение, уровень серьезности, состояние)
        RETURN;
    END
END;
 -- Тестируем
-- Должно сработать успешно
INSERT INTO CUSTOMERS (IDCUST, CUST_NUM, COMPANY, DATA_ORDER)
VALUES (5, '214', 'Тестовая компания', '2023-05-10');

-- Должно вызвать ошибку
INSERT INTO CUSTOMERS (IDCUST, CUST_NUM, COMPANY, DATA_ORDER)
VALUES (6, '215', 'Тестовая компания', '2023-20-05');

SELECT * FROM CUSTOMERS;