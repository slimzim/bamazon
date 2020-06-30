DROP DATABASE IF EXISTS bamazon;

CREATE DATABASE bamazon;

USE bamazon;

CREATE TABLE products (
  id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(55) NOT NULL,
  department_name VARCHAR(55) NOT NULL,
  price DECIMAL(6,2) NOT NULL,
  stock_quantity INT NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Buffet R13 B-flat Clarinet", "Woodwind Instruments", 3499.99, 8);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Buffet R13 A Clarinet", "Woodwind Instruments", 3899.99, 5);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Selmer Mark VI Alto Saxophone", "Woodwind Instruments", 6500.00, 1);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Selmer Mark VI Tenor Saxophone", "Woodwind Instruments", 8995.00, 1);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("AKAI MPK249 MIDI Keyboard", "Electronic Instruments", 399.99, 10);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("AKAI MPK Mini MIDI Keyboard", "Electronic Instruments", 139.99, 20);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Ableton Push 2 MIDI Controller", "Electronic Instruments", 799.99, 12);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("KRK Rokit 8 Monitors", "Studio Equipment", 250.00, 2);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Shure SM81 Condenser Microphone", "Studio Equipment", 275.00, 8);

INSERT INTO products (product_name, department_name, price, stock_quantity)
VALUES ("Focusrite Scarlett 6i6 Audio Interface", "Studio Equipment", 299.99, 6);




