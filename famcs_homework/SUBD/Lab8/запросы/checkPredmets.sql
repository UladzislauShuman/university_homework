ALTER TABLE PREDMETS_25
ADD CONSTRAINT CK_PREDMETS_25_PNAME CHECK (
	PNAME IN (
		N'Физика', 
		N'Химия', 
		N'Математика', 
		N'Философия', 
		N'Экономика'
	)
);
