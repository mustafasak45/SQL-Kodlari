-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5) ,
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
--Calısanlar id ile adresler tablosundaki adres_id ile eşlesenlere bakmak için
select * from calisanlar,adresler WHERE calisanlar.id = adresler.adres_id;
DROP table calisanlar
--Parant tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir

delete from calisanlar where id='10002';
delete from adresler where adres_id='10002';

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

-- ON DELETE CASCADE --
--Her defasında önce child tablodaki verileri silmek yerine
--ON DELETE CASCADE silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli
CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler;
select * from notlar;

delete from notlar where talebe_id ='123';
delete from talebeler where id ='126';-- ON DELETE CASCADE kullandiğimiz icin PARENT table'den direk silebildik
--Parent table'dan sildigimiz icin child table'den de silinmis olur.

delete from talebeler

-- Parent tabloyu kaldirmak istersek Drop table tablo_adi ndan sonra CASCADE komutu kullaniriz.
drop table talebeler CASCADE

--Talebeler tablosundaki isim sutununa NOT NULL kisitlamasi ekleyiniz ve veri tipini VARCHAR(30) olarak degisitiriniz
alter table talebeler
alter column isim type varchar(30),--type modifiye et,data turunde değişiklik yap anlamındadır
alter column isim set not null; --set ile ekleme yaptık

--talebeler tablosundaki yazılı_notu sutununa 60 dan buyuk rakam girebilsin

alter table talebeler
add constraint sinir check (yazili_notu>60);
--check ile istedigimiz sutunu kısıtlama yapabiliriz
--yukaridaki yazili_notu>60 girdigimiz icin 60 dan asagi yazili_notu girilmezz

INSERT INTO talebeler VALUES(128, 'Mustafa SAK', 'Cafer',45);--izin vermezzz
INSERT INTO talebeler VALUES(128, 'Mustafa SAK', 'Cafer',75);--izin verir


--
create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);

Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;

select * from ogrenciler;
select * from ogrenci_adres;

--Tablodaki bir sutuna PRIMARY KEY ekleme
alter table ogrenciler
add primary key (id);

--PRIMARY KEY oluşturmada 2. yol
alter table ogrenciler
add constraint pk_id primary key (id);

--PRIMARY KEY atadiktan sonra FOREIGN KEY atamasi
alter table ogrenci_adres
add foreign key (id) references ogrenciler

--FOREIGN KEY CONSTRAINT silme
alter table ogrenci_adres drop constraint ogrenci_adres_id_fkey;

--PRIMARY KEY constraint silme 
alter table ogrenciler drop constraint pk_id;

--Yazili notu 85 ten buyuk olanın talebe bilgilerini getirin.
select * from talebeler where yazili_notu>85; 

--ismi Mustafa Bak 
select * from talebeler where isim='Mustafa Bak'; 



--SELECT komutunda --BETWEEN Kosulu
--Between belirttiginiz 2 veri arasindaki bilgileri listeler
--Between de belirttigimiz degerlerde listelemeye dahildir

create table personel
(
id char(4),
isim varchar(50),
maas int
);

insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);

/*
    AND (ve): Belirtilen şartların her ikiside gerçekleşiyorsa o kayıt listelenir
Bir tanesi gerçekleşmezse listelemez
    Select * from matematik sinav1 > 50 AND sınav2 > 50
Hem sınav1 hemde sınav2 alanı, 50'den büyük olan kayıtları listeler
    OR (VEYA): Belirtilen şartlardan biri gerçekleşirse, kayıt listelenir
    select * From matematik sınav>50 OR sınav2>50 
Hem sınav1 veya sınav2 alanı, 50 den büyük olan kayıtları listeler    
*/
select * from personel


--id'si 1003 ile 1005 arasında olan personel bilgisini listeleyiniz
select * from personel where id BETWEEN '1003' and '1005';
select * from personel where id>='1003' and id<='1005';

--Derya Soylu ile Yavuz Bal arasindaki personel bilgisini listeleyiniz.
select * from personel where isim BETWEEN 'Derya Soylu' and 'Yavuz Bal';

--Maasi 70000 ve ismi  Sena Beyaz olan personeli listeleyiniz
select * from personel where maas=70000 or isim='Sena Beyaz';

--IN : Birden fazla mantıksal ifade ile tanımlayabileceğimiz durumları tek komutta yazabilme imkanı verir
--Farklı sütunlar için IN kullanılamaz

--id'si 1001,1002 ve 1004 olan personelin bilgilerini listele
select * from personel where id ='1001' or id ='1002' or id ='1004'; --IN kullanmadan
SELECT * FROM personel where id in ('1001', '1002', '1004');  --IN kullanarak

--Maasi sadece 70000,100000 olan personeli listele
select * from personel where maas in ('70000','100000');

/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli kalıp ifadeleri kullanabilmemizi sağlar
ILIKE : Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE :!~~*
% --> 0 veya daha fazla karakteri belirtir.
_ --> Tek bir karakteri belirtir
*/

--Ismi a harfi ile baslayan personeli listele
select * from personel where isim like 'A%';

--Ismi t harfi ile biten personeli listele
select * from personel where isim like '%t';

--Isminin ikinci harfi e olan personeli listeleyiniz
select * from personel where isim like '_e%';

-- Soru9 :Isminin 3.harfi r olan personeli listeleyiniz
select * from personel Where isim LIKE '__r%';
