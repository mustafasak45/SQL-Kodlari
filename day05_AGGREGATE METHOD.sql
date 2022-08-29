-- AGGREGATE METHOD KULLANIMI --
/*
-Aggregate Methodları (SUM(Topla),COUNT(Say),MIN(EN küçük değer),MAX(En büyük değer),AVG(Ortalama)) 
-Subquery içinde de kullanılır
-ANcak, sorgu tek bir değer döndürüyor olmalıdır
SYNTAX: sum() şeklinde olmalı sum () arasında boşluk olmamalı
*/
select * from calisanlar2

-- Çalısanlar2 tablosundaki en yüksek maaş değerini listeleyiniz
SELECT max(maas) from calisanlar2

--Calisanlar tablosundaki maaşların toplamını listeleyiniz
SELECT sum(maas) from calisanlar2

--Calıcanlar tablosundaki maas ortalamalını listeleyiniz
SELECT avg(maas) from calisanlar2 --burada sonuc kusuratlı cıkıyor, kusuratı göstermemek icin alt satırdaki gibi round yaziyoruz

 --ortalamayı(avg) yuvarlamak icin round() kullanılır
SELECT round(avg(maas)) from calisanlar2--ortalamayı alırken kusuratı siler
SELECT round(avg(maas),2) from calisanlar2--ortalmayı alırken parantez icindeki rakam kadar kusurat verir
--

--Calisanlar toplasundan en düşük maası listeleyiniz
SELECT min(maas) from calisanlar2

--Calisanlar tablosundaki kaç kişinin maaş aldığını listeleyiniz
SELECT count(maas) from calisanlar2

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz(Markalrın maaslarını kendi icinde topla)
SELECT marka_isim, calisan_sayisi, (SELECT SUM(maas) FROM calisanlar2 WHERE marka_isim=isyeri) 
AS toplam_maas from markalar --toplam_maas sutunu bizim olusturdugumuz sutundur
--ALIAS (AS) toplama yaptigimizda gecici isim vermek icin kullanilir

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
SELECT marka_isim,calisan_sayisi,(SELECT max(maas) from calisanlar2 where marka_isim=isyeri) AS max_maas,
                                 (SELECT min(maas) from calisanlar2 where marka_isim=isyeri) AS min_maas
from markalar;


--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
SELECT marka_id,marka_isim,(SELECT COUNT(sehir) FROM calisanlar2 WHERE marka_isim=isyeri) 
AS sehir_sayisi FROM markalar


--Interview Question: En yüksek ikinci maas değerini çağırın.
SELECT max(maas) AS enyuksek_ikinci_maas FROM calisanlar2
WHERE maas<(SELECT max(maas) FROM calisanlar2)

----Interview Question: En düşük ikinci maas değerini çağırın.
SELECT min(maas) AS endusuk_ikinci_maas FROM calisanlar2
WHERE maas>(SELECT min(maas) FROM calisanlar2)

--En yüksek üçüncü maas değerini bulun
SELECT max(maas) AS enyuksek_ucunu_maas FROM calisanlar2
WHERE maas<(SELECT MAX(maas)From calisanlar2 WHERE maas<(Select max(maas) FROM calisanlar2))

--En düşük üçüncü maas değerini bulununuz (ÖDEV)
SELECT min(maas) AS EN_DUSUK_UCUNCU_MAAS FROM calisanlar2
WHERE maas>(SELECT min(maas) FROM calisanlar2 where maas>(SELECT min(maas) FROM calisanlar2))
