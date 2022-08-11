#common simple case
SELECT id_produk, stock,
CASE stock
  WHEN '10' THEN 'LOW'
  WHEN '20' THEN 'MEDIUM'
  WHEN '30' THEN 'HIGH'
END AS deskripsi
FROM produk;

#simple case dengan opsi ELSE
SELECT id_produk, stock, 
CASE stock
  WHEN '10' THEN 'LOW'
  WHEN '20' THEN 'MEDIUM'
  WHEN '30' THEN 'HIGH'
  ELSE 'Belum Terdaftar' 
END AS deskripsi 
FROM produk;

#Searched case dengan query case WHEN SQL
SELECT id_produk, nama_produk, stock,
CASE 
  WHEN nama_produk = 'kelaya' THEN 'shampo herbal'
  WHEN nama_produk = 'kitkat' THEN 'makanan ringan'
  WHEN nama_produk = 'aqua' THEN 'minuman'
END AS deskripsi
FROM produk;

#Searched case dengan query case WHEN SQL dan opsi ELSE
SELECT id_produk, nama_produk, stock,
CASE 
  WHEN nama_produk = 'kelaya' THEN 'shampo herbal'
  WHEN nama_produk = 'kitkat' THEN 'makanan ringan'
  WHEN nama_produk = 'aqua' THEN 'minuman'
  ELSE 'belum terdaftar'
END AS deskripsi 
FROM produk;

#Nested case (case dalam IF ELSE)

  
