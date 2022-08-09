CREATE DATABASE penjualan;
USE penjualan;

CREATE TABLE pelanggan(
  id_pelanggan INT(50) NOT NULL, 
  nama_pelanggan VARCHAR(50) NOT NULL, 
  alamat TEXT NOT NULL,
  telepon INT(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  PRIMARY KEY(id_pelanggan)
  );

CREATE TABLE pesan(
  id_pesan INT(5) NOT NULL auto_increment,
  id_pelanggan VARCHAR(5) NOT NULL,
  tgl_pesan DATE NOT NULL,
  PRIMARY KEY (id_pesan),
  KEY id_pelanggan (id_pelanggan)
  );
  
CREATE TABLE produk(
  id_produk VARCHAR(5) NOT NULL,
  nama_produk VARCHAR(30) NOT NULL,
  satuan VARCHAR(10) NOT NULL,
  harga DECIMAL(10,0) NOT NULL default '0',
  stock INT(3) NOT NULL default '0',
  PRIMARY KEY (id_produk)
  );
  
CREATE TABLE detil_pesan(
  id_pesan INT(5) NOT NULL,
  id_produk VARCHAR(5) NOT NULL,
  jumlah INT(5) NOT NULL default '0',
  harga DECIMAL(10,0) NOT NULL default '0',
  PRIMARY KEY (id_pesan,id_produk),
  KEY FK_detil_pesan (id_produk),
  KEY id_pesan(id_pesan)
  );
  
CREATE TABLE faktur(
  id_faktur INT(5) NOT NULL auto_increment,
  id_pesan INT(5) NOT NULL,
  tgl_faktur DATE NOT NULL,
  PRIMARY KEY (id_faktur),
  KEY id_pesan(id_pesan)
  );
  
CREATE TABLE kuitansi(
  id_kuitansi INT(5) NOT NULL auto_increment,
  id_faktur INT(5) NOT NULL,
  tgl_kuitansi DATE NOT NULL,
  PRIMARY KEY (id_kuitansi),
  KEY FK_kuitansi (id_faktur)
  );
 
#Penggabungan tabel dengan perintah WHERE
SELECT pelanggan.id_pelanggan, pelanggan.nama_pelanggan, pesan.id_pesan, pesan.tgl_pesan
FROM pelanggan, pesan
WHERE pelanggan.id_pelanggan=pesan.id_pelanggan;

#Penggabungan tabel dengan INNER JOIN
SELECT pelanggan.id_pelanggan, pelanggan.nama_pelanggan, pesan.id_pesan, pesan.tgl_pesan
FROM pelanggan INNER JOIN pesan
ON pelanggan.id_pelanggan=pesan.id_pelanggan;

#Penggabungan tabel dengan OUTER JOIN
#LEFT JOIN
SELECT pelanggan.id_pelanggan, pelanggan.nama_pelanggan, pesan.id_pesan, pesan.tgl_pesan
FROM pelanggan LEFT JOIN pesan
ON pelanggan.id_pelanggan=pesan.id_pelanggan;
#RIGHT JOIN
SELECT pelanggan.id_pelanggan, pelanggan.nama_pelanggan, pesan.id_pesan, pesan.tgl_pesan
FROM pelanggan RIGHT JOIN pesan
ON pelanggan.id_pelanggan=pesan.id_pelanggan;


