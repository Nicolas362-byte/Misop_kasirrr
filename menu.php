<?php

include "includes/config.php";

cekLogin();
if($_SESSION['role']!="Admin"){

    header("Location: dashboard.php");

    exit;

}

$data=query("

SELECT *

FROM menu

ORDER BY kategori,nama

");

?>

<!DOCTYPE html>

<html lang="id">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width,initial-scale=1.0">

<title>Data Menu</title>

<link rel="stylesheet"
href="assets/css/style.css">

<link rel="stylesheet"
href="assets/css/menu.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

</head>

<body>

<div class="container">

<?php include "components/sidebar.php"; ?>

<div class="content">

<?php include "components/navbar.php"; ?>

<div class="page-title">

<h2>

🍜 Data Menu

</h2>

<p>

Daftar menu Kedai Misop Nde Tigan

</p>

</div>

<div class="card">
    
<?php tampilFlash(); ?>

<div class="card-header-actions">

<div class="search-box">

<input

type="text"

id="searchMenu"

placeholder="🔍 Cari nama menu...">

</div>

<button type="button" class="btn btn-success" id="btnTambahMenu">

<i class="fa-solid fa-plus"></i> Tambah Menu

</button>

</div>

<table>

<thead>

<tr>

<th class="text-center" style="width:50px;">No</th>

<th class="text-center" style="width:90px;">Gambar</th>

<th>Nama</th>

<th>Kategori</th>

<th>Harga</th>

<th class="text-center" style="width:160px;">Stok</th>

<th class="text-center" style="width:80px;">Aksi</th>

</tr>

</thead>

<tbody>

<?php

$no=1;

while($menu=fetch($data)):

?>

<tr>

<td class="text-center">

<?= $no++ ?>

</td>

<td class="text-center">

<img

src="<?= gambarMenu($menu['gambar']) ?>"

width="70"

style="border-radius:10px;">

</td>

<td>

<strong><?= e($menu['nama']) ?></strong>

</td>

<td>

<?= e($menu['kategori']) ?>

</td>

<td>

<?= rupiah($menu['harga']) ?>

</td>

<td class="text-center">

<div class="stok-container">

<form action="proses/update_stok.php" method="POST" class="form-update-stok">

<input type="hidden" name="id" value="<?= $menu['id'] ?>">

<input type="hidden" name="aksi" value="kurang">

<button type="submit" class="btn-stok btn-stok-minus" title="Kurangi Stok" <?= $menu['stok'] <= 0 ? 'disabled' : '' ?>>

<i class="fa-solid fa-minus"></i>

</button>

</form>

<span class="badge <?= $menu['stok'] > 5 ? 'badge-success' : ($menu['stok'] > 0 ? 'badge-warning' : 'badge-danger') ?> stok-badge" data-id="<?= $menu['id'] ?>">

<?= angka($menu['stok']) ?>

</span>

<form action="proses/update_stok.php" method="POST" class="form-update-stok">

<input type="hidden" name="id" value="<?= $menu['id'] ?>">

<input type="hidden" name="aksi" value="tambah">

<button type="submit" class="btn-stok btn-stok-plus" title="Tambah Stok">

<i class="fa-solid fa-plus"></i>

</button>

</form>

</div>

</td>

<td class="text-center">

<form action="proses/hapus_menu.php" method="POST" onsubmit="return confirm('Apakah Anda yakin ingin menghapus menu \'<?= e($menu['nama']) ?>\'?');" style="display:inline;">

<input type="hidden" name="id" value="<?= $menu['id'] ?>">

<button type="submit" class="btn-action-delete" title="Hapus Menu">

<i class="fa-solid fa-trash"></i>

</button>

</form>

</td>

</tr>

<?php endwhile; ?>

</tbody>

</table>

</div>

<!-- Modal Tambah Menu -->

<div id="modalTambahMenu" class="modal">

<div class="modal-content">

<div class="modal-header">

<h3><i class="fa-solid fa-utensils"></i> Tambah Menu Baru</h3>

<span class="close-modal" id="closeModal">&times;</span>

</div>

<form action="proses/tambah_menu.php" method="POST" enctype="multipart/form-data">

<div class="modal-body">

<div class="form-group">

<label for="nama">Nama Menu</label>

<input type="text" name="nama" id="nama" placeholder="Contoh: Es Teh Lemon" required>

</div>

<div class="form-group">

<label for="kategori">Kategori</label>

<select name="kategori" id="kategori" required>

<option value="Makanan">Makanan</option>

<option value="Minuman">Minuman</option>

</select>

</div>

<div class="form-group">

<label for="harga">Harga (Rp)</label>

<input type="number" name="harga" id="harga" placeholder="15000" min="0" required>

</div>

<div class="form-group">

<label for="stok">Stok Awal</label>

<input type="number" name="stok" id="stok" placeholder="20" min="0" value="0" required>

</div>

<div class="form-group">

<label for="gambar">Foto Menu (Opsional)</label>

<input type="file" name="gambar" id="gambar" accept="image/*">

</div>

</div>

<div class="modal-footer">

<button type="button" class="btn btn-secondary" id="btnBatalModal">Batal</button>

<button type="submit" class="btn btn-success"><i class="fa-solid fa-floppy-disk"></i> Simpan Menu</button>

</div>

</form>

</div>

</div>

<div class="footer">

© <?= date("Y") ?>

Kedai Misop Nde Tigan

</div>

</div>

</div>

<script src="assets/js/menu.js"></script>

</body>

</html>