create or replace function konif(r numeric,h numeric)
returns numeric
language plpgsql
as
$$
begin
return ((3.14)*(r*r)*h)/3;
end
$$
select * from konif(5,6) as koni_hacim;