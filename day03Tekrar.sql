create table personel(
pers_id int,
isim varchar(30),
sehir varchar(30),
maas int,
sirket varchar(20),
adres varchar(50)	
);

--YUKARIDAKİ TABLODAKİ BAZI FİELDLER GİBİ TABLO OLUŞTURMA

create table personel_adres
as
select pers_id,sehir,adres from personel;

--TABLO CAGİRMA

select * from personel_adres

--VERİ EKLEME

insert into personel values (1002,'Mustafa SAK','Manisa','25000','Sak Holding','Manisa/Kırkağaç');
insert into personel values (1003,'Zafer Köşktepe','Manisa',35000,'Sak Yapi','İzmir/Ödemiş');
insert into personel values (1004,'Maksad Saidov','Başkent',55000,'Saidowizm','Türkmenistan/Başkent');

--Parçalı veri ekleme
insert into personel(pers_id,sehir) values(1005,'Ankara');

--VERİ SİLME
delete from personel where pers_id=1001;
delete from personel; --tablonun içinin tümünü siler

--TABLOYA YENİ COLUMN EKLEME, COLUMN ADINI DEGİŞTİRME, TABLO ADINI DEGİSTİRME
alter table personel add cinsiyet varchar(20), add yas int;
alter table personel rename column yas to yasi;
alter table personel rename to isciler;

select * from isciler;

CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);

select * from calisanlar;

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz2', 5000, '2018-04-14');--Unique 'Mehmet Yılmaz' daha önce eklendiği için kabul etmiyor
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--NOT NULL Maas NOT NULL belirtildiği için NULL degerini kabul etmez 
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--Unique 'CAN' daha önce eklendiği için kabul etmiyor
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--NOT NULL Maas NOT NULL belirtildiği için NULL degerini kabul etmez 
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--PRIMARY KEY '' daha önce girildiği için kabul etmiyor
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--PRIMARY KEY null kabul etmezz



--FOREIGN KEY--
CREATE TABLE adresler(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
)
--FOREIGN KEY KOD YAZIMI İLE İLGİLİ AÇIKLAMA:
--CONSTRAINT'den sonra FK'ya verilecek olan isim yazilir
--FOREIGN KEY () parantez içine şuanki FK yapacak oldugumuz tablonun fieldi yazilir
--REFERENCES'den sonra referans alacagimiz tablonun adi ve parantez icinde PK olan field adi
	select * from adresler;
	
--İKİ TABLO OLUŞTURARAK ÖRNEK YAPALIM:

--ilk tablomuzu ogretmen adinda create ediyoruz.Bu Tabloyu Parent yapmak istiyorum, bunu ikinci tablo oluştururken
--FK tanımlarken belirliyecegiz
create table ogretmen(
id int PRIMARY KEY, -- Buraya dikkat edelim bu tablonun PRIMARY KEY(Birincil Anahtar) i 'id' olarak belirledik
adi varchar(30) UNIQUE,
soyadi varchar(30)	
)
--ikinci tablomuz da dersler adinda olusturalım.
Create table dersler(
ders_id int PRIMARY KEY,
ders_adi varchar(30),
ogretmen_id int,
CONSTRAINT fk_adi FOREIGN KEY (ogretmen_id) REFERENCES ogretmen(id)--Bu tablodaki 'ogretmen_id' yi FK yaptık ve
--referans olarak da Parent Tablonun adını, parantez içinde de Parent tablonun PK'ini yazdik.	
)

select * from dersler
insert into dersler values(1001,'Bilgisayar',15);--Bu satiri çalıştırmaz cünkü dersler tablosu child tablodur ve daha 
--parent tablosuna(ogretmen) 15 'id' li bir ögretmen girmedigimiz için veri ekleme yapmaz.
insert into ogretmen values(15,'Mustafa','Sak');--Yukarıdaki eklemeyi yapabilmemiz için ilk olarak Parent tabloya
--veri girişi yapıyoruz ve girilen veri Parent tabloda PK olan verili dersi giriş yapiyoruz ki hata vermesin.


insert into ogretmen values(null,'Mehmet','Can');
insert into dersler values(1002,'Makine',NULL);

select * from ogretmen;
select * from ogretmen,dersler where ogretmen.id=dersler.ogretmen_id;--her iki Taployu ilişkilendirdiğimiz KEY'lerle cagiriyoruz

drop table ogretmen cascade--Normalde ogretmen tablosu Parent oldugundan silinmez ama cascade kodunu sonuna ekleyince siler


delete from ogretmen;
delete from ogretmen where id=15;

--ON DELETE CASCADE KOMUTU İLE CHİLDDEN ÖNCE PARENTTEN VERİ SİLE BİLME ÖZELLİĞİ KAZANDIRMA
--Bunun için üstteki Child tablodaki 'CONSTRAINT fk_adi FOREIGN KEY (ogretmen_id) REFERENCES ogretmen(id)' den sonraki satira
--ON DELETE CASCADE komutu ekleriz.
--Örnek Olarak Yukaridaki Tablolari Tekrar Oluşturalım.

create table ogretmen(
id int PRIMARY KEY, 
adi varchar(30) UNIQUE,
soyadi varchar(30)	
)
Create table dersler(
ders_id int PRIMARY KEY,
ders_adi varchar(30),
ogretmen_id int,
CONSTRAINT fk_adi FOREIGN KEY (ogretmen_id) REFERENCES ogretmen(id)
ON DELETE CASCADE	
)
insert into ogretmen values(1001,'Mustafa','Sak');
insert into ogretmen values(1002,'Ahmet','Sak');
insert into dersler values(5000,'Matematik',1001);
insert into dersler values(5002,'Fizik',1002);
select * from ogretmen

delete from ogretmen where id=1001;--ogretmen(Parent) tablosundan sildigimiz verinin karşılığı olan dersler(Child) 
--tablosundan da silinir. Bunu ON DELETE CASCADE özelliği sağlar.

drop table ogretmen cascade -- Parent Tabloyu tamamen silmek için en sona CASCADE ekleriz.
create table deneme(
id int Primary KEY,
ad varchar(20),
soyad varchar(20)
)
drop table ogretmen cascade
drop database deneme;

--ogretmen tablosunun field'lerinde degisiklik yapmak
alter table ogretmen
alter column adi TYPE varchar(20),
alter column soyadi SET NOT NULL;

alter table ogretmen rename column adi to ismi;

--Notlar tablosu olustur, notu 60'tan yukarı girsin
create table notlar(
notu int,
adi varchar(20),
soyadi varchar(20)	
)
select * from notlar

alter table notlar
add constraint sinir60 check (notu>60);
insert into notlar values(100,'Mustafa','Sak');

ALTER TABLE notlar
ADD CONSTRAINT pk_adi PRIMARY KEY (notu);

create table ogretmen_adres
as
select notu,adi from notlar;

ALTER TABLE ogretmen_adres
ADD FOREIGN KEY (notu) REFERENCES notlar;

