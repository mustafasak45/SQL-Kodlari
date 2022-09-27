--function oluşturma
--1. Örnek: İki parametre ile çalışıp bu parametreleri toplayarak return yapan bir fonksiyon oluşturun.
Create OR REPLACE Function toplamaF(x NUMERIC, y NUMERIC)
Returns NUMERIC
Language plpgsql  -- procedure (p) language(l) postgre(pg) sql
AS
$$
 BEGIN
 
 RETURN x+y;

 END
$$

SELECT * FROM toplamaF(15,25);