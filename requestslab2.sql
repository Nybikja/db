-- 1) БД «Аеропорт». Знайдіть номери всіх рейсів, на яких курсує літак 'TU-134'. 
--  Вивести: trip_no, plane, town_from, town_to. Вихідні дані впорядкувати за спаданням за стовпцем time_out.
select trip_no, town_from, town_to from Trip where plane = 'TU-134' order by time_out;

-- 2
select distinct model from PC
where model like '%1%1%';

-- 3) БД «Кораблі». Знайдіть країни, що мали класи як звичайних бойових кораблів 'bb', так і класи крейсерів 'bc'.
--  Вивести: country, типи із класом 'bb', типи із класом 'bc'.
select distinct country, type from classes where type='bb' in (select distinct country from classes where type='bc');

-- 4
SELECT ship, battle, date FROM Battles JOIN Outcomes 
ON battle=name 
WHERE result LIKE 'damaged';

-- 5. БД «Комп. фірма». Знайдіть виробників принтерів, що випускають ПК із найменшим об’ємом RAM. Виведіть: maker.
SELECT DISTINCT maker
FROM product
WHERE model IN (
SELECT model
FROM pc
WHERE ram = (
  SELECT MIN(ram)
  FROM pc
  )
)
AND
maker IN (
SELECT maker
FROM product
WHERE type='printer'
);

--  6
select CONCAT("row: ",SUBSTRING(place, 1, 1)) as 'row', CONCAT("seat: ",SUBSTRING(place, 2, 1)) as 'seat'
from pass_in_trip;


-- 7. БД «Комп. фірма». Знайти тих виробників ПК, для яких не всі моделі ПК є в наявності в таблиці PC 
-- (використовувати засоби групової статистики). Вивести maker. 
SELECT p.maker
FROM product p
LEFT JOIN pc ON pc.model != p.model
WHERE p.type = 'PC'
GROUP BY p.maker;

-- 8
SELECT 
	Product.maker,
	COUNT(pc_data.model) AS PC,
	COUNT(laptop_data.model) AS Laptop,
	COUNT(printer_data.model) AS Printer 
FROM Product
LEFT OUTER JOIN 
	(SELECT maker,PC.model 
	FROM PC 
	JOIN Product 
	ON PC.model=Product.model) AS pc_data
ON Product.model=pc_data.model
LEFT OUTER JOIN 
	(SELECT maker,Laptop.model 
	FROM Laptop 
	JOIN Product 
	ON Laptop.model=Product.model) AS laptop_data
ON Product.model=laptop_data.model
LEFT OUTER JOIN 
	(SELECT maker,Printer.model 
	FROM Printer 
	JOIN Product 
	ON Printer.model=Product.model) AS printer_data
ON Product.model=printer_data.model
GROUP BY maker 
ORDER BY 1;

-- 9
SELECT outcome_o.point,
       outcome_o.date,
       outcome_o.out,
       income_o.inc
FROM   outcome_o
       LEFT OUTER JOIN income_o
                    ON outcome_o.point = income_o.point
                       AND outcome_o.date = income_o.date
GROUP  BY point,
          date;
          
-- 10
SELECT name FROM ships WHERE name like '% % %'
UNION
SELECT ship FROM outcomes WHERE ship like '% % %';