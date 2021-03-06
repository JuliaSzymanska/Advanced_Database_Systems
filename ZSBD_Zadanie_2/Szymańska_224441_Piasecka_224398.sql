-- Martyna Piasecka 224398
-- Julia Szyma�ska 224441

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
SELECT	n.nieruchomoscnr, CONVERT(VARCHAR, (n.czynsz * 100 / (
				SELECT TOP 1 w.czynsz FROM biuro.dbo.wynajecia w 
				WHERE w.nieruchomoscNr = n.nieruchomoscnr 
				ORDER BY w.od_kiedy ASC)) - 100) + '%' AS podwyzka
FROM nieruchomosci n
GO

--4--
SELECT n.nieruchomoscnr, SUM(w.czynsz * (DATEDIFF(month,  w.od_kiedy, w.do_kiedy) + 1)) AS ile  FROM nieruchomosci n, wynajecia w
WHERE w.nieruchomoscNr = n.nieruchomoscnr
GROUP BY n.nieruchomoscnr
GO

--5--
SELECT n.biuroNr, 0.3 * (SUM(w.czynsz * (DATEDIFF(month,  w.od_kiedy, w.do_kiedy) + 1))) AS ile FROM nieruchomosci n, wynajecia w
WHERE w.nieruchomoscNr = n.nieruchomoscnr
GROUP BY n.biuroNr
GO

--6A--
SELECT b.miasto,  COUNT(*)  FROM nieruchomosci n, wynajecia w, biura b 
WHERE n.biuroNr = b.biuroNr
AND n.nieruchomoscnr = w.nieruchomoscNr
GROUP BY b.miasto
ORDER BY COUNT(*) DESC
GO

--6B--
SELECT b.miasto,  SUM(DATEDIFF(day,  w.od_kiedy, w.do_kiedy)) AS przychod FROM nieruchomosci n, wynajecia w, biura b 
WHERE n.biuroNr = b.biuroNr
AND n.nieruchomoscnr = w.nieruchomoscNr
GROUP BY b.miasto
ORDER BY przychod DESC
GO

--7--
SELECT DISTINCT wiz.klientnr, wiz.nieruchomoscnr FROM nieruchomosci, wizyty wiz, wynajecia wyn, klienci
WHERE wiz.nieruchomoscnr = wyn.nieruchomoscNr
AND wiz.klientnr = wyn.klientnr
GO

--8--
SELECT wiz.klientnr, COUNT(wiz.nieruchomoscnr) FROM wizyty wiz
WHERE wiz.data_wizyty < (SELECT MIN(od_kiedy) FROM wynajecia WHERE klientnr = wiz.klientnr)
GROUP BY wiz.klientnr
ORDER BY wiz.klientnr
GO

--9--
SELECT DISTINCT klienci.klientnr FROM klienci, wynajecia
WHERE klienci.klientnr = wynajecia.klientnr
AND klienci.max_czynsz < wynajecia.czynsz

--10--
SELECT DISTINCT biuroNr FROM biura
WHERE biuroNr NOT IN (SELECT biuroNr FROM nieruchomosci)

--11A--
SELECT  (SELECT COUNT(*) 
		FROM personel
		WHERE (plec = 'K')
		) AS panie,

		(SELECT COUNT(*) 
		FROM personel
		WHERE (plec = 'M')
		) AS panowie
GO


--11B--
SELECT DISTINCT	b.biuroNr, 
				(SELECT COUNT(*) 
				FROM personel
				WHERE (plec = 'K')
				AND b.biuroNr = biuroNr
				) AS panie,

				(SELECT COUNT(*) 
				FROM personel
				WHERE (plec = 'M')
				AND b.biuroNr = biuroNr
				) AS panowie
FROM biura b, personel p
WHERE b.biuroNr = p.biuroNr
GO

--11C--
SELECT DISTINCT	miasto, 
				(SELECT COUNT(*) 
				FROM biura, personel
				WHERE (plec = 'K')
				AND biura.biuroNr = personel.biuroNr
				AND biura.miasto = b.miasto
				) AS panie,

				(SELECT COUNT(*) 
				FROM biura, personel
				WHERE (plec = 'M')
				AND biura.biuroNr = personel.biuroNr
				AND biura.miasto = b.miasto
				) AS panowie
FROM biura b, personel p
WHERE b.biuroNr = p.biuroNr
GO

--11D--
SELECT DISTINCT	stanowisko, 
				(SELECT COUNT(*) 
				FROM biura, personel
				WHERE (plec = 'K')
				AND biura.biuroNr = personel.biuroNr
				AND personel.stanowisko = p.stanowisko
				) AS panie,

				(SELECT COUNT(*) 
				FROM biura, personel
				WHERE (plec = 'M')
				AND biura.biuroNr = personel.biuroNr
				AND personel.stanowisko = p.stanowisko
				) AS panowie
FROM biura b, personel p
WHERE b.biuroNr = p.biuroNr
GO