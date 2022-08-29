/*
-- GROUP BY -- HAVİNG --
HAVING ifadesinin işlevi WHERE ifadesininkine çok benziyor. Ancak kümeleme fonksiyonları ile
WHERE ifadesi birlikte kullanılmadığında HAVING ifadesine ihtiyac duyulmuştur
GROUP BY kullanıldıgında kullanılır gruplamadan sonraki şart için group by dan sonra HAVING kullanılır
*/
select * from personel
select distinct ulke 

--Maaş ortalaması 3000’den fazla olan ülkelerdeki erkek çalışanların maaş ortalaması.
select ulke,avg(maas) from personel
where cinsiyet='E'
group by ulke
having avg(maas)>3000

--Erkek çalışanların sayısı 1’den fazla olan ülkelerin maaş ortalamasını getiren sorgu
select ulke, avg(maas) from personel WHERE cinsiyet='E' group by ulke having count(*)>1
select ulke,avg(maas) as maas_Ort from personel where cinsiyet='E' group by ulke having count(*)>1