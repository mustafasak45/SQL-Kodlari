-- EXISTS , NOT EXISTS --
-- EXISTS condition subquerylerde kullanilir
-- IN ifadesinin kullanimina benzer
-- EXISTS , NOT EXISTS ifadeleri de altsorgudan getirilen degerlerin icerisinde
--bir degerin olmasi veya olmamasi durumunda islem yapilmasini saglar
-- Exists true false gibidir.Boolean
--Orneklerde bir tabloda olan diger tabloda var olanları veya olmayanları getir dediğinde kullanılır

CREATE TABLE mart
(
	urun_id int,
	musteri_isim varchar(50),
	urun_isim varchar(50)
);
CREATE TABLE nisan
(
	urun_id int ,
	musteri_isim varchar(50),
	urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

select * from mart
select * from nisan

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
--URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.

--ACIKLAMA:Mart ve nisan aylarında aynı urun_id dedigi icin EXISTS'den sonraki sorguda urun_id'ler esitse getir dedik
select urun_id,musteri_isim FROM mart
WHERE EXISTS (SELECT urun_id FROM nisan WHERE nisan.urun_id=mart.urun_id)


--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
--AÇIKLAMA: her iki ayda dedidigi icin EXISTS'den sonraki sorguda her iki aydaki urun_isim kıyaslaması yaptık
SELECT urun_isim,musteri_isim FROM nisan
WHERE EXISTS(SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim)

--Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri
--NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.

SELECT urun_isim,musteri_isim FROM nisan
WHERE NOT EXISTS(SELECT urun_isim FROM mart WHERE mart.urun_isim=nisan.urun_isim)