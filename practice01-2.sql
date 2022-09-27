CREATE TABLE workers
(
  id int,
  name varchar(20),
  title varchar(60),
  manager_id int
);
INSERT INTO workers VALUES(1, 'Ali Can', 'Dev', 2);
INSERT INTO workers VALUES(2, 'John Davis', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'Dev Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);
select * from workers;

--1) Tabloya company_industry isminde sütun ekleyiniz
alter table workers
add column company_industry varchar(30)

--2)TABLOYA worker_address sütunu ve defaullt olarakta 'Miami, FL, USA' adresini ekleyiniz.
alter table workers
add column worker_adress varchar(50) default 'Miami, FL, USA'

--3)tablodaki worker_address sütununu siliniz
alter table workers
drop column worker_adress

-- Tablodaki company_industry sütununu, company_profession olarak değiştiriniz.
alter table workers
rename column company_industry to company_profession

-- Tablonun ismini employees olarak değişitiriniz.
alter table workers
rename to employees

select * from employees
-- Tablodaki title sütununa data tipini VARCHAR(50) olarak değiştiriniz.
alter table employees
alter column title type varchar(80)

-- Tablodaki title sütununa "UNIQUE" kıstlaması ekleyiniz.
alter table employees add constraint title unique(title)


-- TABLOYA DATA EKLEME
CREATE TABLE students
(
    student_id CHAR(3) PRIMARY KEY,
    student_name VARCHAR(50) UNIQUE,
    student_age int NOT NULL,
    student_dob DATE,
    CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 20)
);
-- Tam veri girişi
INSERT INTO students VALUES(101, 'ALI CAN', 13, '021-08-11');
INSERT INTO students VALUES(102, 'VELI HAN', 14, '2007-08-10');
INSERT INTO students VALUES(103, 'AYSE TAN', 14, '2007-08-08');
INSERT INTO students VALUES(104, 'KEMAL KUZU', 15, null);
INSERT INTO students VALUES(105, 'TOM HANKS', 20, '2005-10-12');
INSERT INTO students VALUES(106, 'ANGELINA JULIE', 18, '1986-10-12');
INSERT INTO students VALUES(107, 'BRAD PITT', 0, '2021-08-10');
-- Parçalı veri girişi
INSERT INTO students(student_id, student_age) VALUES('108', 17);
INSERT INTO students(student_name, student_id, student_age) VALUES('JOHN DAVID', '109', 20);
select * from students;

-- 101 id öğrencinin ismini 'LEO OCEAN' olarak güncelleyinin
update students
set student_name='LEO OCEAN'
where student_id='101';