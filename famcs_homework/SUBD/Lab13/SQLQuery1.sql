-- ������� 1
-- ����������� � �������

-- ������� 2
Exec sp_helpsrvrole; -- ���������� ������ ����� �������

-- ������� 3
EXEC sp_addlogin 'TempUser_25', 'password'; -- ��� ���������� ������� ������ �������
EXEC sp_helplogins; -- ������ ������� �������
EXEC sp_addsrvrolemember 'TempUser_25', 'securityadmin'; -- ��� ���������� ����

-- ������� 4
USE [2_Shuman_LW_8];
EXEC sp_helprole; -- ���������� ������ ����� ���� ������
EXEC sp_helprolemember 'db_owner'; -- ���������� ������ ���� � ��

-- ������� 5
EXEC sp_adduser 'TempUser_25', 'MyFirstUser'; -- ������� ������ ������������ �� ��� ������ 
EXEC sp_helpuser; -- ���������, ��� ������������ ��� ��������
EXEC sp_addrolemember 'db_datareader', 'MyFirstUser'; -- ������� ��� ����

-- ������� 6
CREATE LOGIN Andy WITH PASSWORD = 'SecurePassword!';
USE [2_Shuman_LW_8]; 
CREATE USER Andy FOR LOGIN Andy;

GRANT SELECT, UPDATE ON [2_Shuman_LW_8].dbo.STUDENTS_25 TO Andy; -- ������������� ����� ������� � ��������� ������ ������� ��� Andy

GRANT SELECT (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 TO Andy;
GRANT UPDATE (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 TO Andy;

-- ��������� �� ���������
SELECT * FROM sys.database_permissions 
WHERE grantee_principal_id = DATABASE_PRINCIPAL_ID('Andy');

-- ������� 7
-- ����������� �������������� UI 

-- ������� 8
EXEC sp_droprolemember 'db_datareader', 'MyFirstUser';
EXEC sp_dropuser 'MyFirstUser';
EXEC sp_dropsrvrolemember 'TempUser_25', 'securityadmin';
EXEC sp_droplogin 'TempUser_25';

-- ��� �� ������ ������������ Andy
-- ������� ��� �����
REVOKE SELECT, UPDATE ON [2_Shuman_LW_8].dbo.STUDENTS_25 FROM Andy;
REVOKE SELECT (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 FROM Andy;
REVOKE UPDATE (SFAM, STIP) ON [2_Shuman_LW_8].dbo.STUDENTS_25 FROM Andy;
-- ������� �� ��
USE [2_Shuman_LW_8];
DROP USER Andy;
--������� �� �������
DROP LOGIN Andy;

-- ���� ����� �������� ���������
EXEC sp_revokedbaccess 'Andy';
EXEC sp_droplogin 'Andy';



