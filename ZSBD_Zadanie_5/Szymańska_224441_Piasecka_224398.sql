-- Martyna Piasecka 224398
-- Julia Szymañska 224441

USE test_pracownicy

-- 1. --
CREATE TABLE dziennik (
	tabela		VARCHAR(15)		NOT NULL,
	data		DATE			NOT NULL,
	l_wierszy	INT				NOT NULL,
	komunikat	VARCHAR(300)	NOT NULL
);

-- 2. --

-- Roziwazanie prowadzacego --
BEGIN 
    DECLARE @premia int, @zmiany int
    SET @premia = 1000
    SET @zmiany = 0
    UPDATE pracownicy SET placa = placa + @premia WHERE nr_akt IN (SELECT DISTINCT kierownik FROM pracownicy WHERE kierownik IS NOT NULL)
    SET @zmiany = @zmiany + (SELECT COUNT(nr_akt) FROM pracownicy WHERE nr_akt IN (SELECT DISTINCT kierownik FROM pracownicy WHERE kierownik IS NOT NULL))
    INSERT INTO dziennik VALUES ('pracownicy', getdate(), @zmiany, 'Wprowadzono dodatek funkcyjny w wysokoœci ' + CAST(@premia AS varchar))
END
-- Koniec --

SELECT nr_akt, placa 
FROM pracownicy
WHERE nr_akt IN 
			(SELECT DISTINCT kierownik
			FROM pracownicy WHERE kierownik IS NOT NULL)

DECLARE @premia INT, @iterator INT, @nr INT
DECLARE kursor CURSOR FOR
	SELECT nr_akt FROM pracownicy
	WHERE nr_akt IN 
			(SELECT DISTINCT kierownik
			FROM pracownicy WHERE kierownik IS NOT NULL)
BEGIN
	SET @premia = 550
	SET @iterator = 0

	OPEN kursor
	FETCH NEXT FROM kursor INTO @nr
	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE pracownicy
			SET placa = placa + @premia
			WHERE CURRENT OF kursor
			SET @iterator = @iterator + 1
			FETCH NEXT FROM kursor INTO @nr
		END
	CLOSE kursor
	DEALLOCATE kursor
END

INSERT INTO test_pracownicy.dbo.dziennik 
VALUES	('pracownicy',
		GETDATE(), 
		@iterator, 
		'Wprowadzono dodatek funkcyjny w wysokosci ' + 
		CAST( @premia AS VARCHAR) + 
		' dla ' +
		CAST(@iterator AS VARCHAR) +
		' pracowników')


SELECT nr_akt, placa 
FROM pracownicy 
WHERE nr_akt IN 
		(SELECT DISTINCT kierownik 
		FROM pracownicy)

SELECT * FROM dziennik
GO

-- 3. --
DECLARE @rok INT, @l_prac INT
BEGIN
	SET @rok = 1989
	SET @l_prac = 
		(SELECT COUNT(*)
		FROM pracownicy
		WHERE YEAR(data_zatr) = @rok)

	IF (@l_prac > 0)
		INSERT INTO dziennik
		VALUES	('pracownicy', 
				GETDATE(), 
				@l_prac, 
				'Zatrudniono ' + 
				CAST(@l_prac AS VARCHAR) + 
				' pracowników w roku ' + 
				CAST(@rok AS VARCHAR))
	ELSE
		INSERT INTO dziennik
		VALUES	('pracownicy', 
				GETDATE(), 
				@l_prac, 
				'Nikogo nie zatrudniono w ' + 
				CAST(@rok AS VARCHAR))
END
SELECT * FROM dziennik
GO

-- 4. --
DECLARE @number INT
BEGIN
	SET @number = 8902
	IF (YEAR(GETDATE()) - (SELECT YEAR(data_zatr) 
							FROM pracownicy 
							WHERE nr_akt = @number) > 15)
		INSERT INTO dziennik
		VALUES	('pracownicy',
				GETDATE(),
				'1',
				'Pracownik ' +
				CAST(@number AS VARCHAR) +
				' jest zatrudniony d³u¿ej ni¿ 15 lat')
	ELSE
		INSERT INTO dziennik
			VALUES	('pracownicy',
					GETDATE(),
					'1',
					'Pracownik ' +
					CAST(@number AS VARCHAR) +
					' jest zatrudniony krócej ni¿ 15 lat')
END
SELECT * FROM dziennik
GO

-- 5. --
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'PIERWSZA')
DROP PROCEDURE PIERWSZA
GO

CREATE PROCEDURE PIERWSZA @param INT
AS
	PRINT 'Wartosc parametru wynosila: ' + CAST(@param AS VARCHAR)
GO

BEGIN
	DECLARE @variable INT = 11
	EXEC PIERWSZA @variable
END
GO

-- 6. --
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'DRUGA')
DROP PROCEDURE DRUGA
GO

CREATE PROCEDURE DRUGA @wejsciowy_var_char VARCHAR(30) = NULL, @wyjsciowy_var_char VARCHAR(40) OUTPUT, @wejsciowy_int INT = 1
AS
BEGIN
	DECLARE @druga VARCHAR(20) = 'DRUGA'
	SET @wyjsciowy_var_char = @druga + ' ' + ISNULL(@wejsciowy_var_char, '') + ' ' + CAST(@wejsciowy_int AS VARCHAR)
END
GO

BEGIN
	DECLARE @zwrocona_wartosc VARCHAR(40)
	EXEC DRUGA @wejsciowy_var_char = 'TEST', @wyjsciowy_var_char = @zwrocona_wartosc OUTPUT, @wejsciowy_int = 22
	PRINT @zwrocona_wartosc
END

-- 7. --
IF EXISTS(SELECT 1 FROM sys.objects WHERE type = 'P' AND name = 'PODWYZKA')
DROP PROCEDURE PODWYZKA
GO

CREATE PROCEDURE PODWYZKA @id_dzialu INT = 0, @procent INT = 0
AS
BEGIN
	IF @id_dzialu != 0
		BEGIN
			DECLARE kursor_placa CURSOR FOR
				SELECT placa FROM pracownicy
				WHERE id_dzialu = @id_dzialu
		END
	ELSE
		BEGIN 
			DECLARE kursor_placa CURSOR FOR
				SELECT placa FROM pracownicy
		END
	DECLARE @nr INT, @iterator INT
	BEGIN
		SET @iterator = 0

		OPEN kursor_placa
		FETCH NEXT FROM kursor_placa INTO @nr
		WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE pracownicy
				SET placa = placa * ((100.00 + @procent) / 100.00)
				WHERE CURRENT OF kursor_placa
				SET @iterator = @iterator + 1
				FETCH NEXT FROM kursor_placa INTO @nr
			END
		CLOSE kursor_placa
		DEALLOCATE kursor_placa
	END

	INSERT INTO dziennik 
	VALUES	('pracownicy',
			GETDATE(), 
			@iterator, 
			'Wprowadzono podwyzke o ' + 
			CONVERT(VARCHAR, @procent) + 
			' dla dzialu o id ' +
			CONVERT(VARCHAR, @id_dzialu))

END

SELECT * FROM pracownicy

BEGIN
	EXEC PODWYZKA @procent = 10
END
GO

SELECT * FROM pracownicy
SELECT * FROM dziennik


-- 8. --
GO
CREATE FUNCTION udzial_procentowy (
@id_dzialu AS INT
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @suma MONEY, @suma_dla_dzialu MONEY
	SET @suma = (SELECT SUM(placa) FROM pracownicy)
	SET @suma_dla_dzialu = (SELECT SUM(placa) FROM pracownicy WHERE id_dzialu = @id_dzialu)
	RETURN @suma_dla_dzialu/@suma * 100.0
END
GO
SELECT id_dzialu, [dbo].[udzial_procentowy](id_dzialu) AS udzial_w_budzecie FROM dzialy
GO

-- 9. --
DROP TRIGGER IF EXISTS do_archiwum

CREATE TRIGGER do_archiwum
ON pracownicy
FOR DELETE
AS
	INSERT INTO prac_archiw SELECT * FROM deleted
	SELECT * FROM deleted
GO

SELECT * FROM pracownicy
SELECT * FROM prac_archiw

DELETE FROM pracownicy WHERE nr_akt = 9731

SELECT * FROM pracownicy
SELECT * FROM prac_archiw