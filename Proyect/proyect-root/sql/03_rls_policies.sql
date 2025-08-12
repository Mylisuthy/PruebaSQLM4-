-- Enable Row Level Security on all tables
ALTER TABLE public.status ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customer ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transaction_inf ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.purchase ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bill ENABLE ROW LEVEL SECURITY;

-- RLS Policies for customer table
CREATE POLICY "Users can view own customer info" ON public.customer
FOR SELECT TO authenticated
USING (auth.uid() = (
    SELECT id 
    FROM auth.users 
    WHERE email = customer.email
));

CREATE POLICY "Users can insert own customer info" ON public.customer
FOR INSERT TO authenticated
WITH CHECK (auth.uid() = (
    SELECT id 
    FROM auth.users 
    WHERE email = customer.email
));

CREATE POLICY "Users can update own customer info" ON public.customer
FOR UPDATE TO authenticated
USING (auth.uid() = (
    SELECT id 
    FROM auth.users 
    WHERE email = customer.email
))
WITH CHECK (auth.uid() = (
    SELECT id 
    FROM auth.users 
    WHERE email = customer.email
));

-- RLS Policies for transaction_inf table
CREATE POLICY "Users can view own transactions" ON public.transaction_inf
FOR SELECT TO authenticated
USING (EXISTS (
    SELECT 1 
    FROM public.purchase p
    JOIN public.customer c ON p.id_customer = c.id_customer
    WHERE p.id_transaction_inf = transaction_inf.id_transaction
    AND auth.uid() = (SELECT id FROM auth.users WHERE email = c.email)
));