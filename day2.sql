--Personel isminde bir tablo olusturalım
create table personel(
pers_id int,
isim varchar(30),
sehir VARCHAR(30),	
maas int,	
sirket varchar(20),
adres varchar(50)
);

--varolan personel tablosundan pers_id,sehir,adres fieldlarina sahip personel_adres adinda yeni tablo olusturalım
CREATE table personel_adres
AS
SELECT pers_id, sehir, adres FROM personel;

select * from personel

-- DML --> Data Manupulation Lang.
-- INSERT - UPDATE - DELETE
--Tabloya veri ekleme, tablodan veri güncelleme ve silme işlemlerinde kullanılan komutlar
--INSERT
create table student
(
id varchar(4),
st_name varchar(30),
age int
);
INSERT into student VALUES ('1001','Ali Can',25);
INSERT into student VALUES ('1002','Veli Can',35);
INSERT into student VALUES ('1003','Ayse Can',45);
INSERT into student VALUES ('1004','Derya Can',55);

--INSERT
--Tabloya parcali veri ekleme
insert into student(st_name,age) VALUES ('Mustafa CAN',65);

--UPDATE
--Butun age fieldlarini 85 yapın.
Update student SET age=85;
--İsmi Veli Can olanlari age yi 70 yapın
update student set age=70 where st_name='Ali Can';

--DELETE
--personel_adres tablosundaki verilerin hepsini silin.
DELETE From personel_adres;
--student tablosundaki st_name Veli Can olanlari silin
DELETE FROM student WHERE st_name='Veli Can';
--student tablosundaki age 85'den buyuk olan ve id'si 1001 olanlari silin.
DELETE FROM student WHERE age<85 AND id='1001';


select * from student;

--DQL -->Data Query Lang.
--SELECT
select * from student;
--SELECT KOMUTU WHERE KOSULU
select * from student where age>35;

--TCL -->> Transaction Control Lang.
--Begin -savepoint - rollback - commit
--Transaction veritabani sistemlerinde bir işlem başladiğinda başlar ve işlem bitince sona erer
--Bu işlemler veri tabanı oluşturma, veri silme, veri güncelleme, veriyi geri getirme gibi işlemler olabilir.

CREATE TABLE ogrenciler2
(
id serial,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real
);
select * from ogrenciler2;
--TRANSACTION----
Begin;
insert into ogrenciler2 VALUES (default,'Ali Can','Hasan Can',75.5);
insert into ogrenciler2 VALUES (default,'Canan Gül','Ayşe Şen',90.5);
SAVEPOINT x;
insert into ogrenciler2 VALUES (default,'Kemal Can','Ahmet Can',85.5);
insert into ogrenciler2 VALUES (default,'Ahmet Şen','Ayşe Can',65.5);
ROLLBACK TO x;
select * from ogrenciler2;
COMMIT;

delete from ogrenciler2;

--Transaction kullanımında SERIAL data türü kullanımı tavsiye edilmez.
--savepointten sonra eklediğimiz veride sayaç mantığı ile çalıştığı için
--sayacta en son hangi sayıda kaldıysa ordan devam eder
-- NOT : PostgreSQL de transaction kullanımı için 'Begin' komutuyla başlarız sonrasında tekrar yanlış bir veriyi
-- düzeltmek veya bizim için önemli olan verilerden sonra ekleme yapabilmek için 'SAVEPOINT savepointadi'
-- kullanırız ve bu savepointe dönebilmek için 'ROLLBACK TO savepointismi'
-- komutunu kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki verileri tabloda bize
-- verir ve son olarak Transaction'ı sonlandırmak için mutlaka 'COMMIT' komutu kullanırız. MySQL de
-- transaction olmadanda kullanılır.

-- DML - DELETE -
--DELETE FROM tablo_adi --> Tablo'nun tüm içeriğini siler
-- Veriyi seçerek silmek için WHERE koşulu kullanılır
-- DELETE FROM tablo_adı WHERE sutun_adi = veri --> Tablodaki istediğimiz veriyi siler

CREATE TABLE ogrenciler
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Ali', 99);
--SORU:: id'si 124 olan ögrenciyi silin
delete from ogrenciler where id>124;

--Soru: ismi Kemal Yasa olan satiri siliniz
delete from ogrenciler where isim='Kemal Yasa';

--Soru:ismi Nesibe Yılmaz veya Mustafa Bak olan kayıtlari silelim
delete from ogrenciler where isim='Nesibe Yilmaz' or isim='Mustafa Bak';

--soru: ismi ALi Can ve id'si 123 olan kaydı siliniz
delete from ogrenciler where isim='Ali Can' and id=123;
--Tablodaki tüm verileri silin
Delete from ogrenciler

select * from ogrenciler

-- DELETE - TRUNCATE --
-- TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamını siler.
-- Ancak, seçmeli silme yapamaz
select * from ogrenciler;
TRUNCATE TABLE ogrenciler;

-- DDL - Data Definition Lang.
-- CREATE - ALTER - DROP
-- ALTER TABLE --
-- ALTER TABLE tabloda ADD, TYPE, SET, RENAME veya DROP COLUMNS işlemleri için kullanılır
--Personel isminde bir tablo olusturalım
create table personel(
pers_id int,
isim varchar(30),
sehir VARCHAR(30),	
maas int,	
sirket varchar(20),
adres varchar(50)
);
select * from personel;
select * from isciler;

--SORU: Personel tablosuna cinsiyet Varchar(20) ve yas int seklinde yeni sutunlar ekleyiniz
Alter  table personel add cinsiyet varchar(20), add yas int;

--SORU: Personel tablosundan sirket field'ini siliniz
Alter  table personel drop column sirket;

--SORU: Personel tablosundaki sehir sutununun adını ulke olarak değiştirelim
Alter  table personel RENAME column sehir to ulke;

--SORU: Personel tablosunun adını isciler olarak değiştiriniz
Alter  table personel RENAME to isciler;

--SORU:isciler tablosunu silin
Drop table isciler;

create table isciler(
id int,
ad varchar(20),
soyad varchar(15));
select * from isciler

--  CONSTRANINT -- Kısıtlamalar
--Primary Key-->> Bİr sutunun NULL içermemesini ve sutundaki verilerin BENZERSİZ olmasini saglar(NOT NULL - UNIQUE)
--Foregin Key-->> Baska bir tablodaki PRIMARY KEY'i referans gostermek icin kullanılır
--Boylelikle, tablolar arasinda ilişki kurmus oluruz.
--UNIQUE--> Bir sutundaki tüm degerlerin BENZERSİZ yani tek olmasini saglar
--NOT NULL -->> Bir sutundaki NULL içermemesini yani boş olmamasini saglar
--NOT NULL kısıtlamasi için CONSTRAINT ismi tanımlanmaz. Bu kısıtlama veri turunden hemen sonra yerlestirilir
--CHECK -->> Bir sutuna yerleştirilecek deger aralıgını sınırlamak icin kullanılır.

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

select * from calisanlar;

CREATE TABLE calisanlar2(
id CHAR(5),
isim VARCHAR(50),
maas int NOT NULL,
ise_baslama DATE,
constraint pk_id PRIMARY KEY(id),
constraint ism_unq UNIQUE(isim)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14');--Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--Unique
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');

select * from calisanlar;

--FOREIGN KEY--
CREATE TABLE adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
	)
	
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;