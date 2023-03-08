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
add unique (id);

--mevcut primary keyi degistmek icib önce tablodaki primary keyi kaldirmak gerekir
--sonra yeniden atama yapabiliriz

alter table calisanlar
drop constraint calisanlar_pkey, add primary key (maas);

/*
not:Primary key genellikle bir tablonun olusumm asamadinda belirlenir ve daha sonra degistirilmesi tavsiye edilmez.
Bu nedenle, primary key degisiklikleri özenle yapilmalidir ve degisiklikler öncesi veriler yedeklenmelidir.
*/

alter table calisanlar 
add unique (email);

alter table calisanlar 
add constraint check_maas check (maas>1000);

--Soyisimler sütünuna x veya w ile baslayan veri girilmesin.

alter table calisanlar4 
add constraint check_soyisim check (not(soyisim like'x%' or soyisim like 'w%')); 

--Tabloya yeni bir veya birden fazla sütun ekleme.
alter table calisanlar
add sehir varchar(20),add posta_kodu char(5);

--Tablodan sütun silme

alter table calisanlar
drop tel;

--tablodaki bir sütunun adini degistirmek istersek
alter table calisanlar
rename sehir to il;

--tablonun ismini degistirmek istersek
alter table calisanlar
rename to personel2;

select * from personel2;

--Modify--postgreSQL-->type/set olarak kullaniyor
--Sütunlarin özelliklerini degistirme

alter table personel2
alter column isim type char(11);

--DDL->drop table
--Tabloyu ve database'i silmek icin DROP kullanilir

drop table calisanlar4;

--DML_>DAta manipulation language
--INSERT_>Tabloya veri eklemek icin kullanilir
--UPDATE->Tabloda ki verileri  güncellemek icin kullnilir.
--DELETE->Tablodaki verileri silmek icin kullanilir.

--INSERT

create table calisanlar10(
id char(4) primary key,
isim varchar(15) unique,
soyisim varchar(30),
tel varchar(15),
email varchar(50),
adres varchar(50),
maas int,
check(maas>1000),
unique(maas,tel)
);


select * from calisanlar4;

--Tüm sütunlara ekleme yapmak icin

insert into calisanlar4 values ('1234','Erol','Evren','05435345345','erol@gmail.com','Ankara',1000);
--Bu eklemeyi kabul etmez.Cünkü maas 1000'den büyük olmali. maas sütununda check constranint mevcut


insert into calisanlar4 values ('1234','Erol','xEvren','05435345345','erol@gmail.com','Ankara',1500);
--Bu eklemeyi kabul etmez.Cünkü soyisim x ve w ile baslayamaz. soyisim sütununda check constranint mevcut

insert into calisanlar4 values ('1234','Erol','Evren','05435345345','erol@gmail.com','Ankara',1500);
--Bu eklemeyi kabul etmez.Cünkü isim unique olmali. isim sütununda unique constranint mevcut

insert into calisanlar4 values ('1235','Erolcan','can','05535345345','erol@gmail.com','Ankara',1600);

--istedigimiz sütinlara eklme yapmak icin
insert into calisanlar4(isim,soyisim,tel) values ('Emre','Kaya','05465468695')
--id sütunu primary key oldugu icin veri girmemiz zorunludur.Bu insert komutunu kabul etmez

insert into calisanlar10(id,isim,soyisim,tel) values ('1236','Emre','Kaya','05465468695');

insert into calisanlar4(maas,isim,soyisim,tel,id) values (1800,'Hasan','Kayacan','05465468695','1239')

--DML->Update->Tablodaki verileri güncellemek icin kullanilir.
--Syntax

update tablo_adi
set sütun_adi

update calisanlar4 
set adres='Bursa';

--Erol isimli verinin adresini Ankara olarak güncelleyiniz

update calisanlar4
set adres='Ankara' 
where isim='Erol';

--Emre isimli verinin maasini 2000 olarak güncelleyiniz.
update calisanlar4
set maas=2000
where isim='Emre';

select * from calisanlar4;

create table calisanlar(
id char(4),
isim varchar(50),
maas int,
constraint id_pk primary key(id)
);
insert into calisanlar values('1001', 'Ahmet Aslan', 7000);
insert into calisanlar values('1002', 'Mehmet Yılmaz' ,12000);
insert into calisanlar values('1003', 'Meryem ', 7215);
insert into calisanlar values('1004', 'Veli Han', 5000);

create table aileler (
id char(4),
cocuk_sayisi int,
ek_gelir int,
constraint id_fk foreign key(id)references calisanlar(id)
);
insert into aileler values('1001', 4, 2000);
insert into aileler values('1002', 2, 1500);
insert into aileler values('1003', 1, 2200);
insert into aileler values('1004', 3, 2400);
--Tablo oluştururken Create table ile başlayıp insert komutlarıyla birlikte seçip çalıştırabiliriz

select * from calisanlar
select * from aileler

--Veli Han'ın maasına %20 zam yapınız

update calisanlar
set maas=maas*1.2
where isim='Veli Han';

CREATE TABLE hastaneler
(
id char(5) primary key, 
isim char(30),
sehir char(15),
ozel char(1)
); 
insert into hastaneler values('H101', 'Aci Madem Hastanesi', 'Istanbul', 'Y');
insert into hastaneler values('H102', 'HasZeki Hastanesi', 'Istanbul', 'N');
insert into hastaneler values('H103', 'Medikol Hastanesi', 'Izmir', 'Y');
insert into hastaneler values('H104', 'Memoryil Hastanesi', 'Ankara', 'Y');
select * from hastaneler;

 CREATE TABLE hastalar(
  kimlik_no CHAR(11) PRIMARY Key,
  isim CHAR(50) ,
  teshis  CHAR(20)
  );
  insert INTO hastalar values('12345678901','Ali Can','Gizli Seker');
    insert INTO hastalar values('45678901121','Ayse Yilmaz','Hipertansiyon');
    insert INTO hastalar values('78901123451','Steve Jobs','Pankreatit');
    insert INTO hastalar values('12344321251','Tom Hanks','COVID 19');
    
     
create table bolumler(
bolum_id char(5),
bolum_adi char(20)
);
insert into bolumler values('DHL','Dahiliye');
insert into bolumler values('KBB','Kulak Burun Bogaz');
insert into bolumler values('NRJ','Noroloji');
insert into bolumler values('GAST','Gastoroloji');
insert into bolumler values('KARD','Kardioloji');
insert into bolumler values('PSK','Psikiyatri');
insert into bolumler values('GOZ','Goz Hastaliklari');

create table hasta_kayitlar(
kimlik_no char(11) Primary key,
hasta_ismi char(20),
hastane_adi char(50),
bolum_adi char(20),
teshis char(20)
);
insert into hasta_kayitlar values('1111','NO NAME','','','');
insert into hasta_kayitlar values('2222','NO NAME','','','');
insert into hasta_kayitlar values('3333','NO NAME','','','');
insert into hasta_kayitlar values('4444','NO NAME','','','');
insert into hasta_kayitlar values('5555','NO NAME','','','');

select * from hastaneler
select * from hastalar
select * from bolumler
select * from hasta_kayitlar

/*
hasta_kayıtlar tablosundaki ‘3333’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : ‘Salvadore Dali’ ismi ile
hastane_adi: ‘John Hopins’
bolum_adi: ‘Noroloji’
teshis: ‘Parkinson’
kimlik_no: ‘99991111222’
*/

update hasta_kayitlar
set hasta_ismi='Salvaore Dali',
	hastane_adi='John Hopins',
	bolum_adi='Norolaji',
	teshis='Parkinson',
	kimlik_no=99991111222
	where kimlik_no='3333'

/*
hasta_kayıtlar tablosundaki ‘1111’ kimlik nolu kaydı aşağıdaki gibi güncelleyiniz.
hasta_isim : hastalar tablosundaki kimlik nosu ‘12345678901’ olan kişinin ismi ile
hastane_adi: hastaneler tablosundaki 'H104' bolum_id kodlu hastanenin ismi ile
bolum_adi: bolumler tablosundaki 'DHL' bolum_id kodlu bolum_adi ile
teshis: hastalar tablosundaki 'Ali Can' isimli hastanın teshis bilgisi ile
kimlik_no: hastalar tablosundaki 'Ali Can' isimli hastanın kimlik_no kodu ile
*/

update hasta_kayitlar
set hasta_ismi= (select isim from hastalar where kimlik_no='12345678901'),
	hastane_adi=(select isim from hastaneler where id='H104'),
	bolum_adi= (select bolum_adi from bolumler where bolum_id='DHL'),
	teshis=(select teshis from hastalar where isim='Ali Can'),
	kimlik_no=(select kimlik_no from hastalar where isim='Ali Can')
where kimlik_no='1111';

--DML->DELETE: Tablodaki verileri silmek için kullanılır
select * from calisanlar4;


--Syntax
delete from tablo_adi;


delete from calisanlar4; --Tüm verileri siler

delete from calisanlar4 where id='1235';

select * From calisanlar;
select *from aileler

/*
iliskili tablolarda parent tablodan direkt veeri silemeyiz ve tabloyu silemeyiz.
Eger iliskili tablolardan parent tablodan veri silme ihtimaliniz varsa tabloyu olustururken 
foreign key atamasi yaptigimiz child tabloya"ON DELETE CASCADE" komutu yazmamiz gerekir.
Bu komutu kullanmaz isek önce child tabloyu silmemiz gerekir.
sonra da parent tabloyu silebiliriz.
on delete cascade komtu kullandiginizda parentten bir veri silindiginde childdan da silinit.
*/

create table calisan(
id char(4),
isim varchar(50),
maas int,
primary key(id)
);
insert into calisan values('1001', 'Ahmet Aslan', 7000);
insert into calisan values('1002', 'Mehmet Yılmaz' ,12000);
insert into calisan values('1003', 'Meryem ', 7215);
insert into calisan values('1004', 'Veli Han', 5000);

create table aileler1 (
id char(4),
cocuk_sayisi int,
ek_gelir int,
foreign key(id)references calisan(id)
on delete cascade    
    
);
insert into aileler1 values('1001', 4, 2000);
insert into aileler1 values('1002', 2, 1500);
insert into aileler1 values('1003', 1, 2200);
insert into aileler1 values('1004', 3, 2400);

select * from calisan;--Bu tabloyu tamamen sildik.
select * from aileler1
delete from calisan where id='1001';
 
 drop table calisan cascade -- parent tabloyu tamamen datbaseden kaldirmak istersek b usekilde yazariz.




