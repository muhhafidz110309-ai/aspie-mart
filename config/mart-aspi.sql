-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 23, 2026 at 04:57 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mart-aspi`
--

-- --------------------------------------------------------

--
-- Table structure for table `hutang`
--

CREATE TABLE `hutang` (
  `id` int NOT NULL,
  `transaksi_id` int DEFAULT NULL,
  `nama` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `produk_id` int NOT NULL,
  `qty` int NOT NULL DEFAULT '1',
  `harga` decimal(15,2) NOT NULL DEFAULT '0.00',
  `dibayar` decimal(15,2) DEFAULT '0.00',
  `sisa` decimal(15,2) DEFAULT '0.00',
  `keterangan` text COLLATE utf8mb4_general_ci,
  `tanggal` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hutang`
--

INSERT INTO `hutang` (`id`, `transaksi_id`, `nama`, `produk_id`, `qty`, `harga`, `dibayar`, `sisa`, `keterangan`, `tanggal`, `created_at`) VALUES
(38, NULL, 'Kidut', 548, 1, 5000.00, 5000.00, 0.00, 'DP total: Rp 0', '2026-11-11', '2026-11-12 00:39:49'),
(39, NULL, 'Pa kidut', 503, 2, 8000.00, 0.00, 16000.00, 'DP total: Rp 0', '2026-11-11', '2026-11-12 01:33:34'),
(40, NULL, 'pari 12 rpl', 491, 1, 2000.00, 2000.00, 0.00, 'DP total: Rp 0', '2026-11-15', '2026-11-15 23:42:07');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id` int NOT NULL,
  `kode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `kategori` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sumber_dana` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'kas_penjualan',
  `sumber_keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nominal` decimal(15,2) NOT NULL DEFAULT '0.00',
  `tanggal` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `keterangan` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`id`, `kode`, `user_id`, `kategori`, `sumber_dana`, `sumber_keterangan`, `nominal`, `tanggal`, `keterangan`) VALUES
(8, 'OUT202611117837', 1, 'Konsumsi', 'kas_penjualan', 'Makanan', 76500.00, '2026-11-12 22:17:53', 'Bayar peyek 60k pudding dan maroni pedas 16500k'),
(9, 'OUT202611111540', 1, 'Konsumsi', 'kas_penjualan', 'Makanan', 85000.00, '2026-11-12 02:48:41', 'Bayar roti'),
(10, 'OUT202611124612', 1, 'Konsumsi', 'kas_penjualan', 'Makanan', 70000.00, '2026-11-12 02:51:02', 'Wonton'),
(11, 'OUT202611132065', 1, 'Konsumsi', 'kas_penjualan', 'Makanan', 110000.00, '2026-11-13 01:30:30', 'Wonton'),
(12, 'OUT202611175552', 1, 'Konsumsi', 'kas_penjualan', 'Makanan', 54000.00, '2026-11-17 06:35:38', 'bayar roti mars'),
(13, 'OUT202611172342', 1, 'Promosi', 'kas_penjualan', NULL, 140000.00, '2026-11-17 06:35:52', 'bayar wonton'),
(14, 'OUT202611186778', 1, 'Promosi', 'kas_penjualan', NULL, 9000.00, '2026-11-18 07:56:17', 'Bayar skutel'),
(15, 'OUT202611180670', 1, 'Konsumsi', 'kas_penjualan', 'Minuman', 120000.00, '2026-11-18 09:37:23', 'Bayar air minum'),
(16, 'OUT202611194567', 1, 'Konsumsi', 'kas_penjualan', 'Makanan', 90000.00, '2026-11-19 12:40:07', 'roti'),
(17, 'OUT202611197204', 1, 'Konsumsi', 'kas_penjualan', 'Minuman', 119500.00, '2026-11-19 12:40:56', 'susu dll'),
(18, 'OUT202611198945', 1, 'Promosi', 'kas_penjualan', NULL, 160000.00, '2026-11-19 13:15:24', 'wonton');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int NOT NULL,
  `kode` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `harga_beli` decimal(15,2) DEFAULT '0.00',
  `harga_jual` decimal(15,2) DEFAULT '0.00',
  `stok` int DEFAULT '0',
  `satuan` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pcs',
  `satuan_beli` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'pcs',
  `isi_per_satuan` int DEFAULT '1',
  `gambar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `kode`, `nama`, `kategori`, `harga_beli`, `harga_jual`, `stok`, `satuan`, `satuan_beli`, `isi_per_satuan`, `gambar`, `deskripsi`, `created_at`) VALUES
(490, 'PRO1845', 'HASS', 'Minuman', 1500.00, 1500.00, 906, 'pcs', 'Dus', 49, 'prd_20261025070712_2739e4ae.png', '', '2026-10-24 14:40:26'),
(491, 'PRO1846', 'VIT, OASIS', 'Minuman', 0.00, 2000.00, 990, 'pcs', '', 24, 'prd_20261025093455_db2cab3a.jpg', '', '2026-10-24 14:40:26'),
(492, 'PRO1847', 'Milk Life', 'Minuman', 0.00, 3000.00, 3, 'pcs', '', 15, 'prd_20261025075442_8c64f99c.png', '', '2026-10-24 14:40:26'),
(493, 'PRO1848', 'Cimory Stik', 'Minuman', 0.00, 3000.00, 11, 'pcs', '', 15, 'prd_20261025074459_0fc3558a.png', '', '2026-10-24 14:40:26'),
(494, 'PRO1849', 'Susu Ultra 200 ml', 'Minuman', 0.00, 5500.00, 14, 'pcs', '', 15, 'prd_20261025093201_e0dad6fd.jpg', '', '2026-10-24 14:40:26'),
(495, 'PRO1850', 'Susu Cimory', 'Minuman', 0.00, 7000.00, 8, 'pcs', '', 15, 'prd_20261025073738_95c7a853.jpg', '', '2026-10-24 14:40:26'),
(496, 'PRO1851', 'Susu Frisian Flag', 'Minuman', 0.00, 7000.00, 15, 'pcs', '', 15, 'prd_20261025092726_598a3703.jpg', '', '2026-10-24 14:40:26'),
(497, 'PRO1852', 'Floridina', 'Minuman', 0.00, 3500.00, 8, 'pcs', '', 15, 'prd_20261025070554_8d049fca.jpg', '', '2026-10-24 14:40:26'),
(498, 'PRO1853', 'Stee', 'Minuman', 0.00, 3000.00, 9, 'pcs', '', 15, 'prd_20261025070911_0f79fbe1.png', '', '2026-10-24 14:40:26'),
(499, 'PRO1854', 'Teh Pucuk', 'Minuman', 0.00, 3500.00, 46, 'pcs', '', 15, 'prd_20261025071535_13ef93aa.png', '', '2026-10-24 14:40:26'),
(500, 'PRO1855', 'Golda', 'Minuman', 0.00, 3500.00, 7, 'pcs', '', 15, 'prd_20261025070018_b95e53ab.jpg', '', '2026-10-24 14:40:26'),
(501, 'PRO1856', 'Caffino', 'Minuman', 0.00, 7000.00, 15, 'pcs', '', 15, 'prd_20261025074147_a46f865c.webp', '', '2026-10-24 14:40:26'),
(502, 'PRO1857', 'Hydroplus 350 ml', 'Minuman', 0.00, 5000.00, 15, 'pcs', '', 15, 'prd_20261025071125_5261c612.png', '', '2026-10-24 14:40:26'),
(503, 'PRO1858', 'Nu Milk Tea', 'Minuman', 0.00, 8000.00, 11, 'pcs', '', 15, 'prd_20261025071312_42261898.png', '', '2026-10-24 14:40:26'),
(504, 'PRO1859', 'You C 1000', 'Minuman', 0.00, 8500.00, 15, 'pcs', '', 15, 'prd_20261025074048_2f22c389.png', '', '2026-10-24 14:40:26'),
(505, 'PRO1860', 'Happy Jasmine', 'Minuman', 0.00, 7000.00, 7, 'pcs', '', 15, 'prd_20261025074805_6d58de29.png', '', '2026-10-24 14:40:26'),
(506, 'PRO1861', 'Wonton', 'Makanan', 0.00, 11000.00, 40, 'pcs', '', 15, 'prd_20261025095651_495c2715.jpg', '', '2026-10-24 14:40:26'),
(507, 'PRO1862', 'Dimsum', 'Makanan', 0.00, 11000.00, 6, 'pcs', '', 20, 'prd_20261025093906_93d94d4d.jpg', '', '2026-10-24 14:40:26'),
(508, 'PRO1863', 'Roti Mars', 'Makanan', 0.00, 6000.00, 47, 'pcs', '', 15, 'prd_20261025094147_09ed60b0.png', '', '2026-10-24 14:40:26'),
(509, 'PRO1864', 'Roti Deli', 'Makanan', 0.00, 4000.00, 11, 'pcs', '', 15, 'prd_20261025094257_516f65ed.jpg', '', '2026-10-24 14:40:26'),
(510, 'PRO1865', 'Basreng pouch', 'Makanan', 0.00, 5000.00, 14, 'pcs', '', 15, 'prd_20261025095406_aac9a182.jpg', '', '2026-10-24 14:40:26'),
(511, 'PRO1866', 'Peyek', 'Makanan', 0.00, 2500.00, 5, 'pcs', '', 15, 'prd_20261025094425_280bced5.jpg', '', '2026-10-24 14:40:26'),
(512, 'PRO1867', 'Keripik Kaca', 'Makanan', 0.00, 3000.00, 15, 'pcs', '', 15, 'prd_20261025094920_da9e3a26.jpg', '', '2026-10-24 14:40:26'),
(513, 'PRO1874', 'Gesper', 'ATK', 0.00, 20000.00, 14, 'pcs', '', 15, 'prd_20261025084949_865abb91.png', '', '2026-10-24 14:40:26'),
(514, 'PRO1875', 'HVS', 'ATK', 0.00, 1000.00, 166, 'pcs', '', 15, 'prd_20261025085709_8d9b5944.jpg', '', '2026-10-24 14:40:26'),
(515, 'PRO1876', 'Pembalut', 'ATK', 0.00, 3500.00, 7, 'pcs', '', 15, 'prd_20261025090458_aeb7c010.webp', '', '2026-10-24 14:40:26'),
(516, 'PRO1877', 'Folio', 'ATK', 0.00, 500.00, 965, 'pcs', '', 15, 'prd_20261025085610_a14d5c74.png', '', '2026-10-24 14:40:26'),
(517, 'PRO1878', 'Pulpen Joyko', 'ATK', 0.00, 4500.00, 196, 'pcs', '', 15, 'prd_20261025090826_eb37a73e.webp', '', '2026-10-24 14:40:26'),
(518, 'PRO1879', 'Pulpen Kenko', 'ATK', 0.00, 3000.00, 9, 'pcs', '', 15, 'prd_20261025090929_e17d5ac1.jpg', '', '2026-10-24 14:40:26'),
(519, 'PRO1880', 'Lem GLUE', 'ATK', 0.00, 3000.00, 12, 'pcs', '', 15, 'prd_20261025100303_0ec121a5.jpg', '', '2026-10-24 14:40:26'),
(520, 'PRO1881', 'Meterai', 'ATK', 0.00, 12000.00, 15, 'pcs', '', 15, 'prd_20261025085905_37161555.jpg', '', '2026-10-24 14:40:26'),
(521, 'PRO1882', 'Spidol', 'ATK', 0.00, 7000.00, 15, 'pcs', '', 15, 'prd_20261025090343_50e44678.jpg', '', '2026-10-24 14:40:26'),
(522, 'PRO1883', 'Pensil', 'ATK', 0.00, 2000.00, 15, 'pcs', '', 15, 'prd_20261025090152_6def3732.jpg', '', '2026-10-24 14:40:26'),
(523, 'PRO1884', 'penggaris', 'ATK', 0.00, 2500.00, 15, 'pcs', '', 15, 'prd_20261025090713_05166163.jpg', '', '2026-10-24 14:40:26'),
(524, 'PRO1885', 'Penghapus', 'ATK', 0.00, 2000.00, 14, 'pcs', '', 15, 'prd_20261025090240_3d003830.jpg', '', '2026-10-24 14:40:26'),
(525, 'PRO1886', 'Pulpen AE7', 'ATK', 0.00, 2000.00, 10, 'pcs', '', 15, 'prd_20261025095941_37febd01.jpg', '', '2026-10-24 14:40:26'),
(526, 'HAKU-IKAN', 'Haku ikan (All variant)', 'Es Krim', 0.00, 5000.00, 17, 'Pcs', '', 24, 'prd_20261025104558_07852ef6.png', '', '2026-10-24 14:40:26'),
(527, 'HAKU-BLUE', 'Blueberry cheese', 'Es Krim', 0.00, 9000.00, 14, 'Pcs', '', 15, 'prd_20261025100421_b86f3d7b.jpg', '', '2026-10-24 14:40:26'),
(528, 'HAKU-TIRA', 'Tiramisu', 'Es Krim', 0.00, 9000.00, 15, 'Pcs', '', 1, 'prd_20261025105731_6cdf796a.jpg', '', '2026-10-24 14:40:26'),
(529, 'HAKU-TOKY', 'Tokyo cheese cone', 'Es Krim', 0.00, 9000.00, 15, 'Pcs', '', 1, 'prd_20261025105556_81d76cfe.jpg', '', '2026-10-24 14:40:26'),
(530, 'HAKU-MATC', 'Matcha monaka', 'Es Krim', 0.00, 13000.00, 15, 'Pcs', '', 1, 'prd_20261025132620_480d2b87.png', '', '2026-10-24 14:40:26'),
(531, 'HAKU-VANI', 'Vanila monaka', 'Es Krim', 0.00, 13000.00, 15, 'Pcs', '', 1, 'prd_20261025105644_7c337ef6.png', '', '2026-10-24 14:40:26'),
(532, 'HAKU-ALE', 'Ale-Ale', 'Es Krim', 0.00, 2500.00, 14, 'Pcs', '', 15, 'prd_20261025091746_2d60d71b.png', '', '2026-10-24 14:40:26'),
(533, 'HAKU-ALMC', 'Almond Cup', 'Es Krim', 0.00, 10000.00, 11, 'Pcs', '', 15, 'prd_20261025092111_dd1d0cc4.png', '', '2026-10-24 14:40:26'),
(534, 'HAKU-ALMS', 'Almond Stik', 'Es Krim', 0.00, 12000.00, 12, 'Pcs', '', 15, 'prd_20261028100253_31e38a05.jpg', '', '2026-10-24 14:40:26'),
(535, 'WAKU-STRW', 'Strawberry loop', 'Es Krim', 0.00, 1500.00, 15, 'Pcs', '', 1, 'prd_20261025130741_589b554a.jpg', '', '2026-10-24 14:40:26'),
(536, 'WAKU-ICEL', 'Ice lolly (All variant)', 'Es Krim', 0.00, 2500.00, 12, 'Pcs', '', 1, 'prd_20261025130348_fa64afb6.jpg', '', '2026-10-24 14:40:26'),
(537, 'WAKU-CHOC', 'Choco loop', 'Es Krim', 0.00, 2500.00, 13, 'Pcs', '', 1, 'prd_20261025103203_41257fd3.jpg', '', '2026-10-24 14:40:26'),
(538, 'WAKU-CHOB', 'Choco berry loop', 'Es Krim', 0.00, 2500.00, 15, 'Pcs', '', 15, 'prd_20261025100841_7cf6fc04.jpg', '', '2026-10-24 14:40:26'),
(539, 'WAKU-MANG', 'Mango loop', 'Es Krim', 0.00, 2500.00, 15, 'Pcs', '', 1, 'prd_20261025125305_7106c739.png', '', '2026-10-24 14:40:26'),
(540, 'WAKU-COTT', 'Cotton Candy', 'Es Krim', 0.00, 3000.00, 2, 'Pcs', '', 1, 'prd_20261025104012_57adff8d.jpg', '', '2026-10-24 14:40:26'),
(541, 'WAKU-DINO', 'Dinosaurus', 'Es Krim', 0.00, 2500.00, 12, 'Pcs', '', 1, 'prd_20261025135358_28fa87ee.jpg', '', '2026-10-24 14:40:26'),
(542, 'WAKU-SWEE', 'Sweet lychee', 'Es Krim', 0.00, 3000.00, 15, 'Pcs', '', 1, 'prd_20261025110040_fd21be2b.png', '', '2026-10-24 14:40:26'),
(543, 'WAKU-MIXE', 'Mixed berry', 'Es Krim', 0.00, 3000.00, 15, 'Pcs', '', 1, 'prd_20261025132422_2ae932d6.jpg', '', '2026-10-24 14:40:26'),
(544, 'WAKU-DRAC', 'Dra cola', 'Es Krim', 0.00, 3000.00, 9, 'Pcs', '', 1, 'prd_20261025131104_22d22fc3.jpg', '', '2026-10-24 14:40:26'),
(545, 'WAKU-SODA', 'Soda', 'Es Krim', 0.00, 3000.00, 15, 'Pcs', '', 1, 'prd_20261025122436_7a885a53.jpeg', '', '2026-10-24 14:40:26'),
(546, 'WAKU-KACA', 'Kacang Ijo', 'Es Krim', 0.00, 3000.00, 4, 'Pcs', '', 1, 'prd_20261025132743_6ea6a4e7.jpg', '', '2026-10-24 14:40:26'),
(547, 'FROS-MOCH', 'Mochi (All variant)', 'Es Krim', 0.00, 3000.00, 18, 'Pcs', '', 1, 'prd_20261025104624_2c335531.png', '', '2026-10-24 14:40:26'),
(548, 'FROS-CUPA', 'Cup (All variant)', 'Es Krim', 0.00, 5000.00, 5, 'Pcs', '', 1, 'prd_20261025135730_e7017e9b.jpg', '', '2026-10-24 14:40:26'),
(549, 'FROS-BOBA', 'Boba Milk Tea', 'Es Krim', 0.00, 4000.00, 5, 'Pcs', '', 15, 'prd_20261025091918_e2917821.jpg', '', '2026-10-24 14:40:26'),
(550, 'FROS-COCO', 'Coconut Shake Lychee', 'Es Krim', 0.00, 4000.00, 12, 'Pcs', '', 1, 'prd_20261025103737_ada2ea90.jpg', '', '2026-10-24 14:40:26'),
(551, 'FROS-CHOC', 'Choconut & Cashew', 'Es Krim', 0.00, 5000.00, 4, 'Pcs', '', 1, 'prd_20261025103522_2ee2d695.jpg', '', '2026-10-24 14:40:26'),
(552, 'FROS-CRUN', 'Crunchy Double Choco', 'Es Krim', 0.00, 5000.00, 3, 'Pcs', '', 1, 'prd_20261025104258_7ae1ab10.png', '', '2026-10-24 14:40:26'),
(553, 'FROS-ORAN', 'Orange Coco', 'Es Krim', 0.00, 3000.00, 15, 'Pcs', '', 1, 'prd_20261025115741_cef9b3c6.webp', '', '2026-10-24 14:40:26'),
(554, 'FROS-JCON', 'J Cone Cookies n cream', 'Es Krim', 0.00, 5000.00, 9, 'Pcs', '', 1, 'prd_20261025132847_12ae0ce9.jpg', '', '2026-10-24 14:40:26'),
(555, 'FROS-JCOB', 'J Cone Black Pink', 'Es Krim', 0.00, 5000.00, 12, 'Pcs', '', 1, 'prd_20261025132939_e56c071d.jpg', '', '2026-10-24 14:40:26'),
(556, 'FROS-FBYA', 'F.B Yakoo', 'Es Krim', 0.00, 3000.00, 11, 'Pcs', '', 1, 'prd_20261025125829_a9021e9d.jpg', '', '2026-10-24 14:40:26'),
(557, 'FROS-ESKO', 'Es kopi Jelly', 'Es Krim', 0.00, 3000.00, 15, 'Pcs', '', 1, 'prd_20261025123904_43596f06.jpg', '', '2026-10-24 14:40:26'),
(558, 'FROS-POTA', 'Potato chips', 'Es Krim', 0.00, 5000.00, 15, 'Pcs', '', 1, 'prd_20261025105430_66133de1.png', '', '2026-10-24 14:40:26'),
(561, 'FROS-ESKJ', 'Es Krim Jagung', 'Es Krim', 0.00, 3000.00, 15, 'Pcs', '', 1, 'prd_20261025123751_d6ab17d8.jpeg', '', '2026-10-24 14:40:26'),
(563, 'PRD6249', 'Glue Stick', 'ATK', 0.00, 3000.00, 14, 'pcs', 'dus', 1, 'prd_20261025140030_948ef856.webp', '', '2026-10-25 13:00:30'),
(564, 'PRD8667', 'Tisu', 'ATK', 0.00, 3000.00, 10, 'pcs', 'dus', 1, 'prd_20261109213836_1a1bfc13.png', '', '2026-11-10 02:35:21'),
(565, 'PRD3064', 'Permen 1k3', '', 0.00, 1000.00, 46, '3pcs', 'dus', 1, 'prd_20261111195837_15e7e0db.jpg', '', '2026-11-12 00:58:38'),
(566, 'PRD6883', 'Eat milk', 'Makanan', 0.00, 8000.00, 0, '1pcs', 'dus', 1, 'prd_20261111200416_99dbc0c4.jpg', '', '2026-11-12 01:04:17'),
(567, 'PRD9490', 'Makaroni pedas', 'Makanan', 0.00, 2000.00, 12, 'pcs', 'dus', 1, 'prd_20261111201817_97fefcc7.jpg', '', '2026-11-12 01:18:18'),
(568, 'PRD4870', 'Permen 500/1', 'Makanan', 0.00, 500.00, 57, 'pcs', 'dus', 1, 'prd_20261111202618_0dc8c503.jpg', '', '2026-11-12 01:26:19'),
(569, 'PRD9673', 'Buku', 'ATK', 0.00, 5000.00, 0, 'pcs', 'dus', 1, 'prd_20261111205206_9ad2442b.jpg', '', '2026-11-12 01:48:59'),
(570, 'PRD2061', 'permen karet', 'Makanan', 0.00, 3000.00, 90, 'pcs', 'dus', 1, 'prd_20261117112616_7867df65.jpg', '', '2026-11-17 00:01:11'),
(571, 'PRD2725', 'puding', 'Makanan', 0.00, 5000.00, 5, 'pcs', 'dus', 1, 'prd_20261117122643_302c7c7a.jpg', '', '2026-11-17 01:29:29'),
(572, 'PRD5732', 'solatip', 'ATK', 0.00, 2000.00, 18, 'pcs', 'dus', 1, 'prd_20261117122532_fd3087e2.jpg', '', '2026-11-17 04:03:19'),
(573, 'PRD7542', 'skutel', 'Makanan', 0.00, 5000.00, 9, 'pcs', 'dus', 1, NULL, '', '2026-11-17 05:19:10'),
(575, 'PRD2954', 'Makaroni pedas keju', 'Makanan', 0.00, 5000.00, 8, 'pcs', 'dus', 1, NULL, '', '2026-11-18 00:58:44'),
(576, 'PRD9591', 'Sosis crispy', 'Makanan', 0.00, 5000.00, 14, 'pcs', 'dus', 1, NULL, '', '2026-11-18 01:52:54'),
(577, 'PRD0527', 'cimory 8k', 'Minuman', 0.00, 8000.00, 18, 'pcs', 'dus', 1, NULL, '', '2026-11-19 00:11:02'),
(578, 'PRD2842', 'kertas pembatas', '', 0.00, 5000.00, 9, 'pcs', 'dus', 1, NULL, '', '2026-11-19 00:24:56'),
(579, 'PRD4158', 'pulpen 2,5k', '', 0.00, 2500.00, 16, 'pcs', 'dus', 1, NULL, '', '2026-11-19 02:43:45');

-- --------------------------------------------------------

--
-- Table structure for table `simpanan`
--

CREATE TABLE `simpanan` (
  `id` int NOT NULL,
  `nama_penabung` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `akad` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'Wadiah',
  `saldo` decimal(15,2) DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `simpanan`
--

INSERT INTO `simpanan` (`id`, `nama_penabung`, `jenis`, `akad`, `saldo`, `created_at`) VALUES
(1, 'fakhri', 'Pendidikan', 'Wadiah', 200000.00, '2026-09-23 06:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `simpanan_transaksi`
--

CREATE TABLE `simpanan_transaksi` (
  `id` int NOT NULL,
  `kode` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `simpanan_id` int NOT NULL,
  `tipe` enum('setoran','penarikan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `nominal` decimal(15,2) NOT NULL,
  `saldo_akhir` decimal(15,2) NOT NULL,
  `user_id` int DEFAULT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `tanggal` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `simpanan_transaksi`
--

INSERT INTO `simpanan_transaksi` (`id`, `kode`, `simpanan_id`, `tipe`, `nominal`, `saldo_akhir`, `user_id`, `keterangan`, `tanggal`) VALUES
(1, 'STP202609232570', 1, 'setoran', 200000.00, 200000.00, 1, '', '2026-09-23 13:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` int NOT NULL,
  `kode` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tanggal` datetime DEFAULT CURRENT_TIMESTAMP,
  `user_id` int DEFAULT NULL,
  `jenis` enum('penjualan','pembelian','pelunasan') COLLATE utf8mb4_unicode_ci NOT NULL,
  `total` decimal(15,2) DEFAULT '0.00',
  `metode_pembayaran` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'Tunai',
  `bayar` decimal(15,2) DEFAULT '0.00',
  `kembalian` decimal(15,2) DEFAULT '0.00',
  `keterangan` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `kode`, `tanggal`, `user_id`, `jenis`, `total`, `metode_pembayaran`, `bayar`, `kembalian`, `keterangan`) VALUES
(4, 'TRX202609228896', '2026-09-22 11:19:04', NULL, 'penjualan', 6500.00, 'Tunai', 7000.00, 500.00, ''),
(5, 'TRX202609247184', '2026-09-24 10:46:02', NULL, 'penjualan', 15000.00, 'Tunai', 20000.00, 5000.00, ''),
(6, 'TRX202609282377', '2026-09-28 09:38:15', NULL, 'penjualan', 3500.00, 'Tunai', 4000.00, 500.00, ''),
(7, 'TRX202609283421', '2026-09-28 09:38:36', NULL, 'penjualan', 3500.00, 'Tunai', 4000.00, 500.00, ''),
(8, 'TRX202609307601', '2026-09-30 11:36:03', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, ''),
(44, 'TRX202610257715', '2026-10-25 16:17:14', NULL, 'penjualan', 4000.00, 'Tunai', 5000.00, 1000.00, ''),
(45, 'TRX202610256158', '2026-10-25 16:20:48', NULL, 'penjualan', 12000.00, 'Tunai', 20000.00, 8000.00, ''),
(46, 'TRX202610253192', '2026-10-25 21:12:18', NULL, 'penjualan', 20000.00, 'Tunai', 20000.00, 0.00, 'DP hutang dari rehan'),
(47, 'TRX202610294231', '2026-10-28 23:57:47', NULL, 'penjualan', 20000.00, 'Tunai', 20000.00, 0.00, ''),
(48, 'TRX202610305121', '2026-10-30 02:05:14', NULL, 'penjualan', 26000.00, 'Tunai', 30000.00, 4000.00, ''),
(101, 'TRX202611111939', '2026-11-11 16:55:12', NULL, 'penjualan', 3500.00, 'Tunai', 3500.00, 0.00, ''),
(102, 'TRX202611111315', '2026-11-11 16:59:34', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, ''),
(103, 'TRX202611116256', '2026-11-11 17:00:56', NULL, 'penjualan', 11000.00, 'Tunai', 11000.00, 0.00, ''),
(104, 'TRX202611110620', '2026-11-11 17:05:12', NULL, 'penjualan', 8000.00, 'Tunai', 8000.00, 0.00, ''),
(105, 'TRX202611110010', '2026-11-11 17:08:17', NULL, 'penjualan', 25500.00, 'Tunai', 25500.00, 0.00, ''),
(106, 'TRX202611118012', '2026-11-11 17:09:15', NULL, 'penjualan', 30000.00, 'Tunai', 30000.00, 0.00, ''),
(107, 'TRX202611114562', '2026-11-11 17:13:12', NULL, 'penjualan', 20000.00, 'Tunai', 20000.00, 0.00, ''),
(108, 'TRX202611116956', '2026-11-11 17:14:32', NULL, 'penjualan', 11000.00, 'Tunai', 11000.00, 0.00, ''),
(109, 'TRX202611112210', '2026-11-11 17:18:51', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, ''),
(110, 'TRX202611114425', '2026-11-11 17:26:56', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, ''),
(111, 'TRX202611116433', '2026-11-11 17:38:18', NULL, 'penjualan', 2000.00, 'Tunai', 50000.00, 48000.00, ''),
(112, 'TRX202611110753', '2026-11-11 17:39:25', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, ''),
(113, 'TRX202611114330', '2026-11-11 17:40:47', NULL, 'penjualan', 500.00, 'Tunai', 500.00, 0.00, ''),
(114, 'TRX202611116397', '2026-11-11 17:43:08', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, ''),
(115, 'TRX202611116445', '2026-11-11 17:43:48', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, ''),
(116, 'TRX202611113088', '2026-11-11 17:54:24', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, ''),
(117, 'TRX202611118280', '2026-11-11 17:55:01', NULL, 'penjualan', 4500.00, 'Tunai', 4500.00, 0.00, ''),
(118, 'TRX202611115742', '2026-11-11 17:55:46', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, ''),
(119, 'TRX202611111302', '2026-11-11 17:56:17', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, ''),
(120, 'TRX202611114053', '2026-11-11 17:56:58', NULL, 'penjualan', 1000.00, 'Tunai', 1000.00, 0.00, ''),
(121, 'TRX202611110032', '2026-11-11 17:57:33', NULL, 'penjualan', 3500.00, 'Tunai', 3500.00, 0.00, ''),
(122, 'TRX202611110696', '2026-11-11 19:20:32', NULL, 'penjualan', 46000.00, 'Tunai', 46000.00, 0.00, ''),
(123, 'TRX202611110164', '2026-11-11 19:22:06', NULL, 'penjualan', 16500.00, 'Tunai', 16500.00, 0.00, ''),
(124, 'TRX202611111428', '2026-11-11 19:23:19', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, ''),
(125, 'TRX202611115833', '2026-11-11 19:24:25', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, ''),
(126, 'TRX202611113697', '2026-11-11 19:26:02', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, ''),
(127, 'TRX202611124008', '2026-11-11 23:43:35', NULL, 'penjualan', 394000.00, 'Tunai', 394000.00, 0.00, ''),
(128, 'TRX202611138123', '2026-11-12 22:26:53', NULL, 'penjualan', 261500.00, 'Tunai', 261500.00, 0.00, ''),
(129, 'TRX202611137203', '2026-11-12 22:29:44', NULL, 'penjualan', 135000.00, 'Tunai', 135000.00, 0.00, ''),
(130, 'TRX202611168202', '2026-11-16 15:47:42', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(131, 'TRX202611169865', '2026-11-16 15:50:10', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(132, 'TRX202611165385', '2026-11-16 15:51:25', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(133, 'TRX202611164405', '2026-11-16 15:51:58', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(134, 'TRX202611163437', '2026-11-16 15:53:53', NULL, 'penjualan', 22000.00, 'Tunai', 22000.00, 0.00, 'Metode: Tunai'),
(135, 'TRX202611161215', '2026-11-16 15:55:38', NULL, 'penjualan', 15000.00, 'Tunai', 15000.00, 0.00, 'Metode: Tunai'),
(136, 'TRX202611163613', '2026-11-16 15:56:45', NULL, 'penjualan', 9000.00, 'Tunai', 9000.00, 0.00, 'Metode: Tunai'),
(137, 'TRX202611168038', '2026-11-16 15:57:09', NULL, 'penjualan', 14000.00, 'Tunai', 14000.00, 0.00, 'Metode: Tunai'),
(138, 'TRX202611160571', '2026-11-16 16:02:26', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(140, 'TRX202611160750', '2026-11-16 16:24:39', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(143, 'TRX202611172114', '2026-11-17 08:12:41', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(144, 'TRX202611175816', '2026-11-17 08:23:37', NULL, 'penjualan', 62000.00, 'Tunai', 62000.00, 0.00, 'Metode: Tunai'),
(145, 'TRX202611175316', '2026-11-17 08:23:59', NULL, 'penjualan', 10500.00, 'Tunai', 10500.00, 0.00, 'Metode: Tunai'),
(146, 'TRX202611170855', '2026-11-17 08:24:23', NULL, 'penjualan', 28000.00, 'Tunai', 28000.00, 0.00, 'Metode: Tunai'),
(147, 'TRX202611176474', '2026-11-17 08:24:44', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(148, 'TRX202611177159', '2026-11-17 08:25:05', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(149, 'TRX202611171294', '2026-11-17 08:25:27', NULL, 'penjualan', 500.00, 'Tunai', 500.00, 0.00, 'Metode: Tunai'),
(150, 'TRX202611170388', '2026-11-17 08:25:48', NULL, 'penjualan', 44000.00, 'Tunai', 44000.00, 0.00, 'Metode: Tunai'),
(151, 'TRX202611174901', '2026-11-17 08:27:17', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(152, 'TRX202611172852', '2026-11-17 08:27:32', NULL, 'penjualan', 3500.00, 'Tunai', 3500.00, 0.00, 'Metode: Tunai'),
(153, 'TRX202611178397', '2026-11-17 08:27:44', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(154, 'TRX202611175103', '2026-11-17 08:27:56', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(155, 'TRX202611173306', '2026-11-17 08:28:12', NULL, 'penjualan', 3500.00, 'Tunai', 3500.00, 0.00, 'Metode: Tunai'),
(156, 'TRX202611172330', '2026-11-17 08:29:51', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(157, 'TRX202611172381', '2026-11-17 08:30:15', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(158, 'TRX202611173703', '2026-11-17 08:30:42', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(159, 'TRX202611170335', '2026-11-17 08:31:12', NULL, 'penjualan', 8000.00, 'QRIS', 8000.00, 0.00, 'Metode: QRIS'),
(160, 'TRX202611177030', '2026-11-17 08:31:23', NULL, 'penjualan', 12000.00, 'QRIS', 12000.00, 0.00, 'Metode: QRIS'),
(161, 'TRX202611174950', '2026-11-17 08:31:37', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(162, 'TRX202611174392', '2026-11-17 08:31:51', NULL, 'penjualan', 11000.00, 'QRIS', 11000.00, 0.00, 'Metode: QRIS'),
(163, 'TRX202611171679', '2026-11-17 08:32:01', NULL, 'penjualan', 3500.00, 'QRIS', 3500.00, 0.00, 'Metode: QRIS'),
(164, 'TRX202611178645', '2026-11-17 08:32:11', NULL, 'penjualan', 3000.00, 'QRIS', 3000.00, 0.00, 'Metode: QRIS'),
(165, 'TRX202611173293', '2026-11-17 08:34:30', NULL, 'penjualan', 500.00, 'Tunai', 500.00, 0.00, 'Metode: Tunai'),
(166, 'TRX202611171350', '2026-11-17 08:34:49', NULL, 'penjualan', 9000.00, 'Tunai', 9000.00, 0.00, 'Metode: Tunai'),
(167, 'TRX202611179271', '2026-11-17 08:35:05', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(168, 'TRX202611173108', '2026-11-17 08:36:15', NULL, 'penjualan', 2000.00, 'Tunai', 10000.00, 8000.00, 'Metode: Tunai'),
(169, 'TRX202611177929', '2026-11-17 08:44:16', NULL, 'penjualan', 2000.00, 'Tunai', 20000.00, 18000.00, 'Metode: Tunai'),
(170, 'TRX202611175426', '2026-11-17 08:45:41', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(171, 'TRX202611174163', '2026-11-17 08:48:36', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(172, 'TRX202611174186', '2026-11-17 08:49:13', NULL, 'penjualan', 11000.00, 'QRIS', 11000.00, 0.00, 'Metode: QRIS'),
(173, 'TRX202611179788', '2026-11-17 09:04:11', NULL, 'penjualan', 11000.00, 'QRIS', 11000.00, 0.00, 'Metode: QRIS'),
(174, 'TRX202611179068', '2026-11-17 09:08:16', NULL, 'penjualan', 7000.00, 'QRIS', 7000.00, 0.00, 'Metode: QRIS'),
(175, 'TRX202611178313', '2026-11-17 09:11:31', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(176, 'TRX202611171627', '2026-11-17 09:12:41', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(177, 'TRX202611171541', '2026-11-17 09:14:01', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(178, 'TRX202611170931', '2026-11-17 09:14:21', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(179, 'TRX202611174471', '2026-11-17 09:14:35', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(180, 'TRX202611176173', '2026-11-17 09:16:04', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(181, 'TRX202611171597', '2026-11-17 09:16:55', NULL, 'penjualan', 4500.00, 'Tunai', 5000.00, 500.00, 'Metode: Tunai'),
(182, 'TRX202611176165', '2026-11-17 09:17:27', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(183, 'TRX202611172706', '2026-11-17 09:18:24', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(184, 'TRX202611172894', '2026-11-17 09:18:51', NULL, 'penjualan', 3000.00, 'Tunai', 10000.00, 7000.00, 'Metode: Tunai'),
(185, 'TRX202611175065', '2026-11-17 09:19:12', NULL, 'penjualan', 2000.00, 'Tunai', 6000.00, 4000.00, 'Metode: Tunai'),
(186, 'TRX202611176268', '2026-11-17 09:20:56', NULL, 'penjualan', 7000.00, 'Tunai', 50000.00, 43000.00, 'Metode: Tunai'),
(187, 'TRX202611171673', '2026-11-17 09:21:40', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(188, 'TRX202611171657', '2026-11-17 09:22:12', NULL, 'penjualan', 4000.00, 'Tunai', 5000.00, 1000.00, 'Metode: Tunai'),
(189, 'TRX202611173091', '2026-11-17 09:22:43', NULL, 'penjualan', 2000.00, 'Tunai', 4000.00, 2000.00, 'Metode: Tunai'),
(190, 'TRX202611178197', '2026-11-17 09:23:03', NULL, 'penjualan', 1500.00, 'Tunai', 2000.00, 500.00, 'Metode: Tunai'),
(191, 'TRX202611175470', '2026-11-17 09:29:28', NULL, 'penjualan', 2000.00, 'Tunai', 10000.00, 8000.00, 'Metode: Tunai'),
(192, 'TRX202611174423', '2026-11-17 09:29:42', NULL, 'penjualan', 1500.00, 'Tunai', 2000.00, 500.00, 'Metode: Tunai'),
(193, 'TRX202611177496', '2026-11-17 09:29:57', NULL, 'penjualan', 1500.00, 'Tunai', 5000.00, 3500.00, 'Metode: Tunai'),
(194, 'TRX202611173252', '2026-11-17 09:30:44', NULL, 'penjualan', 18000.00, 'Tunai', 50000.00, 32000.00, 'Metode: Tunai'),
(195, 'TRX202611170913', '2026-11-17 09:31:44', NULL, 'penjualan', 11000.00, 'Tunai', 11000.00, 0.00, 'Metode: Tunai'),
(196, 'TRX202611179373', '2026-11-17 09:31:56', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(197, 'TRX202611179265', '2026-11-17 09:34:00', NULL, 'penjualan', 7000.00, 'Tunai', 10000.00, 3000.00, 'Metode: Tunai'),
(198, 'TRX202611170455', '2026-11-17 09:36:30', NULL, 'penjualan', 3000.00, 'Tunai', 4000.00, 1000.00, 'Metode: Tunai'),
(199, 'TRX202611175681', '2026-11-17 09:36:45', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(200, 'TRX202611175594', '2026-11-17 09:37:45', NULL, 'penjualan', 11000.00, 'Tunai', 50000.00, 39000.00, 'Metode: Tunai'),
(201, 'TRX202611178346', '2026-11-17 09:38:49', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(202, 'TRX202611179301', '2026-11-17 09:39:34', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(203, 'TRX202611179281', '2026-11-17 09:41:12', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(204, 'TRX202611179550', '2026-11-17 09:41:56', NULL, 'penjualan', 5000.00, 'Tunai', 20000.00, 15000.00, 'Metode: Tunai'),
(205, 'TRX202611176214', '2026-11-17 09:42:04', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(206, 'TRX202611179372', '2026-11-17 09:46:00', NULL, 'penjualan', 7000.00, 'Tunai', 10000.00, 3000.00, 'Metode: Tunai'),
(207, 'TRX202611178332', '2026-11-17 09:47:56', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(208, 'TRX202611179753', '2026-11-17 09:48:08', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(209, 'TRX202611179024', '2026-11-17 09:48:17', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(210, 'TRX202611179932', '2026-11-17 09:59:36', NULL, 'penjualan', 5000.00, 'Tunai', 50000.00, 45000.00, 'Metode: Tunai'),
(211, 'TRX202611172453', '2026-11-17 10:08:19', NULL, 'penjualan', 4500.00, 'Tunai', 5000.00, 500.00, 'Metode: Tunai'),
(212, 'TRX202611175694', '2026-11-17 10:09:36', NULL, 'penjualan', 3000.00, 'Tunai', 10000.00, 7000.00, 'Metode: Tunai'),
(213, 'TRX202611175733', '2026-11-17 10:15:53', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(214, 'TRX202611173056', '2026-11-17 10:35:22', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(215, 'TRX202611171458', '2026-11-17 10:44:05', NULL, 'penjualan', 12000.00, 'Tunai', 20000.00, 8000.00, 'Metode: Tunai'),
(216, 'TRX202611173345', '2026-11-17 10:49:34', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(217, 'TRX202611176311', '2026-11-17 10:58:17', NULL, 'penjualan', 11000.00, 'QRIS', 11000.00, 0.00, 'Metode: QRIS'),
(218, 'TRX202611173825', '2026-11-17 11:04:04', NULL, 'penjualan', 3000.00, 'Tunai', 20000.00, 17000.00, 'Metode: Tunai'),
(219, 'TRX202611172183', '2026-11-17 11:05:06', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(220, 'TRX202611176736', '2026-11-17 11:05:38', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(221, 'TRX202611173578', '2026-11-17 11:05:49', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(222, 'TRX202611174131', '2026-11-17 11:06:20', NULL, 'penjualan', 5000.00, 'Tunai', 20000.00, 15000.00, 'Metode: Tunai'),
(223, 'TRX202611177667', '2026-11-17 11:08:49', NULL, 'penjualan', 3000.00, 'QRIS', 3000.00, 0.00, 'Metode: QRIS'),
(224, 'TRX202611171762', '2026-11-17 11:14:50', NULL, 'penjualan', 11000.00, 'Tunai', 11000.00, 0.00, 'Metode: Tunai'),
(225, 'TRX202611178217', '2026-11-17 11:24:36', NULL, 'penjualan', 8000.00, 'Tunai', 10000.00, 2000.00, 'Metode: Tunai'),
(226, 'TRX202611176985', '2026-11-17 11:27:56', NULL, 'penjualan', 10000.00, 'Tunai', 20000.00, 10000.00, 'Metode: Tunai'),
(227, 'TRX202611175178', '2026-11-17 11:38:55', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(228, 'TRX202611179176', '2026-11-17 11:46:33', NULL, 'penjualan', 6000.00, 'Tunai', 10000.00, 4000.00, 'Metode: Tunai'),
(229, 'TRX202611171479', '2026-11-17 11:50:06', NULL, 'penjualan', 11000.00, 'Tunai', 20000.00, 9000.00, 'Metode: Tunai'),
(230, 'TRX202611173789', '2026-11-17 11:50:17', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(231, 'TRX202611177449', '2026-11-17 11:52:34', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(232, 'TRX202611175047', '2026-11-17 11:58:00', NULL, 'penjualan', 1500.00, 'Tunai', 5000.00, 3500.00, 'Metode: Tunai'),
(233, 'TRX202611179818', '2026-11-17 12:03:14', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(234, 'TRX202611175229', '2026-11-17 12:04:21', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(235, 'TRX202611177369', '2026-11-17 12:08:07', NULL, 'penjualan', 7500.00, 'Tunai', 10000.00, 2500.00, 'Metode: Tunai'),
(236, 'TRX202611173672', '2026-11-17 12:08:22', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(237, 'TRX202611178480', '2026-11-17 12:08:51', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(238, 'TRX202611172389', '2026-11-17 12:09:52', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(239, 'TRX202611171188', '2026-11-17 12:11:54', NULL, 'penjualan', 10000.00, 'Tunai', 50000.00, 40000.00, 'Metode: Tunai'),
(240, 'TRX202611170788', '2026-11-17 12:13:40', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(241, 'TRX202611179322', '2026-11-17 12:16:51', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(242, 'TRX202611178142', '2026-11-17 12:18:21', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(243, 'TRX202611174935', '2026-11-17 12:18:44', NULL, 'penjualan', 5000.00, 'QRIS', 5000.00, 0.00, 'Metode: QRIS'),
(244, 'TRX202611170606', '2026-11-17 12:22:40', NULL, 'penjualan', 67500.00, 'QRIS', 67500.00, 0.00, 'Metode: QRIS'),
(245, 'TRX202611178057', '2026-11-17 12:23:08', NULL, 'penjualan', 3000.00, 'Tunai', 10000.00, 7000.00, 'Metode: Tunai'),
(246, 'TRX202611173379', '2026-11-17 12:23:59', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(247, 'TRX202611172235', '2026-11-17 12:24:35', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(248, 'TRX202611179167', '2026-11-17 12:26:58', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(249, 'TRX202611174998', '2026-11-17 12:27:27', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(250, 'TRX202611173407', '2026-11-17 12:30:33', NULL, 'penjualan', 1500.00, 'Tunai', 2000.00, 500.00, 'Metode: Tunai'),
(251, 'TRX202611177724', '2026-11-17 12:37:48', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(252, 'TRX202611179879', '2026-11-17 12:43:15', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(253, 'TRX202611178703', '2026-11-17 12:46:31', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(254, 'TRX202611171733', '2026-11-17 12:52:07', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(255, 'TRX202611178007', '2026-11-17 12:52:42', NULL, 'penjualan', 2500.00, 'Tunai', 3000.00, 500.00, 'Metode: Tunai'),
(256, 'TRX202611170040', '2026-11-17 12:53:35', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(257, 'TRX202611174044', '2026-11-17 12:55:16', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Pelunasan hutang dari pari 12 rpl'),
(258, 'TRX202611175355', '2026-11-17 12:56:51', NULL, 'penjualan', 2000.00, 'Tunai', 10000.00, 8000.00, 'Metode: Tunai'),
(259, 'TRX202611170906', '2026-11-17 12:57:40', NULL, 'penjualan', 3000.00, 'Tunai', 10000.00, 7000.00, 'Metode: Tunai'),
(260, 'TRX202611177406', '2026-11-17 12:57:58', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(261, 'TRX202611179593', '2026-11-17 12:58:09', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(262, 'TRX202611177509', '2026-11-17 13:12:07', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(263, 'TRX202611176742', '2026-11-17 13:12:40', NULL, 'penjualan', 3500.00, 'QRIS', 3500.00, 0.00, 'Metode: QRIS'),
(264, 'TRX202611176667', '2026-11-17 13:21:01', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(265, 'TRX202611178521', '2026-11-17 13:23:41', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(266, 'TRX202611174777', '2026-11-17 13:43:15', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(267, 'TRX202611176473', '2026-11-17 13:55:30', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(268, 'TRX202611177242', '2026-11-17 14:03:19', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(269, 'TRX202611176064', '2026-11-17 14:05:14', NULL, 'penjualan', 3000.00, 'QRIS', 3000.00, 0.00, 'Metode: QRIS'),
(270, 'TRX202611178720', '2026-11-17 14:05:48', NULL, 'penjualan', 3000.00, 'QRIS', 3000.00, 0.00, 'Metode: QRIS'),
(271, 'TRX202611182089', '2026-11-18 06:30:16', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(272, 'TRX202611183367', '2026-11-18 06:30:51', NULL, 'penjualan', 7500.00, 'Tunai', 7500.00, 0.00, 'Metode: Tunai'),
(273, 'TRX202611181004', '2026-11-18 06:31:02', NULL, 'penjualan', 500.00, 'Tunai', 500.00, 0.00, 'Metode: Tunai'),
(274, 'TRX202611180096', '2026-11-18 06:31:58', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(275, 'TRX202611185345', '2026-11-18 06:33:31', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(276, 'TRX202611180254', '2026-11-18 06:34:05', NULL, 'penjualan', 1500.00, 'Tunai', 5000.00, 3500.00, 'Metode: Tunai'),
(277, 'TRX202611181188', '2026-11-18 06:34:33', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(278, 'TRX202611180105', '2026-11-18 06:35:13', NULL, 'penjualan', 6500.00, 'Tunai', 10500.00, 4000.00, 'Metode: Tunai'),
(279, 'TRX202611185936', '2026-11-18 06:37:09', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(280, 'TRX202611184506', '2026-11-18 06:38:07', NULL, 'penjualan', 3000.00, 'Tunai', 4000.00, 1000.00, 'Metode: Tunai'),
(281, 'TRX202611189998', '2026-11-18 06:38:27', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(282, 'TRX202611188378', '2026-11-18 06:38:41', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(283, 'TRX202611189981', '2026-11-18 06:40:30', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(284, 'TRX202611184078', '2026-11-18 06:41:10', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(285, 'TRX202611189094', '2026-11-18 06:44:23', NULL, 'penjualan', 4500.00, 'Tunai', 5000.00, 500.00, 'Metode: Tunai'),
(286, 'TRX202611186401', '2026-11-18 06:50:57', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(287, 'TRX202611188816', '2026-11-18 06:53:27', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(288, 'TRX202611185684', '2026-11-18 06:54:14', NULL, 'penjualan', 9000.00, 'Tunai', 9000.00, 0.00, 'Metode: Tunai'),
(289, 'TRX202611185560', '2026-11-18 06:54:30', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(290, 'TRX202611180748', '2026-11-18 06:54:43', NULL, 'penjualan', 1500.00, 'Tunai', 1500.00, 0.00, 'Metode: Tunai'),
(291, 'TRX202611185731', '2026-11-18 06:55:00', NULL, 'penjualan', 500.00, 'Tunai', 500.00, 0.00, 'Metode: Tunai'),
(292, 'TRX202611185937', '2026-11-18 07:19:19', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(293, 'TRX202611188901', '2026-11-18 07:19:40', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(294, 'TRX202611181697', '2026-11-18 07:26:05', NULL, 'penjualan', 3000.00, 'Tunai', 20000.00, 17000.00, 'Metode: Tunai'),
(295, 'TRX202611180471', '2026-11-18 07:40:24', NULL, 'penjualan', 11000.00, 'Tunai', 20000.00, 9000.00, 'Metode: Tunai'),
(296, 'TRX202611186729', '2026-11-18 07:46:44', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(297, 'TRX202611180723', '2026-11-18 07:57:52', NULL, 'penjualan', 2000.00, 'Tunai', 50000.00, 48000.00, 'Metode: Tunai'),
(298, 'TRX202611188793', '2026-11-18 07:58:11', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(299, 'TRX202611182457', '2026-11-18 08:09:19', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(300, 'TRX202611182529', '2026-11-18 08:17:52', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(301, 'TRX202611187269', '2026-11-18 08:18:04', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(302, 'TRX202611188765', '2026-11-18 08:26:10', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(303, 'TRX202611181608', '2026-11-18 08:30:03', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(304, 'TRX202611180393', '2026-11-18 08:41:22', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(305, 'TRX202611187174', '2026-11-18 08:50:07', NULL, 'penjualan', 7000.00, 'Tunai', 20000.00, 13000.00, 'Metode: Tunai'),
(306, 'TRX202611184136', '2026-11-18 08:53:42', NULL, 'penjualan', 16000.00, 'QRIS', 16000.00, 0.00, 'Metode: QRIS'),
(307, 'TRX202611187476', '2026-11-18 08:54:10', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(308, 'TRX202611185565', '2026-11-18 08:54:23', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(309, 'TRX202611182807', '2026-11-18 08:54:34', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(310, 'TRX202611183169', '2026-11-18 08:55:05', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(311, 'TRX202611188803', '2026-11-18 08:55:35', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(312, 'TRX202611188642', '2026-11-18 08:57:53', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(313, 'TRX202611182434', '2026-11-18 08:58:04', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(314, 'TRX202611184841', '2026-11-18 09:00:04', NULL, 'penjualan', 3500.00, 'Tunai', 4000.00, 500.00, 'Metode: Tunai'),
(315, 'TRX202611180412', '2026-11-18 09:04:36', NULL, 'penjualan', 1500.00, 'Tunai', 2000.00, 500.00, 'Metode: Tunai'),
(316, 'TRX202611185203', '2026-11-18 09:06:09', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(317, 'TRX202611180788', '2026-11-18 09:08:02', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(318, 'TRX202611189671', '2026-11-18 09:08:32', NULL, 'penjualan', 2000.00, 'Tunai', 50000.00, 48000.00, 'Metode: Tunai'),
(319, 'TRX202611182303', '2026-11-18 09:09:11', NULL, 'penjualan', 1500.00, 'Tunai', 5000.00, 3500.00, 'Metode: Tunai'),
(320, 'TRX202611188761', '2026-11-18 09:10:18', NULL, 'penjualan', 4000.00, 'Tunai', 5000.00, 1000.00, 'Metode: Tunai'),
(321, 'TRX202611189707', '2026-11-18 09:10:54', NULL, 'penjualan', 13000.00, 'Tunai', 50000.00, 37000.00, 'Metode: Tunai'),
(322, 'TRX202611181415', '2026-11-18 09:11:13', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(323, 'TRX202611184741', '2026-11-18 09:11:47', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(324, 'TRX202611180301', '2026-11-18 09:12:17', NULL, 'penjualan', 1000.00, 'Tunai', 1000.00, 0.00, 'Metode: Tunai'),
(325, 'TRX202611189826', '2026-11-18 09:13:21', NULL, 'penjualan', 4000.00, 'QRIS', 4000.00, 0.00, 'Metode: QRIS'),
(326, 'TRX202611186857', '2026-11-18 09:14:08', NULL, 'penjualan', 1500.00, 'Tunai', 10000.00, 8500.00, 'Metode: Tunai'),
(327, 'TRX202611188051', '2026-11-18 09:15:23', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(328, 'TRX202611188072', '2026-11-18 09:16:58', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(329, 'TRX202611185759', '2026-11-18 09:17:24', NULL, 'penjualan', 2000.00, 'Tunai', 10000.00, 8000.00, 'Metode: Tunai'),
(330, 'TRX202611184429', '2026-11-18 09:22:38', NULL, 'penjualan', 22000.00, 'QRIS', 22000.00, 0.00, 'Metode: QRIS'),
(331, 'TRX202611186701', '2026-11-18 09:24:20', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(332, 'TRX202611189913', '2026-11-18 09:24:35', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(333, 'TRX202611186594', '2026-11-18 09:24:51', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(334, 'TRX202611189153', '2026-11-18 09:26:11', NULL, 'penjualan', 6000.00, 'Tunai', 10000.00, 4000.00, 'Metode: Tunai'),
(335, 'TRX202611185831', '2026-11-18 09:28:21', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(336, 'TRX202611182029', '2026-11-18 09:28:44', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(337, 'TRX202611187836', '2026-11-18 09:29:24', NULL, 'penjualan', 8000.00, 'QRIS', 8000.00, 0.00, 'Metode: QRIS'),
(338, 'TRX202611180576', '2026-11-18 09:29:52', NULL, 'penjualan', 3000.00, 'Tunai', 4000.00, 1000.00, 'Metode: Tunai'),
(339, 'TRX202611181550', '2026-11-18 09:32:11', NULL, 'penjualan', 11000.00, 'Tunai', 11000.00, 0.00, 'Metode: Tunai'),
(340, 'TRX202611189925', '2026-11-18 09:32:59', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(341, 'TRX202611181870', '2026-11-18 09:33:13', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(342, 'TRX202611188217', '2026-11-18 09:38:15', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(343, 'TRX202611186983', '2026-11-18 09:39:12', NULL, 'penjualan', 5000.00, 'Tunai', 50000.00, 45000.00, 'Metode: Tunai'),
(344, 'TRX202611185625', '2026-11-18 09:40:11', NULL, 'penjualan', 14500.00, 'Tunai', 50000.00, 35500.00, 'Metode: Tunai'),
(345, 'TRX202611181249', '2026-11-18 09:40:24', NULL, 'penjualan', 5000.00, 'QRIS', 5000.00, 0.00, 'Metode: QRIS'),
(346, 'TRX202611184448', '2026-11-18 09:41:13', NULL, 'penjualan', 2500.00, 'Tunai', 5000.00, 2500.00, 'Metode: Tunai'),
(347, 'TRX202611186329', '2026-11-18 09:47:59', NULL, 'penjualan', 9000.00, 'QRIS', 9000.00, 0.00, 'Metode: QRIS'),
(348, 'TRX202611188947', '2026-11-18 09:49:43', NULL, 'penjualan', 5000.00, 'QRIS', 5000.00, 0.00, 'Metode: QRIS'),
(349, 'TRX202611189428', '2026-11-18 09:52:43', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(350, 'TRX202611187027', '2026-11-18 09:57:20', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(351, 'TRX202611189631', '2026-11-18 09:58:02', NULL, 'penjualan', 13500.00, 'Tunai', 13500.00, 0.00, 'Metode: Tunai'),
(352, 'TRX202611181431', '2026-11-18 09:58:21', NULL, 'penjualan', 4500.00, 'Tunai', 5000.00, 500.00, 'Metode: Tunai'),
(353, 'TRX202611187613', '2026-11-18 09:59:05', NULL, 'penjualan', 4000.00, 'Tunai', 5000.00, 1000.00, 'Metode: Tunai'),
(354, 'TRX202611180458', '2026-11-18 10:00:16', NULL, 'penjualan', 3000.00, 'Tunai', 10000.00, 7000.00, 'Metode: Tunai'),
(355, 'TRX202611189365', '2026-11-18 10:04:09', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(356, 'TRX202611182919', '2026-11-18 10:11:05', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(357, 'TRX202611189711', '2026-11-18 10:16:13', NULL, 'penjualan', 12500.00, 'QRIS', 12500.00, 0.00, 'Metode: QRIS'),
(358, 'TRX202611185483', '2026-11-18 10:17:30', NULL, 'penjualan', 7500.00, 'QRIS', 7500.00, 0.00, 'Metode: QRIS'),
(359, 'TRX202611186741', '2026-11-18 10:18:00', NULL, 'penjualan', 16000.00, 'Tunai', 16000.00, 0.00, 'Metode: Tunai'),
(360, 'TRX202611188597', '2026-11-18 10:26:44', NULL, 'penjualan', 1000.00, 'Tunai', 1000.00, 0.00, 'Metode: Tunai'),
(361, 'TRX202611189832', '2026-11-18 10:27:02', NULL, 'penjualan', 500.00, 'Tunai', 500.00, 0.00, 'Metode: Tunai'),
(362, 'TRX202611187114', '2026-11-18 10:27:38', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(363, 'TRX202611189722', '2026-11-18 10:28:02', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(364, 'TRX202611186407', '2026-11-18 10:28:30', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(365, 'TRX202611180074', '2026-11-18 10:29:01', NULL, 'penjualan', 1000.00, 'Tunai', 5000.00, 4000.00, 'Metode: Tunai'),
(366, 'TRX202611184743', '2026-11-18 10:29:34', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(367, 'TRX202611185371', '2026-11-18 10:31:40', NULL, 'penjualan', 2500.00, 'Tunai', 5000.00, 2500.00, 'Metode: Tunai'),
(368, 'TRX202611189055', '2026-11-18 10:31:56', NULL, 'penjualan', 1000.00, 'Tunai', 1000.00, 0.00, 'Metode: Tunai'),
(369, 'TRX202611190312', '2026-11-19 07:09:10', NULL, 'penjualan', 24000.00, 'Tunai', 24000.00, 0.00, 'Metode: Tunai'),
(370, 'TRX202611197673', '2026-11-19 07:09:26', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(371, 'TRX202611193025', '2026-11-19 07:09:41', NULL, 'penjualan', 19500.00, 'Tunai', 19500.00, 0.00, 'Metode: Tunai'),
(372, 'TRX202611197806', '2026-11-19 07:09:58', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(373, 'TRX202611193068', '2026-11-19 07:10:32', NULL, 'penjualan', 1500.00, 'Tunai', 5000.00, 3500.00, 'Metode: Tunai'),
(374, 'TRX202611192110', '2026-11-19 07:11:54', NULL, 'penjualan', 8000.00, 'Tunai', 8000.00, 0.00, 'Metode: Tunai'),
(375, 'TRX202611198852', '2026-11-19 07:12:12', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(376, 'TRX202611193821', '2026-11-19 07:12:42', NULL, 'penjualan', 4500.00, 'Tunai', 4500.00, 0.00, 'Metode: Tunai'),
(377, 'TRX202611199458', '2026-11-19 07:13:21', NULL, 'penjualan', 15000.00, 'Tunai', 15000.00, 0.00, 'Metode: Tunai'),
(378, 'TRX202611194596', '2026-11-19 07:13:36', NULL, 'penjualan', 4000.00, 'Tunai', 4000.00, 0.00, 'Metode: Tunai'),
(379, 'TRX202611194770', '2026-11-19 07:13:47', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(381, 'TRX202611193237', '2026-11-19 07:15:37', NULL, 'penjualan', 8500.00, 'Tunai', 8500.00, 0.00, 'Metode: Tunai'),
(382, 'TRX202611196488', '2026-11-19 07:20:21', NULL, 'penjualan', 8000.00, 'QRIS', 8000.00, 0.00, 'Metode: QRIS'),
(383, 'TRX202611197682', '2026-11-19 07:21:11', NULL, 'penjualan', 12000.00, 'Tunai', 12000.00, 0.00, 'Metode: Tunai'),
(384, 'TRX202611192328', '2026-11-19 07:26:15', NULL, 'penjualan', 25000.00, 'QRIS', 25000.00, 0.00, 'Metode: QRIS'),
(385, 'TRX202611190402', '2026-11-19 07:27:55', NULL, 'penjualan', 5000.00, 'Tunai', 10000.00, 5000.00, 'Metode: Tunai'),
(386, 'TRX202611195436', '2026-11-19 07:29:53', NULL, 'penjualan', 11000.00, 'Tunai', 20000.00, 9000.00, 'Metode: Tunai'),
(387, 'TRX202611193708', '2026-11-19 07:36:59', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(388, 'TRX202611197134', '2026-11-19 07:38:10', NULL, 'penjualan', 3500.00, 'Tunai', 5000.00, 1500.00, 'Metode: Tunai'),
(389, 'TRX202611190966', '2026-11-19 07:48:27', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(390, 'TRX202611192922', '2026-11-19 08:12:00', NULL, 'penjualan', 14000.00, 'Tunai', 14000.00, 0.00, 'Metode: Tunai'),
(391, 'TRX202611198784', '2026-11-19 08:19:56', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(392, 'TRX202611190746', '2026-11-19 08:20:11', NULL, 'penjualan', 5000.00, 'QRIS', 5000.00, 0.00, 'Metode: QRIS'),
(393, 'TRX202611192888', '2026-11-19 08:24:11', NULL, 'penjualan', 2000.00, 'Tunai', 10000.00, 8000.00, 'Metode: Tunai'),
(394, 'TRX202611196922', '2026-11-19 08:24:32', NULL, 'penjualan', 1000.00, 'Tunai', 1000.00, 0.00, 'Metode: Tunai'),
(395, 'TRX202611190161', '2026-11-19 09:14:39', NULL, 'penjualan', 37000.00, 'QRIS', 37000.00, 0.00, 'Metode: QRIS'),
(396, 'TRX202611193280', '2026-11-19 09:18:28', NULL, 'penjualan', 2000.00, 'QRIS', 2000.00, 0.00, 'Metode: QRIS'),
(397, 'TRX202611194452', '2026-11-19 09:19:58', NULL, 'penjualan', 79000.00, 'Tunai', 79000.00, 0.00, 'Metode: Tunai'),
(398, 'TRX202611197345', '2026-11-19 09:21:36', NULL, 'penjualan', 10500.00, 'Tunai', 10500.00, 0.00, 'Metode: Tunai'),
(399, 'TRX202611194800', '2026-11-19 09:22:46', NULL, 'penjualan', 3500.00, 'Tunai', 3500.00, 0.00, 'Metode: Tunai'),
(400, 'TRX202611190571', '2026-11-19 09:23:50', NULL, 'penjualan', 5000.00, 'Tunai', 5000.00, 0.00, 'Metode: Tunai'),
(401, 'TRX202611191463', '2026-11-19 09:37:57', NULL, 'penjualan', 24000.00, 'QRIS', 24000.00, 0.00, 'Metode: QRIS'),
(402, 'TRX202611194816', '2026-11-19 09:42:48', NULL, 'penjualan', 73500.00, 'Tunai', 73500.00, 0.00, 'Metode: Tunai'),
(404, 'TRX202611192300', '2026-11-19 09:45:31', NULL, 'penjualan', 17000.00, 'QRIS', 17000.00, 0.00, 'Metode: QRIS'),
(405, 'TRX202611191294', '2026-11-19 09:46:34', NULL, 'penjualan', 26000.00, 'Tunai', 26000.00, 0.00, 'Metode: Tunai'),
(406, 'TRX202611195156', '2026-11-19 09:46:50', NULL, 'penjualan', 15000.00, 'QRIS', 15000.00, 0.00, 'Metode: QRIS'),
(407, 'TRX202611194487', '2026-11-19 09:48:43', NULL, 'penjualan', 10000.00, 'Tunai', 10000.00, 0.00, 'Metode: Tunai'),
(408, 'TRX202611195272', '2026-11-19 09:50:17', NULL, 'penjualan', 1500.00, 'QRIS', 1500.00, 0.00, 'Metode: QRIS'),
(409, 'TRX202611191518', '2026-11-19 09:53:34', NULL, 'penjualan', 3000.00, 'Tunai', 5000.00, 2000.00, 'Metode: Tunai'),
(410, 'TRX202611192307', '2026-11-19 12:28:48', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(411, 'TRX202611195554', '2026-11-19 12:29:02', NULL, 'penjualan', 16500.00, 'Tunai', 16500.00, 0.00, 'Metode: Tunai'),
(412, 'TRX202611198970', '2026-11-19 12:29:53', NULL, 'penjualan', 35000.00, 'Tunai', 35000.00, 0.00, 'Metode: Tunai'),
(413, 'TRX202611197136', '2026-11-19 12:30:21', NULL, 'penjualan', 20000.00, 'Tunai', 20000.00, 0.00, 'Metode: Tunai'),
(414, 'TRX202611194172', '2026-11-19 12:31:17', NULL, 'penjualan', 14000.00, 'Tunai', 14000.00, 0.00, 'Metode: Tunai'),
(415, 'TRX202611191793', '2026-11-19 12:31:50', NULL, 'penjualan', 2000.00, 'Tunai', 5000.00, 3000.00, 'Metode: Tunai'),
(416, 'TRX202611190035', '2026-11-19 12:32:03', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(417, 'TRX202611191124', '2026-11-19 12:32:33', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(418, 'TRX202611191660', '2026-11-19 12:32:47', NULL, 'penjualan', 22000.00, 'Tunai', 22000.00, 0.00, 'Metode: Tunai'),
(419, 'TRX202611197215', '2026-11-19 12:33:11', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(420, 'TRX202611196311', '2026-11-19 12:33:31', NULL, 'penjualan', 7000.00, 'Tunai', 7000.00, 0.00, 'Metode: Tunai'),
(421, 'TRX202611193529', '2026-11-19 12:34:41', NULL, 'penjualan', 11500.00, 'Tunai', 11500.00, 0.00, 'Metode: Tunai'),
(422, 'TRX202611194624', '2026-11-19 12:35:05', NULL, 'penjualan', 23000.00, 'Tunai', 23000.00, 0.00, 'Metode: Tunai'),
(423, 'TRX202611199380', '2026-11-19 12:37:19', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(424, 'TRX202611198998', '2026-11-19 12:37:35', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(425, 'TRX202611197476', '2026-11-19 12:39:34', NULL, 'penjualan', 129500.00, 'QRIS', 129500.00, 0.00, 'Metode: QRIS'),
(426, 'TRX202611208460', '2026-11-20 07:01:37', NULL, 'penjualan', 28000.00, 'Tunai', 28000.00, 0.00, 'Metode: Tunai'),
(427, 'TRX202611209162', '2026-11-20 07:01:48', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(428, 'TRX202611207993', '2026-11-20 07:02:05', NULL, 'penjualan', 5500.00, 'Tunai', 5500.00, 0.00, 'Metode: Tunai'),
(429, 'TRX202611201741', '2026-11-20 07:02:27', NULL, 'penjualan', 14500.00, 'Tunai', 14500.00, 0.00, 'Metode: Tunai'),
(430, 'TRX202611203638', '2026-11-20 07:02:42', NULL, 'penjualan', 11000.00, 'QRIS', 11000.00, 0.00, 'Metode: QRIS'),
(431, 'TRX202611207577', '2026-11-20 07:04:37', NULL, 'penjualan', 4000.00, 'Tunai', 10000.00, 6000.00, 'Metode: Tunai'),
(432, 'TRX202611204867', '2026-11-20 07:05:18', NULL, 'penjualan', 2000.00, 'Tunai', 2000.00, 0.00, 'Metode: Tunai'),
(433, 'TRX202611201668', '2026-11-20 07:06:30', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(435, 'TRX202611202383', '2026-11-20 07:09:02', NULL, 'penjualan', 14000.00, 'Tunai', 20000.00, 6000.00, 'Metode: Tunai'),
(436, 'TRX202611205490', '2026-11-20 07:09:29', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai'),
(437, 'TRX202611201008', '2026-11-20 07:11:22', NULL, 'penjualan', 6000.00, 'Tunai', 6000.00, 0.00, 'Metode: Tunai'),
(438, 'TRX202611203211', '2026-11-20 07:11:42', NULL, 'penjualan', 5500.00, 'Tunai', 5500.00, 0.00, 'Metode: Tunai'),
(439, 'TRX202611207037', '2026-11-20 07:17:06', NULL, 'penjualan', 9000.00, 'Tunai', 9000.00, 0.00, 'Metode: Tunai'),
(440, 'TRX202611207091', '2026-11-20 07:19:02', NULL, 'penjualan', 7500.00, 'Tunai', 7500.00, 0.00, 'Metode: Tunai'),
(441, 'TRX202611207273', '2026-11-20 07:19:30', NULL, 'penjualan', 13500.00, 'Tunai', 13500.00, 0.00, 'Metode: Tunai'),
(442, 'TRX202611209072', '2026-11-20 07:21:29', NULL, 'penjualan', 27000.00, 'QRIS', 27000.00, 0.00, 'Metode: QRIS'),
(443, 'TRX202611207135', '2026-11-20 07:22:08', NULL, 'penjualan', 3000.00, 'Tunai', 3000.00, 0.00, 'Metode: Tunai');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_detail`
--

CREATE TABLE `transaksi_detail` (
  `id` int NOT NULL,
  `transaksi_id` int NOT NULL,
  `produk_id` int DEFAULT NULL,
  `qty` int NOT NULL,
  `harga` decimal(15,2) NOT NULL,
  `subtotal` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaksi_detail`
--

INSERT INTO `transaksi_detail` (`id`, `transaksi_id`, `produk_id`, `qty`, `harga`, `subtotal`) VALUES
(8, 4, 6, 1, 3000.00, 3000.00),
(9, 4, 9, 1, 3500.00, 3500.00),
(10, 5, 6, 1, 3000.00, 3000.00),
(11, 5, 7, 1, 7000.00, 7000.00),
(12, 5, NULL, 1, 5000.00, 5000.00),
(13, 6, 9, 1, 3500.00, 3500.00),
(14, 7, 9, 1, 3500.00, 3500.00),
(15, 8, NULL, 2, 2500.00, 5000.00),
(65, 44, 509, 1, 4000.00, 4000.00),
(66, 45, 534, 1, 12000.00, 12000.00),
(67, 46, 527, 1, 9000.00, 9000.00),
(68, 46, 532, 1, 2500.00, 2500.00),
(69, 46, 533, 1, 10000.00, 10000.00),
(70, 46, 549, 1, 4000.00, 4000.00),
(71, 47, 533, 2, 10000.00, 20000.00),
(72, 48, 513, 1, 20000.00, 20000.00),
(73, 48, 514, 1, 3000.00, 3000.00),
(74, 48, 563, 1, 3000.00, 3000.00),
(141, 101, 499, 1, 3500.00, 3500.00),
(142, 102, 565, 3, 1000.00, 3000.00),
(143, 103, 506, 1, 11000.00, 11000.00),
(144, 104, 566, 1, 8000.00, 8000.00),
(145, 105, 490, 17, 1500.00, 25500.00),
(146, 106, 491, 15, 2000.00, 30000.00),
(147, 107, 491, 10, 2000.00, 20000.00),
(148, 108, 506, 1, 11000.00, 11000.00),
(149, 109, 567, 2, 2000.00, 4000.00),
(150, 110, 568, 3, 500.00, 1500.00),
(151, 111, 491, 1, 2000.00, 2000.00),
(152, 112, 490, 2, 1500.00, 3000.00),
(153, 113, 568, 1, 500.00, 500.00),
(154, 114, 526, 1, 5000.00, 5000.00),
(155, 114, 554, 1, 5000.00, 5000.00),
(156, 115, 491, 1, 2000.00, 2000.00),
(157, 116, 569, 1, 5000.00, 5000.00),
(158, 117, 517, 1, 4500.00, 4500.00),
(159, 118, 525, 2, 2000.00, 4000.00),
(160, 119, 491, 1, 2000.00, 2000.00),
(161, 120, 568, 2, 500.00, 1000.00),
(162, 121, 515, 1, 3500.00, 3500.00),
(163, 122, 491, 23, 2000.00, 46000.00),
(164, 123, 490, 11, 1500.00, 16500.00),
(165, 124, 565, 2, 1000.00, 2000.00),
(166, 125, 568, 14, 500.00, 7000.00),
(167, 126, 551, 2, 5000.00, 10000.00),
(168, 127, 490, 27, 1500.00, 40500.00),
(169, 127, 491, 10, 2000.00, 20000.00),
(170, 127, 492, 7, 3000.00, 21000.00),
(171, 127, 493, 3, 3000.00, 9000.00),
(172, 127, 497, 3, 3500.00, 10500.00),
(173, 127, 499, 2, 3500.00, 7000.00),
(174, 127, 503, 1, 8000.00, 8000.00),
(175, 127, 505, 3, 7000.00, 21000.00),
(176, 127, 506, 5, 11000.00, 55000.00),
(177, 127, 508, 3, 6000.00, 18000.00),
(178, 127, 511, 1, 2500.00, 2500.00),
(179, 127, 515, 4, 3500.00, 14000.00),
(180, 127, 516, 15, 500.00, 7500.00),
(181, 127, 525, 2, 2000.00, 4000.00),
(182, 127, 526, 14, 5000.00, 70000.00),
(183, 127, 536, 3, 2500.00, 7500.00),
(184, 127, 546, 11, 3000.00, 33000.00),
(185, 127, 549, 2, 4000.00, 8000.00),
(186, 127, 564, 1, 3000.00, 3000.00),
(187, 127, 565, 1, 1000.00, 1000.00),
(188, 127, 566, 3, 8000.00, 24000.00),
(189, 127, 567, 2, 2000.00, 4000.00),
(190, 127, 568, 11, 500.00, 5500.00),
(191, 128, 490, 38, 1500.00, 57000.00),
(192, 128, 492, 3, 3000.00, 9000.00),
(193, 128, 495, 5, 7000.00, 35000.00),
(194, 128, 497, 1, 3500.00, 3500.00),
(195, 128, 498, 1, 3000.00, 3000.00),
(196, 128, 499, 1, 3500.00, 3500.00),
(197, 128, 505, 5, 7000.00, 35000.00),
(198, 128, 508, 3, 6000.00, 18000.00),
(199, 128, 511, 2, 2500.00, 5000.00),
(200, 128, 515, 2, 3500.00, 7000.00),
(201, 128, 519, 1, 3000.00, 3000.00),
(202, 128, 525, 1, 2000.00, 2000.00),
(203, 128, 532, 1, 2500.00, 2500.00),
(204, 128, 540, 3, 3000.00, 9000.00),
(205, 128, 550, 1, 4000.00, 4000.00),
(206, 128, 552, 7, 5000.00, 35000.00),
(207, 128, 564, 1, 3000.00, 3000.00),
(208, 128, 565, 5, 1000.00, 5000.00),
(209, 128, 566, 2, 8000.00, 16000.00),
(210, 128, 567, 2, 2000.00, 4000.00),
(211, 128, 568, 4, 500.00, 2000.00),
(212, 129, 491, 18, 2000.00, 36000.00),
(213, 129, 506, 9, 11000.00, 99000.00),
(214, 130, 491, 5, 2000.00, 10000.00),
(215, 131, 491, 5, 2000.00, 10000.00),
(216, 132, 491, 5, 2000.00, 10000.00),
(217, 133, 491, 5, 2000.00, 10000.00),
(218, 134, 491, 11, 2000.00, 22000.00),
(219, 135, 507, 1, 11000.00, 11000.00),
(220, 135, 567, 2, 2000.00, 4000.00),
(221, 136, 490, 6, 1500.00, 9000.00),
(222, 137, 495, 2, 7000.00, 14000.00),
(223, 138, 491, 1, 2000.00, 2000.00),
(225, 140, 491, 1, 2000.00, 2000.00),
(229, 143, 490, 1, 1500.00, 1500.00),
(230, 144, 491, 31, 2000.00, 62000.00),
(231, 145, 490, 7, 1500.00, 10500.00),
(232, 146, 495, 4, 7000.00, 28000.00),
(233, 147, 570, 1, 3000.00, 3000.00),
(234, 148, 565, 7, 1000.00, 7000.00),
(235, 149, 568, 1, 500.00, 500.00),
(236, 150, 507, 4, 11000.00, 44000.00),
(237, 151, 544, 2, 3000.00, 6000.00),
(238, 152, 499, 1, 3500.00, 3500.00),
(239, 153, 509, 1, 4000.00, 4000.00),
(240, 154, 508, 1, 6000.00, 6000.00),
(241, 155, 500, 1, 3500.00, 3500.00),
(242, 156, 540, 1, 3000.00, 3000.00),
(243, 156, 549, 1, 4000.00, 4000.00),
(244, 157, 571, 1, 5000.00, 5000.00),
(245, 158, 493, 1, 3000.00, 3000.00),
(246, 159, 491, 4, 2000.00, 8000.00),
(247, 160, 508, 2, 6000.00, 12000.00),
(248, 161, 490, 1, 1500.00, 1500.00),
(249, 162, 507, 1, 11000.00, 11000.00),
(250, 163, 499, 1, 3500.00, 3500.00),
(251, 164, 570, 1, 3000.00, 3000.00),
(252, 165, 516, 1, 500.00, 500.00),
(253, 166, 517, 2, 4500.00, 9000.00),
(254, 167, 514, 1, 3000.00, 3000.00),
(255, 168, 491, 1, 2000.00, 2000.00),
(256, 169, 491, 1, 2000.00, 2000.00),
(257, 170, 518, 1, 3000.00, 3000.00),
(258, 171, 491, 1, 2000.00, 2000.00),
(259, 172, 507, 1, 11000.00, 11000.00),
(260, 173, 507, 1, 11000.00, 11000.00),
(261, 174, 495, 1, 7000.00, 7000.00),
(262, 175, 490, 2, 1500.00, 3000.00),
(263, 176, 491, 1, 2000.00, 2000.00),
(264, 177, 491, 1, 2000.00, 2000.00),
(265, 178, 491, 1, 2000.00, 2000.00),
(266, 179, 490, 1, 1500.00, 1500.00),
(267, 180, 491, 1, 2000.00, 2000.00),
(268, 180, 547, 1, 3000.00, 3000.00),
(269, 181, 517, 1, 4500.00, 4500.00),
(270, 182, 548, 1, 5000.00, 5000.00),
(271, 183, 490, 2, 1500.00, 3000.00),
(272, 184, 490, 2, 1500.00, 3000.00),
(273, 185, 491, 1, 2000.00, 2000.00),
(274, 186, 495, 1, 7000.00, 7000.00),
(275, 187, 554, 1, 5000.00, 5000.00),
(276, 188, 491, 2, 2000.00, 4000.00),
(277, 189, 491, 1, 2000.00, 2000.00),
(278, 190, 490, 1, 1500.00, 1500.00),
(279, 191, 491, 1, 2000.00, 2000.00),
(280, 192, 490, 1, 1500.00, 1500.00),
(281, 193, 490, 1, 1500.00, 1500.00),
(282, 194, 495, 1, 7000.00, 7000.00),
(283, 194, 507, 1, 11000.00, 11000.00),
(284, 195, 507, 1, 11000.00, 11000.00),
(285, 196, 490, 1, 1500.00, 1500.00),
(286, 197, 499, 2, 3500.00, 7000.00),
(287, 198, 547, 1, 3000.00, 3000.00),
(288, 199, 554, 1, 5000.00, 5000.00),
(289, 200, 507, 1, 11000.00, 11000.00),
(290, 201, 526, 2, 5000.00, 10000.00),
(291, 202, 552, 1, 5000.00, 5000.00),
(292, 203, 490, 1, 1500.00, 1500.00),
(293, 204, 526, 1, 5000.00, 5000.00),
(294, 205, 526, 1, 5000.00, 5000.00),
(295, 206, 491, 1, 2000.00, 2000.00),
(296, 206, 555, 1, 5000.00, 5000.00),
(297, 207, 548, 1, 5000.00, 5000.00),
(298, 208, 526, 1, 5000.00, 5000.00),
(299, 209, 491, 1, 2000.00, 2000.00),
(300, 210, 490, 1, 1500.00, 1500.00),
(301, 210, 568, 1, 500.00, 500.00),
(302, 210, 570, 1, 3000.00, 3000.00),
(303, 211, 517, 1, 4500.00, 4500.00),
(304, 212, 570, 1, 3000.00, 3000.00),
(305, 213, 490, 1, 1500.00, 1500.00),
(306, 214, 568, 4, 500.00, 2000.00),
(307, 215, 508, 2, 6000.00, 12000.00),
(308, 216, 491, 1, 2000.00, 2000.00),
(309, 217, 507, 1, 11000.00, 11000.00),
(310, 218, 490, 1, 1500.00, 1500.00),
(311, 218, 568, 3, 500.00, 1500.00),
(312, 219, 568, 2, 500.00, 1000.00),
(313, 219, 572, 1, 2000.00, 2000.00),
(314, 220, 547, 1, 3000.00, 3000.00),
(315, 221, 547, 1, 3000.00, 3000.00),
(316, 222, 517, 1, 4500.00, 4500.00),
(317, 222, 568, 1, 500.00, 500.00),
(318, 223, 547, 1, 3000.00, 3000.00),
(319, 224, 507, 1, 11000.00, 11000.00),
(320, 225, 548, 1, 5000.00, 5000.00),
(321, 225, 570, 1, 3000.00, 3000.00),
(322, 226, 571, 2, 5000.00, 10000.00),
(323, 227, 491, 1, 2000.00, 2000.00),
(324, 228, 508, 1, 6000.00, 6000.00),
(325, 229, 507, 1, 11000.00, 11000.00),
(326, 230, 491, 1, 2000.00, 2000.00),
(327, 231, 491, 1, 2000.00, 2000.00),
(328, 232, 490, 1, 1500.00, 1500.00),
(329, 233, 491, 1, 2000.00, 2000.00),
(330, 234, 547, 3, 3000.00, 9000.00),
(331, 234, 565, 1, 1000.00, 1000.00),
(332, 235, 499, 1, 3500.00, 3500.00),
(333, 235, 509, 1, 4000.00, 4000.00),
(334, 236, 554, 1, 5000.00, 5000.00),
(335, 237, 491, 1, 2000.00, 2000.00),
(336, 238, 490, 1, 1500.00, 1500.00),
(337, 239, 491, 1, 2000.00, 2000.00),
(338, 239, 503, 1, 8000.00, 8000.00),
(339, 240, 491, 1, 2000.00, 2000.00),
(340, 241, 491, 1, 2000.00, 2000.00),
(341, 242, 491, 1, 2000.00, 2000.00),
(342, 243, 571, 1, 5000.00, 5000.00),
(343, 244, 490, 1, 1500.00, 1500.00),
(344, 244, 497, 1, 3500.00, 3500.00),
(345, 244, 500, 5, 3500.00, 17500.00),
(346, 244, 507, 3, 11000.00, 33000.00),
(347, 244, 508, 2, 6000.00, 12000.00),
(348, 245, 540, 1, 3000.00, 3000.00),
(349, 246, 491, 1, 2000.00, 2000.00),
(350, 246, 540, 1, 3000.00, 3000.00),
(351, 247, 490, 1, 1500.00, 1500.00),
(352, 248, 490, 1, 1500.00, 1500.00),
(353, 249, 490, 2, 1500.00, 3000.00),
(354, 249, 568, 2, 500.00, 1000.00),
(355, 250, 490, 1, 1500.00, 1500.00),
(356, 251, 491, 1, 2000.00, 2000.00),
(357, 252, 490, 1, 1500.00, 1500.00),
(358, 253, 491, 1, 2000.00, 2000.00),
(359, 254, 549, 1, 4000.00, 4000.00),
(360, 255, 541, 1, 2500.00, 2500.00),
(361, 256, 491, 1, 2000.00, 2000.00),
(362, 257, 491, 1, 2000.00, 2000.00),
(363, 258, 491, 1, 2000.00, 2000.00),
(364, 259, 547, 1, 3000.00, 3000.00),
(365, 260, 555, 1, 5000.00, 5000.00),
(366, 261, 495, 1, 7000.00, 7000.00),
(367, 262, 490, 1, 1500.00, 1500.00),
(368, 262, 568, 3, 500.00, 1500.00),
(369, 263, 499, 1, 3500.00, 3500.00),
(370, 264, 490, 1, 1500.00, 1500.00),
(371, 265, 571, 1, 5000.00, 5000.00),
(372, 266, 511, 1, 2500.00, 2500.00),
(373, 266, 568, 1, 500.00, 500.00),
(374, 267, 573, 1, 5000.00, 5000.00),
(375, 268, 556, 1, 3000.00, 3000.00),
(376, 269, 540, 1, 3000.00, 3000.00),
(377, 270, 556, 1, 3000.00, 3000.00),
(378, 271, 491, 3, 2000.00, 6000.00),
(379, 272, 490, 5, 1500.00, 7500.00),
(380, 273, 568, 1, 500.00, 500.00),
(381, 274, 491, 1, 2000.00, 2000.00),
(382, 275, 514, 2, 1000.00, 2000.00),
(383, 276, 490, 1, 1500.00, 1500.00),
(384, 277, 570, 1, 3000.00, 3000.00),
(385, 278, 491, 1, 2000.00, 2000.00),
(386, 278, 517, 1, 4500.00, 4500.00),
(387, 279, 491, 1, 2000.00, 2000.00),
(388, 280, 490, 2, 1500.00, 3000.00),
(389, 281, 490, 1, 1500.00, 1500.00),
(390, 281, 568, 1, 500.00, 500.00),
(391, 282, 511, 2, 2500.00, 5000.00),
(392, 283, 491, 1, 2000.00, 2000.00),
(393, 284, 516, 4, 500.00, 2000.00),
(394, 285, 517, 1, 4500.00, 4500.00),
(395, 286, 491, 2, 2000.00, 4000.00),
(396, 287, 491, 5, 2000.00, 10000.00),
(397, 288, 490, 6, 1500.00, 9000.00),
(398, 289, 495, 1, 7000.00, 7000.00),
(399, 290, 490, 1, 1500.00, 1500.00),
(400, 291, 568, 1, 500.00, 500.00),
(401, 292, 491, 1, 2000.00, 2000.00),
(402, 293, 491, 1, 2000.00, 2000.00),
(403, 294, 490, 2, 1500.00, 3000.00),
(404, 295, 507, 1, 11000.00, 11000.00),
(405, 296, 491, 1, 2000.00, 2000.00),
(406, 297, 491, 1, 2000.00, 2000.00),
(407, 298, 491, 1, 2000.00, 2000.00),
(408, 299, 495, 1, 7000.00, 7000.00),
(409, 300, 540, 2, 3000.00, 6000.00),
(410, 301, 491, 1, 2000.00, 2000.00),
(411, 302, 490, 1, 1500.00, 1500.00),
(412, 302, 568, 1, 500.00, 500.00),
(413, 303, 491, 1, 2000.00, 2000.00),
(414, 304, 490, 2, 1500.00, 3000.00),
(415, 304, 568, 2, 500.00, 1000.00),
(416, 305, 495, 1, 7000.00, 7000.00),
(417, 306, 507, 1, 11000.00, 11000.00),
(418, 306, 576, 1, 5000.00, 5000.00),
(419, 307, 576, 1, 5000.00, 5000.00),
(420, 308, 491, 1, 2000.00, 2000.00),
(421, 309, 576, 1, 5000.00, 5000.00),
(422, 310, 576, 1, 5000.00, 5000.00),
(423, 311, 491, 1, 2000.00, 2000.00),
(424, 312, 491, 1, 2000.00, 2000.00),
(425, 313, 491, 1, 2000.00, 2000.00),
(426, 314, 499, 1, 3500.00, 3500.00),
(427, 315, 490, 1, 1500.00, 1500.00),
(428, 316, 511, 2, 2500.00, 5000.00),
(429, 317, 491, 1, 2000.00, 2000.00),
(430, 318, 491, 1, 2000.00, 2000.00),
(431, 319, 490, 1, 1500.00, 1500.00),
(432, 320, 514, 2, 1000.00, 2000.00),
(433, 320, 516, 4, 500.00, 2000.00),
(434, 321, 490, 1, 1500.00, 1500.00),
(435, 321, 507, 1, 11000.00, 11000.00),
(436, 321, 568, 1, 500.00, 500.00),
(437, 322, 490, 2, 1500.00, 3000.00),
(438, 323, 491, 1, 2000.00, 2000.00),
(439, 324, 565, 1, 1000.00, 1000.00),
(440, 325, 549, 1, 4000.00, 4000.00),
(441, 326, 490, 1, 1500.00, 1500.00),
(442, 327, 490, 1, 1500.00, 1500.00),
(443, 327, 568, 1, 500.00, 500.00),
(444, 327, 570, 1, 3000.00, 3000.00),
(445, 328, 491, 1, 2000.00, 2000.00),
(446, 329, 491, 1, 2000.00, 2000.00),
(447, 330, 507, 2, 11000.00, 22000.00),
(448, 331, 490, 1, 1500.00, 1500.00),
(449, 331, 568, 1, 500.00, 500.00),
(450, 332, 551, 1, 5000.00, 5000.00),
(451, 333, 491, 1, 2000.00, 2000.00),
(452, 334, 547, 2, 3000.00, 6000.00),
(453, 335, 514, 2, 1000.00, 2000.00),
(454, 336, 491, 2, 2000.00, 4000.00),
(455, 337, 499, 1, 3500.00, 3500.00),
(456, 337, 517, 1, 4500.00, 4500.00),
(457, 338, 544, 1, 3000.00, 3000.00),
(458, 339, 507, 1, 11000.00, 11000.00),
(459, 340, 490, 1, 1500.00, 1500.00),
(460, 340, 568, 1, 500.00, 500.00),
(461, 341, 540, 1, 3000.00, 3000.00),
(462, 342, 490, 1, 1500.00, 1500.00),
(463, 343, 555, 1, 5000.00, 5000.00),
(464, 344, 499, 1, 3500.00, 3500.00),
(465, 344, 507, 1, 11000.00, 11000.00),
(466, 345, 551, 1, 5000.00, 5000.00),
(467, 346, 491, 1, 2000.00, 2000.00),
(468, 346, 568, 1, 500.00, 500.00),
(469, 347, 492, 1, 3000.00, 3000.00),
(470, 347, 556, 1, 3000.00, 3000.00),
(471, 347, 564, 1, 3000.00, 3000.00),
(472, 348, 490, 1, 1500.00, 1500.00),
(473, 348, 499, 1, 3500.00, 3500.00),
(474, 349, 518, 1, 3000.00, 3000.00),
(475, 350, 490, 1, 1500.00, 1500.00),
(476, 350, 568, 1, 500.00, 500.00),
(477, 351, 490, 2, 1500.00, 3000.00),
(478, 351, 499, 1, 3500.00, 3500.00),
(479, 351, 518, 1, 3000.00, 3000.00),
(480, 351, 547, 1, 3000.00, 3000.00),
(481, 351, 568, 2, 500.00, 1000.00),
(482, 352, 490, 1, 1500.00, 1500.00),
(483, 352, 570, 1, 3000.00, 3000.00),
(484, 353, 497, 1, 3500.00, 3500.00),
(485, 353, 568, 1, 500.00, 500.00),
(486, 354, 490, 1, 1500.00, 1500.00),
(487, 354, 565, 1, 1000.00, 1000.00),
(488, 354, 568, 1, 500.00, 500.00),
(489, 355, 572, 1, 2000.00, 2000.00),
(490, 356, 564, 1, 3000.00, 3000.00),
(491, 357, 490, 1, 1500.00, 1500.00),
(492, 357, 506, 1, 11000.00, 11000.00),
(493, 358, 490, 1, 1500.00, 1500.00),
(494, 358, 508, 1, 6000.00, 6000.00),
(495, 359, 490, 2, 1500.00, 3000.00),
(496, 359, 506, 1, 11000.00, 11000.00),
(497, 359, 565, 2, 1000.00, 2000.00),
(498, 360, 516, 2, 500.00, 1000.00),
(499, 361, 516, 1, 500.00, 500.00),
(500, 362, 516, 6, 500.00, 3000.00),
(501, 363, 516, 4, 500.00, 2000.00),
(502, 364, 516, 6, 500.00, 3000.00),
(503, 365, 516, 2, 500.00, 1000.00),
(504, 366, 495, 1, 7000.00, 7000.00),
(505, 367, 491, 1, 2000.00, 2000.00),
(506, 367, 568, 1, 500.00, 500.00),
(507, 368, 516, 2, 500.00, 1000.00),
(508, 369, 491, 12, 2000.00, 24000.00),
(509, 370, 499, 2, 3500.00, 7000.00),
(510, 371, 490, 13, 1500.00, 19500.00),
(511, 372, 565, 2, 1000.00, 2000.00),
(512, 373, 490, 1, 1500.00, 1500.00),
(513, 374, 577, 1, 8000.00, 8000.00),
(514, 375, 490, 2, 1500.00, 3000.00),
(515, 376, 568, 9, 500.00, 4500.00),
(516, 377, 576, 3, 5000.00, 15000.00),
(517, 378, 567, 2, 2000.00, 4000.00),
(518, 379, 492, 1, 3000.00, 3000.00),
(523, 381, 514, 4, 1000.00, 4000.00),
(524, 381, 517, 1, 4500.00, 4500.00),
(525, 382, 566, 1, 8000.00, 8000.00),
(526, 383, 490, 2, 1500.00, 3000.00),
(527, 383, 491, 2, 2000.00, 4000.00),
(528, 383, 524, 1, 2000.00, 2000.00),
(529, 383, 540, 1, 3000.00, 3000.00),
(530, 384, 490, 3, 1500.00, 4500.00),
(531, 384, 491, 4, 2000.00, 8000.00),
(532, 384, 517, 1, 4500.00, 4500.00),
(533, 384, 564, 1, 3000.00, 3000.00),
(534, 384, 578, 1, 5000.00, 5000.00),
(535, 385, 517, 1, 4500.00, 4500.00),
(536, 385, 568, 1, 500.00, 500.00),
(537, 386, 506, 1, 11000.00, 11000.00),
(538, 387, 514, 2, 1000.00, 2000.00),
(539, 388, 499, 1, 3500.00, 3500.00),
(540, 389, 517, 1, 4500.00, 4500.00),
(541, 389, 568, 1, 500.00, 500.00),
(542, 390, 565, 1, 1000.00, 1000.00),
(543, 390, 567, 4, 2000.00, 8000.00),
(544, 390, 575, 1, 5000.00, 5000.00),
(545, 391, 491, 1, 2000.00, 2000.00),
(546, 392, 491, 1, 2000.00, 2000.00),
(547, 392, 556, 1, 3000.00, 3000.00),
(548, 393, 491, 1, 2000.00, 2000.00),
(549, 394, 565, 1, 1000.00, 1000.00),
(550, 395, 491, 5, 2000.00, 10000.00),
(551, 395, 506, 1, 11000.00, 11000.00),
(552, 395, 565, 1, 1000.00, 1000.00),
(553, 395, 575, 1, 5000.00, 5000.00),
(554, 395, 576, 2, 5000.00, 10000.00),
(555, 396, 491, 1, 2000.00, 2000.00),
(556, 397, 491, 18, 2000.00, 36000.00),
(557, 397, 495, 1, 7000.00, 7000.00),
(558, 397, 514, 4, 1000.00, 4000.00),
(559, 397, 537, 2, 2500.00, 5000.00),
(560, 397, 547, 1, 3000.00, 3000.00),
(561, 397, 550, 1, 4000.00, 4000.00),
(562, 397, 551, 2, 5000.00, 10000.00),
(563, 397, 565, 2, 1000.00, 2000.00),
(564, 397, 570, 1, 3000.00, 3000.00),
(565, 397, 576, 1, 5000.00, 5000.00),
(566, 398, 495, 1, 7000.00, 7000.00),
(567, 398, 515, 1, 3500.00, 3500.00),
(568, 399, 490, 2, 1500.00, 3000.00),
(569, 399, 568, 1, 500.00, 500.00),
(570, 400, 526, 1, 5000.00, 5000.00),
(571, 401, 550, 1, 4000.00, 4000.00),
(572, 401, 551, 1, 5000.00, 5000.00),
(573, 401, 552, 1, 5000.00, 5000.00),
(574, 401, 554, 2, 5000.00, 10000.00),
(575, 402, 490, 7, 1500.00, 10500.00),
(576, 402, 491, 3, 2000.00, 6000.00),
(577, 402, 495, 1, 7000.00, 7000.00),
(578, 402, 498, 1, 3000.00, 3000.00),
(579, 402, 506, 1, 11000.00, 11000.00),
(580, 402, 511, 1, 2500.00, 2500.00),
(581, 402, 547, 1, 3000.00, 3000.00),
(582, 402, 549, 1, 4000.00, 4000.00),
(583, 402, 551, 4, 5000.00, 20000.00),
(584, 402, 565, 5, 1000.00, 5000.00),
(585, 402, 568, 3, 500.00, 1500.00),
(589, 404, 514, 1, 1000.00, 1000.00),
(590, 404, 519, 2, 3000.00, 6000.00),
(591, 404, 579, 4, 2500.00, 10000.00),
(592, 405, 490, 2, 1500.00, 3000.00),
(593, 405, 507, 2, 11000.00, 22000.00),
(594, 405, 565, 1, 1000.00, 1000.00),
(595, 406, 552, 3, 5000.00, 15000.00),
(596, 407, 526, 1, 5000.00, 5000.00),
(597, 407, 548, 1, 5000.00, 5000.00),
(598, 408, 490, 1, 1500.00, 1500.00),
(599, 409, 514, 3, 1000.00, 3000.00),
(600, 410, 491, 3, 2000.00, 6000.00),
(601, 411, 490, 11, 1500.00, 16500.00),
(602, 412, 548, 7, 5000.00, 35000.00),
(603, 413, 540, 1, 3000.00, 3000.00),
(604, 413, 541, 2, 2500.00, 5000.00),
(605, 413, 549, 3, 4000.00, 12000.00),
(606, 414, 495, 2, 7000.00, 14000.00),
(607, 415, 491, 1, 2000.00, 2000.00),
(608, 416, 565, 2, 1000.00, 2000.00),
(609, 417, 568, 12, 500.00, 6000.00),
(610, 418, 507, 2, 11000.00, 22000.00),
(611, 419, 565, 2, 1000.00, 2000.00),
(612, 420, 497, 1, 3500.00, 3500.00),
(613, 420, 500, 1, 3500.00, 3500.00),
(614, 421, 508, 1, 6000.00, 6000.00),
(615, 421, 511, 1, 2500.00, 2500.00),
(616, 421, 518, 1, 3000.00, 3000.00),
(617, 422, 495, 1, 7000.00, 7000.00),
(618, 422, 566, 1, 8000.00, 8000.00),
(619, 422, 577, 1, 8000.00, 8000.00),
(620, 423, 490, 1, 1500.00, 1500.00),
(621, 423, 568, 1, 500.00, 500.00),
(622, 424, 490, 1, 1500.00, 1500.00),
(623, 424, 565, 1, 1000.00, 1000.00),
(624, 424, 568, 1, 500.00, 500.00),
(625, 425, 490, 3, 1500.00, 4500.00),
(626, 425, 491, 1, 2000.00, 2000.00),
(627, 425, 495, 2, 7000.00, 14000.00),
(628, 425, 498, 4, 3000.00, 12000.00),
(629, 425, 506, 8, 11000.00, 88000.00),
(630, 425, 508, 1, 6000.00, 6000.00),
(631, 425, 540, 1, 3000.00, 3000.00),
(632, 426, 491, 14, 2000.00, 28000.00),
(633, 427, 490, 4, 1500.00, 6000.00),
(634, 428, 565, 2, 1000.00, 2000.00),
(635, 428, 568, 1, 500.00, 500.00),
(636, 428, 570, 1, 3000.00, 3000.00),
(637, 429, 500, 1, 3500.00, 3500.00),
(638, 429, 506, 1, 11000.00, 11000.00),
(639, 430, 506, 1, 11000.00, 11000.00),
(640, 431, 509, 1, 4000.00, 4000.00),
(641, 432, 491, 1, 2000.00, 2000.00),
(642, 433, 491, 3, 2000.00, 6000.00),
(644, 435, 514, 14, 1000.00, 14000.00),
(645, 436, 491, 1, 2000.00, 2000.00),
(646, 436, 565, 1, 1000.00, 1000.00),
(647, 437, 491, 3, 2000.00, 6000.00),
(648, 438, 494, 1, 5500.00, 5500.00),
(649, 439, 490, 6, 1500.00, 9000.00),
(650, 440, 516, 3, 500.00, 1500.00),
(651, 440, 518, 2, 3000.00, 6000.00),
(652, 441, 517, 3, 4500.00, 13500.00),
(653, 442, 490, 1, 1500.00, 1500.00),
(654, 442, 491, 3, 2000.00, 6000.00),
(655, 442, 508, 1, 6000.00, 6000.00),
(656, 442, 517, 1, 4500.00, 4500.00),
(657, 442, 544, 3, 3000.00, 9000.00),
(658, 443, 490, 2, 1500.00, 3000.00);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `nama` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','kasir') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'kasir',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama`, `username`, `password`, `role`, `created_at`) VALUES
(10, 'Administrator', 'admin', 'admin123', 'admin', '2026-11-23 01:55:56'),
(11, 'Kasir', 'kasir', 'kasir123', 'kasir', '2026-11-23 01:55:56');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hutang`
--
ALTER TABLE `hutang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `produk_id` (`produk_id`),
  ADD KEY `fk_hutang_transaksi` (`transaksi_id`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode` (`kode`);

--
-- Indexes for table `simpanan`
--
ALTER TABLE `simpanan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_penabung_jenis` (`nama_penabung`,`jenis`);

--
-- Indexes for table `simpanan_transaksi`
--
ALTER TABLE `simpanan_transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `simpanan_id` (`simpanan_id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kode` (`kode`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_id` (`transaksi_id`),
  ADD KEY `produk_id` (`produk_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hutang`
--
ALTER TABLE `hutang`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=580;

--
-- AUTO_INCREMENT for table `simpanan`
--
ALTER TABLE `simpanan`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `simpanan_transaksi`
--
ALTER TABLE `simpanan_transaksi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=445;

--
-- AUTO_INCREMENT for table `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=661;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `hutang`
--
ALTER TABLE `hutang`
  ADD CONSTRAINT `fk_hutang_transaksi` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `hutang_ibfk_1` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `simpanan_transaksi`
--
ALTER TABLE `simpanan_transaksi`
  ADD CONSTRAINT `simpanan_transaksi_ibfk_1` FOREIGN KEY (`simpanan_id`) REFERENCES `simpanan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
