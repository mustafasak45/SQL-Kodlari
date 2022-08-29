create table ogrenciler(
id int primary key,
ogrenci_adi varchar(20),
ogrenci_soyadi varchar(20)	
);

insert into ogrenciler values(1,'Elif','Türkmen');
insert into ogrenciler values(2,'Ayşe','Sarı');
insert into ogrenciler values(3,'Ender','Kaya');
insert into ogrenciler values(4,'Ali','Demir');
insert into ogrenciler values(5,'Adem','Salih');

create table alinan_dersler(
id int,
ogrenci_id int,
ders_id int,
constraint fk_ogrenciler foreign key (ogrenci_id) references ogrenciler(id),
constraint fk_dersler foreign key (ders_id) references dersler(id)	
)
insert into alinan_dersler values(1,1,3); 
insert into alinan_dersler values(2,1,5);
insert into alinan_dersler values(3,2,1);
insert into alinan_dersler values(4,3,4);
insert into alinan_dersler values(5,4,2);
insert into alinan_dersler values(6,4,3);

create table dersler(
id int primary key,
ders_adi varchar(20)	
)
insert into dersler values(1,'Matemetik');
insert into dersler values(2,'Tarih');
insert into dersler values(3,'Edebiyat');
insert into dersler values(4,'Yazılım');
insert into dersler values(5,'İstatistik');
