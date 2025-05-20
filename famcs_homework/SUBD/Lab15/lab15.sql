-- �������
-- ��������� ��, ��� � ���������� ���������� � ���� ������ �� �����������?

-- ���������������� �����
-- ������� 1
CREATE DATABASE Sales
ON 
(
	NAME = Sales_dat,
	FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\saledat.mdf',
	SIZE = 10,
	MAXSIZE = 50,
	FILEGROWTH = 5
)
LOG ON
(
	NAME = Sales_log,
	FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\salelog.ldf',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH = 5MB
);

sp_helpdb Sales;

-- ������� 2
sp_addumpdevice 'disk', 'backupdisk','C:\git\university_homework\famcs_homework\SUBD\Lab15\sales.bak';

BACKUP DATABASE Sales TO backupdisk;

-- ��������������� ������ 

-- ������� 1
--1. �������� ������������, �������� ����� �������� � �������� ��� ������.
CREATE LOGIN shumanVO WITH PASSWORD = '1111';
ALTER SERVER ROLE dbcreator ADD MEMBER shumanVO;
-- 2. �������� ����� ����������� ���� ������, ������ ��������� �����
--������� 5 ��, ������ ������� � 2 ��. �������� ���� ����� ������������� ��
--10 �� c ����� 20%. ����� ����� ������� ������������� �� 5 �� � ����� 1 ��.
--������������ ������ �� ����� � D:\MSSQL\DATA.
-- ��� ����������� ����� � ���� ������� � ����� ����� ��-�

CREATE DATABASE Shuman_LW_15
ON PRIMARY
(
	NAME = Shuman_LW_15_data,
	FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\shuman_dat.mdf',
	SIZE = 5MB,
	FILEGROWTH = 20%
)
LOG ON 
(
	NAME = Shuman_LW_15_log,
	FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\shuman_log.ldf',
	SIZE = 2MB,
	MAXSIZE = 5MB,
	FILEGROWTH = 1MB
);


--3. ���������, ��� ���� ������ ������� ������� �������.
sp_helpdb Shuman_LW_15;

--������� 2.

---1. ����������� ������ ���������� ���� ������, ������� ����� ���� �����������. 
SELECT name, value, value_in_use 
FROM sys.configurations;

---2. ����������� ������ ������������� ���������� ��������� ���� ���� ������. 
SELECT * FROM sys.database_scoped_configurations;

---3. ���������� ������������� ���� ������ ������ ���������� � � ������ ��������� ������ ������������. 
ALTER DATABASE Shuman_LW_15 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- ����� �������� � ���������������������
ALTER DATABASE Shuman_LW_15 SET MULTI_USER;

---4. ��������� � ��������� ���������� ���� ������
EXEC sp_helpdb 'Shuman_LW_15';

--������� 3.
--1. ������������ ��������� ���� ���� ������.
EXEC sp_renamedb 'Shuman_LW_15', 'Shuman_LW_15_rename';
-- ���� �����
ALTER DATABASE Shuman_LW_15 MODIFY NAME = Shuman_LW_15_rename;

EXEC sp_helpdb 'Shuman_LW_15_rename';

--������� 4. 
---1. �������� ����������� �������� ������. 
ALTER DATABASE Shuman_LW_15_rename
ADD FILEGROUP Shuman_FG;

---2. ��� ����� ���� ������ ���������� ��� ���� ���� �������� 2 �� � ��������� ��� � ��������� ������� ������. 
ALTER DATABASE Shuman_LW_15_rename
ADD FILE (
    NAME = SHUMAN_ZAD4,
    FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\SHUMAN_ZAD4.ndf',
    SIZE = 2MB,
    FILEGROWTH = 1MB
) TO FILEGROUP Shuman_FG;

---3. �������� ������������ ����������� ���� ��������.
USE Shuman_LW_15_rename
GO

sp_helpfilegroup;

--������� 5. 
---1. ��� ����� ��������� ���� ������ ���������� ����������� ��������������� ������ ������.
-- � �� �������������� �� sp_dboption, �� SQL Server �����, ��� ��� ��� (�������� �������)
SELECT name, is_auto_shrink_on
FROM sys.databases
WHERE name = 'Shuman_LW_15_rename';

ALTER DATABASE Shuman_LW_15_rename SET AUTO_SHRINK ON;

--������� 6.
---1. ���������� �������� � �������� ������������, ���������� ����� ������, ��������� � ���������� ���������� ��-11.
USE [02_Shuman_LRL11];
GO 

EXEC sp_spaceused;

---2. ������� ���� ������ ���, ����� ��� ��������� ������ 25% ������������, ���������� �� �� ������� ������. 
DBCC SHRINKDATABASE ('02_Shuman_LRL11', 25);

---3. �������� ������������ ������������ ��������.
EXEC sp_spaceused;


--������� 7. 
---1. ��� ���� ������, ��������� � ��-11 �������� ��� ���� ���� � �������� ������ PRIMARY. 
ALTER DATABASE [02_Shuman_LRL11]
ADD FILE 
(
	NAME = ShumanFile_11,
	FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\ShumanFile_11.ndf',
	SIZE = 2MB,
	FILEGROWTH = 1MB
) TO FILEGROUP [PRIMARY];

---2. ��������� ������ ���� ������ ��������� � ��-11. ��������� ��������� ���� ���������. 
DBCC SHRINKDATABASE ('02_Shuman_LRL11', 25);

---3. ��������, ��� ������ ���� ������ ������������� ���������
USE [02_Shuman_LRL11];
GO 

EXEC sp_spaceused;

--������� 8. 
---1. �������� ��������� ����� ���� ������ ��������� � ��-11. ���������� ��� ���������� ���������� �����������: 
-- D:\MSSQL\BACKUP\��-11_backup.bak. 
EXEC sp_addumpdevice 'disk', 'Shuman_LRL11_bak', 'C:\git\university_homework\famcs_homework\SUBD\Lab15\lab11.bak';

SELECT name, physical_name 
FROM sys.backup_devices;


---2. ��������� ��������� ����������� ������� ���������� ���� ������ ��������� � ��-11.
-- ������
BACKUP DATABASE [02_Shuman_LRL11]
TO Shuman_LRL11_bak;
--������� ����������
BACKUP LOG [02_Shuman_LRL11]
TO Shuman_LRL11_bak;

--������� 9. 
---1. ������� ���� ������, ��������� � ��-11. 
USE	master
GO

ALTER DATABASE [02_Shuman_LRL11] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- �������� ��� �����������
GO

DROP DATABASE [02_Shuman_LRL11];

USE [02_Shuman_LRL11]
GO
---2. ������������ ��������� ���� � ���������� � ���������� ������ ��11_backup.bak. 
-- ����� ������ ���������� ����� ������ ��� backup
RESTORE FILELISTONLY
FROM DISK = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\lab11.bak';

USE	master
GO

RESTORE DATABASE [02_Shuman_LRL11]
FROM DISK = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\lab11.bak'
WITH 
    MOVE '02_Shuman_LRL11' TO 'C:\git\university_homework\famcs_homework\SUBD\02_Shuman_LRL11.mdf',
    MOVE 'ShumanFile_11' TO 'C:\git\university_homework\famcs_homework\SUBD\ShumanFile_11.ndf',
    MOVE '02_Shuman_LRL11_log' TO 'C:\git\university_homework\famcs_homework\SUBD\02_Shuman_LRL11_log.ldf',
    REPLACE;

---3. �������� ������������ ������������ ��������.
USE [02_Shuman_LRL11]
EXEC sp_helpfile;
