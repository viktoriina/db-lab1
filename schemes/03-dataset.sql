
-- Inserting into Customers table
INSERT INTO Customers (name, email, phone, address) VALUES
('John Doe', 'john.doe@example.com', '555-1234', '123 Elm St'),
('Jane Smith', 'jane.smith@example.com', '555-5678', '456 Oak St'),
('Alice Johnson', 'alice.j@example.com', '555-9876', '789 Maple St'),
('Bob Brown', 'bob.brown@example.com', '555-3456', '321 Pine St'),
('Charlie Davis', 'charlie.davis@example.com', '555-6789', '654 Cedar St');

-- Inserting into Products table
INSERT INTO Products (name, description, price, stock, category_id) VALUES
('Laptop', 'High performance laptop', 1200.00, 50, 1),
('Smartphone', 'Latest model smartphone', 800.00, 100, 2),
('Tablet', '10-inch screen tablet', 300.00, 150, 3),
('Headphones', 'Noise-cancelling headphones', 200.00, 200, 4),
('Smartwatch', 'Fitness tracking smartwatch', 150.00, 75, 2);

-- Inserting into Categories table
INSERT INTO Categories (name, description) VALUES
('Electronics', 'Electronic devices and gadgets'),
('Wearables', 'Smartwatches and wearable tech'),
('Tablets', 'Portable tablet computers'),
('Audio', 'Audio devices and accessories'),
('Accessories', 'Tech accessories and peripherals');

-- Inserting into Orders table
INSERT INTO Orders (customer_id, total_price, status) VALUES
(1, 1250.00, 'Shipped'),
(2, 850.00, 'Processing'),
(3, 300.00, 'Delivered'),
(4, 1200.00, 'Pending'),
(5, 150.00, 'Delivered');

-- Inserting into OrderItems table
INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 1200.00),
(2, 2, 1, 800.00),
(3, 3, 1, 300.00),
(4, 1, 2, 2400.00),
(5, 4, 1, 200.00);

-- Inserting into Payments table
INSERT INTO Payments (order_id, payment_method, amount) VALUES
(1, 'Credit Card', 1250.00),
(2, 'PayPal', 850.00),
(3, 'Credit Card', 300.00),
(4, 'Bank Transfer', 1200.00),
(5, 'Credit Card', 150.00);

-- Inserting into ShippingAddresses table
INSERT INTO ShippingAddresses (customer_id, address, city, state, postal_code, country) VALUES
(1, '123 Elm St', 'Metropolis', 'NY', '10001', 'USA'),
(2, '456 Oak St', 'Gotham', 'CA', '90001', 'USA'),
(3, '789 Maple St', 'Central City', 'TX', '73301', 'USA'),
(4, '321 Pine St', 'Star City', 'FL', '33001', 'USA'),
(5, '654 Cedar St', 'Coast City', 'NV', '89501', 'USA');

-- Inserting into Reviews table
INSERT INTO Reviews (customer_id, product_id, rating, comment) VALUES
(1, 1, 5, 'Excellent laptop, very fast.'),
(2, 2, 4, 'Great phone, but battery life could be better.'),
(3, 3, 5, 'Perfect size for travel.'),
(4, 4, 4, 'Very good sound quality.'),
(5, 5, 5, 'Love the fitness features.');

-- Inserting into Coupons table
INSERT INTO Coupons (code, discount, expiration_date) VALUES
('DISCOUNT10', 10.00, '2024-12-31'),
('SAVE20', 20.00, '2024-11-30'),
('SPRINGSALE', 15.00, '2024-05-31'),
('SUMMERDEAL', 25.00, '2024-08-31'),
('FALLDISCOUNT', 5.00, '2024-10-31');

-- Inserting into Cart table
INSERT INTO Cart (customer_id) VALUES
(1),
(2),
(3),
(4),
(5);

-- Inserting into Discounts table
INSERT INTO Discounts (product_id, discount_amount, start_date, end_date) VALUES
(1, 50.00, '2024-01-01', '2024-01-31'),
(2, 75.00, '2024-02-01', '2024-02-28'),
(3, 30.00, '2024-03-01', '2024-03-31'),
(4, 20.00, '2024-04-01', '2024-04-30'),
(5, 15.00, '2024-05-01', '2024-05-31');

-- Inserting into Inventory table
INSERT INTO Inventory (product_id, quantity) VALUES
(1, 50),
(2, 100),
(3, 150),
(4, 200),
(5, 75);

-- Inserting into Suppliers table
INSERT INTO Suppliers (name, contact_info) VALUES
('Tech Supplier Inc.', 'tech.supplier@example.com'),
('GadgetWorld', 'gadgetworld@example.com'),
('BestElectronics', 'bestelectronics@example.com'),
('AudioGear Co.', 'audiogear@example.com'),
('SmartTech', 'smarttech@example.com');

-- Inserting into Employees table
INSERT INTO Employees (name, role, email) VALUES
('Anna White', 'Manager', 'anna.white@example.com'),
('James Black', 'Sales', 'james.black@example.com'),
('Laura Green', 'Support', 'laura.green@example.com'),
('David Blue', 'IT', 'david.blue@example.com'),
('Emily Red', 'HR', 'emily.red@example.com');

-- Inserting into AuditLogs table (example logs)
INSERT INTO AuditLogs (entity, action, entity_id, changed_by) VALUES
('Product', 'Update', 1, 1),
('Order', 'Create', 2, 2),
('Customer', 'Update', 3, 3),
('Product', 'Delete', 4, 4),
('Review', 'Update', 5, 5);
