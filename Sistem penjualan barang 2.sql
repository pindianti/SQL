#mencari jumlah pembeli yg telah melakukan pembelian
select count(*) as jumlah
from (select distinct id_pesan
from detil_pesan);

#mencari data pesanan dengan jumlah pemesanan produk lebih dari 2
select count(jumlah) as total 
from detil_pesan
where jumlah>2

#mencari jumlah pesanan produk dengan nama produk tertentu
select count(*) 
from (select id_produk, stock from produk)
where stock>=20 and nama ="kelaya";
#atau
select count(*) as total 
from produk
where stock>=20 and nama ="kelaya";

#mencari jumlah pesanan produk dengan nama produk tertentu
select count (id_produk) as total
from produk
where nama in ("kelaya", "zinc", "aqua");

#mencari jumlah pesanan produk dengan rentang tanggal tertentu
select count(id_pesan) as total 
from pesan
where tgl_pesan between #2022-08-07# and #2022-08-08#;
#atau 
select count(id_pesan) as total 
from pesan
where tgl_pesan between 2022-08-07 and 2022-08-08;
