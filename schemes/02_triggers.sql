
-- Trigger 1: Automatically update the 'updated_at' column in Customers table
CREATE OR REPLACE FUNCTION update_customer_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER customer_update_timestamp
BEFORE UPDATE ON Customers
FOR EACH ROW
EXECUTE FUNCTION update_customer_timestamp();

-- Trigger 2: Automatically update the 'updated_at' column in Products table
CREATE OR REPLACE FUNCTION update_product_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER product_update_timestamp
BEFORE UPDATE ON Products
FOR EACH ROW
EXECUTE FUNCTION update_product_timestamp();

-- Trigger 3: Automatically update the 'updated_at' column in Orders table
CREATE OR REPLACE FUNCTION update_order_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_update_timestamp
BEFORE UPDATE ON Orders
FOR EACH ROW
EXECUTE FUNCTION update_order_timestamp();

-- Trigger 4: Prevent 'Orders' from being updated if the status is 'Delivered'
CREATE OR REPLACE FUNCTION prevent_order_update_if_delivered()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status = 'Delivered' THEN
        RAISE EXCEPTION 'Cannot update delivered orders';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_delivered_order_update
BEFORE UPDATE ON Orders
FOR EACH ROW
EXECUTE FUNCTION prevent_order_update_if_delivered();

-- Trigger 5: Automatically log changes in AuditLogs table
CREATE OR REPLACE FUNCTION log_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO AuditLogs(entity, action, entity_id, changed_by, changed_at)
    VALUES (TG_TABLE_NAME, TG_OP, NEW.product_id, 1, NOW());  -- Assuming employee with id 1 for now
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_product_changes
AFTER UPDATE OR DELETE ON Products
FOR EACH ROW
EXECUTE FUNCTION log_changes();


-- Trigger 6: Automatically set order status to 'Pending' when a new order is created
CREATE OR REPLACE FUNCTION set_default_order_status()
RETURNS TRIGGER AS $$
BEGIN
    NEW.status = 'Pending';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_order_pending_status
BEFORE INSERT ON Orders
FOR EACH ROW
EXECUTE FUNCTION set_default_order_status();

-- Trigger 7: Automatically apply a discount from Coupons to an order if coupon is provided
CREATE OR REPLACE FUNCTION apply_coupon_discount()
RETURNS TRIGGER AS $$
DECLARE
    discount_amount DECIMAL(10, 2);
BEGIN
    -- Check if a coupon is applied and active
    IF NEW.coupon_code IS NOT NULL THEN
        SELECT discount INTO discount_amount
        FROM Coupons
        WHERE code = NEW.coupon_code AND is_active = TRUE;

        IF discount_amount IS NOT NULL THEN
            -- Apply discount to total price
            NEW.total_price = NEW.total_price - (NEW.total_price * (discount_amount / 100));
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER apply_discount_on_order
BEFORE INSERT ON Orders
FOR EACH ROW
EXECUTE FUNCTION apply_coupon_discount();

-- Trigger 8: Prevent deletion of a product if it is associated with an order
CREATE OR REPLACE FUNCTION prevent_product_deletion()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM OrderItems WHERE product_id = OLD.product_id) THEN
        RAISE EXCEPTION 'Cannot delete product that has been ordered';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_product_delete
BEFORE DELETE ON Products
FOR EACH ROW
EXECUTE FUNCTION prevent_product_deletion();

-- Trigger 9: Automatically generate a review reminder when an order is delivered
CREATE OR REPLACE FUNCTION create_review_reminder()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Delivered' THEN
        INSERT INTO Reminders (customer_id, product_id, reminder_type, created_at)
        SELECT Orders.customer_id, OrderItems.product_id, 'Review Reminder', NOW()
        FROM Orders
        JOIN OrderItems ON Orders.order_id = OrderItems.order_id
        WHERE Orders.order_id = NEW.order_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER review_reminder_on_delivery
AFTER UPDATE ON Orders
FOR EACH ROW
WHEN (NEW.status = 'Delivered')
EXECUTE FUNCTION create_review_reminder();

-- Trigger 10: Automatically deactivate coupon if expiration date is reached
CREATE OR REPLACE FUNCTION deactivate_expired_coupons()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.expiration_date < NOW() THEN
        NEW.is_active = FALSE;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER deactivate_coupon_on_expiration
BEFORE UPDATE ON Coupons
FOR EACH ROW
EXECUTE FUNCTION deactivate_expired_coupons();
