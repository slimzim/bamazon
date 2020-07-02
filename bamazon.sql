SET SQL_SAFE_UPDATES=0;

DROP DATABASE IF EXISTS bamazon;

CREATE DATABASE bamazon;

USE bamazon;

DROP TABLE products;


CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(55) NOT NULL,
  department_name VARCHAR(55) NOT NULL,
  price DECIMAL(6,2) NOT NULL,
  stock_quantity INT NOT NULL,
  product_sales DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (id)
);

-- default values for products table

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Buffet R13 B-flat Clarinet", "Woodwind Instruments", 3499.99, 8, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Buffet R13 A Clarinet", "Woodwind Instruments", 3899.99, 5, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Selmer Mark VI Alto Saxophone", "Woodwind Instruments", 6500.00, 1, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Selmer Mark VI Tenor Saxophone", "Woodwind Instruments", 8995.00, 1, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("AKAI MPK249 MIDI Keyboard", "Electronic Instruments", 399.99, 10, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("AKAI MPK Mini MIDI Keyboard", "Electronic Instruments", 139.99, 20, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Ableton Push 2 MIDI Controller", "Electronic Instruments", 799.99, 12, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("KRK Rokit 8 Monitors", "Studio Equipment", 250.00, 2, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Shure SM81 Condenser Microphone", "Studio Equipment", 275.00, 8, 0);

INSERT INTO products (product_name, department_name, price, stock_quantity, product_sales)
VALUES ("Focusrite Scarlett 6i6 Audio Interface", "Studio Equipment", 299.99, 6, 0);

-- commands for products table

SELECT * FROM products;

-- reset first row to default values

UPDATE products SET stock_quantity = 10 WHERE id=1;
UPDATE products SET product_sales = 0 WHERE id=1;

DELETE FROM products WHERE id = 14;

DESCRIBE products;


-- Second Table

DROP TABLE departments;

CREATE TABLE departments (
	id INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(55) NOT NULL,
    over_head_costs DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (id)
    );
    
INSERT INTO departments (department_name, over_head_costs)
VALUES ("Woodwind Instruments", 1000);

INSERT INTO departments (department_name, over_head_costs)
VALUES ("Electronic Instruments", 400);

INSERT INTO departments (department_name, over_head_costs)
VALUES ("Studio Equipment", 300);

SELECT * FROM departments;

SELECT departments.id as "department_id", departments.department_name as "department_name", departments.over_head_costs as "over_head_costs", products.product_sales as "product_sales"
FROM products
LEFT JOIN departments ON products.department_name = departments.department_name;

SELECT products.department_name, SUM(product_sales) as "total_product_sales"
FROM products
GROUP BY department_name;
    
UPDATE products SET product_sales = product_sales + price WHERE product_name = 'Buffet R13 B-flat Clarinet'
