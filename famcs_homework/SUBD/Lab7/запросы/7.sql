SELECT COUNT(DISTINCT USP.SNUM)
FROM USP
WHERE	USP.PNUM = 2003 AND
		USP.OCENKA > (
			SELECT AVG(USP.OCENKA)
			FROM USP
			WHERE USP.PNUM = 2003
		);