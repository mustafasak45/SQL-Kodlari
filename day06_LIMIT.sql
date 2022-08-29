---  LİMİT  ---

select * from kisiler


-- listeden ilk 5 veriyi listeleyiniz
select * from kisiler limit 5;

--ilk iki veriden sonra 5 veriyi listeleyin
select * from kisiler limit 5 OFFSET 2

-- listeden ilk 5 veriyi maasi en yüksek olanı listeleyiniz
select * from kisiler order by maas desc limit 5 

-- id değeri 5 den büyük olan ilk iki veriyi listeleyiniz
select * from kisiler where id>5 limit 2

--  MAAŞ'ı en yüksek 3 kişinin bilgilerini listeleyiniz
select * from kisiler order by maas desc limit 3 

-- En yüksek maaşı alan 4. 5.  6. kişilerin bilgilerini listeleyiniz
select * from kisiler order by maas desc limit 3 offset 3
 
