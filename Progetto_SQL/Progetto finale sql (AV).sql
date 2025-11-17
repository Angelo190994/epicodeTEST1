create database ToyGroup2;
use ToyGroup2;

create table Product (
IDProduct int primary key,
NameProduct varchar(50),
Category varchar(50)
);

insert into Product(IDProduct,NameProduct,Category) values
(1,'Robot','Giocattoli'),
(2,'Dinosauri','Giocattoli'),  
(3,'Puzzle','Giocattoli'),
(4, 'Auto radioco', 'Giocattoli'),
(5, 'Gormiti', 'Giocattoli'),
(6, 'Barbie', 'Bambole'),
(7, 'Animali', 'Giocattoli'),
(8, 'Lego', 'Giochi costruzioni'),
(9, 'Yo-yo', 'Giocattoli'),
(10, 'Cucina', 'Giocattoli');


create table Region (
IDRegion int primary key,
NameRegion varchar(50),
Country varchar(50));


INSERT INTO Region (IDregion, Nameregion,Country)
VALUES
  (1, 'Honk Kong','Cina'),
  (2, 'Hanoi','Vietnam'),
  (3, 'Varsavia','Polonia'),
  (4, 'Madrid','Spagna'),
  (5, 'Lisbona','Portogallo'),
  (6, 'Milano','Italia'),
  (7, 'Berlino','Germania'),
  (8, 'Tokyo','Giappone'),
  (9,'Vienna','Austria'),
  (10,'Parigi','Francia');
  
  
  
  create table Sales (
IDSales int primary key,
IDProduct int,
IDRegion int,
OrderDate date,
SalesAmount decimal(10,2),
foreign key (IDRegion) references Region(IDRegion),
foreign key (IDProduct) references Product(IDProduct)
); 

INSERT INTO Sales (IDSales, IDProduct, IDRegion, OrderDate, SalesAmount)
VALUES
  (1, 1, 1, '2021-01-01', 20.00),
  (2, 2, 2, '2021-01-02', 15.00),
  (3, 3, 1, '2021-01-03', 10.50),
  (4, 4, 4, '2021-01-05', 35.00),
  (5, 5, 3, '2021-01-06', 18.50),
  (6, 6, 1, '2021-01-07', 25.00),
  (7, 7, 5, '2021-01-08', 12.00),
  (8, 8, 4, '2021-01-09', 22.50),
  (9, 9, 4, '2021-01-10', 8.00),
  (10, 10, 8, '2021-01-11', 27.50);
  
  
  -- Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.
  select product.NameProduct, year(sales.orderdate) as anno,
  sum(sales.SalesAmount) as fatturato
  from sales
  inner join product 
  on sales.IDProduct=product.IDProduct
  group by product.NameProduct, anno;
  

-- Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. 
select region.Country, year(sales.orderdate) as anno,
  sum(sales.SalesAmount) as fatturato
  from sales
  inner join region
  on region.IDRegion=sales.IDRegion
  group by region.Country, anno
  order by  fatturato desc;
  
  -- qual è la categoria di articoli maggiormente richiesta dal mercato? 
  select product.Category, sum(sales.salesamount) as totalevendite
  from product
  join sales on product.IDProduct=sales.IDProduct
  group by product.Category
  order by totalevendite desc;
  
  -- Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente)
  select product.NameProduct, max(sales.orderdate) as ultimadata
  from product
  join sales on product.IDProduct=sales.IDProduct
  group by product.NameProduct;
  
  -- quali sono, se ci sono, i prodotti invenduti? Proponi due approcci 
-- 1
SELECT *
FROM Product
WHERE Product.IDproduct NOT IN (SELECT Sales.idproduct FROM Sales);
  
  -- 2 
  select product.IDProduct, product.NameProduct, count(sales.salesamount) as totalevendite 
  from product
  join sales on product.IDProduct=sales.IDProduct
  group by product.IDProduct having totalevendite=0;