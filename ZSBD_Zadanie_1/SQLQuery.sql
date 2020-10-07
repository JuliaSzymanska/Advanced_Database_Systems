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
SELECT k.kraj, COUNT(id_skoczka) FROM kraje k, zawodnicy z
WHERE k.id_kraju = z.id_kraju
GROUP BY kraj;
GO

--4--
SELECT nazwisko FROM zawodnicy
WHERE id_skoczka NOT IN (SELECT id_skoczka FROM uczestnictwa_w_zawodach);
GO

