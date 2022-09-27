CREATE TABLE workers
(
  id CHAR(9),
  name VARCHAR(50),
  state VARCHAR(50),
  salary SMALLINT,
  company VARCHAR(20)
);
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
SELECT * FROM workers;

--HAVING ile ilgili PRACTİCE:
--Group by ardından where kullanılmaz onun yerine şartı HAVING ile yaparız


--Toplam salary değeri 2500 üzeri olan her bir çalışan için salary toplamını bulun.
select name,sum(salary) as "Total Salary" from workers 
group by name
having sum(salary)>2500


--Birden fazla çalışanı olan, her bir state için çalışan toplamlarını bulun.
select state,count(state) as number_of_employees from workers
group by state
having count(state)>1


--Her bir state için değeri 3000'den az olan maximum salary değerlerini bulun.
select state,max(salary) from workers
group by state
having max(salary)<3000


--Her bir company için değeri 2000'den fazla olan minimum salary değerlerini bulun.
select company,min(salary) as MIN_SALARY from workers
group by company
having min(salary)<2000


--Tekrarsız isimleri çağırın.
select distinct name from workers --Distinct clause, çağırılan terimlerden tekrarlı olanların sadece birincisini alır.

--Name değerlerini company kelime uzunluklarına göre sıralayın.
select name,company from workers 
order by LENGTH(company)

--Tüm name ve state değerlerini aynı sütunda çağırarak her bir sütun değerinin uzunluğuna göre sıralayın.
--CONCAT() fonksiyonu birden fazla String veya sutunu birleştirmek için kullanılır.

--1.YOL:CONCAT() fonksiyonu kullanarak
select CONCAT(name,' ',state) as name_and_state from workers
order by LENGTH(CONCAT(name,state))

--2.YOL
select name || ' ' || state || ' ' || Length(name) +Length(state) as "Name and States"
FROM workers
ORDER BY Length(name) +Length(state)

--3.YOL
select CONCAT(name,' ',state) as name_and_state from workers
order by LENGTH(name) + LENGTH(state);



/*
UNION Operator: 1) İki sorgu(query) sonucunu birleştirmek için kullanılır.
				2) Tekrarsız(unique) recordları verir.
				3) Tek bir sutuna çok sütün koyabiliriz.
				4) Tek bir sütüna çok sütun koyarken mevcut data durumuna dikkat etmek gerekir.				
*/
SELECT * FROM workers;

--salary değeri 3000'den yüksek olan state değerlerini ve 
--salary değeri 2000'den küçük olan name değerlerini TEKRARSIZ olarak bulun.
select state as "Name and State",salary from workers where salary>3000
UNION
select name,salary from workers where salary<2000

--salary değeri 3000'den yüksek olan state değerlerini ve 2000'den küçük olan name değerlerini TEKRARLI olarak bulun.
select state as "Name and State",salary from workers where salary>3000
UNION ALL		--->>	UNION ile aynı işi yapar. Ancak, tekrarlı değerleri de verir
select name,salary from workers where salary<2000

--salary değeri 1000'den yüksek, 2000'den az olan "ortak" name değerlerini bulun.
select name from workers where salary>1000
INTERSECT -->>INTERSECT Operator: İki sorgu (query) sonucunun ortak(common) değerlerini verir. Unique(tekrarsız) recordları verir.
select name from workers where salary<2000

--salary değeri 2000'den az olan ve company değeri  IBM, APPLE yada MICROSOFT olan ortak "name" değerlerini bulun.
select name from workers where salary<2000
INTERSECT
select name from workers where company IN('IBM','APPLE','MICROSOFT');

--EXCEPT Operator : Bir sorgu sonucundan başka bir sorgu sonucunu çıkarmak için kullanılır. Unique(tekrarsız) recordları verir.
--salary değeri 3000'den az ve GOOGLE'da çalışmayan  name değerlerini bulun.
select name from workers where salary<3000 
EXCEPT
select name from workers where company='GOOGLE';

------------------------------------------

CREATE TABLE my_companies
(
  company_id CHAR(3),
  company_name VARCHAR(20)
);
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');
SELECT * FROM my_companies;
CREATE TABLE orders
(
  company_id CHAR(3),
  order_id CHAR(3),
  order_date DATE
);
INSERT INTO orders VALUES(101, 11, '17-Apr-2020');
INSERT INTO orders VALUES(102, 22, '18-Apr-2020');
INSERT INTO orders VALUES(103, 33, '19-Apr-2020');
INSERT INTO orders VALUES(104, 44, '20-Apr-2020');
INSERT INTO orders VALUES(105, 55, '21-Apr-2020');
SELECT * FROM orders;

/*
--JOINS: 1) INNER JOIN: Ortak(Common) datayı verir.
		 2) LEFT JOIN: Birinci table'nin tüm datasını verir.
		 	Yani Soldaki tabloda asıl veriler olacak, diger tabloda aynı olan verileri oturtacak diğer hücreler null döndürecek
		 3) RIGHT JOIN: İkinci table'nin tüm datasını verir.
		 4) FULL JOIN: İki table'nin tüm datasını verir.
		 5) SELF JOIN: Tek table üzerinde çalışırken iki table varmış gibi çalışılır. 
*/ 
--1) INNER JOIN

--Ortak companyler için company_name, order_id ve order_date değerlerini çağırın.
select mc.company_name,o.order_id,o.order_date
from my_companies mc inner join orders o --mc ve o bizim verdigimiz isim ve genelde bu adlar verirlir
on mc.company_id = o.company_id;

-- 2) LEFT JOIN
--my_companies table'ındaki companyler için order_id ve order_date değerlerini çağırın.
select mc.company_name,o.order_id,o.order_date
from my_companies mc left join orders o 
on mc.company_id = o.company_id;

--3) RIGHT JOIN
--Orders table'ındaki company'ler için company_name, company_id ve order_date değerlerini çağırın.
select mc.company_name,o.order_id,o.order_date
from my_companies mc right join orders o 
on mc.company_id = o.company_id;

--4) FULL JOIN
--İki table'dan da company_name, order_id ve order_date değerlerini çağırın.
select mc.company_name,o.order_id,o.order_date
from orders o full join my_companies mc
on mc.company_id = o.company_id;

--5) SELF JOIN
CREATE TABLE workers
(
  id CHAR(2),
  name VARCHAR(20),
  title VARCHAR(60),
  manager_id CHAR(2)
);
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);
SELECT * FROM workers;
--workers tablosunu kullanarak çalışanların yöneticilerini gösteren bir tablo hazırlayın.

SELECT employee.name AS Employee, manager.name AS Manager
FROM workers employee FULL JOIN workers manager
ON manager.id = employee.id








