<?php

include "../includes/config.php";

cekLogin();
if($_SESSION['role'] != "Admin"){
    if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
        header('Content-Type: application/json');
        echo json_encode(['status' => 'error', 'message' => 'Akses ditolak']);
        exit;
    }
    header("Location: ../dashboard.php");
    exit;
}

if($_SERVER['REQUEST_METHOD'] == "POST"){
    $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
    $aksi = isset($_POST['aksi']) ? $_POST['aksi'] : '';

    if($id > 0 && ($aksi == 'tambah' || $aksi == 'kurang')){
        if($aksi == 'tambah'){
            $sql = "UPDATE menu SET stok = stok + 1 WHERE id = '$id'";
        } else {
            $sql = "UPDATE menu SET stok = GREATEST(0, stok - 1) WHERE id = '$id'";
        }

        if(query($sql)){
            $res = query("SELECT stok FROM menu WHERE id = '$id'");
            $menuData = fetch($res);
            $newStok = (int)$menuData['stok'];

            if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
                header('Content-Type: application/json');
                $badgeClass = $newStok > 5 ? 'badge-success' : ($newStok > 0 ? 'badge-warning' : 'badge-danger');
                echo json_encode([
                    'status' => 'success',
                    'id' => $id,
                    'stok' => $newStok,
                    'badge_class' => $badgeClass,
                    'stok_formatted' => angka($newStok)
                ]);
                exit;
            }

            setFlash("Stok berhasil diperbarui.", "success");
        } else {
            if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {
                header('Content-Type: application/json');
                echo json_encode(['status' => 'error', 'message' => 'Gagal mengupdate stok']);
                exit;
            }
            setFlash("Gagal mengupdate stok.", "danger");
        }
    }
}

redirect("../menu.php");
?>
