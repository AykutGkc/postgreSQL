/*
SORU1: memurlar isminde bir tablo oluşturunuz. 
id, isim, maas, mezuniyet sutunları olsun.
id sutununun data tipi int olsun. PRİMARY KEY kısıtlaması olsun.
isim sutununun data tipi varchar(30) olsun. UNIQUE kısıtlaması olsun.
maas sutununun data tipi int olsun. maas 5000 buyuk olsun.
mezuniyet sutununun data tipi varchar(25) olsun. NOT NULL kısıtlaması olsun.    
*/

create table memurlar  
(
id int PRIMARY KEY,            
isim varchar(30) UNIQUE,       
maas int CHECK(maas>5000),      
mezuniyet varchar(25) NOT NULL   
);

insert into memurlar values(1,'Ali',10000,'Lisans');
insert into memurlar values(2,'Ahmet',15000,'Yüksek Lisans');
insert into memurlar values(3,'Altug',20000,'Lisans');
insert into memurlar values(4,'Elif',18000, 'Lisans');

select * from memurlar;

insert into memurlar values(1,'Zulal',20000,'Lise');       		-- PRIMARY KEY SEBEBİYLE EROR VERİR   
insert into memurlar values(5,'Altug',25000,'Yüksek Lisans');   -- UNIQUE SEBEBİYLE EROR VERİR 
insert into memurlar values(6,'Hayri',4000,'Lisans');		   	-- CHECK SEBEBİYLE EROR VERİR
insert into memurlar values(7,'Burak',30000,null);		  		-- NOT NULL SEBEBİYLE EROR VERİR

/*
SORU2: insanlar isminde bir tablo oluşturunuz. 
isim, soyisim sutunları olsun.
isim sutununun data tipi varchar(20) olsun.
soyisim sutununun data tipi varchar(30) olsun. 


isim sutununda PRİMARY KEY kısıtlaması olsun. Kısıtlamanın isimi pr_ks olsun.
soyisim sutununda UNIQUE kısıtlaması olsun. Kısıtlamanın ismi uni_ks olsun.

*/

create table insanlar (
isim varchar(20),
soyisim varchar(30),
	
constraint insanlar_primary_keydir primary key(isim),
constraint uni_ks unique(soyisim)
)

insert into insanlar values('Harun','Tan');
insert into insanlar values('Azra','Can');

insert into insanlar values('Harun','Kan'); -- Primary key sebebiyle error verir
insert into insanlar values(null,'Er');     -- Primary key sebebiyle error verir
insert into insanlar values('Kudret','Can'); -- Unique sebebiyle error verir.


/*
SORU3: hayvanlar isminde bir tablo oluşturunuz. 
isim, cins sutunları olsun.
isim sutununun data tipi varchar(20) olsun.
cins sutununun data tipi varchar(25) olsun.

isim ve cins sutunları birlesiminden bir PRIMARY KEY kısıtlaması olsun.(Composite Primary Key)
*/

create table hayvanlar(
isim varchar(20),
cins varchar(25),

constraint com_pk_ks primary key(isim,cins)
)

insert into hayvanlar values('Findik','Süs Kopegi');
insert into hayvanlar values('Findik','Coban Kopegi');
insert into hayvanlar values('Duman','Süs Kopegi');
insert into hayvanlar values('Findik','Süs Kopegi'); --Composite primary key sebebiyle error verdi.

select * from hayvanlar;

/*

NOT: CONSTRAINT'leri sutun isimlerinin altında belirtmenin bize sagladıgı kolaylık;

1) CONSTRAINT ismini kendimiz belirleyebiliyoruz

2) COMPOSİTE PRIMARY KEY yapmamıza imkan veriyor. (iki sutunun birlesiminden bir Primary Key olusturulmasına)

*/

create table emekciler
(
id char(5) PRIMARY KEY,   ---> UNIQUE + NOT NULL
isim varchar(50) UNIQUE,
maas int NOT NULL
);


insert into emekciler values(10002, 'Mehmet Yılmaz', 12000);
insert into emekciler values(10008, null, 5000);
insert into emekciler values(10010, null,5000);
insert into emekciler values(10020, null, 5000);
insert into emekciler values(10004, 'Veli Han', 5000);
insert into emekciler values(10005, 'Mustafa Ali', 5000);
insert into emekciler values(10006, 'Canan Yaş', null);  -- maas null olamaz
insert into emekciler values(10003, 'CAN', 5000);
insert into emekciler values(10007, 'CAN', 5000);   -- unique
insert into emekciler values(10009, 'Cem', '12');    -- int
insert into emekciler values('', 'osman', 2000);
insert into emekciler values('', 'osman can', 2000); -- primary key 
insert into emekciler values('', 'veli can', 6000);  -- primary key
insert into emekciler values(10002, 'ayse Yılmaz', 12000);  -- primary key
insert into emekciler values(null, 'filiz', 12000);  -- primary key

/*----------------------------FOREGIN KEY---------------------------------------------------

	FOREGIN KEY --> Başka bir tablodaki PRİMARY KEY'i referans göstermek için kullanılır. 
	Böylelikle, tablolar arasında parent child ilişkisi oluşur.
	
	FOREIGN KEY'in bulundugu tablo Child tablodur.
	PRIMARY KEY'in bulundugu tablo ise Parent tablodur.

	FOREIGN KEY KISITLAMASI SAYESİNDE:
	---------------------------------
	
	1-) parent tabloda olmayan primary key ile child tabloya veri girişi yapılamaz
	(child tablo null deger kabul eder)

	2-) child tablodaki veri silinmeden parent tablodaki veri silinemez

	3-) child tablo silinmeden parent tablo silinemez
----------------------------------------------------------------------------------------------*/

create table hastaneler
(
hastane_adi varchar(30) ,
adres varchar(30),
alan_kodu int,
	
constraint hastane_c_k primary key(hastane_adi)
);
insert into hastaneler values('Meddem', 'Isparta', '0246');
insert into hastaneler values('Sifa', 'Ankara', '0236');
insert into hastaneler values('Davraz', 'Istanbul', '0216');
insert into hastaneler values('Deva', 'Antalya', '0242');


create table doktorlar
(
gorev_yeri varchar(30),
doktor_adi varchar(30),
diploma_no int,
brans_adı varchar(30),
adres varchar(30),
	
CONSTRAINT fk FOREIGN KEY(gorev_yeri) REFERENCES hastaneler(hastane_adi)
	
);	
select * from doktorlar;

insert into doktorlar values('Meddem', 'Hasan Bal', '123456', 'psikiyatri');
insert into doktorlar values('Sifa', 'Vedat Sen', '123865', 'pediatri');
insert into doktorlar values('Davraz', 'Huseyin Oz', '123568', 'noroloji');
insert into doktorlar values('Deva', 'Ahmet Kar', '123852', 'dahiliye');
insert into doktorlar values('Meddem', 'Hakan Kar', '123369', 'dermatoloji');
insert into doktorlar values('Sifa', 'Ramiz Kara', '123147', 'anestezi');
insert into doktorlar values('Davraz', 'Okan Pul', '123147', 'ortopedi');


--SORU 1: doktorlar tablosuna gorev_yeri 'Meddem' olan veri girişi yapınız

insert into doktorlar values ('Meddem','Hakki Öz',159624,'noroloji');

--SORU 2: .doktorlar tablosuna gorev_yeri 'Okmeydanı' olan veri girişi yapınız.

insert into doktorlar values('Okmeydanı','Hatice Kar',145796,'ortopedi'); -- bu sebeple bu kod calısmaz

--SORU 3: doktorlar tablosuna gorev_yeri null olan veri girişi yapınız

insert into doktorlar values(null,'Hasim Dal',148627,'noroloji');
--> child tablo null deger kabul eder

--SORU 4: .hastaneler tablosundaki hastane_adi 'Meddem' olan veriyi siliniz. 

--> child tablodaki veri silinmeden parent tablodaki veri silinemez

delete from hastaneler where hastane_adi='Meddem'; -- bu sebeple bu kod eror verir.

--SORU 5: doktorlar tablosundaki gorev_yeri 'Meddem' olan verileri siliniz

delete from doktorlar where gorev_yeri='Meddem';

--SORU 6: .hastaneler tablosundaki hastane_adi 'Meddem' olan veriyi siliniz 

delete from hastaneler where hastane_adi='Meddem';

--SORU 7: .hastaneler tablosunu siliniz. 

--> child tablo silinmeden parent tablo silinemez

drop table hastaneler;  -- bu sebeple bu kod eror verir


select * from doktorlar;

--SORU 8: doktorlar tablosunu siliniz 

alter table doktorlar drop column gorev_yeri;

drop table doktorlar;


--SORU 7: .hastaneler tablosunu siliniz. 

drop table hastaneler;



select * from doktorlar;


