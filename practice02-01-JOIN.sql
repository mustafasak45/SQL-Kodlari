CREATE TABLE sirketler
(
	sirket_id int,
	sirket_isim VARCHAR(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');
CREATE TABLE siparisler
(
	siparis_id int,
	sirket_id int,
	siparis_tarihi DATE
);
INSERT INTO siparisler VALUES(11, 101, '2022-04-17');
INSERT INTO siparisler VALUES(22, 102, '2022-04-18');
INSERT INTO siparisler VALUES(33, 103, '2022-04-19');
INSERT INTO siparisler VALUES(44, 104, '2022-04-20');
INSERT INTO siparisler VALUES(55, 105, '2022-04-21');
select * from sirketler;
select * from siparisler;


--SORU1: Iki Tabloda sirket_id’si ayni olanlarin; sirket_ismi, siparis_id ve
--  siparis_tarihleri listeleyen bir sorgu yaziniz.

select sir.sirket_isim,sip.siparis_id,sip.siparis_tarihi
from sirketler sir inner join siparisler sip
on sir.sirket_id = sip.sirket_id

--SORU2: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan
--siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.

select sir.sirket_isim, sip.siparis_id,sip.siparis_tarihi
from siparisler as sip 					
right join sirketler as sir					
ON sip.sirket_id=sir.sirket_id	

select sir.sirket_isim, sip.siparis_id,sip.siparis_tarihi
from sirketler as sir						
left join siparisler as sip 				
ON sip.sirket_id=sir.sirket_id	


--SORU3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile
--bunlara karşılık gelen sirket_isimlerini listeleyen bir sorgu yaziniz.

select sip.siparis_id,sir.sirket_isim,sip.siparis_tarihi
from siparisler sip
full join sirketler sir
on sir.sirket_id = sip.sirket_id

-----------------------------------------------------------------------------

create table films
(film_id int,
film_name varchar(30),
category varchar(30)
);
insert into films values (1, 'Assassins Creed: Embers', 'Animations');
insert into films values (2, 'Real Steel(2012)', 'Animations');
insert into films values (3, 'Alvin and the Chipmunks', 'Animations');
insert into films values (4, 'The Adventures of Tin Tin', 'Animations');
insert into films values (5, 'Safe (2012)', 'Action');
insert into films values (6, 'Safe House(2012)', 'Action');
insert into films values (7, 'Marley and me', 'Romance');
create table actors
(id int,
actor_name varchar(30),
film_id int
);
insert into actors values (1, 'Adam Smith', 1);
insert into actors values (2, 'Ravi Kumar', 2);
insert into actors values (3, 'Susan Davidson', 5);
insert into actors values (4, 'Lee Pong', 6);
insert into actors values (5, 'Bruce Lee', NULL);
insert into actors values (6, 'Lee Pong', 1);

select * from actors
select * from films


-- SORU1: Tüm filmleri, film türlerini ve filimlerde oynayan aktörleri listeleyiniz.
--LEFT ile çözümü
select f.film_name,f.category,a.actor_name		
from films f 		
left join actors a		
on f.film_id = a.film_id order by f.film_name		

--RIGHT ile çözümü
select f.film_name,f.category,a.actor_name				
from actors a				
right join films f				
on f.film_id=a.film_id order by f.film_name				
