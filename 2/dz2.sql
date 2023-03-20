-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
-- Удаление БД с именем dz2, если она существует
DROP DATABASE IF EXISTS dz2;  
-- Создаем БД dz2, если она не существует
CREATE DATABASE IF NOT EXISTS dz2; 
-- Подключиться к БД 
USE dz2;

-- Создание таблицы
CREATE TABLE IF NOT EXISTS sales
(
	# имя_столбца тип_данных свойства
    id INT PRIMARY KEY AUTO_INCREMENT, 
    order_date DATE NOT NULL, 
    count_product INT 
);

-- Заполним таблицу данными
INSERT INTO sales (order_date, count_product)
VALUES 
    ('2022-01-01', 156),
	('2022-01-02', 180),
	('2022-01-03', 21),
	('2022-01-04', 124),
	('2022-01-05', 341);

SELECT * FROM sales;

-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300
-- До 100 - маленький заказ
-- 100 - 300 - средней заказ
-- больше 300 - большой заказ
SELECT 
	id AS "Номер заказа",
    order_date AS "Дата заказа",
    count_product AS "Количество" ,  
	IF (count_product < 100, "маленький заказ",
		IF(count_product BETWEEN 100 AND 300, "средней заказ","большой заказ"))
	AS "Тип заказа"
FROM sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
-- Создание таблицы
CREATE TABLE IF NOT EXISTS orders
(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    employee_id VARCHAR(20) NOT NULL, 
    amount DOUBLE NULL,
    order_status VARCHAR(20) NOT NULL
);

-- Заполним таблицу данными
INSERT orders  
VALUES
	(1, 'e03', 15.00, 'OPEN');

INSERT INTO orders (employee_id, amount, order_status)
VALUES 
	('e01', 25.50, 'OPEN'),
	('e05', 100.70, 'CLOSED'),
	('e02', 22.18, 'OPEN'),
	('e04', 9.50, 'CANCELLED');

SELECT *
FROM orders;

-- OPEN – «Order is in open state»
-- CLOSED - «Order is closed»
-- CANCELLED -  «Order is cancelled»

SELECT 
	id AS "Номер заказа",
    employee_id AS "id сотрудника",
    amount AS "Сумма",
    order_status AS "Статус заказа" , 
CASE
	WHEN order_status = "OPEN" THEN "Order is in open state"
    WHEN order_status = "CLOSED" THEN "Order is closed"
    WHEN order_status = "CANCELLED" THEN "Order is cancelled"
    ELSE "Error"
END AS  full_order_status
FROM orders;
