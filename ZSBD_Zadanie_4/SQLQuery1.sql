-- Martyna Piasecka 224398
-- Julia Szymañska 224441

-- 1. --
DECLARE @text VARCHAR(20)
SET @text = 'Czesc, to ja'
PRINT @text

-- 2. --
DECLARE @number INT
SET @number = 8
PRINT 'Zmienna = ' + CONVERT(VARCHAR(5), @number) +  CHAR(10)			-- CHAR(10) daje now¹ liniê
GO

-- 3. --
DECLARE @variable INT
SET @variable = 10

IF (@variable = 10)
	PRINT 'Zmienna ma wartosc 10' +  CHAR(10)
ELSE
	PRINT 'Zmienna ma wartosc rozna od 10' +  CHAR(10)
GO

-- 4. --
DECLARE @i INT
SET @i = 1

WHILE (@i < 5)
	BEGIN
		PRINT 'Zmienna ma wartosc ' + CONVERT(VARCHAR(1), @i)
		SET @i = @i + 1
	END
GO

-- 5. -- 
DECLARE @j INT
SET @j = 3

WHILE (@j < 8)
	BEGIN
		IF(@j = 3)
			PRINT CHAR(10) + 'poczatek'

		IF (@j = 5)
			PRINT 'srodek'

		IF (@j = 7)
			PRINT 'koniec'

		PRINT @j
		SET @j = @j + 1
	END
GO

-- 6. --
IF exists(SELECT 1 FROM master.dbo.sysdatabases WHERE NAME = 'testowa') DROP DATABASE testowa
GO
CREATE DATABASE testowa
GO

USE testowa

CREATE TABLE oddzialy (
nr_odd INT PRIMARY KEY,
nazwa_odd VARCHAR(30) NOT NULL 
)

INSERT INTO oddzialy
VALUES('1','Marketing');
INSERT INTO oddzialy
VALUES('2','Sprzedaz');
INSERT INTO oddzialy
VALUES('3','Kontrola towaru');
INSERT INTO oddzialy
VALUES('4','Fabryka');
INSERT INTO oddzialy
VALUES('5','Pomoc');
INSERT INTO oddzialy
VALUES('6','Wysylka');
GO

-- 7. --
DECLARE @id INT
SET @id = 2
DECLARE @name VARCHAR(20)
BEGIN 
	SET @name = (SELECT nazwa_odd FROM oddzialy
				WHERE nr_odd = @id)
	PRINT 'Nazwa oddzialu to: ' + @name
END

-- 8. --
DECLARE kursor CURSOR FOR
SELECT * FROM oddzialy
DECLARE @nazwa VARCHAR(20), @nr INT
OPEN kursor
FETCH NEXT FROM kursor INTO @nr, @nazwa
WHILE @@FETCH_STATUS = 0
	BEGIN 
		PRINT 'Numer oddzialy to: ' + CONVERT(VARCHAR(2), @nr) + ', nazwa oddzialu to: ' + @nazwa	
		FETCH NEXT FROM kursor INTO @nr, @nazwa
	END
CLOSE kursor
DEALLOCATE kursor

-- 9. --
DECLARE @liczba INT, @nr_del INT
SET @liczba = 0
DECLARE kursor_del CURSOR FOR
SELECT nr_odd FROM oddzialy
OPEN kursor_del
FETCH NEXT FROM kursor_del INTO @nr_del
WHILE @@FETCH_STATUS = 0
	BEGIN 
		IF @nr_del > 2
			BEGIN
				DELETE FROM oddzialy WHERE nr_odd = @nr_del
				SET @liczba = @liczba + 1
				PRINT 'Liczba usunietych rekordow: ' +  CONVERT(VARCHAR(2), @liczba)
			END
		FETCH NEXT FROM kursor_del INTO @nr_del
	END
CLOSE kursor_del
DEALLOCATE kursor_del

-- 10. --
DECLARE @istnieje BIT, @nr_update INT, @nr_selected INT
SET @nr_selected = 3
SET @istnieje = 0
DECLARE kursor_up CURSOR FOR
	SELECT nr_odd FROM oddzialy
BEGIN
	OPEN kursor_up
	FETCH NEXT FROM kursor_up INTO @nr_update
	WHILE @@FETCH_STATUS = 0
		BEGIN 
			IF @nr_update = @nr_selected
				BEGIN
					UPDATE oddzialy SET nazwa_odd = 'Zmieniony' WHERE nr_odd = @nr_update
					SET @istnieje = 1
				END	
			FETCH NEXT FROM kursor_up INTO @nr_update
		END
	CLOSE kursor_up
	DEALLOCATE kursor_up
	IF @istnieje = 0
		INSERT INTO oddzialy VALUES('3','NowoDodany');
END