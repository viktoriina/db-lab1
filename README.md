# Modern technologies of the Databases | Lab 1

## Subject

E-Commerce system.

## Key features

* 16 entities
* 10 functions + triggers

## Dataset

Sample data is provided in `./schemes/03-dataset.sql`

## Scripts

Launch:

```bash
docker compose up -d
```

Drop DB and Volume:

```bash
docker compose down -v 
```

Connect to DB to Run Queries:

```bash
docker exec -it e_commerce-db psql -U postgres -d e_commerce
```

## Triggers | Functions

### 1. `customer_update_timestamp`

* **Function: `update_customer_timestamp()`**
* **Purpose**: Automatically updates the `updated_at` column in the **Customers** table whenever a customer record is updated. This ensures that the last modification time is always tracked accurately.
  
### 2. `product_update_timestamp`

* **Function: `update_product_timestamp()`**
* **Purpose**: Similar to the customer trigger, this one updates the `updated_at` column in the **Products** table whenever a product record is modified.

### 3. `order_update_timestamp`

* **Function: `update_order_timestamp()`**
* **Purpose**: Automatically updates the `updated_at` column in the **Orders** table when any updates occur. This helps in tracking changes to orders over time.

### 4. `prevent_delivered_order_update`

* **Function: `prevent_order_update_if_delivered()`**
* **Purpose**: Prevents any updates to an order once it is marked as "Delivered." This ensures that no further modifications can be made to finalized orders.

### 5. `log_product_changes`

* **Function: `log_changes()`**
* **Purpose**: Logs any updates or deletions made to **Products** in the **AuditLogs** table, creating a historical record of changes and the employees who made them.

### 6. `set_order_pending_status`

* **Function: `set_default_order_status()`**
* **Purpose**: Automatically sets the status of newly created orders to "Pending" when they are inserted into the **Orders** table. This ensures that new orders always start in a pending state.

### 7. `apply_discount_on_order`

* **Function: `apply_coupon_discount()`**
* **Purpose**: Automatically applies a coupon discount to an order if a valid coupon code is provided. It checks if the coupon is active, and if so, adjusts the total price accordingly.

### 8. `prevent_product_delete`

* **Function: `prevent_product_deletion()`**
* **Purpose**: Prevents deletion of any product that has already been included in an order. This ensures that products related to past orders are preserved in the database.

### 9. `review_reminder_on_delivery`

* **Function: `create_review_reminder()`**
* **Purpose**: When an order is marked as "Delivered," this trigger automatically creates a reminder for the customer to review the product(s) they purchased. This helps in gathering customer feedback.

### 10. `deactivate_coupon_on_expiration`

* **Function: `deactivate_expired_coupons()`**
* **Purpose**: Automatically deactivates a coupon if its expiration date has passed, ensuring that expired coupons cannot be applied to new orders.

## Run demo

You can test out triggers and functions using `./demo.sql` file; after executing into postgres container,
run desired sql queries from the file.
