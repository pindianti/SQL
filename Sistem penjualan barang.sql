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

#Menggabungkan tiga tabel untuk pemesanan dengan nomor 1
SELECT pesan.id_pesan, produk.id_produk, produk.nama_produk, detil_pesan.harga, detil_pesan.jumlah
  FROM pesan, detil_pesan, produk
  WHERE pesan.id_pesan=detil_pesan.id_pesan 
  AND detil_pesan.id_produk=produk.id_produk 
  AND pesan.id_pesan='1'

#Pengelompokkan hasil query dengan GROUP BY (tanpa dijumlahkan (masing-masing transaksi))
SELECT pesan.id_pesan, pesan.tgl_pesan, detil_pesan.jumlah
  FROM pesan, detil_pesan
  WHERE pesan.id_pesan=detil_pesan.id_pesan;

#Pengelompokkan hasil query dengan GROUP BY dan SUM untuk menjumlahkan barang
SELECT pesan.id_pesan, pesan.tgl_pesan, SUM(detil_pesan.jumlah) as jumlah
  FROM pesan, detil_pesan
  WHERE pesan.id_pesan=detil_pesan.id_pesan
  GROUP BY id_pesan;

#Pengelompokkan hasil query dengan tambahan WITH ROLLUP untuk menampilkan jumlah total seluruh barang
SELECT pesan.id_pesan, pesan.tgl_pesan, SUM(detil_pesan.jumlah) as jumlah
  FROM pesan, detil_pesan
  WHERE pesan.id_pesan=detil_pesan.id_pesan
  GROUP BY id_pesan WITH ROLLUP;

#Perintah query untuk menampilkan jumlah item(jenis) barang di tiap transaksi
SELECT pesan.id_pesan, COUNT(detil_pesan.id_produk) as jumlah
  FROM pesan, detil_pesan
  WHERE pesan.id_pesan=detil_pesan.id_pesan
  GROUP BY pesan.id_pesan;

#Perintah query dengan HAVING, kasusnya menampilkan data yg jumlah item barangnya lebih dari 2
#(note: WHERE tidak bisa diterapkan pada fungsi agregat seperti COUNT, SUM, AVG, dll)
SELECT pesan.id_pesan, COUNT(detil_pesan.id_produk) as jumlah
  FROM pesan, detil_pesan
  WHERE pesan.id_pesan=detil_pesan.id_pesan
  GROUP BY pesan.id_pesan
  HAVING jumlah>2;

#Menampilkan data yang kondisinya merupakan hasil dari query lain dengan SubSELECT
#Menampilkan daftar pelanggan yang pernah melakukan transaksi(pemesanan)
SELECT id_pelanggan, nama_pelanggan FROM pelanggan
  WHERE id_pelanggan IN (SELECT id_pelanggan FROM pesan);

#Menampilkan data pemesanan dengan jumlah barang terbanyak
SELECT id_pesan, jumlah FROM detil_pesan
  WHERE jumlah=(SELECT MAX(jumlah) FROM detil_pesan);

#Menampilkan record secara random
SELECT id_pelanggan, nama_pelanggan, email FROM pelanggan ORDER BY RAND();

#Menggabungkan data di suatu tabel dengan UNION, UNION ALL, UNION DISTINC 
#UNION = Apabila ada data yg sama, maka hanya ditampilkan 1 kali saja
SELECT harga FROM produk
  UNION SELECT harga FROM detil_pesan;
#UNION ALL = Memungkinkan untuk menampilkan data yang sama secara bersamaan
SELECT harga FROM produk
  UNION ALL SELECT harga FROM detil_pesan;
#UNION DISTINC = Tujuannya hampir sama seperti UNION
SELECT harga FROM produk
  UNION DISTINC SELECT harga FROM detil_pesan;

#Perintah UNION dengan AS
#Menampilkan data dengan keterangan tertentu dalam 1 query
#(misal ingin menampilkan data nama pelanggan dengan status user dan data nama produk dengan status terjual  
SELECT nama_pelanggan, 'User' AS status FROM pelanggan
  UNION SELECT nama_produk, 'Terjual' AS status FROM produk; 

#Perintah UNION dengan WHERE
SELECT harga FROM produk
  WHERE harga = '10'
  UNION 
  SELECT harga FROM detil_pesan
  WHERE harga ='10';
  
#Perintah operator AND, OR, dan NOT
#Operator AND akan menampilkan record apabila semua kondisi bernilai TRUE
SELECT nama_produk, satuan FROM produk WHERE harga='10' AND stock='10';
#Operator OR akan menampilkan record apabila salah satu kondisi bernilai TRUE
SELECT nama_produk, satuan FROM produk WHERE harga='10' OR stock='10';
#Operator NOT menampilkan semua record kecuali record yg berada di kondisi WHERE NOT
SELECT nama_pelanggan, email FROM pelanggan WHERE NOT id_pelanggan='1';
  
#SUBQUERY
#query di dalam query
