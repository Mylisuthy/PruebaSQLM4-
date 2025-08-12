-- Insert into status table
INSERT INTO public.status (amount_paid, status)
VALUES 
    (100.50, 'completed'),
    (50.25, 'pending'),
    (75.00, 'failed');

-- Insert into customer table
INSERT INTO public.customer (first_name, last_name, email, address, phone_number, num_identification)
VALUES 
    ('John', 'Doe', 'john.doe@example.com', '123 Main St', '+1234567890', 'ID12345'),
    ('Jane', 'Smith', 'jane.smith@example.com', '456 Elm St', '+0987654321', 'ID67890');

-- Insert into transaction_inf table
INSERT INTO public.transaction_inf (date, time, amount, transaction_type)
VALUES 
    ('2023-06-15', '14:30:00', 100.50, 'online_purchase'),
    ('2023-06-16', '10:45:00', 50.25, 'cash_payment');

-- Insert into purchase table
-- Note: This requires existing records in transaction_inf and customer tables
INSERT INTO public.purchase (purchase_type, article, id_transaction_inf, id_customer)
VALUES 
    ('product', 'Laptop', 1, 1),
    ('service', 'Software Subscription', 2, 2);

-- Insert into bill table
-- Note: This requires existing records in status and purchase tables
INSERT INTO public.bill (billing_period, invoiced_amount, platform_used, id_status, id_purchase)
VALUES 
    ('2023-06-30', 100.50, 'Nequi', 1, 1),
    ('2023-06-30', 50.25, 'Daviplata', 2, 2);