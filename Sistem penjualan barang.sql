CREATE DATABASE penjualan;
USE penjualan;
CREATE TABLE pelanggan(
id_pelanggan INT(50) NOT NULL, 
nama_pelanggan VARCHAR(50) NOT NULL, 
alamat TEXT NOT NULL,
telepon INT(50) NOT NULL,
email VARCHAR(100) NOT NULL,
PRIMARY KEY(id_pelanggan)
)
