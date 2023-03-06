--SQL: Database'deki(Veritabani) verileri verileri yönetmek,sorgulamak ve tasarlamak icin kullanilan bir sorgu dilidir.
--Database(Veritabani):Birbirleriyle ilgili datalatin toplandigi yerin adi
--Faydalari:
--1-Yüksek miktarda veri depolanabilir.
--2-CRUD operasyonlarinin kolayligi
--3-Dataya ulasimin kontrollü ve kolay olmasi
--4-Güvenli olmasi
--DBMS(VTYS):Database management system
--VTYS:veri tabanini yönetmek icin kullanilan yazilimlardir.(postgreSQL,mySQL,MSSQL)

--SQl KOMUTLARI 4 ANA GRUBA AYRILIR:
--1-DDL-->DATA DEFINITION LANGUAGE
--CREATE-->Database ve tablo olusturmak icin kullanilir
--ALTER-->Tablo ve database'i güncellemek icin
--DROP-->tablo ve database'i silmek icin.

create table calisanlar(
id char(4),
isim varchar(15),
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int 
);

--DQL-->Data Query Language(Veri sorgu dili)
--Eger tablodaki tüm verileri listelemek istersek:
select * from calisanlar;
--Eger bir veya birden fazla sütünu secmek istersek:
select id,isim from calisanlar;

--Olusturmuz oldugumuz bir tablodan yeni bir tablo olusturmak icin
create table maas 
as select id,maas from calisanlar;

select * from maas;

--SQL tablolar datalari iliskili tablolarda saklar.
--Constraint(Kisitlama)
--Primary key
--Foreign key
--Unique
--Check
--not null

--1-Primary key:Iliskili tablolarda mutlaka primary key olmalidir
--Bir satirda her satir icin tanimlayici görevi görür.
--3 yolla primray key olusturabiliriz.

--1.Yol
create table calisanlar1(
id char(4) primary key,
isim varchar(15),
soyisim varchar(30),
tel varchar(15)
)

select *from calisanlar1;

--2.Yol
create table calisanlar2(
id char(4) ,
isim varchar(15),
soyisim varchar(30),
tel varchar(15),
primary key (id)
)

--3.Yol
create table calisanlar3(
id char(4) ,
isim varchar(15),
soyisim varchar(30),
tel varchar(15),
constraint pk primary key (id)
);

--Foreign key: Primary key olan tablo ile iliski olusturmak icin kullanilir.

create table ucret(
id char(4),
maas real,
foreign key(id) references calisanlar1(id)
);

--Check:Bir alana girilecek degerleri sinirlamak icin kullanilir.
--Unique:Bir sutundaki verilerin tekrarsiz yani tek olamsini saglar.
--Not null:Bir sutunun null icermemesini yani bos olmamasini saglar.

create table calisanlar4(
id char(4) primary key,
isim varchar(15) unique,
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int not null,
check(maas>1000),
unique(maas,tel)
);

--Alter tablo: tablolari güncellemek icin kullanilir.
select * from calisanlar

--ADD
alter table calisanlar 
add primary key (id);

--mevcut primary keyi degistmek icib önce tablodaki primary keyi kaldirmak gerekir
--sonra yeniden atama yapabiliriz

alter table calisanlar
drop constraint calisanlar_pkey, add primary key (id);

/*
not:Primary key genellikle bir tablonun olusumm asamadinda belirlenir ve daha sonra degistirilmez.
Bu nedenle, primary key degisiklikleri özenle yapilmalidir ve degisiklikler öncesi veriler yedeklenmelidir.
*/

alter table calisanlar 
add unique (email);

alter table calisanlar 
add constraint check_maas check (maas>1000);

--Soyisimler sütünuna x veya w ile baslayan veri girilmesin.

alter table calisanlar 
add constraint check_soyisim check (not(soyisim like'x%' or soyisim like 'w%'));

--Tabloya yeni bir veya birden fazla sütun ekleme.
alter table calisanlar
add sehir varchar(20),add posta_kodu char(5);

--Tablodan sütun silme

alter table calisanlar
drop ulke;

--tablodaki bir sütunun adini degistirmek istersek
alter table calisanlar
rename sehir to il;

--tablonun ismini degistirmek istersek
alter table calisanlar
rename to personel;

select * from personel;

--Modify--postgreSQL-->type/set olarak kullaniyor
--Sütunlarin özelliklerini degistirme

alter table personel
alter column tel type char(11);

--DDL->drop table
--Tabloyu ve database'i silmek icin DROP kullanilir

drop table calisanlar4;

--DML_>DAta manipulation language
--INSERT_>Tabloya veri eklemek icin kullanilir
--UPDATE->Tabloda ki verileri  güncellemek icin kullnilir.
--DELETE->Tablodaki verileri silmek icin kullanilir.

--INSERT

create table calisanlar4(
id char(4) primary key,
isim varchar(15) unique,
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int not null,
check(maas>1000),
unique(maas,tel)
);


select * from calisanlar4;

--Tüm sütunlara ekleme yapmak icin

insert into calisanlar4 values ('1234','Erol','Evren','05435345345','erol@gmail.com','Ankara',1000);
--Bu eklemeyi kabul etmez.Cünkü maas 100'den büyük olmali. maas sütununda check constranint mevcut














