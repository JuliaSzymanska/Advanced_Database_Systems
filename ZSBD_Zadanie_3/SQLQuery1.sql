use bibliotekaa
select * from  bibliotekaa.dbo.pracownicy
DECLARE @x int, @s varchar(10)

SET @x=10
SET @s='napis'

PRINT @x+3
PRINT @s

-- zostanie wyœwietlone imiê i nazwisko ostatniego rekordu w tabeli spe³niaj¹cego warunek (id=7), w tym przypadku jest to tylko jeden rekord
DECLARE @imieP varchar(20), @nazwiskoP varchar(20)
SELECT @imieP=imie, @nazwiskoP=nazwisko from bibliotekaa.dbo.pracownicy where id=7
PRINT @imieP+' '+@nazwiskoP

-- dane zostana przepisane z ostatniego (10) wiersza
--DECLARE @imieP varchar(20), @nazwiskoP varchar(20)
SELECT @imieP=imie, @nazwiskoP=nazwisko from bibliotekaa..pracownicy
PRINT @imieP+' '+@nazwiskoP

--1--
-- zwrócone zostanie imiê i nazwisko pracownika o id=1 - zapytanie SELECT
--DECLARE @imieP varchar(20), @nazwiskoP varchar(20)
SET @imieP='Teofil'
SET @nazwiskoP='Szczerbaty'
SELECT @imieP=imie, @nazwiskoP=nazwisko from bibliotekaa.dbo.pracownicy where id=1
PRINT @imieP+' '+@nazwiskoP

--2--
-- zostanie wyœwietlone imiê i nazwisko: Teofil Szczerbaty, 
-- nie zostanie przypisana wartoœæ zwrócona przez zapytanie SELECT, 
-- poniewa¿ nie istnieje ¿aden pracownik o id=20
--DECLARE @imieP varchar(20), @nazwiskoP varchar(20)
SET @imieP='Teofil'
SET @nazwiskoP='Szczerbaty'
SELECT @imieP=imie, @nazwiskoP=nazwisko FROM bibliotekaa.dbo.pracownicy WHERE id=20
PRINT @imieP+' '+@nazwiskoP

--WAITFOR
CREATE TABLE bibliotekaa.dbo.liczby (licz1 int, czas DATETIME DEFAULT getdate());
GO
DECLARE @x int
set @x=2
insert into bibliotekaa.dbo.liczby(licz1) VALUES (@x);
WAITFOR DELAY '00:00:10'
INSERT INTO bibliotekaa.dbo.liczby(licz1) values (@x+2);
SELECT * FROM bibliotekaa.dbo.liczby;

--IF..ELSE
IF EXISTS (SELECT * FROM bibliotekaa.dbo.wypozyczenia) PRINT('By³y wypo¿yczenia')
ELSE PRINT('Nie by³o ¿adnych wypo¿yczeñ')

--WHILE
DECLARE @y INT
SET @y=0
WHILE(@y<10)
BEGIN
	PRINT @y
	IF (@y=5) BREAK
	SET @y=@y+1
END

--CASE
SELECT tytul AS tytulK, cena AS cenaK, [cena jest]=CASE
WHEN cena < 20.00 then 'Niska'
WHEN cena BETWEEN 20.00 AND 40.00 THEN 'Przystêpna'
WHEN cena > 40 then 'Wysoka'
ELSE 'Nieznana'
END
FROM bibliotekaa.dbo.ksiazki

--NULLIF - zwraca wartoœæ zero, jesli dwa wyra¿enia sa równe, jesli nie, to zwraca pierwsz¹ wartoœæ
SELECT COUNT(*) AS [Liczba pracowników],
AVG(NULLIF(zarobki, 0)) AS [Œrednia p³aca],
MIN(NULLIF(zarobki, 0)) AS [P³aca minimalna]
FROM bibliotekaa.dbo.Pracownicy

--NULLIF - w³asny przyk³ad
SELECT COUNT(*) AS [Liczba czytelników],
AVG(NULLIF(year(getdate()) - year(data_ur), 0)) AS [Œredni wiek],
MIN(NULLIF(year(getdate()) - year(data_ur), 0)) AS [Minimalny wiek],
MAX(NULLIF(year(getdate()) - year(data_ur), 0)) AS [Maksymalny wiek]
FROM czytelnicy

--ISNULL - poni¿szy przyk³ad nie zadzia³a, bo nie dotyczy tej bazy danuych, na której dzia³amy
/*SELECT title, pub_id, ISNULL(price, (SELECT MIN(price) FROM pubs..titles))
FROM pubs..titles */

--ISNULL - zastêpuje pierwsze wyra¿enie (jeœli jest NULL) wartoœci¹ wyra¿enia drugiego
-- w³asny przyk³ad
SELECT nazwa, ISNULL(telefon, 111-222-333) AS telefon
FROM wydawnictwa

--B³êdy- raiserror - generuje komunikat o b³êdzie i inicjuje jego przetwarzanie
-- raiseerror(1,2,3) :	1 - zdefiniowany przez u¿ytkownika numer komunikatu o b³êdzie, wartoœæ > 50000 (jesli nie ma to domyœlnie 50000)
--						2 - poziom wa¿noœci b³êdu, 0-10 informational messages, 11-18 errors, 19-25 fatal errors 
--						3 - state, najczêsciej wartoœæ równa 1
raiserror(21000, 10, 1)
print @@error

-- seterror ustawia wartoœæ 1

raiserror(21000, 10, 1) WITH SETERROR
print @@error

raiserror(21000, 11, 1) WITH SETERROR
print @@error

raiserror('Ala ma kota', 11, 1) WITH SETERROR
print @@error 

DECLARE @d1 DATETIME, @d2 DATETIME
SET @d1 = '20091020'
SET @d2 = '20091025'

-- dateadd(jaka czêœæ daty, ile dodaæ/obj¹æ, do czego)

SELECT DATEADD(HOUR, 112, @d1)
SELECT DATEADD(DAY, 112, @d1)

-- datediff(jaka czêœæ daty, pierwsza data, druga data) - pokazuje jaki interwa³ czasu ró¿nicy jest miêdzy datami

SELECT DATEDIFF(MINUTE, @d1, @d2)
SELECT DATEDIFF(DAY, @d1, @d2)

SELECT DATENAME(MONTH, @d1) -- nazwa miesi¹ca
SELECT DATEPART(MONTH, @d1) -- numer miesi¹ca

SELECT CAST(DAY(@d1) AS VARCHAR) + '-' + CAST(MONTH(@d1) AS VARCHAR) + '-' + CAST(YEAR(@d1) AS VARCHAR)

-- zwraca d³ugoœæ wyra¿enia
SELECT COL_LENGTH('bibliotekaa..pracownicy', 'imie')

-- zwraca liczbê bitów, które reprezentuj¹ wyra¿enie
SELECT DATALENGTH(2+3.4)

-- zwraca identyfikator bazy danych
SELECT DB_ID('master')

-- zwraca nazwê bazy danych 
SELECT DB_NAME(1)

-- zwraca numer identyfikacyjny u¿ytkownika bazy danych
SELECT USER_ID()

-- zwraca numer identyfikacyjny stacji roboczej, czyli procesu, który ³¹czy siê z serwerem SQL
SELECT HOST_ID()

-- zwraca nazwê stacji roboczej, która ³¹czy siê z serwerem SQL
SELECT HOST_NAME()

USE bibliotekaa;

-- zwraca numer identyfikacyjny obiektu bazy danych dla danego schematu
SELECT OBJECT_ID('Pracownicy')

-- zwraca nazwê obiektu bazy danych dla danego schematu
SELECT OBJECT_NAME(OBJECT_ID('Pracownicy'))

-- 1. --
IF EXISTS(SELECT 1 FROM master.dbo.sysdatabases WHERE name = 'test_cwiczenia')
DROP DATABASE test_cwiczenia
GO
CREATE DATABASE test_cwiczenia
GO
USE test_cwiczenia
GO
CREATE TABLE test_cwiczenia..liczby (liczba INT)
GO
DECLARE @i INT
SET @i = 1
WHILE @i < 100
BEGIN
	INSERT test_cwiczenia..liczby VALUES(@i)
	SET @i = @i + 1
END
GO
SELECT * FROM test_cwiczenia..liczby;

-- 2. --
USE test_cwiczenia
GO
IF EXISTS(SELECT 1 FROM sys.objects WHERE TYPE = 'P' AND name = 'proc_liczby')
DROP PROCEDURE proc_liczby 
GO
CREATE PROCEDURE proc_liczby @max INT = 10
AS
BEGIN
	SELECT liczba FROM test_cwiczenia..liczby
	WHERE liczba <= @max
END
GO
EXEC test_cwiczenia..proc_liczby 3
EXEC test_cwiczenia..proc_liczby
GO

-- 3. --
USE test_cwiczenia
GO
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'proc_statystyka')
DROP PROCEDURE proc_statystyka
GO
CREATE PROCEDURE proc_statystyka @max INT OUTPUT, @min INT OUTPUT, @aux INT OUTPUT
AS
BEGIN
	SET @max = (SELECT MAX(liczba) FROM test_cwiczenia..liczby)
	SET @min = (SELECT MIN(liczba) FROM test_cwiczenia..liczby)
	SET @aux = 10
END
GO
DECLARE @max INT, @min INT, @aux2 INT
EXEC test_cwiczenia..proc_statystyka @max OUTPUT, @min OUTPUT, @aux = @aux2 OUTPUT
SELECT @max 'Max', @min 'Min', @aux2
GO

-- 1 -- w³asny przyk³ad
--DROP FUNCTION podajcene

GO
CREATE FUNCTION podajcene(@nazwa VARCHAR(40))
	RETURNS MONEY
BEGIN
	RETURN (SELECT cena FROM bibliotekaa..Ksiazki WHERE tytul = @nazwa)
END
GO

SELECT dbo.podajcene('Potop')

-- 2 -- w³asny przyk³ad
--DROP FUNCTION funkcja 

GO
CREATE FUNCTION funkcja(@max MONEY) 
	RETURNS TABLE
RETURN (SELECT *
		FROM bibliotekaa..Ksiazki 
		WHERE cena <= @max)
GO

SELECT * FROM funkcja(50)