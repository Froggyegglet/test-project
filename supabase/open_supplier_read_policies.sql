drop policy if exists "Public can read visible suppliers" on suppliers;
drop policy if exists "Public can read suppliers" on suppliers;
create policy "Public can read suppliers"
on suppliers for select
to anon, authenticated
using (true);

drop policy if exists "Public can read visible supplier products" on supplier_products;
drop policy if exists "Public can read supplier products" on supplier_products;
create policy "Public can read supplier products"
on supplier_products for select
to anon, authenticated
using (true);
