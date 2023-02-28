--Student isimli bir table olusturunuz.

create table students
(
	id smallint,
	isim varchar(50),
	adres varchar(100),
	sinav_notu smallint
);

--insert : veritabanina yeni veri ekler

insert into students values (120,'Ali Can','Ankara',65);
insert into students values ('121','Veli Han','Trabzon',75);
--integer sütünlara yalin yada tek tirnak icinde deger girilebilir.
insert into students values (122,'Ayse Tan','Bursa',85);
insert into students values (123,'Mary Star','Istanbul',95);
insert into students values (124,'Terry Star','Ankara',95);
insert into students values (125,'Herry Otar','Hatay',95);
insert into students values (126,'Sally Young','Isparta',100);
--varchar sütünlara tek tirnaklara icinde veri girilir.

--Soru:1 Students tablosundaki id ve isim stunlarini cagiriniz

select id,isim from students;

--Soru 2: Notu 85 üzeri olan ögrenci bilgilerinin tamamini cagiriniz

select * from students where sinav_notu>85;

--Soru 3: Adresi ankara olan ögrencilerin isimlerini cagiriniz

select isim from students where adres='Ankara';

--Soru 4: Notu 85 üzerinde olan ankarali ögrenci isimlerini cagiriniz.

select isim from students where sinav_notu>85 and adres='Ankara';

--Soru 5: Sinav notu 95 veya 65 olan ögrenci bilgilerini cagiriniz

--1.Yol
select * from students where sinav_notu=95 or sinav_notu=70;
--2.Yol
select * from students where sinav_notu in (70,95);

--Soru 6: Sinav notu 75 ve 95 arasinda olan ögrencilerin isimlerini cagiriniz.

--1.Yol
select isim from students where sinav_notu>=75 and sinav_notu<=95;
--2.Yol
select isim from students where sinav_notu between 75 and 95; --Önce kücük yazilmalidir, parantez kullanilmaz.

--Sorru 7: id si 122 ile 125 arasinda olmayan ögrencilerin adreslerini yazdiriniz.

--1.Yol
select adres from students where id<122 or id>125;
--2.Yol
select adres from students where id not between 122 and 125; --Cagiralacaklara sinirlar dahil degil
--3.Yol
select adres from students where id not in (122,123,124,125);

--Soru 8: Adresi hatay olan satiri siliniz.
delete from students where adres='Hatay';

--Soru 9: isimi ali can ve veli han olan satirlari(record/row) siliniz.

--1.Yol
delete from students where isim='Ali Can' or isim='Veli Han';
--2.Yol:IN
delete from students where isim in('Ali Can','Veli Han');


--Tüm satirlari sil
delete from students; 

Truncate students; --Veriler geri gelmeyecek sekilde silinir. where ile kullanilmaz.Delete ile farki bir satiri silmez ve gri getirilemez.

select * from students;

--students table'ini siliniz

drop table students;






