<?php

include "../includes/config.php";

cekLogin();
if($_SESSION['role'] != "Admin"){
    header("Location: ../dashboard.php");
    exit;
}

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $nama = mysqli_real_escape_string($conn, trim($_POST['nama']));
    $kategori = mysqli_real_escape_string($conn, $_POST['kategori']);
    $harga = (int)$_POST['harga'];
    $stok = (int)$_POST['stok'];
    $gambar = "default.jpg";

    if(empty($nama) || empty($kategori) || $harga < 0){
        setFlash("Data menu tidak valid.", "danger");
        redirect("../menu.php");
    }

    if(isset($_FILES['gambar']) && $_FILES['gambar']['error'] === UPLOAD_ERR_OK){
        $fileTmpPath = $_FILES['gambar']['tmp_name'];
        $fileName = $_FILES['gambar']['name'];
        $fileExtension = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
        
        $allowedExtensions = ['jpg', 'jpeg', 'png', 'webp'];
        if(in_array($fileExtension, $allowedExtensions)){
            $newFileName = time() . '_' . preg_replace('/[^a-zA-Z0-9_\.]/', '_', $fileName);
            $uploadFileDir = '../assets/img/';
            $dest_path = $uploadFileDir . $newFileName;

            if(move_uploaded_file($fileTmpPath, $dest_path)){
                $gambar = $newFileName;
            }
        }
    }

    $sql = "INSERT INTO menu (nama, kategori, harga, stok, gambar) VALUES ('$nama', '$kategori', '$harga', '$stok', '$gambar')";
    if(query($sql)){
        setFlash("Menu <strong>" . e($nama) . "</strong> berhasil ditambahkan!", "success");
    } else {
        setFlash("Gagal menambahkan menu.", "danger");
    }
}

redirect("../menu.php");
?>
