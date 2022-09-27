--1. Örnek: companies tablosundan en yüksek ikinci number_of_employees değeri olan company ve
--number_of_employees değerlerini çağırın.

select company,number_of_employees 
from companies 
order by number_of_employees desc 
offset 1 row 
fetch next 1 row only;


--SUBQUERY
select company, number_of_employees
from companies
where number_of_employees=(select max(number_of_employees) from companies
							where number_of_employees < (select max(number_of_employees) from companies))

