CREATE TABLE `barang` (
  `idbarang` int(11) NOT NULL,
  `kode` varchar(50) NOT NULL,
  `namabarang` varchar(50) NOT NULL,
  `jenisbarang` varchar(25) NOT NULL,
  `stock` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `name` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `barang` (`idbarang`, `kode`, `namabarang`, `jenisbarang`, `stock`, `owner_id`, `name`) VALUES
(46, 'bdg', 'iPhone 20 Pro Max', 'Handphone', 40, 4, 'fikri017'),
(49, 'bdg', 'iPhone 15 Pro Max', 'Handphone', 67, 2, 'deopm'),
(50, 'xyz', 'Ember', 'Furniture', 77, 3, 'sucre_ding'),
(51, 'xyz', 'Piring', 'Peralatan Makan', 90, 5, 'yoru');

ALTER TABLE `barang`
  ADD PRIMARY KEY (`idbarang`);

ALTER TABLE `barang`
  MODIFY `idbarang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
