ALTER TABLE PREDMETS_25
ADD CONSTRAINT CK_PREDMETS_25_PNAME CHECK (
	PNAME IN (
		N'������', 
		N'�����', 
		N'����������', 
		N'���������', 
		N'���������'
	)
);
