/*
student_info adında bir table oluşturunuz.
student_id(PRIMARY KEY), student_name(UNIQUE), student_age(NOT NULL) ve student_dob adında sütunlar oluşturunuz.
Sütunlara uygun data tipleri ve belirtilen constraint'leri atayınız.
student_age sütunu 0-20 arası dışında değer alamaz.
student_name sütunu küçük harf karakter alamaz.
*/

CREATE TABLE student_info
(

	student_id SMALLINT PRIMARY KEY,
	student_name VARCHAR(50) UNIQUE,
	student_age SMALLINT NOT NULL,
	student_dob DATE,
	CONSTRAINT student_age_check CHECK(student_age BETWEEN 0 AND 20),
	CONSTRAINT student_name_upper_case CHECK(student_name = UPPER(student_name))
	
);


--Tüm sütunlara veri girerek 2 record oluşturunuz:

INSERT INTO student_info VALUES('101','ALI CAN', 15, '12.06.2007');
INSERT INTO student_info VALUES(102, 'VELI HAN', 19, '5.Aug.04');
INSERT INTO student_info VALUES(103, 'AYSE TAN', 16, 'Sep.3.06');
INSERT INTO student_info VALUES(104, 'KEMAL KUZU', 15, null);
INSERT INTO student_info VALUES('105', 'TOM HANKS', 20, '12-Sep-2003');
INSERT INTO student_info VALUES('106', 'ANGELINA JULIE', 10, '12-Sep-2013');
INSERT INTO student_info VALUES('107', 'BRAD PITT', 0, '10-Aug-2021');

--Spesifik iki stuna veri giriniz
insert into student_info(student_id,student_age) values (108,17);
insert into student_info(student_id,student_age,student_name) values (109,17,'JOHN WALKER')

--STUDENT_ID DEGERI 108 OLAN SATIRIN STUDENT_NAME DEGERINI 'LEO OCEAN' OLARAK GÜNCELLEYINIZ.
update student_info 
set student_name ='LEO OCEAN'
where student_id=108;

--John Walker student_dob sütununu 11-dec-1997 degeriyle degistiriniz
update student_info
set student_dob='11-Dec-1997'
where student_name='JOHN WALKER';

--105 id_li dob hücresini 11-Apr-1996 degerine ve name hücresini MARK TWAIN degerine güncelle.
update student_info
set student_dob='11-Apr-1996',
	student_name='MARK TWAIN'
where student_id=105;

--id'si 106'dan kücük tüm student_dob degerlerini '1-Aug-2021'e güncelle
update student_info
set student_dob='1-8-2021'
where student_id<106;

--Tüm age degerlerini en yüksek student_age degerlerini güncelleyin
update student_info
set student_age= ( select MAX(student_age) from student_info);

--Tüm student_dob değerlerini en düşük student_dob değerine güncelleyin.
update student_info
set student_dob=(select min(student_dob) from student_info);

select * from student_info;

CREATE TABLE workers
(
worker_id SMALLINT,
worker_name VARCHAR(50),
worker_salary SMALLINT,     
CONSTRAINT worker_id_pk PRIMARY KEY(worker_id)    
);

INSERT INTO workers VALUES(101, 'Ali Can', 12000);
INSERT INTO workers VALUES(102, 'Veli Han', 2000);
INSERT INTO workers VALUES(103, 'Ayse Kan', 7000);
INSERT INTO workers VALUES(104, 'Angie Ocean', 8500);

--Veli Han'ın salary değerini en yüksek salary değerinin %20 düşüğüne yükseltin.
update workers
set worker_salary=(select max(worker_salary)*0.8 from workers)
where worker_name='Veli Han';

--Ali Can'ın salary değerini en düşük salary değerinin %30 fazlasına düşürün.(ÖDEV)

--Ortalama salary değerinden düşük olan salary değerlerini 1000 artırın.

update workers
set worker_salary=worker_salary+1000
where worker_salary<(select avg(worker_salary)from workers);

--Ortalama salary değerinden düşük salary değerlerine ortalama salary değeri atayın.(ÖDEV)

select * from workers;

CREATE TABLE people
(
ssn INT,
name VARCHAR(50),
address VARCHAR(80)     
);

INSERT INTO people VALUES(123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES(234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES(345678901, 'Maryy Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES(456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES(567890123, 'California');
INSERT INTO people(ssn, name) VALUES(567890123, 'California');

--null name değerlerini "To be inserted later" değerine güncelleyin.
update people
set name='To be inserted later'
where name is null;

--null address değerlerini "To be inserted later" değerine güncelleyin.
update people
set address='To be inserted later'
where address is null;

--İsimsiz recordları silin.
delete from people
where name='To be inserted later';

--ssn değeri 123456789'dan büyük ve 345678901'den küçük olan recordları sil.
delete from people
where ssn>123456789 and ssn<345678901;

--name değeri NULL olmayan tüm recordları silin.
delete from people
where name is not null;

--address değeri Michigan olmayan kaydı siliniz
--(Java)!= ==> (SQL)<>
delete from people 
where address <> 'Michigan';

select * from people;

CREATE TABLE workers
(
    id SMALLINT,
    name VARCHAR(50),
    salary SMALLINT,
    CONSTRAINT id4_pk PRIMARY KEY(id)
);  
    
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500);  
INSERT INTO workers VALUES(10005, 'Angie Ocean', null);  

--En düşük ve en büyük salary değerlerine sahip recordları çağırın.

select * from workers 
where salary in ((select min(salary)from workers),(select max(salary)from workers));

--En düsük salary degerini bulunuz
select min(salary) as minimum_salary
from workers;

--Record sayısını(adetini) bulun.
select count(*) as satir_sayisi
from workers;

delete from workers where salary is null

--Interview Question: En yüksek ikinci salary değerini çağırın.
--1. Yol:
select max(salary) as en_yüksek_ikinci_salary
from workers
where salary<(select max(salary) from workers);

--2.Yol-tavsiye edilen
select * from workers order by salary desc offset 1 limit 1;

--select * from workers order by salary desc offset 1 row fetch next 1 row only;

select *from workers;

CREATE TABLE customers_likes
( 
  product_id CHAR(10),
  customer_name VARCHAR(50),
  liked_product VARCHAR(50)
);


INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

--liked_product değerleri arasında Lary'nin değeri varsa customer_name değerlerini "No name" olarak güncelle.
update customers_likes 
set customer_name ='No Name'
where exists(select liked_product from customers_likes where customer_name='Lary');

select * from customers_likes

CREATE TABLE employees 
(  
  id CHAR(9), 
  name VARCHAR(50), 
  state VARCHAR(50), 
  salary SMALLINT,
  company VARCHAR(20)
);

INSERT INTO employees VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO employees VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO employees VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO employees VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO employees VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO employees VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO employees VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

SELECT * FROM employees;

CREATE TABLE companies 
(  
  company_id CHAR(9), 
  company VARCHAR(20),
  number_of_employees SMALLINT
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;

--number_of_employees değeri 15000'den büyük olan name ve company değerlerini çağırın.
select name,company
from employees 
where company in (select company from companies 
where number_of_employees>15000);


