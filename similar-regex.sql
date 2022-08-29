-- SELECT - SIMILAR TO - REGEX(Regular Expressions) --
/*
SIMILAR TO : Daha karmaşık pattern(kalıp) ile sorgulama işlemi için SIMILAR TO kullanılabilir.
Sadece PostgreSQL de kullanılır. Büyük Küçük harf önemlidir
REGEX : Herhangi bir kod, metin içerisinde istenen yazı veya kod parçasının aranıp bulunmasını sağlayan
kendine ait bir söz dizimi olan bir yapıdır.MySQL de(REGEXP_LİKE) olarak kullanılır
PostgreSQL'de "~" karakteri ile kullanılır.
*/

CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
   INSERT INTO kelimeler VALUES (1002, 'hat', 3);
   INSERT INTO kelimeler VALUES (1003, 'hit', 3);
   INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
   INSERT INTO kelimeler VALUES (1005, 'hct', 3);
   INSERT INTO kelimeler VALUES (1006, 'adem', 4);
   INSERT INTO kelimeler VALUES (1007, 'selim', 5);
   INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
   INSERT INTO kelimeler VALUES (1009, 'hip', 3);
   INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
   INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
   INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
   INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
   INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
   INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
   INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
   INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);
   
   --  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz

select * from kelimeler where kelime similar to '%(at|ot)%';

select * from kelimeler where kelime like '%at%' or kelime like '%ot';
select * from kelimeler where kelime ~~* '%at%' or kelime ~~* '%ot';

--REGEX
select * from kelimeler where kelime ~* 'ot' or kelime ~* 'at';

-- SORU: 'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
select * from kelimeler where kelime similar to 'ho%|hi%';

--ILIKE ile
select * from kelimeler where kelime ~~* 'ho%' or kelime ~~* 'hi%';
--REGEX ile
select * from kelimeler where kelime ~* 'h[oi](.*)'--REgex'te ".(nokta) bir karakteri temsil eder"
--Regex'de ikinci karakter için köşeli parantez kullanılır. * hepsi anlaminda kullanilir

--SORU: Sonu 't' veya 'm' ile bitenleri listeleyeniz
--SIMILAR To ile
select * from kelimeler where kelime similar to '%t|%m';
--REGEX ile
select * from kelimeler where kelime ~* '(.*)[tmp]$' --$ bitir anlamina gelir, yani son harf ya 't' ya da 'm'

--SORU: h ile başlayıp t ile biten 3 harfli kelimeleri listeleyeniz
--SIMILAR TO ile
select * from kelimeler where kelime similar to 'h[a-z,A-Z,0-9]t'or kelime similar to 'h[a-z,A-Z,0-9]T' or kelime similar to 'H[a-z,A-Z,0-9]t' or kelime similar to 'H[a-z,A-Z,0-9]T';
--LIKE ile
select * from kelimeler where kelime ~~* 'h_t';
--REGEX ile
select * from kelimeler where kelime ~* 'h[a-z,A-Z,0-9]t';

--SORU: İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan
--“kelime" değerlerini çağırın.

--SIMILAR TO İLE
select * from kelimeler where kelime similar to 'h[a-e]%t';
--REGEX İLE
select * from kelimeler where kelime ~* 'h[a-e](.*)t';

--SORU:İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '^[say](.*)'; -- ^ baslangici temsil eder, $ tam tersi temsil eder

--SORU:Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '[maf]$';

--SORU:İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
select * from kelimeler where kelime ~ 'h[a|i]t$'
select * from kelimeler where kelime similar to 'h[a|i]t';

--SORU:İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup
--üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.
select * from kelimeler where kelime ~ '^[b-s].l(.*)'

--SORU:içerisinde en az 2 adet oo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where kelime similar to '%[o][o]%'
select * from kelimeler where kelime similar to '%[o]{2}%'

--SORU:içerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where kelime similar to '%[o]{4}%'

--SORU:'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
SELECT kelime FROM kelimeler WHERE kelime ~ '^[a|s|y](.*)[m|f]$';