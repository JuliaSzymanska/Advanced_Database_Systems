-- Martyna Piasecka 224398
-- Julia Szymañska 224441

USE biuro;
GO

--1--
DECLARE @zapytanie VARCHAR(MAX)
SET @zapytanie = ''
SELECT @zapytanie = @zapytanie + ' SELECT * FROM ' + QUOTENAME(name) FROM sys.tables
EXEC(@zapytanie)
GO

--2--
SELECT	nieruchomoscnr,

		(SELECT COUNT(*) 
		FROM wizyty
		WHERE (wizyty.nieruchomoscnr = nieruchomosci.nieruchomoscnr)
		) AS ile_wizyt,

		(SELECT COUNT(*) 
		FROM wynajecia
		WHERE (wynajecia.nieruchomoscnr = nieruchomosci.nieruchomoscnr)
		) AS ile_wynajmow

FROM nieruchomosci
GROUP BY nieruchomoscnr
GO

--3--
SELECT	n.nieruchomoscnr, CONVERT(VARCHAR, (n.czynsz * 100 / MIN(w.czynsz)) - 100) + '%' AS podwyzka
FROM nieruchomosci n, wynajecia w
WHERE n.nieruchomoscnr = w.nieruchomoscNr
GROUP BY n.nieruchomoscnr, n.czynsz
GO

--4--


--5--


--6--


