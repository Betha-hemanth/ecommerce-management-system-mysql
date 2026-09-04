CREATE DATABASE online_ecommerce_management;

USE online_ecommerce_management;


CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number BIGINT UNIQUE,
    city VARCHAR(50),
    registration_date DATE
);


CREATE TABLE addresses(
    address_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_type VARCHAR(20) NOT NULL,
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


CREATE TABLE categories(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);


CREATE TABLE products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    seller_name VARCHAR(50),

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);


CREATE TABLE orders(
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    shipping_address_id INT,
    order_status VARCHAR(20) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (shipping_address_id)
        REFERENCES addresses(address_id)
);


CREATE TABLE order_items(
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


CREATE TABLE payments(
    payment_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


CREATE TABLE reviews(
    review_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT,
    review_text VARCHAR(255),
    review_date DATE,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CHECK (rating BETWEEN 1 AND 5)
);


CREATE TABLE coupons(
    coupon_id INT PRIMARY KEY,
    coupon_code VARCHAR(20) UNIQUE NOT NULL,
    discount_percentage DECIMAL(5,2),
    minimum_order_amount DECIMAL(10,2),
    expiry_date DATE
);


CREATE TABLE order_coupons(
    order_id INT,
    coupon_id INT,
    discount_amount DECIMAL(10,2),

    PRIMARY KEY (order_id, coupon_id),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (coupon_id)
        REFERENCES coupons(coupon_id)
);



INSERT INTO customers
(customer_id, customer_name, email, phone_number, city, registration_date)
VALUES
(101, 'Hemanth', 'hemanth@gmail.com', '9876543210', 'Chennai', '2026-01-10'),
(102, 'Rahul', 'rahul@gmail.com', '9876543211', 'Bangalore', '2026-01-15'),
(103, 'Priya', 'priya@gmail.com', '9876543212', 'Hyderabad', '2026-01-20'),
(104, 'Arjun', 'arjun@gmail.com', '9876543213', 'Chennai', '2026-02-05'),
(105, 'Sneha', 'sneha@gmail.com', '9876543214', 'Mumbai', '2026-02-12'),
(106, 'Karthik', 'karthik@gmail.com', '9876543215', 'Coimbatore', '2026-02-18'),
(107, 'Divya', 'divya@gmail.com', '9876543216', 'Bangalore', '2026-03-01'),
(108, 'Vijay', 'vijay@gmail.com', '9876543217', 'Madurai', '2026-03-08'),
(109, 'Anjali', 'anjali@gmail.com', '9876543218', 'Chennai', '2026-03-15'),
(110, 'Suresh', 'suresh@gmail.com', '9876543219', 'Hyderabad', '2026-03-20'),
(111, 'Meena', 'meena@gmail.com', '9876543220', 'Pune', '2026-04-01'),
(112, 'Rohit', 'rohit@gmail.com', '9876543221', 'Delhi', '2026-04-10');




INSERT INTO addresses
(address_id, customer_id, address_type, street, city, state, pincode)
VALUES
(201, 101, 'Home', 'Anna Nagar', 'Chennai', 'Tamil Nadu', '600040'),
(202, 101, 'Office', 'Guindy Industrial Estate', 'Chennai', 'Tamil Nadu', '600032'),
(203, 102, 'Home', 'Whitefield', 'Bangalore', 'Karnataka', '560066'),
(204, 103, 'Home', 'Banjara Hills', 'Hyderabad', 'Telangana', '500034'),
(205, 104, 'Home', 'Velachery', 'Chennai', 'Tamil Nadu', '600042'),
(206, 105, 'Home', 'Andheri West', 'Mumbai', 'Maharashtra', '400053'),
(207, 106, 'Home', 'RS Puram', 'Coimbatore', 'Tamil Nadu', '641002'),
(208, 107, 'Office', 'Electronic City', 'Bangalore', 'Karnataka', '560100'),
(209, 108, 'Home', 'KK Nagar', 'Madurai', 'Tamil Nadu', '625020'),
(210, 109, 'Home', 'T Nagar', 'Chennai', 'Tamil Nadu', '600017'),
(211, 110, 'Home', 'Madhapur', 'Hyderabad', 'Telangana', '500081'),
(212, 111, 'Home', 'Kothrud', 'Pune', 'Maharashtra', '411038'),
(213, 112, 'Home', 'Rohini', 'Delhi', 'Delhi', '110085');




INSERT INTO categories
(category_id, category_name)
VALUES
(301, 'Electronics'),
(302, 'Clothing'),
(303, 'Books'),
(304, 'Home Appliances'),
(305, 'Sports'),
(306, 'Accessories');




INSERT INTO products
(product_id, product_name, category_id, price, stock, seller_name)
VALUES
(401, 'Laptop', 301, 55000.00, 15, 'TechWorld'),
(402, 'Smartphone', 301, 30000.00, 25, 'MobileHub'),
(403, 'Tablet', 301, 22000.00, 12, 'TechWorld'),
(404, 'Bluetooth Speaker', 301, 3500.00, 30, 'SoundZone'),
(405, 'Wireless Mouse', 306, 800.00, 50, 'GadgetStore'),
(406, 'Mechanical Keyboard', 306, 2500.00, 20, 'GadgetStore'),
(407, 'Men T-Shirt', 302, 799.00, 40, 'FashionPoint'),
(408, 'Women Dress', 302, 1999.00, 25, 'FashionPoint'),
(409, 'Jeans', 302, 2499.00, 30, 'DenimWorld'),
(410, 'Java Programming Book', 303, 899.00, 35, 'BookHouse'),
(411, 'Database Systems Book', 303, 1299.00, 20, 'BookHouse'),
(412, 'Python Programming Book', 303, 999.00, 25, 'BookHouse'),
(413, 'Air Conditioner', 304, 42000.00, 8, 'HomeTech'),
(414, 'Washing Machine', 304, 28000.00, 10, 'HomeTech'),
(415, 'Microwave Oven', 304, 12000.00, 15, 'KitchenWorld'),
(416, 'Running Shoes', 305, 3500.00, 30, 'SportsZone'),
(417, 'Cricket Bat', 305, 4500.00, 18, 'SportsZone'),
(418, 'Football', 305, 1200.00, 40, 'SportsZone'),
(419, 'Smart Watch', 301, 6500.00, 22, 'TechWorld'),
(420, 'Power Bank', 306, 1500.00, 45, 'GadgetStore');




INSERT INTO orders
(order_id, customer_id, order_date, shipping_address_id, order_status)
VALUES
(501, 101, '2026-04-05', 201, 'Delivered'),
(502, 102, '2026-04-07', 203, 'Delivered'),
(503, 103, '2026-04-10', 204, 'Shipped'),
(504, 104, '2026-04-12', 205, 'Delivered'),
(505, 105, '2026-04-15', 206, 'Pending'),
(506, 101, '2026-04-18', 202, 'Delivered'),
(507, 106, '2026-04-20', 207, 'Shipped'),
(508, 107, '2026-04-22', 208, 'Delivered'),
(509, 108, '2026-04-25', 209, 'Cancelled'),
(510, 109, '2026-05-01', 210, 'Delivered'),
(511, 110, '2026-05-03', 211, 'Shipped'),
(512, 101, '2026-05-05', 201, 'Delivered'),
(513, 105, '2026-05-08', 206, 'Delivered'),
(514, 102, '2026-05-10', 203, 'Pending'),
(515, 103, '2026-05-12', 204, 'Delivered'),
(516, 111, '2026-05-15', 212, 'Delivered');




INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, price_at_purchase)
VALUES
(601, 501, 401, 1, 55000.00),
(602, 501, 405, 2, 800.00),

(603, 502, 402, 1, 30000.00),
(604, 502, 420, 1, 1500.00),

(605, 503, 403, 1, 22000.00),
(606, 503, 406, 1, 2500.00),

(607, 504, 407, 3, 799.00),
(608, 504, 410, 1, 899.00),

(609, 505, 413, 1, 42000.00),

(610, 506, 419, 1, 6500.00),
(611, 506, 405, 1, 800.00),

(612, 507, 417, 1, 4500.00),
(613, 507, 418, 2, 1200.00),

(614, 508, 408, 1, 1999.00),
(615, 508, 409, 1, 2499.00),

(616, 509, 416, 1, 3500.00),

(617, 510, 411, 2, 1299.00),
(618, 510, 412, 1, 999.00),

(619, 511, 414, 1, 28000.00),

(620, 512, 401, 1, 55000.00),
(621, 512, 406, 1, 2500.00),

(622, 513, 415, 1, 12000.00),
(623, 513, 407, 2, 799.00),

(624, 514, 404, 1, 3500.00),

(625, 515, 402, 1, 30000.00),
(626, 515, 405, 1, 800.00),

(627, 516, 416, 2, 3500.00),
(628, 516, 418, 1, 1200.00);



INSERT INTO payments
(payment_id, order_id, payment_date, payment_method, amount, payment_status)
VALUES
(701, 501, '2026-04-05', 'UPI', 56600.00, 'Completed'),
(702, 502, '2026-04-07', 'Credit Card', 31500.00, 'Completed'),
(703, 503, '2026-04-10', 'Debit Card', 24500.00, 'Completed'),
(704, 504, '2026-04-12', 'UPI', 3296.00, 'Completed'),
(705, 505, '2026-04-15', 'Credit Card', 42000.00, 'Pending'),
(706, 506, '2026-04-18', 'UPI', 7300.00, 'Completed'),
(707, 507, '2026-04-20', 'Cash on Delivery', 6900.00, 'Pending'),
(708, 508, '2026-04-22', 'UPI', 4498.00, 'Completed'),
(709, 509, '2026-04-25', 'Debit Card', 3500.00, 'Refunded'),
(710, 510, '2026-05-01', 'UPI', 3597.00, 'Completed'),
(711, 511, '2026-05-03', 'Credit Card', 28000.00, 'Completed'),
(712, 512, '2026-05-05', 'UPI', 57500.00, 'Completed'),
(713, 513, '2026-05-08', 'Debit Card', 13598.00, 'Completed'),
(714, 514, '2026-05-09','Cash on Delivery', 3500.00, 'Pending'),
(715, 515, '2026-05-10','Credit Card', 30800.00, 'Completed'),
(716, 516, '2026-05-11','UPI', 8200.00, 'Completed');




INSERT INTO reviews
(review_id, customer_id, product_id, rating, review_text, review_date)
VALUES
(801, 101, 401, 5, 'Excellent laptop with great performance', '2026-04-15'),
(802, 102, 402, 4, 'Good smartphone for the price', '2026-04-18'),
(803, 103, 403, 5, 'Very useful tablet', '2026-04-20'),
(804, 104, 407, 4, 'Good quality T-shirt', '2026-04-20'),
(805, 106, 417, 5, 'Excellent cricket bat', '2026-04-25'),
(806, 107, 408, 4, 'Nice dress and good quality', '2026-04-28'),
(807, 109, 411, 5, 'Very informative book', '2026-05-05'),
(808, 110, 414, 4, 'Works perfectly', '2026-05-10'),
(809, 105, 413, 3, 'Good but slightly expensive', '2026-05-12'),
(810, 111, 416, 5, 'Very comfortable shoes', '2026-05-20');




INSERT INTO coupons
(coupon_id, coupon_code, discount_percentage, minimum_order_amount, expiry_date)
VALUES
(901, 'WELCOME10', 10.00, 1000.00, '2026-12-31'),
(902, 'SAVE15', 15.00, 5000.00, '2026-10-31'),
(903, 'FESTIVE20', 20.00, 10000.00, '2026-11-30'),
(904, 'NEWUSER5', 5.00, 500.00, '2026-12-31'),
(905, 'BIGSALE25', 25.00, 20000.00, '2026-09-30');




INSERT INTO order_coupons
(order_id, coupon_id, discount_amount)
VALUES
(501, 903, 10000.00),
(502, 902, 4725.00),
(503, 902, 3675.00),
(504, 904, 164.80),
(506, 901, 730.00),
(508, 904, 224.90),
(510, 904, 179.85),
(512, 903, 10000.00),
(513, 902, 2039.70),
(515, 903, 6160.00),
(516, 904, 410.00);

SELECT * FROM customers;

SELECT * FROM products 
WHERE price > 10000;

SELECT * FROM customers
WHERE city = "chennai";

SELECT * FROM products 
WHERE price BETWEEN 1000 AND 10000;

SELECT * FROM products
WHERE product_name = "smartphone";

SELECT * FROM products
ORDER BY price DESC
LIMIT 5;


SELECT * FROM orders
WHERE order_date =  '2026-04-07';

SELECT COUNT(customer_name) FROM customers;

SELECT COUNT(product_id) FROM products;

SELECT AVG(price) FROM products;

SELECT product_name,product_id FROM products
ORDER BY price DESC LIMIT 1;

SELECT product_name,product_id FROM products
ORDER BY price ASC LIMIT 1;

SELECT SUM(price * stock) AS total_value_of_products FROM products;

SELECT category_name,COUNT(category_id) AS product_count FROM categories
GROUP BY category_name;

SELECT 
    c.category_name,
    AVG(p.price) AS average_price
FROM products p
JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_name;

SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 3;

SELECT c.customer_name,COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT p.product_name,SUM(oi.quantity * oi.price_at_purchase) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

SELECT c.category_name,AVG(p.price) AS average_price
FROM categories c
JOIN products p
ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING AVG(p.price) > 5000;

SELECT c.customer_name,o.order_id,o.order_date
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id;

SELECT product_name,category_name
FROM products as p
LEFT JOIN categories as c
ON p.category_id = c.category_id;

SELECT o.order_id,c.customer_id,p.product_name,oi.quantity
FROM orders AS o
JOIN customers AS c
ON o.customer_id = c.customer_id
JOIN order_items AS oi
ON o.order_id = oi.order_id
JOIN products AS p
ON oi.product_id = p.product_id;

SELECT DISTINCT c.customer_id, c.customer_name
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

SELECT c.customer_id, c.customer_name
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

SELECT c.customer_name,SUM(oi.quantity * oi.price_at_purchase) AS total_spent
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

SELECT p.product_name,SUM(oi.quantity) AS quantity_sold
FROM products AS p
JOIN order_items AS oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC
LIMIT 1;

SELECT MONTHNAME(o.order_date) AS month,SUM(oi.quantity * oi.price_at_purchase) AS revenue
FROM orders AS o
JOIN order_items AS oi
ON o.order_id = oi.order_id
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY MONTH(o.order_date);

SELECT p.product_id,p.product_name
FROM products AS p
LEFT JOIN order_items AS oi
ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

SELECT
    c.customer_name,
    COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) AS total_spent,
    CASE
        WHEN COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) <= 10000
            THEN 'Regular'

        WHEN COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) <= 50000
            THEN 'Silver'

        WHEN COALESCE(SUM(oi.quantity * oi.price_at_purchase), 0) <= 100000
            THEN 'Gold'

        ELSE 'Platinum'
    END AS customer_category

FROM customers AS c

LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id

LEFT JOIN order_items AS oi
    ON o.order_id = oi.order_id

GROUP BY c.customer_id, c.customer_name;