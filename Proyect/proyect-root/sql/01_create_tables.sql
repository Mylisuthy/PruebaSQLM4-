-- Create status table
CREATE TABLE public.status (
    id_status bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    amount_paid numeric(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL CHECK (status IN ('completed', 'pending', 'failed')),
    last_payment timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Create customer table
CREATE TABLE public.customer (
    id_customer bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text UNIQUE NOT NULL,
    address text,
    phone_number text,
    num_identification text UNIQUE NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Create transaction_inf table
CREATE TABLE public.transaction_inf (
    id_transaction bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    transaction_datetime text NOT NULL,
    amount numeric(10,2) NOT NULL,
    transaction_type text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Create purchase table
CREATE TABLE public.purchase (
    id_purchase bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    purchase_type text NOT NULL,
    article text NOT NULL,
    id_transaction_inf bigint REFERENCES public.transaction_inf(id_transaction) ON DELETE SET NULL,
    id_customer bigint REFERENCES public.customer(id_customer) ON DELETE CASCADE,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);

-- Create bill table
CREATE TABLE public.bill (
    id_bill bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    billing_period date NOT NULL,
    invoiced_amount numeric(10,2) NOT NULL,
    platform_used VARCHAR(30) NOT NULL CHECK (platform_used IN ('Nequi', 'Daviplata')),
    Invoice_number text UNIQUE NOT NULL,
    id_status bigint REFERENCES public.status(id_status) ON DELETE SET NULL,
    id_purchase bigint REFERENCES public.purchase(id_purchase) ON DELETE CASCADE,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);