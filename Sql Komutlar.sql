Select * from Products

/* Columnlara as ile ýd ve name adý verdik */
Select ProductId as Id ,ProductName as Name from Products

/* Tüm stoðu eritirsek her bir ürün için kaç para kazanýrýz */
Select p.ProductName,p.UnitsInStock * p.UnitPrice as Total from Products p

/* 3ü yanyana getirir. */
Select p.ProductName + ' - ' + p.QuantityPerUnit  from Products p

Select 'Engin Demiroð' as Egitmen

Select 9*8 as Sonuc

/* Where ile categoryýd 1 olanlarý çaðýrdýk */
Select * from Products where CategoryID=1 

/*Stoklarý 10 dan fazla ürünleri bana getir.*/
Select * from Products where UnitsInStock>10

/*Stoktan azalmýþ ürünleri bana göster- 5 ten az olmasý azalmýþ demek*/
Select * from Products where UnitsInStock<5

/* Stokta hiç kalmayan ve sipariþte bekleyen ürün*/
Select * from Products where UnitsInStock=0 and UnitsOnOrder>0

/* Stok adedi 0 olanlar ya da sipariþi hiç olmayan ürünler*/
Select * from Products where UnitsInStock=0 or UnitsOnOrder>0

/* Chai dýþýndakileri ve stok adedi 0 olanlarý getir*/
Select * from Products where not ProductName='Chai' and UnitsInStock=0

/* ordey by metinsel ise alfabetik, sayýsal ise numerik sýralama gerçekleþtirir. */ 
Select * from Products order by ProductName

/* Ucuzdan pahalýya sýralar*/
Select * from Products order by UnitPrice

/* Pahalýdan ucuza sýralar*/
Select * from Products order by UnitPrice desc
/* Alfabeyi tersten sýralar*/
Select * from Products order by ProductName desc

/* asc doðru desc tersten sýralar */ 

/* baþý ch sonu ne olduðu belli deðil demek */
Select * from Products where ProductName like 'ch%'

/* içinde ch olan ürünleri getirir */
Select * from Products where ProductName like '%ch%'

/* 10 ve 46 arasýndaki sýralar*/
Select * from Products where UnitPrice between 10 and 46 order by UnitPrice

/* Kategorisi 1 veya 2 olanlarý getirir*/
Select * from Products where CategoryID in (1,2)

--Aggregeation Function
/* Count fonksiyonlarý nulllarý saymaz*/
/* Count (*) satýr saysýný verdi- her iki komut da ayný iþlevi yapar*/
Select Count(*) as [Ürün Sayýsý] from Products
Select COUNT (ProductName) from Products

/* Count * satýr sayýsýný verir, count (Region) kaç bölge olduðunu verir*/
Select COUNT(Region) from Customers

Select MIN(UnitPrice) from Products
Select MAX(UnitPrice) from Products

/*Ortalama bir ürünün fiyatý*/
Select AVG(UnitPrice) from Products

Select SUM(UnitPrice * Quantity) as Kazanç from [Order Details]

/*Rastgele Sayý Üretmeye Yarýyor*/
Select RAND()

--STRING FUNCTION
/*Metnin solundan 3 karakter al demek*/
Select LEFT (ProductName,3) from Products

/*Metnin saðýndan 3 karakter al demek*/
Select RIGHT (ProductName,3) from Products

/* Kaç karakter olduðunu yani uzunluðunu sayar*/
Select ProductName, LEN(ProductName) as Karakter from Products

/*hepsini küçük harfe çevirir*/
Select LOWER('EnGIN dEmIrOG')

/*hepsini büyük harfe çevirir*/
Select UPPER('EnGIN dEmIrOG')

/*gereksiz boþuklarý kapatýr baþ ve sondaki*/
Select TRIM('  engin demirog     ')

Select TRIM(ProductName) from Products where TRIM (ProductName)='Chai'

/*saðdaki boþluðu atmaya yarar*/
Select LTRIM('  engin demirog     ')

/*soldaki boþluðu atmaya yarar*/
Select RTRIM('  engin demirog     ')

/*Metni tersten yazmaya yarar*/
Select REVERSE('Engin Demiroð')

/*Bir metnin içerisinde baþka bir metin geçiyormu bakmak için kullanýlýr*/
--n harfini engin demiroð da 1. karakterden aramaya baþla demek
Select CHARINDEX('n', 'Engin Demiroð',1)

Select ProductName from Products where CHARINDEX
(' ', ProductName,1)>0

/*Bir karakter topluluðunu baþka bir karakter topluluðuyla deðiþtirmeye yarar*/
--hangi metin deðiþecek, o metinde ne deðiþecek, ne ile deðiþicek
Select REPLACE('Engin demiroð',' ',' _ ')

Select REPLACE(ProductName, ' ', ' _ ') from Products

/*Metni parçalama yarar*/
--1.karakterden itibaren 5 tane parçala
Select SUBSTRING('Engin Demiroð',1,5)

/*Klavyede yazýlan karakterin bilgisyardaki karþýlýðýný verir*/
Select Ascii('A')

/*Ascii kodu verilen deðerin karakter karþlýðýný verir*/
Select CHAR(65)

/* bir kolondaki tekrarlayan kayýtlarý tekrarlamadan bir kere getirmeye yarar*/

/* customer tablosundaki countyleri sýrayla bir defa getirir*/
Select distinct Country from Customers order by Country

/* Group by belirlenen kolona göre gruplar*/
/* Her ülkede kaçar tane müþteri olduðunu gösterir */
Select Country, COUNT(*) as Adet from Customers group by Country

/* group by arka planda her grup için bir liste oluþturur, her bir listeye ayrý ayrý sorgu yazmanýn þart koymanýn yöntemi having */
/*having count(*), sum gibi durumlarda kullanýlýr where koþulu verimizi filtrelemeye yönelik kullanýlýr*/
-- ülke ve þehir bazýnda birden fazla müþterimiz nerelerde var ?
Select Country,City,COUNT(*) as Adet from Customers 
group by Country,City
having COUNT(*)>1 order by Country

/*JOINLER*/
/* inner join iki tabloda þart konusunda eþleþenleri getirir diðerlerini getirmez*/
/* Product ve Categoride tablolarýndan her þeyi getir*/
Select * from Products inner join Categories
on Products.CategoryID=Categories.CategoryID
where Products.UnitPrice>20
order by Categories.CategoryID

--yukarýdaki kod parçasýnýn aynýsý yazým þekli deðiþik
Select * from Products p inner join Categories c
on p.CategoryID=c.CategoryID
where p.UnitPrice>20
order by c.CategoryID

/* bugüne kadar hangi üründen ne kadar sipariþ aldýk ürün ismi,sipariþ alýnan tarihi,sipariþten kazanýlan tutar */
Select p.ProductName,o.OrderDate,od.Quantity 
from Products p inner join [Order Details] od
on p.ProductID=od.ProductID
inner join Orders o
on o.OrderID=od.OrderID
order by p.ProductName,o.OrderDate

/* left join eþleþmeyen verileri de getirir */
/* soldaki tabloda olup saðdaki tabloda olanlarý da  olmayanlarýda getir demek*/
/* stoðumuzda satýþý hiç yapýlmayan ürünler nelerdir*/
Select * from Products p left join [Order Details] od
on p.ProductID = od.ProductID
where od.ProductID is null

/* hiç satýþ yapamadýðýmýz müþteriler*/
Select * from Customers c left join Orders o
on c.CustomerID = o.CustomerID
where o.CustomerID is null

/* right join saðdaki tabloda olup soldaki tabloda olanlarý da  olmayanlarýda getir demek*/
Select c.ContactName,c.CustomerID from Orders o right join Customers c
on o.CustomerID = c.CustomerID
where o.CustomerID is null

/* full join: inner, left, right olanlarý getirir*/
Select * from Customers c full join Orders o 
on o.CustomerID = c.CustomerID

/* Hiç satýþ yapamayan personelimiz var mý? Kimlerdir?*/
Select * from Employees e left join Orders o
on e.EmployeeID = o.EmployeeID
where o.EmployeeID is null

/* Hangi üründen kaç tane satmýþýz?*/
Select p.ProductName, COUNT(*) as Adet from Products p inner join [Order Details] od
on p.ProductID = od.ProductID
group by p.ProductName
order by p.ProductName

/*Kampanya yapýlan ürünlerden kaçar tane satmýþýz*/
Select p.ProductName, COUNT(*) as Adet from Products p inner join [Order Details] od
on p.ProductID = od.ProductID
where od.Discount>0
group by p.ProductName
order by p.ProductName

/* Hangi kategoriden kaç tane ürün satmýþýz?*/
Select c.CategoryName,COUNT(*) as Adet from Products p inner join Categories c
on p.CategoryID = c.CategoryID
inner join [Order Details] od
on od.ProductID = p.ProductID
group by c.CategoryName

/* tek tablo, Bir kolonda çalýþanýn ismi, diðer kolonda bu çalýþanýn üstü kim*/
Select e2.FirstName + ' ' +e2.LastName as Personel,
e1.FirstName + ' ' +e1.LastName as Üstü
from Employees e1 inner join Employees e2
on e1.EmployeeID = e2.ReportsTo

/*insert*/
/*Categori tablosuna CategoryName,Description kolonlarýný ekle */
insert into Categories (CategoryName,Description)
values ('Test Categoy','Test Category Description')

insert into [Order Details] values (10248,12,12,10,0)

/*update*/
/* Territories de ki açýklamalarý tamamen deðiþtiri*/
update Territories set TerritoryDescription = 'Ýç Anadolu'

/*Sadece 10. categoryi düzenle*/
update Categories set CategoryName='Test Category 2'
where CategoryID=10

/*Birden fazla kolona güncelleme*/
update Categories set CategoryName='Test Category 3',
Description='Test Category 3 Description'
where CategoryID>=9

/*delete*/
/*yukarýda eklediðimiz kýsmý sildik*/
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

/* union iki sorguyu bi ara getirirken farklý olanlarý getirir*/
/* kolonlarýn eþit olmasý gerekiyor*/
/* farklýlarý deðil hepsini getirmek istersen all ekleir*/
Select CustomerID, CompanyName, ContactName from Customers
union all
Select * from CustomersWork