USE narciarze;
GO

--1--
DECLARE @sqlText VARCHAR(MAX)
SET @sqlText = ''
SELECT @sqlText = @sqlText + ' SELECT * FROM ' + QUOTENAME(name) FROM sys.tables
EXEC(@sqlText)
GO

--2--
SELECT kraj FROM kraje
WHERE id_kraju NOT IN (SELECT id_kraju FROM zawodnicy);
GO

--3--


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

--8--     ---------------- !!!!!!!!!!!!!!!!!!!!!!
SELECT z.nazwisko, DATEDIFF(year, z.data_ur, zawody.DATA) FROM zawody, zawodnicy z,  uczestnictwa_w_zawodach u
WHERE z.id_skoczka = u.id_skoczka
AND u.id_zawodow = zawody.id_zawodow
AND zawody.DATA IN (SELECT DATA FROM (SELECT z.id_skoczka, MIN(zawod.DATA) as DATA FROM zawody zawod, uczestnictwa_w_zawodach uc, zawodnicy z
							WHERE z.id_skoczka = uc.id_skoczka
							AND uc.id_zawodow = zawod.id_zawodow GROUP BY zawod.DATA, z.id_skoczka) AS tab WHERE tab.id_skoczka = z.id_skoczka)
ORDER BY z.nazwisko

--9--
SELECT nazwa, (sedz - k) as odl FROM skocznie
ORDER BY odl DESC