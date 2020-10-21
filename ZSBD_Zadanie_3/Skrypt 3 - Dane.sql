INSERT INTO bibliotekaa.dbo.czytelnicy
VALUES('TJ123','Tkaczyk','Jerzy','64101500456', '1964/10/15', 'M','0427650912');
INSERT INTO bibliotekaa.dbo.czytelnicy
VALUES('KM090','Krawczyk','Monika','76051900953','1976/05/19', 'K','0238651112');
INSERT INTO bibliotekaa.dbo.czytelnicy
VALUES('MM009','Maczyk','Marta','78070900953','1978/09/07', 'K','0427770822');
INSERT INTO bibliotekaa.dbo.czytelnicy
VALUES('BJ111','Balcerek','Janusz','62090200953','1962/02/09', 'M','0123310345');
INSERT INTO bibliotekaa.dbo.czytelnicy
VALUES('DM212','Daniec','Micha³','67032000322','1967/03/20', 'M','0231510885');
GO
SELECT count(*) FROM bibliotekaa.dbo.czytelnicy;
GO
SELECT * FROM bibliotekaa.dbo.czytelnicy;
GO
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Borsuk','Jan','1965/10/21','1999/06/11');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Kotecki','Adam','1968/11/21','1998/10/01');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Olek','Tadeusz','1975/10/23','2001/03/05');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Kraska','Adam','1975/06/02','2001/10/21');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Lisiak','Anna','1968/12/05','1998/01/01');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Kowalska','Ewa','1979/05/11','2001/09/05');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Nowaczyk','Maria','1963/08/14','1998/01/01');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Marczyk','Barbara','1984/03/18','2002/03/01');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Kraska','Katarzyna','1983/06/07','2002/09/15');
INSERT INTO bibliotekaa.dbo.pracownicy
VALUES('Michalak','Anna','1970/08/17','2001/03/04');
GO
SELECT COUNT(*) FROM bibliotekaa.dbo.pracownicy;
GO
SELECT * FROM bibliotekaa.dbo.pracownicy;
GO
INSERT INTO bibliotekaa.dbo.wydawnictwa
VALUES ('bibliotekaa.dbo.wydawnictwa Naukowo-Techniczne','Warszawa','635-12-09');
INSERT INTO bibliotekaa.dbo.wydawnictwa
VALUES ('Helion', 'Gliwice','025-22-03');
INSERT INTO bibliotekaa.dbo.wydawnictwa
VALUES ('Pañstwowy Instytut Wydawniczy', 'Warszawa','635-42-11');
INSERT INTO bibliotekaa.dbo.wydawnictwa
VALUES ('Dom Ksi¹¿ki', 'Poznañ','775-24-92');
INSERT INTO bibliotekaa.dbo.wydawnictwa
VALUES ('Wydawnictwo Dzieciom', 'Kraków','305-32-34');
GO
SELECT COUNT(*) FROM bibliotekaa.dbo.wydawnictwa;
GO
SELECT * FROM bibliotekaa.dbo.wydawnictwa;
GO
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(1,1,'Fizyka dla dociekliwych',45.50,320,'ksi¹¿ka naukowa');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(2,2,'Bazy danych dla ka¿dego',68.90, 240,'ksi¹¿ka naukowa');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(3,3,'Bajki na dobranoc',39.90, 120, 'dla dzieci');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(4,3,'Potop', 62.70, 359,'powieœæ historyczna');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(5,3,'Faraon', 55.20, 322,'powieœæ historyczna');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(6,4,'Wojna œwiatów',29.00, 102, 'powieœæ science fiction');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(7,4,'Zag³ada cyborgów', 21.30, 89, 'powieœæ science fiction');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(8,5,'Na jagody', 19.20, 55, 'dla dzieci');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(9,5,'Krasnoludki s¹ na œwiecie', 15.90, 35, 'dla dzieci');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(10,2,'SQL dla ka¿dego', 85.90, 210, 'ksi¹¿ka naukowa');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(11,3,'Ch³opi', 23.20, 384, 'powieœæ');
INSERT INTO bibliotekaa.dbo.ksiazki
VALUES(12,3,'Qvo vadis', 25.40, 245, 'powieœæ historyczna');
GO
SELECT COUNT(*) FROM bibliotekaa.dbo.ksiazki;
GO
SELECT * FROM bibliotekaa.dbo.ksiazki;
GO

INSERT INTO bibliotekaa.dbo.wypozyczenia
VALUES(1,'TJ123',4,'2008/03/01','2008/07/28', 25.50);
INSERT INTO bibliotekaa.dbo.wypozyczenia
VALUES(2,'KM090',2,'2008/03/04','2008/06/18',5.20);
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(3,'MM009',2,'2008/03/04','2008/03/20');
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(8,'MM009',1,'2008/03/20','2008/04/10');
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(8,'KM090',1,'2008/04/12','2008/04/30');
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(4,'BJ111',6,'2008/04/15','2008/06/12');
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(5,'BJ111',6,'2008/04/15','2008/06/12');
INSERT INTO bibliotekaa.dbo.wypozyczenia
VALUES(12,'DM212',6,'2008/08/21','2008/12/21',12.1);
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(5,'DM212',6,'2008/06/21','2008/07/29');
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(10,'DM212',6,'2008/06/21','2008/08/08');
INSERT INTO bibliotekaa.dbo.wypozyczenia
VALUES(10,'TJ123',7,'2008/08/21','2008/11/09',8.80);
INSERT INTO bibliotekaa.dbo.wypozyczenia
VALUES(4,'MM009',7,'2008/08/22','2008/12/18',7.5);
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(2,'DM212',8,'2008/11/16','2009/01/19');
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(2,'DM212',8,'2008/11/17', NULL);
INSERT INTO bibliotekaa.dbo.wypozyczenia (sygn , id_cz, id_p ,data_w, data_z)
VALUES(11,'KM090',9,'2008/11/21', NULL);
GO
SELECT COUNT(*) FROM bibliotekaa.dbo.wypozyczenia;
GO
SELECT * FROM bibliotekaa.dbo.wypozyczenia;
GO
