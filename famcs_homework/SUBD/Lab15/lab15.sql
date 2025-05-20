-- Вопросы
-- нормально ли, что в результате уменьшения у меня ничего не уменьшилось?

-- Подготовительная часть
-- Задание 1
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

-- Задание 2
sp_addumpdevice 'disk', 'backupdisk','C:\git\university_homework\famcs_homework\SUBD\Lab15\sales.bak';

BACKUP DATABASE Sales TO backupdisk;

-- Самостоятельная работа 

-- Задание 1
--1. Создайте пользователя, имеющего право создания и удаления баз данных.
CREATE LOGIN shumanVO WITH PASSWORD = '1111';
ALTER SERVER ROLE dbcreator ADD MEMBER shumanVO;
-- 2. Создайте новую собственную базу данных, размер основного файла
--которой 5 Мб, размер журнала – 2 Мб. Основной файл может увеличиваться до
--10 Мб c шагом 20%. Объем файла журнала увеличивается до 5 Мб с шагом 1 Мб.
--Расположение файлов на диске – D:\MSSQL\DATA.
-- все необходимые файлы я буду хранить в папке своих ЛР-т

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


--3. Убедитесь, что база данных создана должным образом.
sp_helpdb Shuman_LW_15;

--Задание 2.

---1. Просмотрите список параметров базы данных, которые могут быть установлены. 
SELECT name, value, value_in_use 
FROM sys.configurations;

---2. Просмотрите список установленных параметров созданной Вами базы данных. 
SELECT * FROM sys.database_scoped_configurations;

---3. Определите использование базы данных только владельцем и в режиме поддержки одного пользователя. 
ALTER DATABASE Shuman_LW_15 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- чтоьы вернутся в многопользовательский
ALTER DATABASE Shuman_LW_15 SET MULTI_USER;

---4. Убедитесь в изменении параметров базы данных
EXEC sp_helpdb 'Shuman_LW_15';

--Задание 3.
--1. Переименуйте созданную Вами базу данных.
EXEC sp_renamedb 'Shuman_LW_15', 'Shuman_LW_15_rename';
-- либо можно
ALTER DATABASE Shuman_LW_15 MODIFY NAME = Shuman_LW_15_rename;

EXEC sp_helpdb 'Shuman_LW_15_rename';

--Задание 4. 
---1. Создайте собственную файловую группу. 
ALTER DATABASE Shuman_LW_15_rename
ADD FILEGROUP Shuman_FG;

---2. Для Вашей базы данных определите еще один файл размером 2 Мб и поместите его в созданную рабочую группу. 
ALTER DATABASE Shuman_LW_15_rename
ADD FILE (
    NAME = SHUMAN_ZAD4,
    FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\SHUMAN_ZAD4.ndf',
    SIZE = 2MB,
    FILEGROWTH = 1MB
) TO FILEGROUP Shuman_FG;

---3. Докажите правильность выполненных Вами действий.
USE Shuman_LW_15_rename
GO

sp_helpfilegroup;

--Задание 5. 
---1. Для Вашей созданной базы данных установите возможность автоматического сжатия данных.
-- я бы воспользовался бы sp_dboption, но SQL Server пишет, что его нет (вероятно устарел)
SELECT name, is_auto_shrink_on
FROM sys.databases
WHERE name = 'Shuman_LW_15_rename';

ALTER DATABASE Shuman_LW_15_rename SET AUTO_SHRINK ON;

--Задание 6.
---1. Определите сведения о дисковом пространстве, занимаемом базой данных, созданной в результате выполнения ЛР-11.
USE [02_Shuman_LRL11];
GO 

EXEC sp_spaceused;

---2. Сожмите базу данных так, чтобы она содержала только 25% пространства, доступного ей на текущий момент. 
DBCC SHRINKDATABASE ('02_Shuman_LRL11', 25);

---3. Докажите правильность выполненного действия.
EXEC sp_spaceused;


--Задание 7. 
---1. Для базы данных, созданной в ЛР-11 добавьте еще один файл к файловой группе PRIMARY. 
ALTER DATABASE [02_Shuman_LRL11]
ADD FILE 
(
	NAME = ShumanFile_11,
	FILENAME = 'C:\git\university_homework\famcs_homework\SUBD\Lab15\ShumanFile_11.ndf',
	SIZE = 2MB,
	FILEGROWTH = 1MB
) TO FILEGROUP [PRIMARY];

---2. Выполните сжатие базы данных созданной в ЛР-11. Обоснуйте выбранные Вами параметры. 
DBCC SHRINKDATABASE ('02_Shuman_LRL11', 25);

---3. Докажите, что сжатие базы данных действительно выполнено
USE [02_Shuman_LRL11];
GO 

EXEC sp_spaceused;

--Задание 8. 
---1. Создайте резервную копию базы данных созданной в ЛР-11. Физическое имя устройства резервного копирования: 
-- D:\MSSQL\BACKUP\ЛР-11_backup.bak. 
EXEC sp_addumpdevice 'disk', 'Shuman_LRL11_bak', 'C:\git\university_homework\famcs_homework\SUBD\Lab15\lab11.bak';

SELECT name, physical_name 
FROM sys.backup_devices;


---2. Выполните резервное копирование журнала транзакций базы данных созданной в ЛР-11.
-- полное
BACKUP DATABASE [02_Shuman_LRL11]
TO Shuman_LRL11_bak;
--журнала транзакций
BACKUP LOG [02_Shuman_LRL11]
TO Shuman_LRL11_bak;

--Задание 9. 
---1. Удалите базу данных, созданную в ЛР-11. 
USE	master
GO

ALTER DATABASE [02_Shuman_LRL11] SET SINGLE_USER WITH ROLLBACK IMMEDIATE; -- завершим все подключения
GO

DROP DATABASE [02_Shuman_LRL11];

USE [02_Shuman_LRL11]
GO
---2. Восстановите удаленную базу с устройства с физическим именем ЛР11_backup.bak. 
-- чтобы узнать логические имена файлов для backup
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

---3. Докажите правильность выполненного действия.
USE [02_Shuman_LRL11]
EXEC sp_helpfile;
