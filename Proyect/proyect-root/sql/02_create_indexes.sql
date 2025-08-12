-- Create indexes for foreign key columns to optimize joins
CREATE INDEX idx_purchase_transaction ON public.purchase(id_transaction_inf);
CREATE INDEX idx_purchase_customer ON public.purchase(id_customer);
CREATE INDEX idx_bill_status ON public.bill(id_status);
CREATE INDEX idx_bill_purchase ON public.bill(id_purchase);