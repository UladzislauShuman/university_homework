-- ������� 0 -- ������� � �������������� ��������� �������
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
    (1, '211', '�����', '121', 80000, '2005-12-12', 9000),
    (2, '212', '�����', '124', 167890, '2005-02-01', 145678),
    (3, '212', '�����', '124', 2000, '2005-06-04', 1000),
    (4, '213', '������', '121', 12, '2004-02-06', 2000);
-- �������� �� ������� ���, ����� �� ����� ���� ������� ������
-- ID, ��� ����� � �� ��� ��������������� IDCUST INT IDENTITY(1,1) PRIMARY KEY

CREATE TABLE SALESPERS (
    FIO CHAR(20) NULL,
    EMPL_NYM CHAR(10) NOT NULL PRIMARY KEY,
    QUOTA FLOAT(8) NULL
);

INSERT INTO SALESPERS
VALUES
    ('������', '121', 105000),
    ('������', '122', 14),
    ('�������', '123', 0),
    ('��������', '124', 150000);


CREATE TABLE OFFICES (
    IDOFF INT NOT NULL PRIMARY KEY CHECK (IDOFF BETWEEN 0 AND 9999),
    TARGET FLOAT(8) NULL,
    CITY CHAR(10) NULL,
    CUST_NUM CHAR(10) NULL,
    STATUS CHAR(30) NULL
);
-- � ���������� ��� IDOFF ����� ����� �� 4
-- ���� ���� ���� � ���������� ����, �� -- ������ ���������� ��� �� � ���
-- �� ����� ������ ��� �����, ����� � �������������� ����

INSERT INTO OFFICES 
VALUES
    (1, 1000000, '������', '211', NULL),
    (2, 120000, '������', '212', NULL),
    (3, 3450000, '�����', '213', NULL);

SELECT * FROM CUSTOMERS;
SELECT * FROM SALESPERS;
SELECT * FROM OFFICES;

-- ������� 1
CREATE PROCEDURE GET_CUST -- �������� �������� ��������� GET_CUST
	-- ������ �������� �������
    @IDCUST NUMERIC(9), -- ������� �������� ������������� �������
	-- ��������� ��� ��������
    @COMPANY CHAR(20) OUTPUT, -- � ���������� ��� ���
    @FIO CHAR(20) OUTPUT, -- ��� ������������� �� ��� ���������
    @CITY CHAR(10) OUTPUT -- �������� ������: � ������� ���������� ���� ��� �������
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

-- ������������������ ����� ������ ��������� �� ������ ��������� Transact-SQL. ��������, GET_CUST1 (�������������_�������).
CREATE PROCEDURE GET_CUST1
    @IDCUST NUMERIC(9)
AS
BEGIN
    DECLARE @COMPANY CHAR(20), @FIO CHAR(20), @CITY CHAR(10); -- ��������� ��� ����������

    EXEC GET_CUST @IDCUST, @COMPANY OUTPUT, @FIO OUTPUT, @CITY OUTPUT; -- �������� ��� ����������� ������

	-- � ������� ��
    PRINT '��������: ' + @COMPANY;
    PRINT '��������: ' + @FIO;
    PRINT '����� �����: ' + @CITY;
END;

EXEC GET_CUST1 1;


-- ������� 2
-- ����� ������ ��, ��� � ��� ���� ���������� CUST_NUM
-- �������� �������� ��������� CHK_TOT
CREATE OR ALTER PROCEDURE CHK_TOT
    @IDCUST NUMERIC(9) -- ������� �������� ������������� �������
AS
BEGIN
	-- ��������� ����������
    DECLARE @TotalAmount MONEY = 0;
    DECLARE @CUST_NUM CHAR(10);
    DECLARE @COMPANY CHAR(20);
    DECLARE @StatusMessage NVARCHAR(100);
    DECLARE @OfficeCount INT;
    DECLARE @CurrentStatus CHAR(50);

    -- �������� ������ �������
    SELECT @CUST_NUM = CUST_NUM, 
           @COMPANY = COMPANY
    FROM CUSTOMERS
    WHERE IDCUST = @IDCUST;

    -- �����, � ���� �� ������
    IF @CUST_NUM IS NOT NULL
    BEGIN
        --  � ��������� ����� ��������� ��� �������
        SELECT @TotalAmount = COALESCE(SUM(AMOUNT), 0)
        FROM CUSTOMERS
        WHERE CUST_NUM = @CUST_NUM;

        -- � � ����������� �� ����, �������� �� ��� ����� 30 000$, 
		-- ������� � ���� STATUS ������� OFFICES 
		-- ���� �� ���� ���������� � �������� ����� �������, ������ ����� �������
        IF @TotalAmount > 30000
            SET @CurrentStatus = '������� ����� �������';
        ELSE
            SET @CurrentStatus = '����� ����� �������';

        UPDATE OFFICES
        SET STATUS = @CurrentStatus
        WHERE CUST_NUM = @CUST_NUM;

        -- �������� ���������� ����������� ������
        SELECT @OfficeCount = @@ROWCOUNT;

        -- ����� (��� �������)
        PRINT '===================================';
        PRINT '��������� �������:';
        PRINT 'ID �������: ' + CAST(@IDCUST AS NVARCHAR);
        PRINT '����� �������: ' + @CUST_NUM;
        PRINT '��������: ' + @COMPANY;
        PRINT '����� ����� �������: ' + CAST(@TotalAmount AS NVARCHAR) + '$';
        PRINT '���������� ������: ' + @CurrentStatus;
        PRINT '��������� ������: ' + CAST(@OfficeCount AS NVARCHAR);
        PRINT '===================================';
    END
    ELSE -- ���� ������ �� ������
    BEGIN
        PRINT '===================================';
        PRINT '������: ������ � ID ' + CAST(@IDCUST AS NVARCHAR) + ' �� ������';
        PRINT '===================================';
    END
END;

-- ��������� ����������
EXEC CHK_TOT 1;
EXEC CHK_TOT 2;
EXEC CHK_TOT 3;
EXEC CHK_TOT 4;

SELECT * FROM OFFICES;

-- ������� 3
-- 3.	�������� �������� ��������� ��� ���������� ������ � ����� ������� � ������� OFFICES
-- �� ������� ����� ����� ��������������� �������� �� ������� 2
-- � � �� �� ������������� �� ��� �������� @TotalAmount, �� -- � ��� ��� OUTPUT ���������
-- ������� � ����� ������� ����� ���������, ��� ����� � ���� ���� ��������
-- � ����� ������
CREATE OR ALTER PROCEDURE CHK_TOT_WITH_TOTAL_AMOUNT_OUTPUT
    @IDCUST NUMERIC(9), -- ������� �������� ������������� �������
	@TotalAmount MONEY OUTPUT
AS
BEGIN
	-- ��������� ����������
    DECLARE @CUST_NUM CHAR(10);
    DECLARE @COMPANY CHAR(20);
    DECLARE @StatusMessage NVARCHAR(100);
    DECLARE @OfficeCount INT;
    DECLARE @CurrentStatus CHAR(50);

    -- �������� ������ �������
    SELECT @CUST_NUM = CUST_NUM
    FROM CUSTOMERS
    WHERE IDCUST = @IDCUST;

    -- �����, � ���� �� ������
    IF @CUST_NUM IS NOT NULL
    BEGIN
        --  � ��������� ����� ��������� ��� �������
        SELECT @TotalAmount = COALESCE(SUM(AMOUNT), 0)
        FROM CUSTOMERS
        WHERE CUST_NUM = @CUST_NUM;

        -- ����� (��� �������)
        PRINT '===================================';
        PRINT '����� ����� �������: ' + CAST(@TotalAmount AS NVARCHAR) + '$';
        PRINT '===================================';
    END
    ELSE -- ���� ������ �� ������
    BEGIN
        PRINT '===================================';
        PRINT '������: ������ � ID ' + CAST(@IDCUST AS NVARCHAR) + ' �� ������';
        PRINT '===================================';
    END
END;

EXEC CHK_TOT_WITH_TOTAL_AMOUNT_OUTPUT 2, null;
---

-- ������ ���� �������
CREATE OR ALTER PROCEDURE ADD_OFFICE_RECORD
    @IDOFF INT, -- ��������� ��� �������� ������� OFFICES
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

    -- ������� ID ������� �� CUST_NUM (��� ������ CHK_TOT)
	-- � CUSTOMERS ������ ����� ���� ��������� ������� � ���������� CUST_NUM
	-- � ���� ��� MIN -- �� ����� ��������� �����
    SELECT @IDCUST = MIN(IDCUST) -- ����� ���� �� � MAX
    FROM CUSTOMERS  
    WHERE CUST_NUM = @CUST_NUM;
    
    -- ��������� ������������� �������
    IF @IDCUST IS NULL
    BEGIN
        PRINT '������: ������ � ������� ' + @CUST_NUM + ' �� ���������� � ������� CUSTOMERS';
        RETURN;
    END
    
    -- �������� ����� ������� ����� ��� ������������������ �����
    EXEC CHK_TOT_WITH_TOTAL_AMOUNT_OUTPUT 
        @IDCUST = @IDCUST, 
        @TotalAmount = @TotalAmount OUTPUT;
    
    -- �������� ���������� � ������� (CUST_REP � COMPANY)
    SELECT @CUST_REP = CUST_REP, @COMPANY = COMPANY
    FROM CUSTOMERS
    WHERE CUST_NUM = @CUST_NUM;
    
    -- ������������� ������������� ����� ����� ������� ���������������� �������
    PRINT '��������� �������: ' + @COMPANY + ' (CUST_NUM: ' + @CUST_NUM + ')';
    PRINT '����� �������: ' + CAST(@TotalAmount AS NVARCHAR) + '$';
    
    -- ��������� ������� ��� ���������� ������
    IF @TotalAmount < 20000
    BEGIN
        -- ��������� ������ � OFFICES
        INSERT INTO OFFICES (IDOFF, TARGET, CITY, CUST_NUM, STATUS)
        VALUES (@IDOFF, @TARGET, @CITY, @CUST_NUM, @STATUS);
        
        -- ��������� QUOTA � SALESPERS (��������� TARGET)
        UPDATE SALESPERS
        SET QUOTA = QUOTA + @TARGET
        WHERE EMPL_NYM = @CUST_REP;
        
        PRINT '��������� ������ � OFFICES. QUOTA ��������� �������� �� ' + CAST(@TARGET AS NVARCHAR) + '$';
    END
    ELSE IF @TotalAmount = 20000 -- ���� � ��������� �����, �� ����� �������� � ��������� ����
	-- ����� �� � ������ ���������� �� ���� <= 20000
    BEGIN
        -- ��������� ������ � OFFICES
        INSERT INTO OFFICES (IDOFF, TARGET, CITY, CUST_NUM, STATUS)
        VALUES (@IDOFF, @TARGET, @CITY, @CUST_NUM, @STATUS);
        
        -- ��������� QUOTA 
        UPDATE SALESPERS
        SET QUOTA = QUOTA + 20000 -- (������������� ����� 20000)
        WHERE EMPL_NYM = @CUST_REP;
        
        PRINT '��������� ������ � OFFICES. QUOTA ��������� �������� �� 20000$';
    END
    ELSE
    BEGIN
        PRINT '������: ����� ������� ������� (' + CAST(@TotalAmount AS NVARCHAR) + '$) ��������� 20000$. ���������� ���������.';
        RETURN;
    END
    
    -- ������� �������� ���������� � ��������
    SELECT @Message = '�������� QUOTA ���������: ' + FIO + ' (' + EMPL_NYM + ') = ' + CAST(QUOTA AS NVARCHAR) + '$'
    FROM SALESPERS
    WHERE EMPL_NYM = @CUST_REP;
    
    PRINT @Message;
END;

-- ����� ��������� ���������� ��������� �������

-- ��������� ���� ��� ������� � CUST_NUM='211' (����� ������� = 9000$)
EXEC ADD_OFFICE_RECORD 
    @IDOFF = 4, 
    @TARGET = 50000, 
    @CITY = '�����', 
    @CUST_NUM = '211';

-- ��������� ������:
SELECT * FROM OFFICES WHERE IDOFF = 4;  -- ������ ��������� ����� ������
SELECT * FROM SALESPERS WHERE EMPL_NYM = '121';  -- QUOTA ������ ����������� �� 50000

-- �������� ��������� ����� ������� ������� '213' �� 20000 (���� 2000)
UPDATE CUSTOMERS SET AMOUNT = 20000 WHERE IDCUST = 4;

-- ������ �������� ���������
EXEC ADD_OFFICE_RECORD 
    @IDOFF = 6, 
    @TARGET = 10000, 
    @CITY = '���', 
    @CUST_NUM = '213';

-- ���������:
SELECT * FROM OFFICES WHERE IDOFF = 6
SELECT * FROM SALESPERS WHERE EMPL_NYM = '121';  -- QUOTA ������ ����������� �� 20000 (������������� �����)


-- �������� �������� ����
EXEC ADD_OFFICE_RECORD 
    @IDOFF = 7, 
    @TARGET = 30000, 
    @CITY = '������', 
    @CUST_NUM = '212';

SELECT * FROM OFFICES WHERE IDOFF = 7;


-- ������� 4
-- ������� �������, ���������������� ����� ���������� ������� EMPL_NUM � ������� SALESPERS �� ������� CUST_REP ������� CUSTOMERS.
CREATE OR ALTER TRIGGER UPDATE_SALESPERS_EMPL_NYM -- ������� ��� ��������
ON SALESPERS -- �� �������
AFTER UPDATE -- ����� ����������
AS
BEGIN
    -- ���������, ��������� �� ������ EMPL_NUM
    IF UPDATE(EMPL_NYM)
    BEGIN
        -- ��������� CUST_REP � CUSTOMERS ��� ���� �������,
        -- ��� ������ EMPL_NYM ��� ������ ��� CUST_REP
        UPDATE CUSTOMERS
        SET CUST_REP = inserted.EMPL_NYM
        FROM CUSTOMERS 
        INNER JOIN deleted ON CUSTOMERS.CUST_REP = deleted.EMPL_NYM
        INNER JOIN inserted ON deleted.FIO = inserted.FIO  -- ������������, ��� FIO �� ��������
        WHERE deleted.EMPL_NYM <> inserted.EMPL_NYM;  -- ������ ���� EMPL_NUM ������������� ���������
    END
END;

-- ������� ��� ����: deleted � inserted � ��� ����������� ��������� �������,
-- ������� ������������� ��������� � ����������� �������� ��� ���������� ���������.
-- ��� �������� ������, ���������� ���������, ��������� ������������ ��������.

-- ���������

SELECT * FROM SALESPERS;
SELECT * FROM CUSTOMERS;

UPDATE SALESPERS 
SET EMPL_NYM = '125' 
WHERE FIO = '������' AND EMPL_NYM = '121';

-- ������� 5
-- ������� �������, ������� ����������� ������ ���, ����� ������ ����������� � ������� CUSTOMERS ��� ��������������. 
-- ���� ����� ������ �� � ������ 15 ���� ������, �� ������ �� �����������. 

CREATE OR ALTER TRIGGER CUSTOMERS_DATE_CHECK  -- ������� �������
ON CUSTOMERS -- ����� ������ ����������� � ������� CUSTOMERS ��� ��������������
AFTER INSERT, UPDATE
AS
BEGIN
    -- ��������� ������ � ����� ������ �� � ������ 15 ���� ������
    IF EXISTS (
        SELECT 1 
        FROM inserted
        WHERE DATA_ORDER IS NOT NULL
        AND DATEPART(day, DATA_ORDER) > 15
    )
    BEGIN
        -- ���������� ���������� � ������� ��������� �� ������
        ROLLBACK TRANSACTION;
        RAISERROR('������ ����������� ������ � ������ 15 ���� ������!', 16, 1); -- (���������, ������� �����������, ���������)
        RETURN;
    END
END;
 -- ���������
-- ������ ��������� �������
INSERT INTO CUSTOMERS (IDCUST, CUST_NUM, COMPANY, DATA_ORDER)
VALUES (5, '214', '�������� ��������', '2023-05-10');

-- ������ ������� ������
INSERT INTO CUSTOMERS (IDCUST, CUST_NUM, COMPANY, DATA_ORDER)
VALUES (6, '215', '�������� ��������', '2023-20-05');

SELECT * FROM CUSTOMERS;