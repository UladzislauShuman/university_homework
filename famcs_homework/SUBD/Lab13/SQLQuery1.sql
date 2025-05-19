-- Задание 1
-- подключение к серверу

-- Задание 2
Exec sp_helpsrvrole; -- Определите список ролей сервера

-- Задание 3
EXEC sp_addlogin 'TempUser_25', 'password'; -- Для добавления учетной записи сервера
EXEC sp_helplogins; -- список логинов сервера
EXEC sp_addsrvrolemember 'TempUser_25', 'securityadmin'; -- для присвоения роли

-- Задание 4
USE [2_Shuman_LW_8];
EXEC sp_helprole; -- определите список ролей базы данных
EXEC sp_helprolemember 'db_owner'; -- определить членов роли в БД

-- Задание 5
EXEC sp_adduser 'TempUser_25', 'MyFirstUser'; -- создать нового пользователя БД для логина 
EXEC sp_helpuser; -- проверить, что пользователь был добавлен
EXEC sp_addrolemember 'db_datareader', 'MyFirstUser'; -- добавим ему роль

-- Задание 6
CREATE LOGIN Andy WITH PASSWORD = 'SecurePassword!';
USE [2_Shuman_LW_8]; 
CREATE USER Andy FOR LOGIN Andy;

GRANT SELECT, UPDATE ON [2_Shuman_LW_8].dbo.STUDENTS_25 TO Andy; -- предоставляем права Выборки и Изменения данных таблицы для Andy

GRANT SELECT (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 TO Andy;
GRANT UPDATE (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 TO Andy;

-- посмотрим на результат
SELECT * FROM sys.database_permissions 
WHERE grantee_principal_id = DATABASE_PRINCIPAL_ID('Andy');

-- Задание 7
-- выполняется использованием UI 

-- Задание 8
EXEC sp_droprolemember 'db_datareader', 'MyFirstUser';
EXEC sp_dropuser 'MyFirstUser';
EXEC sp_dropsrvrolemember 'TempUser_25', 'securityadmin';
EXEC sp_droplogin 'TempUser_25';

-- так же удалим пользователя Andy
-- удалить его права
REVOKE SELECT, UPDATE ON [2_Shuman_LW_8].dbo.STUDENTS_25 FROM Andy;
REVOKE SELECT (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 FROM Andy;
REVOKE UPDATE (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 FROM Andy;
-- удалить из БД
USE [2_Shuman_LW_8];
DROP USER Andy;
--удалить из Сервера
DROP LOGIN Andy;

-- либо через хранимые процедуры
EXEC sp_revokedbaccess 'Andy';
EXEC sp_droplogin 'Andy';



