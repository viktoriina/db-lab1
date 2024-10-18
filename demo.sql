
-- Demonstrating the working of triggers and functions in the e-commerce schema

-- 1. Demonstrate 'customer_update_timestamp' trigger
-- Inserting a customer
INSERT INTO Customers (name, email, phone, address) 
VALUES ('Test User', 'test.user@example.com', '555-4321', '789 Walnut St');
-- Update the customer and observe 'updated_at' column update
UPDATE Customers 
SET address = '123 Updated Address' 
WHERE email = 'test.user@example.com';

-- 2. Demonstrate 'product_update_timestamp' trigger
-- Inserting a product
INSERT INTO Products (name, description, price, stock, category_id) 
VALUES ('Test Product', 'This is a test product.', 999.99, 10, 1);
-- Update the product and observe 'updated_at' column update
UPDATE Products 
SET price = 899.99 
WHERE name = 'Test Product';

-- 3. Demonstrate 'prevent_delivered_order_update' trigger
-- Inserting an order with status 'Delivered'
INSERT INTO Orders (customer_id, total_price, status) 
VALUES (1, 500.00, 'Delivered');
-- Attempt to update the order and trigger an error (should fail)
UPDATE Orders 
SET total_price = 600.00 
WHERE status = 'Delivered';

-- 4. Demonstrate 'log_product_changes' trigger
-- Update a product and observe the change being logged in AuditLogs
UPDATE Products 
SET stock = 0 
WHERE name = 'Test Product';
-- Delete a product and observe the change being logged in AuditLogs
DELETE FROM Products WHERE name = 'Test Product';

-- 5. Demonstrate 'apply_discount_on_order' trigger
-- Applying a coupon when creating a new order
INSERT INTO Orders (customer_id, total_price, status, coupon_code) 
VALUES (2, 1000.00, 'Pending', 'SAVE20');

-- 6. Demonstrate 'set_order_pending_status' trigger
-- Inserting a new order without setting the status, observe it default to 'Pending'
INSERT INTO Orders (customer_id, total_price) 
VALUES (3, 300.00);

-- 7. Demonstrate 'prevent_product_delete' trigger
-- Trying to delete a product that is associated with an order (should fail)
DELETE FROM Products WHERE product_id = 1;  -- Assuming product_id 1 is in an existing order

-- 8. Demonstrate 'review_reminder_on_delivery' trigger
-- Update the status of an order to 'Delivered' and observe a review reminder being created
UPDATE Orders 
SET status = 'Delivered' 
WHERE order_id = 1;

-- 9. Demonstrate 'deactivate_coupon_on_expiration' trigger
-- Update a coupon's expiration date and check if it becomes inactive
UPDATE Coupons 
SET expiration_date = '2023-01-01' 
WHERE code = 'SAVE20';

-- Query AuditLogs to see logged actions
SELECT * FROM AuditLogs;
