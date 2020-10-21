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

--1--
-- zwrócone zostanie imiê i nazwisko pracownika o id=1 - zapytanie SELECT
DECLARE @imieP varchar(20), @nazwiskoP varchar(20)
SET @imieP='Teofil'
SET @nazwiskoP='Szczerbaty'
SELECT @imieP=imie, @nazwiskoP=nazwisko from bibliotekaa.dbo.pracownicy where id=1
PRINT @imieP+' '+@nazwiskoP

--2--
-- zostanie wyœwietlone imiê i nazwisko: Teofil Szczerbaty, 
-- nie zostanie przypisana wartoœæ zwrócona przez zapytanie SELECT, 
-- poniewa¿ nie istnieje ¿aden pracownik o id-20
DECLARE @imieP varchar(20), @nazwiskoP varchar(20)
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
If EXISTS (SELECT * FROM bibliotekaa.dbo.wypozyczenia) PRINT('By³y wypo¿yczenia')
ELSE PRINT('Nie by³o ¿adnych wypo¿yczeñ')

--WHILE
DECLARE @y int
SET @y=0
WHILE(@y<10)
BEGIN
	PRINT @y
	if (@y=5) break
	set @y=@y+1
END

--CASE
SELECT tytul AS tytulK, cena as cenaK, [cena jest]=CASE
WHEN cena<20.00 then 'Niska'
WHEN cena between 20.00 and 40.00 THEN 'Przystêpna'
WHEN cena>40 then 'Wysoka'
ELSE 'Nieznana'
END
FROM bibliotekaa.dbo.ksiazki

--NULLIF
/*SELECT COUNT(*) AS [Liczba pracowników],
AVG(NULLIF(zarobki, 0)) AS [Œrednia p³aca],
MIN(NULLIF(zarobki, 0)) AS [P³aca minimalna]
FROM bibliotekaa.dbo.Pracownicy*/

--ISNULL

--B³êdy
raiserror(21000, 10, 1)
print @@error

raiserror(21000, 10, 1) WITH SETERROR
print @@error

raiserror(21000, 11, 1) WITH SETERROR
print @@error

raiserror('Ala ma kota', 11, 1) WITH SETERROR
print @@error

declare @d1 datetime, @d2 datetime
set @d1 = '20091020'
set @d2 = '20091025'

select dateadd(hour, 112, @d1)
select dateadd(day, 112, @d1)

select datediff(minute, @d1, @d2)
select datediff(day, @d1, @d2)

select datename(month, @d1)
select datepart(month, @d1)

select cast(day(@d1) as varchar)
+ '-' + cast(month(@d1) as varchar) + '-' + cast(year(@d1) as varchar)


select COL_LENGTH('bibliotekaa..pracownicy', 'imie')
select datalength(2+3.4)
select db_id('master')
select db_name(1)
select user_id()
select user_name()
select host_id()
select host_name()
use bibliotekaa;
select object_id('Pracownicy')
select object_name(object_id('Pracownicy'))

--1--
if exists(select 1 from master.dbo.sysdatabases where name = 'test_cwiczenia')
drop database test_cwiczenia
go
create database test_cwiczenia
go
use test_cwiczenia
go
create table test_cwiczenia..liczby ( liczba int )
go
declare @i int
set @i=1 
while @i<100
begin
	insert test_cwiczenia..liczby values( @i )
	set @i=@i+1
end
go
select * from test_cwiczenia..liczby; 