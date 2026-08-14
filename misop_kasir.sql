-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 17, 2026 at 12:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `misop_kasir`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_transaksi`
--

CREATE TABLE `detail_transaksi` (
  `id` int(11) NOT NULL,
  `transaksi_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_transaksi`
--

INSERT INTO `detail_transaksi` (`id`, `transaksi_id`, `menu_id`, `qty`, `harga`, `subtotal`) VALUES
(1, 1, 16, 1, 18000, 18000),
(2, 1, 17, 1, 18000, 18000),
(3, 1, 11, 2, 15000, 30000),
(4, 1, 14, 1, 5000, 5000),
(5, 2, 17, 1, 18000, 18000),
(6, 3, 11, 1, 15000, 15000),
(7, 3, 12, 1, 18000, 18000),
(8, 3, 14, 1, 5000, 5000),
(9, 4, 18, 2, 5000, 10000),
(10, 4, 19, 1, 5000, 5000),
(11, 4, 14, 1, 5000, 5000),
(12, 5, 18, 1, 5000, 5000),
(13, 5, 15, 1, 8000, 8000),
(14, 6, 12, 1, 18000, 18000),
(15, 7, 18, 1, 5000, 5000),
(16, 7, 19, 1, 5000, 5000),
(17, 7, 14, 1, 5000, 5000),
(18, 8, 11, 1, 15000, 15000),
(19, 8, 15, 1, 8000, 8000),
(20, 8, 12, 1, 18000, 18000),
(21, 9, 18, 1, 5000, 5000),
(22, 9, 19, 1, 5000, 5000),
(23, 9, 11, 1, 15000, 15000),
(24, 9, 14, 1, 5000, 5000),
(25, 10, 20, 1, 5000, 5000),
(26, 11, 14, 2, 5000, 10000),
(27, 11, 11, 1, 15000, 15000),
(28, 11, 12, 1, 18000, 18000);

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `kategori` enum('Makanan','Minuman') NOT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(11) DEFAULT 0,
  `gambar` varchar(255) DEFAULT 'default.jpg',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `nama`, `kategori`, `harga`, `stok`, `gambar`, `created_at`) VALUES
(11, 'Dimsum', 'Makanan', 15000, 24, 'dimsum.jpg', '2026-06-30 03:14:04'),
(12, 'Lontong Medan', 'Makanan', 18000, 21, 'lontong_medan.jpg', '2026-06-30 03:14:04'),
(13, 'Misop Komplit', 'Makanan', 22000, 20, 'mieso_komplit.jpg', '2026-06-30 03:14:04'),
(14, 'Es Teh Manis', 'Minuman', 5000, 43, 'estehmanis.jpg', '2026-06-30 03:14:04'),
(15, 'Kopi', 'Minuman', 8000, 38, 'kopi.jpg', '2026-06-30 03:14:04'),
(16, 'Mie Gomak', 'Makanan', 18000, 19, 'mie_gomak.jpg', '2026-06-30 03:14:04'),
(17, 'Miso Tanpa Telur', 'Makanan', 18000, 18, 'mieso_tanpa telor.jpg', '2026-06-30 03:14:04'),
(18, 'Sate Ati', 'Makanan', 5000, 35, 'sate_ati.jpg', '2026-06-30 03:14:04'),
(19, 'Sate Kerang', 'Makanan', 5000, 37, 'sate_kerang.jpg', '2026-06-30 03:14:04'),
(20, 'Sate Telur', 'Makanan', 5000, 39, 'sate_telor.jpg', '2026-06-30 03:14:04');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int(11) NOT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `customer` varchar(100) NOT NULL,
  `kasir` varchar(100) NOT NULL,
  `metode` enum('Tunai','QRIS','Transfer') NOT NULL,
  `subtotal` int(11) NOT NULL,
  `diskon` int(11) DEFAULT 0,
  `pajak` int(11) DEFAULT 0,
  `total` int(11) NOT NULL,
  `bayar` int(11) DEFAULT 0,
  `kembalian` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `tanggal`, `customer`, `kasir`, `metode`, `subtotal`, `diskon`, `pajak`, `total`, `bayar`, `kembalian`) VALUES
(1, '2026-06-30 10:59:24', 'Ruli', 'Nicolas', 'Tunai', 71000, 0, 7100, 78100, 80000, 1900),
(2, '2026-06-30 12:36:37', 'niko', 'Rismawati Tarigan', 'QRIS', 18000, 0, 1800, 19800, 19800, 0),
(3, '2026-07-01 12:50:06', 'Anggit', 'Nicolas', 'Tunai', 38000, 0, 3800, 41800, 42000, 200),
(4, '2026-07-01 12:52:57', 'Alim', 'Nicolas', 'QRIS', 20000, 0, 2000, 22000, 22000, 0),
(5, '2026-07-03 09:25:51', 'Daffa', 'Nicolas', 'Tunai', 13000, 0, 1300, 14300, 14300, 0),
(6, '2026-07-03 09:36:16', 'Alwan', 'Nicolas', 'QRIS', 18000, 0, 1800, 19800, 19800, 0),
(7, '2026-07-03 09:48:14', 'Wahyu', 'Nicolas', 'QRIS', 15000, 0, 1500, 16500, 16500, 0),
(8, '2026-07-03 10:25:22', 'Rafli', 'Rismawati Tarigan', 'Tunai', 41000, 0, 4100, 45100, 45500, 400),
(9, '2026-07-03 10:45:35', 'Kartika', 'Nicolas', 'Tunai', 30000, 0, 3000, 33000, 40000, 7000),
(10, '2026-07-03 12:44:27', 'Naila', 'Nicolas', 'Tunai', 5000, 0, 500, 5500, 5500, 0),
(11, '2026-07-05 13:46:57', 'Siska', 'Nicolas', 'QRIS', 43000, 0, 4300, 47300, 47300, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Kasir') DEFAULT 'Kasir',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `password`, `role`, `created_at`) VALUES
(1, 'Rismawati Tarigan', 'rismawati', '0192023a7bbd73250516f069df18b500', 'Admin', '2026-06-30 02:59:37'),
(3, 'Nicolas', 'nicolas', 'de28f8f7998f23ab4194b51a6029416f', 'Kasir', '2026-06-30 03:07:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_menu` (`menu_id`),
  ADD KEY `idx_detail_transaksi` (`transaksi_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_menu_nama` (`nama`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_transaksi_tanggal` (`tanggal`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_transaksi`
--
ALTER TABLE `detail_transaksi`
  ADD CONSTRAINT `fk_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_transaksi` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
