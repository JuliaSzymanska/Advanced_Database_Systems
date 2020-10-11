-- Martyna Piasecka 224398
-- Julia Szymañska 224441

USE narciarze;
GO

--1--
DECLARE @zapytanie VARCHAR(MAX)
SET @zapytanie = ''
SELECT @zapytanie = @zapytanie + ' SELECT * FROM ' + QUOTENAME(name) FROM sys.tables
EXEC(@zapytanie)
GO

--2--
SELECT kraj FROM kraje
WHERE id_kraju NOT IN (SELECT id_kraju FROM zawodnicy);
GO

--3--
SELECT kraj, COUNT(*) AS liczba FROM kraje, zawodnicy
WHERE (kraje.id_kraju = zawodnicy.id_kraju)
GROUP BY kraj
GO

--4--
SELECT nazwisko FROM zawodnicy
WHERE id_skoczka NOT IN (SELECT id_skoczka FROM uczestnictwa_w_zawodach);
GO

--5--
SELECT z.nazwisko, COUNT(z.id_skoczka) AS ile FROM zawodnicy z, uczestnictwa_w_zawodach u
WHERE z.id_skoczka = u.id_skoczka
GROUP BY nazwisko;
GO

--6--
SELECT z.nazwisko, s.nazwa FROM zawodnicy z, uczestnictwa_w_zawodach u, zawody, skocznie s
WHERE z.id_skoczka = u.id_skoczka
	AND u.id_zawodow = zawody.id_zawodow
	AND zawody.id_skoczni = s.id_skoczni
GROUP BY nazwisko, nazwa;
GO

--7--
SELECT nazwisko, DATEDIFF(year,  data_ur, GETDATE()) AS wiek FROM zawodnicy
ORDER BY wiek DESC;
GO

--8--
SELECT nazwisko, MIN(YEAR(DATA) - YEAR(data_ur)) AS wiek
FROM zawodnicy, zawody, uczestnictwa_w_zawodach
WHERE zawodnicy.id_skoczka = uczestnictwa_w_zawodach.id_skoczka
	AND uczestnictwa_w_zawodach.id_zawodow = zawody.id_zawodow
GROUP BY nazwisko
GO

--9--
SELECT nazwa, (sedz - k) as odl FROM skocznie
ORDER BY odl DESC
GO

--10--
SELECT TOP 1 nazwa, (sedz - k) as odl FROM skocznie, zawody
WHERE skocznie.id_skoczni = zawody.id_skoczni
ORDER BY k DESC
GO

--11--
SELECT DISTINCT kraj FROM kraje, zawody, skocznie
WHERE kraje.id_kraju = skocznie.id_kraju
	AND skocznie.id_skoczni = zawody.id_skoczni
GO

--12--
SELECT nazwisko, kraj, COUNT(*) AS ile FROM zawodnicy, kraje k, skocznie s, zawody, uczestnictwa_w_zawodach u
WHERE k.id_kraju = s.id_kraju
	AND k.id_kraju = zawodnicy.id_kraju
	AND s.id_skoczni = zawody.id_skoczni
	AND zawodnicy.id_skoczka = u.id_skoczka
	AND zawody.id_zawodow = u.id_zawodow
GROUP BY nazwisko, kraj
ORDER BY nazwisko
GO

--13--
INSERT INTO trenerzy VALUES (7, 'Corby', 'Fisher', '1975-07-20');
GO

--14--
ALTER TABLE zawodnicy 
ADD trener int 
GO

--15-- 
 UPDATE zawodnicy 
 SET zawodnicy.trener = trenerzy.id_trenera
 FROM zawodnicy INNER JOIN trenerzy ON zawodnicy.id_kraju = trenerzy.id_kraju
GO

--16--
ALTER TABLE zawodnicy
ADD CONSTRAINT FKTrenerzyZawodnicy FOREIGN KEY (trener) REFERENCES trenerzy(id_trenera)
GO

--17--
UPDATE trenerzy
SET data_ur_t = (	SELECT TOP 1 DATEADD(YEAR, -5, data_ur) 
					FROM zawodnicy 
					ORDER BY data_ur DESC )
WHERE data_ur_t IS NULL
GO