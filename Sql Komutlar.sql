Select * from Products

/* Columnlara as ile �d ve name ad� verdik */
Select ProductId as Id ,ProductName as Name from Products

/* T�m sto�u eritirsek her bir �r�n i�in ka� para kazan�r�z */
Select p.ProductName,p.UnitsInStock * p.UnitPrice as Total from Products p

/* 3� yanyana getirir. */
Select p.ProductName + ' - ' + p.QuantityPerUnit  from Products p

Select 'Engin Demiro�' as Egitmen

Select 9*8 as Sonuc

/* Where ile category�d 1 olanlar� �a��rd�k */
Select * from Products where CategoryID=1 

/*Stoklar� 10 dan fazla �r�nleri bana getir.*/
Select * from Products where UnitsInStock>10

/*Stoktan azalm�� �r�nleri bana g�ster- 5 ten az olmas� azalm�� demek*/
Select * from Products where UnitsInStock<5

/* Stokta hi� kalmayan ve sipari�te bekleyen �r�n*/
Select * from Products where UnitsInStock=0 and UnitsOnOrder>0

/* Stok adedi 0 olanlar ya da sipari�i hi� olmayan �r�nler*/
Select * from Products where UnitsInStock=0 or UnitsOnOrder>0

/* Chai d���ndakileri ve stok adedi 0 olanlar� getir*/
Select * from Products where not ProductName='Chai' and UnitsInStock=0

/* ordey by metinsel ise alfabetik, say�sal ise numerik s�ralama ger�ekle�tirir. */ 
Select * from Products order by ProductName

/* Ucuzdan pahal�ya s�ralar*/
Select * from Products order by UnitPrice

/* Pahal�dan ucuza s�ralar*/
Select * from Products order by UnitPrice desc
/* Alfabeyi tersten s�ralar*/
Select * from Products order by ProductName desc

/* asc do�ru desc tersten s�ralar */ 

/* ba�� ch sonu ne oldu�u belli de�il demek */
Select * from Products where ProductName like 'ch%'

/* i�inde ch olan �r�nleri getirir */
Select * from Products where ProductName like '%ch%'

/* 10 ve 46 aras�ndaki s�ralar*/
Select * from Products where UnitPrice between 10 and 46 order by UnitPrice

/* Kategorisi 1 veya 2 olanlar� getirir*/
Select * from Products where CategoryID in (1,2)

--Aggregeation Function
/* Count fonksiyonlar� nulllar� saymaz*/
/* Count (*) sat�r says�n� verdi- her iki komut da ayn� i�levi yapar*/
Select Count(*) as [�r�n Say�s�] from Products
Select COUNT (ProductName) from Products

/* Count * sat�r say�s�n� verir, count (Region) ka� b�lge oldu�unu verir*/
Select COUNT(Region) from Customers

Select MIN(UnitPrice) from Products
Select MAX(UnitPrice) from Products

/*Ortalama bir �r�n�n fiyat�*/
Select AVG(UnitPrice) from Products

Select SUM(UnitPrice * Quantity) as Kazan� from [Order Details]

/*Rastgele Say� �retmeye Yar�yor*/
Select RAND()

--STRING FUNCTION
/*Metnin solundan 3 karakter al demek*/
Select LEFT (ProductName,3) from Products

/*Metnin sa��ndan 3 karakter al demek*/
Select RIGHT (ProductName,3) from Products

/* Ka� karakter oldu�unu yani uzunlu�unu sayar*/
Select ProductName, LEN(ProductName) as Karakter from Products

/*hepsini k���k harfe �evirir*/
Select LOWER('EnGIN dEmIrOG')

/*hepsini b�y�k harfe �evirir*/
Select UPPER('EnGIN dEmIrOG')

/*gereksiz bo�uklar� kapat�r ba� ve sondaki*/
Select TRIM('  engin demirog     ')

Select TRIM(ProductName) from Products where TRIM (ProductName)='Chai'

/*sa�daki bo�lu�u atmaya yarar*/
Select LTRIM('  engin demirog     ')

/*soldaki bo�lu�u atmaya yarar*/
Select RTRIM('  engin demirog     ')

/*Metni tersten yazmaya yarar*/
Select REVERSE('Engin Demiro�')

/*Bir metnin i�erisinde ba�ka bir metin ge�iyormu bakmak i�in kullan�l�r*/
--n harfini engin demiro� da 1. karakterden aramaya ba�la demek
Select CHARINDEX('n', 'Engin Demiro�',1)

Select ProductName from Products where CHARINDEX
(' ', ProductName,1)>0

/*Bir karakter toplulu�unu ba�ka bir karakter toplulu�uyla de�i�tirmeye yarar*/
--hangi metin de�i�ecek, o metinde ne de�i�ecek, ne ile de�i�icek
Select REPLACE('Engin demiro�',' ',' _ ')

Select REPLACE(ProductName, ' ', ' _ ') from Products

/*Metni par�alama yarar*/
--1.karakterden itibaren 5 tane par�ala
Select SUBSTRING('Engin Demiro�',1,5)

/*Klavyede yaz�lan karakterin bilgisyardaki kar��l���n� verir*/
Select Ascii('A')

/*Ascii kodu verilen de�erin karakter kar�l���n� verir*/
Select CHAR(65)

/* bir kolondaki tekrarlayan kay�tlar� tekrarlamadan bir kere getirmeye yarar*/

/* customer tablosundaki countyleri s�rayla bir defa getirir*/
Select distinct Country from Customers order by Country

/* Group by belirlenen kolona g�re gruplar*/
/* Her �lkede ka�ar tane m��teri oldu�unu g�sterir */
Select Country, COUNT(*) as Adet from Customers group by Country

/* group by arka planda her grup i�in bir liste olu�turur, her bir listeye ayr� ayr� sorgu yazman�n �art koyman�n y�ntemi having */
/*having count(*), sum gibi durumlarda kullan�l�r where ko�ulu verimizi filtrelemeye y�nelik kullan�l�r*/
-- �lke ve �ehir baz�nda birden fazla m��terimiz nerelerde var ?
Select Country,City,COUNT(*) as Adet from Customers 
group by Country,City
having COUNT(*)>1 order by Country

/*JOINLER*/
/* inner join iki tabloda �art konusunda e�le�enleri getirir di�erlerini getirmez*/
/* Product ve Categoride tablolar�ndan her �eyi getir*/
Select * from Products inner join Categories
on Products.CategoryID=Categories.CategoryID
where Products.UnitPrice>20
order by Categories.CategoryID

--yukar�daki kod par�as�n�n ayn�s� yaz�m �ekli de�i�ik
Select * from Products p inner join Categories c
on p.CategoryID=c.CategoryID
where p.UnitPrice>20
order by c.CategoryID

/* bug�ne kadar hangi �r�nden ne kadar sipari� ald�k �r�n ismi,sipari� al�nan tarihi,sipari�ten kazan�lan tutar */
Select p.ProductName,o.OrderDate,od.Quantity 
from Products p inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Orders o
on o.OrderID=od.OrderID
order by p.ProductName,o.OrderDate

/* left join e�le�meyen verileri de getirir */
/* soldaki tabloda olup sa�daki tabloda olanlar� da  olmayanlar�da getir demek*/
/* sto�umuzda sat��� hi� yap�lmayan �r�nler nelerdir*/
Select * from Products p left join [Order Details] od
on p.ProductID = od.ProductID
where od.ProductID is null

/* hi� sat�� yapamad���m�z m��teriler*/
Select * from Customers c left join Orders o
on c.CustomerID = o.CustomerID
where o.CustomerID is null

/* right join sa�daki tabloda olup soldaki tabloda olanlar� da  olmayanlar�da getir demek*/
Select c.ContactName,c.CustomerID from Orders o right join Customers c
on o.CustomerID = c.CustomerID
where o.CustomerID is null

/* full join: inner, left, right olanlar� getirir*/
Select * from Customers c full join Orders o 
on o.CustomerID = c.CustomerID

/* Hi� sat�� yapamayan personelimiz var m�? Kimlerdir?*/
Select * from Employees e left join Orders o
on e.EmployeeID = o.EmployeeID
where o.EmployeeID is null

/* Hangi �r�nden ka� tane satm���z?*/
Select p.ProductName, COUNT(*) as Adet from Products p inner join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductName
order by p.ProductName

/*Kampanya yap�lan �r�nlerden ka�ar tane satm���z*/
Select p.ProductName, COUNT(*) as Adet from Products p inner join [Order Details] od
on p.ProductID = od.ProductID
where od.Discount>0
group by p.ProductName
order by p.ProductName

/* Hangi kategoriden ka� tane �r�n satm���z?*/
Select c.CategoryName,COUNT(*) as Adet from Products p inner join Categories c
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName

/* tek tablo, Bir kolonda �al��an�n ismi, di�er kolonda bu �al��an�n �st� kim*/
Select e2.FirstName + ' ' +e2.LastName as Personel,
e1.FirstName + ' ' +e1.LastName as �st�
from Employees e1 inner join Employees e2
on e1.EmployeeID = e2.ReportsTo

/*insert*/
/*Categori tablosuna CategoryName,Description kolonlar�n� ekle */
insert into Categories (CategoryName,Description)
values ('Test Categoy','Test Category Description')

insert into [Order Details] values (10248,12,12,10,0)

/*update*/
/* Territories de ki a��klamalar� tamamen de�i�tiri*/
update Territories set TerritoryDescription = '�� Anadolu'

/*Sadece 10. categoryi d�zenle*/
update Categories set CategoryName='Test Category 2'
where CategoryID=10

/*Birden fazla kolona g�ncelleme*/
update Categories set CategoryName='Test Category 3',
Description='Test Category 3 Description'
where CategoryID>=9

/*delete*/
/*yukar�da ekledi�imiz k�sm� sildik*/
delete from Categories where CategoryID>=9

Select * from CustomersWork

insert into CustomersWork (CustomerID,ContactName,CompanyName)
select CustomerID,ContactName,CompanyName from Customers

delete from CustomersWork

insert into CustomersWork (CustomerId,ContactName,CompanyName)
select CustomerId,ContactName,CompanyName from Customers
where ContactName like '%en%'

update Customers set CompanyName = CustomersWork.CompanyName
from
Customers inner join CustomersWork
on CustomersWork.CustomerID=CustomersWork.CustomerID
where CustomersWork.CompanyName like '&Test&'

Select * from Customers

delete Customers
from Customers inner join CustomersWork
on CustomersWork.CustomerID=CustomersWork.CustomerID
where CustomersWork.CompanyName like '&Test&'

/* union */
/* join iki tabloyu yanyana getirir union alt alta getirir*/

/* union iki sorguyu bi ara getirirken farkl� olanlar� getirir*/
/* kolonlar�n e�it olmas� gerekiyor*/
/* farkl�lar� de�il hepsini getirmek istersen all ekleir*/
Select CustomerID, CompanyName, ContactName from Customers
union all
Select * from CustomersWork