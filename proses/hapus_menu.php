<?php

include "../includes/config.php";

cekLogin();
if($_SESSION['role'] != "Admin"){
    header("Location: ../dashboard.php");
    exit;
}

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $id = (int)$_POST['id'];

    if($id > 0){
        $res = query("SELECT * FROM menu WHERE id = '$id'");
        if(rows($res) > 0){
            $menu = fetch($res);
            $nama = $menu['nama'];
            $gambar = $menu['gambar'];

            $sql = "DELETE FROM menu WHERE id = '$id'";
            if(query($sql)){
                if(!empty($gambar) && $gambar != 'default.jpg' && file_exists('../assets/img/' . $gambar)){
                    @unlink('../assets/img/' . $gambar);
                }
                setFlash("Menu <strong>" . e($nama) . "</strong> berhasil dihapus.", "success");
            } else {
                setFlash("Gagal menghapus menu.", "danger");
            }
        }
    }
}

redirect("../menu.php");
?>
