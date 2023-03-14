create table memurlar
(
id int,
isim varchar(20),
soyisim varchar(25),
maas int,
sicil_notu int
);


insert into memurlar values(1,'Ali','Ozturk',50000,100);
insert into memurlar values(2,'Adem','Tan',40000,90);
insert into memurlar values(3,'Halit','Ozyıldızlı',35000,85);
insert into memurlar values(4,'Hasan','Oz',45000,95);
insert into memurlar values(5,'Recep','Cicek',30000,80);
insert into memurlar values(6,'Harun','Sever',20000,70);
insert into memurlar values(7,'Hatice','Tarkan',25000,75);
insert into memurlar values(8,'Poyraz','Yuzbası',10000,60);
insert into memurlar values(9,'Ayse','Karlı',15000,65);
insert into memurlar values(10,'Adem','Akmaz',9000,55);


-- SORU1: memurlar tablosunda id'si 5'den buyuk olan,
-- ilk 2 veriyi listeleyiniz