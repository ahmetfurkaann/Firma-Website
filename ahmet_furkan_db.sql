-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 03 Oca 2022, 21:18:14
-- Sunucu sürümü: 10.4.20-MariaDB
-- PHP Sürümü: 8.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `ahmet_furkan_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `asilar`
--

CREATE TABLE `asilar` (
  `asi_id` int(11) NOT NULL,
  `asi_turu` varchar(30) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci COMMENT='Aşı türleri burada tutuluyor';

--
-- Tablo döküm verisi `asilar`
--

INSERT INTO `asilar` (`asi_id`, `asi_turu`) VALUES
(0, 'Yok'),
(1, 'Sinovac'),
(2, 'Biontech');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `belirtiler`
--

CREATE TABLE `belirtiler` (
  `id` int(11) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `belirti_ismi` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `belirtiler`
--

INSERT INTO `belirtiler` (`id`, `tc_no`, `belirti_ismi`) VALUES
(2, '24515478895', 'Tat ve Koku Kaybı'),
(3, '24515478895', 'Öksürük'),
(5, '24515478895', 'Boğaz Şişmesi'),
(6, '47854123654', 'Tat ve Koku Kaybı'),
(7, '47854123654', 'Kemik Ağrısı'),
(8, '47854123654', 'Baş Ağrısı'),
(9, '47854123654', 'Halsizlik'),
(10, '65414253612', 'Yüksek Ateş'),
(11, '65414253612', 'Baş Ağrısı'),
(13, '36512589544', 'Tat ve Koku Kaybı'),
(14, '36512589544', 'Baş Ağrısı'),
(17, '14526587496', 'Tat ve Koku Kaybı'),
(18, '14526587496', 'Baş Ağrısı'),
(19, '14526587496', 'Tat ve Koku Kaybı'),
(23, '65415263548', 'Öksürük'),
(25, '54854152415', 'Boğaz Şişmesi'),
(26, '54854152415', 'Öksürük'),
(27, '54854152415', 'Baş Ağrısı'),
(30, '15426594874', 'Boğaz Şişmesi'),
(31, '15426594874', 'Kemik Ağrısı'),
(32, '42653164696', 'Tat ve Koku Kaybı'),
(33, '42653164696', 'Boğaz Şişmesi'),
(34, '36525152456', 'Boğaz Şişmesi'),
(35, '36525152456', 'Öksürük'),
(36, '35412657845', 'Tat ve Koku Kaybı'),
(37, '35412657845', 'Boğaz Şişmesi'),
(38, '35412657845', 'Baş Ağrısı'),
(39, '35412657845', 'Öksürük'),
(40, '45625361524', 'Boğaz Şişmesi'),
(41, '45625361524', 'Kemik Ağrısı'),
(43, '45625361524', 'Halsizlik'),
(46, '45784598457', 'Halsizlik'),
(47, '14526587496', 'Karın Ağrısı');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `calisma_sureleri`
--

CREATE TABLE `calisma_sureleri` (
  `id` int(11) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `haftaicigiris` time DEFAULT NULL,
  `haftaicicikis` time DEFAULT NULL,
  `cumartesigiris` time DEFAULT NULL,
  `cumartesicikis` time DEFAULT NULL,
  `pazargiris` time DEFAULT NULL,
  `pazarcikis` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `calisma_sureleri`
--

INSERT INTO `calisma_sureleri` (`id`, `tc_no`, `haftaicigiris`, `haftaicicikis`, `cumartesigiris`, `cumartesicikis`, `pazargiris`, `pazarcikis`) VALUES
(16, '24515478895', '09:00:00', '17:00:00', '10:00:00', '15:00:00', '00:00:00', '00:00:00'),
(17, '25436558874', '09:00:00', '17:00:00', '10:00:00', '14:00:00', '00:00:00', '00:00:00'),
(18, '65414253612', '08:00:00', '16:00:00', '10:00:00', '16:00:00', '00:00:00', '00:00:00'),
(19, '47854123654', '10:00:00', '18:00:00', '10:00:00', '14:00:00', '00:00:00', '00:00:00'),
(20, '36525152456', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(21, '36512589544', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(22, '44566521365', '10:00:00', '19:00:00', '10:00:00', '16:00:00', '10:00:00', '14:00:00'),
(23, '42653164696', '09:00:00', '16:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(24, '45784598457', '09:00:00', '16:30:00', '10:00:00', '15:00:00', '00:00:00', '00:00:00'),
(26, '26535145698', '08:00:00', '16:00:00', '09:00:00', '15:00:00', '00:00:00', '00:00:00'),
(27, '35412657845', '09:00:00', '15:00:00', '10:00:00', '15:00:00', '11:00:00', '14:00:00'),
(29, '54854152415', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(30, '15426594874', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(31, '56948251478', '08:00:00', '17:00:00', '10:00:00', '15:00:00', '00:00:00', '00:00:00'),
(33, '65415263548', '10:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(34, '14526587496', '10:00:00', '16:00:00', '10:00:00', '15:00:00', '00:00:00', '00:00:00'),
(35, '36523233659', '12:00:00', '18:00:00', '10:00:00', '15:00:00', '12:00:00', '15:00:00'),
(36, '45654454125', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(37, '47658325647', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(38, '46532659745', '09:00:00', '16:00:00', '09:00:00', '15:00:00', '00:00:00', '00:00:00'),
(39, '14525221515', '12:00:00', '16:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00'),
(40, '47854552212', '10:00:00', '18:00:00', '10:00:00', '15:00:00', '00:00:00', '00:00:00'),
(41, '36522365215', '09:00:00', '15:00:00', '10:00:00', '14:00:00', '11:00:00', '14:00:00'),
(42, '45625361524', '09:00:00', '17:00:00', '10:00:00', '15:00:00', '10:00:00', '15:00:00'),
(44, '41511254965', '08:00:00', '15:00:00', '10:00:00', '15:00:00', '12:00:00', '15:00:00'),
(45, '56245285474', '08:00:00', '17:00:00', '08:00:00', '14:00:00', '00:00:00', '00:00:00'),
(46, '54784598452', '08:00:00', '17:00:00', '00:00:00', '00:00:00', '10:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `covid`
--

CREATE TABLE `covid` (
  `id` int(5) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `yakalandigi_tarih` date DEFAULT NULL,
  `negatif_tarihi` date DEFAULT NULL,
  `asi_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `covid`
--

INSERT INTO `covid` (`id`, `tc_no`, `yakalandigi_tarih`, `negatif_tarihi`, `asi_id`) VALUES
(1, '24515478895', '2021-11-17', '2021-12-04', 1),
(5, '47854123654', '2021-11-15', '2021-12-01', 2),
(7, '65414253612', '2021-09-07', '2021-09-23', 1),
(8, '36512589544', '2021-06-15', '2021-07-01', 2),
(10, '42653164696', '2021-11-24', '2021-12-08', 2),
(11, '14526587496', '2021-04-05', '2021-04-22', 0),
(15, '65415263548', '2021-12-14', '2021-12-26', 2),
(16, '54854152415', '2021-10-05', '2021-10-23', 0),
(18, '15426594874', '2021-06-01', '2021-06-14', 1),
(19, '36525152456', '2021-12-15', '2022-01-03', 0),
(20, '35412657845', '2021-12-22', '2022-01-05', 0),
(21, '45625361524', '2021-12-18', '2022-01-01', 2),
(23, '45784598457', '2021-07-25', '2021-08-08', 2),
(24, '14525221515', '2021-11-16', '2021-12-02', 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `eleman`
--

CREATE TABLE `eleman` (
  `eleman_id` int(11) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `isim` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `soyisim` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `kan_grubu` varchar(20) COLLATE utf8_turkish_ci DEFAULT NULL,
  `dogum_yeri` varchar(50) COLLATE utf8_turkish_ci DEFAULT NULL,
  `pozisyon` varchar(200) COLLATE utf8_turkish_ci DEFAULT NULL,
  `maas` int(6) DEFAULT NULL,
  `lisans` int(11) DEFAULT NULL,
  `yuksek_lisans` int(11) DEFAULT NULL,
  `doktora` int(11) DEFAULT NULL,
  `asi_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `eleman`
--

INSERT INTO `eleman` (`eleman_id`, `tc_no`, `isim`, `soyisim`, `kan_grubu`, `dogum_yeri`, `pozisyon`, `maas`, `lisans`, `yuksek_lisans`, `doktora`, `asi_id`) VALUES
(41, '14525221515', 'Eda', 'Gül', 'B+', 'İstanbul', 'İnsan Kaynakları', 11500, 85, 85, 85, 1),
(36, '14526587496', 'Mehmet Ali', 'Ardıç', '0+', 'Manisa', 'Java Developer', 5500, 21, 106, 100, 0),
(32, '15426594874', 'Elif Dilay', 'Altınkaya', 'B-', 'Trabzon', 'Pazarlamacı', 5600, 74, 0, 0, 1),
(16, '24515478895', 'Ahmet Furkan', 'Bayram', 'A+', 'İstanbul', 'Java Developer', 5800, 120, 0, 0, 1),
(48, '25415471587', 'Ahmet Bayram', 'Furkan', 'A+', 'İstanbul', 'Pazarlamacı', 7000, 120, 0, 0, 2),
(18, '25436558874', 'Yunus', 'Arkan', 'A+', 'Adana', 'Siber Güvenlik', 5700, 120, 0, 0, 1),
(28, '26535145698', 'Servet', 'Akış', 'AB-', 'Konya', 'Sistem Analisti', 6400, 45, 45, 45, 0),
(29, '35412657845', 'İclal', 'Akkoyun', 'AB+', 'Gaziantep', 'Sistem Analisti', 5700, 165, 145, 0, 0),
(22, '36512589544', 'Cemile', 'Doğan', 'B-', 'İstanbul', 'Veritabanı Yönetimi', 5900, 46, 60, 0, 2),
(43, '36522365215', 'İsmail', 'Çelik', 'AB+', 'Giresun', 'Web Developer', 6200, 2, 32, 0, 2),
(37, '36523233659', 'Sevinç', 'Ak', 'B+', 'Zonguldak', 'Pazarlamacı', 4500, 106, 0, 0, 1),
(21, '36525152456', 'Melike', 'Ay', 'A-', 'İstanbul', 'Bulut Yöneticisi', 5500, 106, 106, 106, 0),
(45, '41511254965', 'Ömer', 'Ataş', 'A+', 'İstanbul', 'Siber Güvenlik', 5700, 66, 36, 0, 1),
(24, '42653164696', 'Murat', 'Alabakan', 'AB-', 'Elazığ', 'Pazarlamacı', 5600, 126, 127, 134, 2),
(23, '44566521365', 'Sude', 'Su', 'AB+', 'Bursa', 'Pazarlamacı', 5400, 89, 0, 0, 0),
(44, '45625361524', 'Senanur', 'Sevgi', 'AB-', 'Giresun', 'Pazarlamacı', 4500, 25, 0, 0, 2),
(38, '45654454125', 'Cihan', 'Akarpınar', 'B+', 'Isparta', 'Siber Güvenlik', 5800, 140, 61, 12, 1),
(26, '45784598457', 'Ceren', 'Ağca', 'A-', 'Bayburt', 'Web Developer', 5600, 86, 85, 0, 2),
(40, '46532659745', 'Senem', 'Aksevim', 'AB+', 'Trabzon', 'Siber Güvenlik', 7000, 120, 120, 120, 2),
(39, '47658325647', 'Ayşe', 'Aksoy', 'B+', 'Sivas', 'Java Developer', 5800, 15, 165, 42, 1),
(20, '47854123654', 'Hüseyin', 'Türkmen', 'A+', 'Giresun', 'Java Developer', 5850, 120, 120, 0, 2),
(42, '47854552212', 'Efecan', 'Hoşgör', 'A-', 'İstanbul', 'Sistem Analisti', 8500, 75, 45, 0, 0),
(47, '54784598452', 'Furkan', 'Kızılpınar', 'A+', 'Zonguldak', 'Bilgi İşlem', 5800, 106, 85, 106, 2),
(31, '54854152415', 'Elif Tuğçe', 'Altaş', 'B-', 'İstanbul', 'Sistem Analisti', 145, 85, 16, 16, 0),
(46, '56245285474', 'Ahmet', 'Akyol', '0+', 'İzmir', 'Bilgi İşlem', 5900, 165, 25, 25, 2),
(33, '56948251478', 'Rana', 'Altınoklu', '0-', 'Artvin', 'Sistem Operatörü', 5600, 106, 120, 0, 0),
(19, '65414253612', 'Hilal', 'Küçük', '0+', 'Samsun', 'Web Developer', 5700, 120, 22, 0, 1),
(35, '65415263548', 'Halim', 'Aral', '0+', 'Ankara', 'Bilgi İşlem', 5700, 21, 0, 0, 2),
(30, '74654321402', 'Semina', 'Aktuna', 'B+', 'Şanlıurfa', 'Sistem Analisti', 5700, 140, 140, 145, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `eleman_hobileri`
--

CREATE TABLE `eleman_hobileri` (
  `id` int(11) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `hobi_ismi` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `eleman_hobileri`
--

INSERT INTO `eleman_hobileri` (`id`, `tc_no`, `hobi_ismi`) VALUES
(2, '24515478895', 'Yüzmek'),
(3, '24515478895', 'Müzik Dinlemek'),
(4, '25436558874', 'Dans Etmek'),
(5, '25436558874', 'Koşmak'),
(6, '65414253612', 'Dans Etmek'),
(7, '65414253612', 'Yoga'),
(8, '47854123654', 'Yürüyüş Yapmak'),
(9, '47854123654', 'Müzik Dinlemek'),
(10, '36525152456', 'Resim Yapmak'),
(11, '36525152456', 'Televizyon İzlemek'),
(12, '36512589544', 'Yoga'),
(13, '44566521365', 'Fotoğrafçılık'),
(14, '44566521365', 'Şarkı Söylemek'),
(15, '42653164696', 'Yüzmek'),
(16, '45784598457', 'Fotoğrafçılık'),
(17, '45784598457', 'Yoga'),
(18, '45784598457', 'Müzik Dinlemek'),
(20, '26535145698', 'İp Atlama'),
(21, '26535145698', 'Koşmak'),
(22, '35412657845', 'Avcılık'),
(23, '74654321402', 'Fotoğrafçılık'),
(24, '54854152415', 'Müzik Dinlemek'),
(25, '15426594874', 'Televizyon İzlemek'),
(26, '56948251478', 'Dağ Tırmanışı'),
(27, '56948251478', 'Müzik Dinlemek'),
(29, '65415263548', 'Dans Etmek'),
(30, '65415263548', 'Dağ Tırmanışı'),
(31, '14526587496', 'Yüzmek');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `hasta`
--

CREATE TABLE `hasta` (
  `id` int(5) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `hastalik_adi` text COLLATE utf8_turkish_ci DEFAULT NULL,
  `hastalik_tarihi` date DEFAULT NULL,
  `ilac` text COLLATE utf8_turkish_ci DEFAULT NULL,
  `doz` text COLLATE utf8_turkish_ci DEFAULT NULL,
  `semptomlar` text COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `hasta`
--

INSERT INTO `hasta` (`id`, `tc_no`, `hastalik_adi`, `hastalik_tarihi`, `ilac`, `doz`, `semptomlar`) VALUES
(2, '25436558874', 'Astım', '2021-12-16', 'Ventolin Inhaler', '3', 'Nefes Darlığı'),
(3, '24515478895', 'Grip', '2021-11-19', 'Gripin', '3', 'Burun Tıkanıklığı'),
(4, '36512589544', 'Egzama', '2021-10-12', 'Pruzon', '2', 'Egzama'),
(5, '36525152456', 'Grip', '2021-11-20', 'Ibufen', '3', 'Yüksek Ateş'),
(6, '36525152456', 'Grip', '2021-11-20', 'Benical', '2', 'Baş Ağrısı'),
(7, '47854123654', 'Insomnia', '2021-09-16', 'Atarax', '1', 'Uykusuzluk'),
(8, '24515478895', 'Egzama', '2021-09-18', 'Pruzon', '3', 'Egzama'),
(9, '47854123654', 'Egzama', '2021-11-18', 'Nurofen', '2', 'Egzama'),
(10, '24515478895', 'Insomnia', '2021-09-18', 'Atarax', '1', 'Uykusuzluk'),
(11, '36512589544', 'Kızamık', '2021-10-14', 'MMR Vaccine', '2', 'Kızamık'),
(12, '24515478895', 'Kızamık', '2021-10-13', 'MMR Vaccine', '1', 'Kızamık'),
(13, '65414253612', 'Üst Solunum Yolu Hastalığı', '2021-07-14', 'Klorhex', '6', 'Boğaz Şişmesi'),
(14, '54854152415', 'Su Çiçeği', '2021-05-14', 'Kalmosan', '2', 'Su Çiçeği'),
(15, '54854152415', 'Chron', '2020-02-14', 'Stelara', '1', 'Dışkıda kan ve iltihap'),
(18, '26535145698', 'Chron', '2021-12-15', 'Stelara', '2', 'Mide bulantısı ve kusma'),
(19, '54854152415', 'Graves', '2021-07-25', 'GravesDrug', '2', 'Boğaz Şişmesi'),
(20, '54854152415', 'Sinüzit', '2021-10-14', 'Multisinus', '2', 'Burun Akıntısı'),
(21, '56948251478', 'Chron', '2021-11-02', 'Stelara', '2', 'Dışkıda kan ve iltihap'),
(22, '44566521365', 'Üst Solunum Yolu Hastalığı', '2021-12-25', 'Aferin', '3', 'Öksürük'),
(23, '45625361524', 'Hashimato', '2021-10-14', 'Euthyrox', '2', 'Halsizlik'),
(24, '45625361524', 'Myastenia Gravis', '2021-12-21', 'Mestinon', '2', 'Kas Güçsüzlüğü'),
(25, '45654454125', 'Egzama', '2021-08-12', 'Dupixent', '2', 'Egzama'),
(26, '45784598457', 'Grip', '2021-11-20', 'Theraflu', '3', 'Yüksek Ateş'),
(27, '36522365215', 'Grip', '2021-11-03', 'Theraflu', '3', 'Yüksek Ateş');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kronik_hastaliklar`
--

CREATE TABLE `kronik_hastaliklar` (
  `id` int(11) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `kronik_hastaligi` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `kronik_hastaliklar`
--

INSERT INTO `kronik_hastaliklar` (`id`, `tc_no`, `kronik_hastaligi`) VALUES
(2, '24515478895', 'Astım'),
(3, '24515478895', 'Diyabet'),
(4, '24515478895', 'Yüksek Tansiyon'),
(5, '47854123654', 'Yüksek Tansiyon'),
(8, '54854152415', 'Yüksek Tansiyon'),
(9, '54854152415', 'Bronşit'),
(11, '15426594874', 'Yüksek Tansiyon'),
(12, '45625361524', 'Yüksek Tansiyon'),
(13, '45625361524', 'Diyabet'),
(14, '45625361524', 'Astım'),
(15, '45784598457', 'Astım'),
(16, '45784598457', 'Bronşit');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `temasli_calisanlar`
--

CREATE TABLE `temasli_calisanlar` (
  `id` int(11) NOT NULL,
  `tc_no` varchar(12) COLLATE utf8_turkish_ci NOT NULL,
  `temasli_tcno` varchar(12) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `temasli_calisanlar`
--

INSERT INTO `temasli_calisanlar` (`id`, `tc_no`, `temasli_tcno`) VALUES
(1, '36512589544', '42653164696'),
(3, '24515478895', '42653164696'),
(4, '24515478895', '44566521365'),
(5, '36512589544', '65414253612'),
(6, '36512589544', '47854123654'),
(8, '14526587496', '26535145698'),
(9, '14526587496', '15426594874'),
(10, '54854152415', '35412657845'),
(11, '54854152415', '65415263548'),
(13, '15426594874', '47854123654'),
(14, '15426594874', '42653164696'),
(15, '36525152456', '35412657845');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `universite`
--

CREATE TABLE `universite` (
  `id` int(11) NOT NULL,
  `lisans` int(11) DEFAULT NULL,
  `yuksek_lisans` int(11) DEFAULT NULL,
  `doktora` int(11) DEFAULT NULL,
  `universite_ismi` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `universite`
--

INSERT INTO `universite` (`id`, `lisans`, `yuksek_lisans`, `doktora`, `universite_ismi`) VALUES
(1, 1, 1, 1, 'ABANT İZZET BAYSAL ÜNİVERSİTESİ'),
(2, 2, 2, 2, 'ABDULLAH GÜL ÜNİVERSİTESİ'),
(3, 3, 3, 3, 'ACIBADEM MEHMET ALİ AYDINLAR ÜNİVERSİTESİ'),
(4, 4, 4, 4, 'ADANA BİLİM VE TEKNOLOJİ ÜNİVERSİTESİ'),
(5, 5, 5, 5, 'ADIYAMAN ÜNİVERSİTESİ'),
(6, 6, 6, 6, 'ADNAN MENDERES ÜNİVERSİTESİ'),
(7, 7, 7, 7, 'AFYON KOCATEPE ÜNİVERSİTESİ'),
(8, 8, 8, 8, 'AĞRI İBRAHİM ÇEÇEN ÜNİVERSİTESİ'),
(9, 9, 9, 9, 'AHİ EVRAN ÜNİVERSİTESİ'),
(10, 10, 10, 10, 'AKDENİZ KARPAZ ÜNİVERSİTESİ'),
(11, 11, 11, 11, 'AKDENİZ ÜNİVERSİTESİ'),
(12, 12, 12, 12, 'AKSARAY ÜNİVERSİTESİ'),
(13, 13, 13, 13, 'ALANYA ALAADDİN KEYKUBAT ÜNİVERSİTESİ'),
(14, 14, 14, 14, 'ALANYA HAMDULLAH EMİN PAŞA ÜNİVERSİTESİ'),
(15, 15, 15, 15, 'ALTINBAŞ ÜNİVERSİTESİ'),
(16, 16, 16, 16, 'AMASYA ÜNİVERSİTESİ'),
(17, 17, 17, 17, 'ANADOLU ÜNİVERSİTESİ'),
(18, 18, 18, 18, 'ANKARA SOSYAL BİLİMLER ÜNİVERSİTESİ'),
(19, 19, 19, 19, 'ANKARA ÜNİVERSİTESİ'),
(20, 20, 20, 20, 'ANKARA YILDIRIM BEYAZIT ÜNİVERSİTESİ'),
(21, 21, 21, 21, 'ANTALYA AKEV ÜNİVERSİTESİ'),
(22, 22, 22, 22, 'ANTALYA BİLİM ÜNİVERSİTESİ'),
(23, 23, 23, 23, 'ARDAHAN ÜNİVERSİTESİ'),
(24, 24, 24, 24, 'ARTVİN ÇORUH ÜNİVERSİTESİ'),
(25, 25, 25, 25, 'ATAŞEHİR ADIGÜZEL MESLEK YÜKSEKOKULU'),
(26, 26, 26, 26, 'ATATÜRK ÜNİVERSİTESİ'),
(27, 27, 27, 27, 'ATILIM ÜNİVERSİTESİ'),
(28, 28, 28, 28, 'AVRASYA ÜNİVERSİTESİ'),
(29, 29, 29, 29, 'AVRUPA MESLEK YÜKSEKOKULU'),
(30, 30, 30, 30, 'BAHÇEŞEHİR ÜNİVERSİTESİ'),
(31, 31, 31, 31, 'BALIKESİR ÜNİVERSİTESİ'),
(32, 32, 32, 32, 'BANDIRMA ONYEDİ EYLÜL ÜNİVERSİTESİ'),
(33, 33, 33, 33, 'BARTIN ÜNİVERSİTESİ'),
(34, 34, 34, 34, 'BAŞKENT ÜNİVERSİTESİ'),
(35, 35, 35, 35, 'BATMAN ÜNİVERSİTESİ'),
(36, 36, 36, 36, 'BAYBURT ÜNİVERSİTESİ'),
(37, 37, 37, 37, 'BEYKENT ÜNİVERSİTESİ'),
(38, 38, 38, 38, 'BEYKOZ ÜNİVERSİTESİ'),
(39, 39, 39, 39, 'BEZM-İ ÂLEM VAKIF ÜNİVERSİTESİ'),
(40, 40, 40, 40, 'BİLECİK ŞEYH EDEBALİ ÜNİVERSİTESİ'),
(41, 41, 41, 41, 'BİNGÖL ÜNİVERSİTESİ'),
(42, 42, 42, 42, 'BİRUNİ ÜNİVERSİTESİ'),
(43, 43, 43, 43, 'BİTLİS EREN ÜNİVERSİTESİ'),
(44, 44, 44, 44, 'BOĞAZİÇİ ÜNİVERSİTESİ'),
(45, 45, 45, 45, 'BOZOK ÜNİVERSİTESİ'),
(46, 46, 46, 46, 'BURSA TEKNİK ÜNİVERSİTESİ'),
(47, 47, 47, 47, 'BÜLENT ECEVİT ÜNİVERSİTESİ'),
(48, 48, 48, 48, 'CUMHURİYET ÜNİVERSİTESİ'),
(49, 49, 49, 49, 'ÇAĞ ÜNİVERSİTESİ'),
(50, 50, 50, 50, 'ÇANAKKALE ONSEKİZ MART ÜNİVERSİTESİ'),
(51, 51, 51, 51, 'ÇANKAYA ÜNİVERSİTESİ'),
(52, 52, 52, 52, 'ÇANKIRI KARATEKİN ÜNİVERSİTESİ'),
(53, 53, 53, 53, 'ÇUKUROVA ÜNİVERSİTESİ'),
(54, 54, 54, 54, 'DİCLE ÜNİVERSİTESİ'),
(55, 55, 55, 55, 'DOĞU AKDENİZ ÜNİVERSİTESİ'),
(56, 56, 56, 56, 'DOĞUŞ ÜNİVERSİTESİ'),
(57, 57, 57, 57, 'DOKUZ EYLÜL ÜNİVERSİTESİ'),
(58, 58, 58, 58, 'DUMLUPINAR ÜNİVERSİTESİ'),
(59, 59, 59, 59, 'DÜZCE ÜNİVERSİTESİ'),
(60, 60, 60, 60, 'EGE ÜNİVERSİTESİ'),
(61, 61, 61, 61, 'ERCİYES ÜNİVERSİTESİ'),
(62, 62, 62, 62, 'ERZİNCAN ÜNİVERSİTESİ'),
(63, 63, 63, 63, 'ERZURUM TEKNİK ÜNİVERSİTESİ'),
(64, 64, 64, 64, 'ESKİŞEHİR OSMANGAZİ ÜNİVERSİTESİ'),
(65, 65, 65, 65, 'FARUK SARAÇ TASARIM MESLEK YÜKSEKOKULU'),
(66, 66, 66, 66, 'FATİH SULTAN MEHMET VAKIF ÜNİVERSİTESİ'),
(67, 67, 67, 67, 'FIRAT ÜNİVERSİTESİ'),
(68, 68, 68, 68, 'GALATASARAY ÜNİVERSİTESİ'),
(69, 69, 69, 69, 'GAZİ ÜNİVERSİTESİ'),
(70, 70, 70, 70, 'GAZİANTEP ÜNİVERSİTESİ'),
(71, 71, 71, 71, 'GAZİOSMANPAŞA ÜNİVERSİTESİ'),
(72, 72, 72, 72, 'GEBZE TEKNİK ÜNİVERSİTESİ'),
(73, 73, 73, 73, 'GİRESUN ÜNİVERSİTESİ'),
(74, 74, 74, 74, 'GİRNE AMERİKAN ÜNİVERSİTESİ'),
(75, 75, 75, 75, 'GİRNE ÜNİVERSİTESİ'),
(76, 76, 76, 76, 'GÜMÜŞHANE ÜNİVERSİTESİ'),
(77, 77, 77, 77, 'HACETTEPE ÜNİVERSİTESİ'),
(78, 78, 78, 78, 'HAKKARİ ÜNİVERSİTESİ'),
(79, 79, 79, 79, 'HALİÇ ÜNİVERSİTESİ'),
(80, 80, 80, 80, 'HARRAN ÜNİVERSİTESİ'),
(81, 81, 81, 81, 'HASAN KALYONCU ÜNİVERSİTESİ'),
(82, 82, 82, 82, 'HİTİT ÜNİVERSİTESİ'),
(83, 83, 83, 83, 'IĞDIR ÜNİVERSİTESİ'),
(84, 84, 84, 84, 'IŞIK ÜNİVERSİTESİ'),
(85, 85, 85, 85, 'İBN HALDUN ÜNİVERSİTESİ'),
(86, 86, 86, 86, 'İHSAN DOĞRAMACI BİLKENT ÜNİVERSİTESİ'),
(87, 87, 87, 87, 'İNÖNÜ ÜNİVERSİTESİ'),
(88, 88, 88, 88, 'İSKENDERUN TEKNİK ÜNİVERSİTESİ'),
(89, 89, 89, 89, 'İSTANBUL 29 MAYIS ÜNİVERSİTESİ'),
(90, 90, 90, 90, 'İSTANBUL AREL ÜNİVERSİTESİ'),
(91, 91, 91, 91, 'İSTANBUL AYDIN ÜNİVERSİTESİ'),
(92, 92, 92, 92, 'İSTANBUL AYVANSARAY ÜNİVERSİTESİ'),
(93, 93, 93, 93, 'İSTANBUL BİLGİ ÜNİVERSİTESİ'),
(94, 94, 94, 94, 'İSTANBUL ESENYURT ÜNİVERSİTESİ'),
(95, 95, 95, 95, 'İSTANBUL GEDİK ÜNİVERSİTESİ'),
(96, 96, 96, 96, 'İSTANBUL GELİŞİM ÜNİVERSİTESİ'),
(97, 97, 97, 97, 'İSTANBUL KAVRAM MESLEK YÜKSEKOKULU'),
(98, 98, 98, 98, 'İSTANBUL KENT ÜNİVERSİTESİ'),
(99, 99, 99, 99, 'İSTANBUL KÜLTÜR ÜNİVERSİTESİ'),
(100, 100, 100, 100, 'İSTANBUL MEDENİYET ÜNİVERSİTESİ'),
(101, 101, 101, 101, 'İSTANBUL MEDİPOL ÜNİVERSİTESİ'),
(102, 102, 102, 102, 'İSTANBUL RUMELİ ÜNİVERSİTESİ'),
(103, 103, 103, 103, 'İSTANBUL SABAHATTİN ZAİM ÜNİVERSİTESİ'),
(104, 104, 104, 104, 'İSTANBUL ŞEHİR ÜNİVERSİTESİ'),
(105, 105, 105, 105, 'İSTANBUL ŞİŞLİ MESLEK YÜKSEKOKULU'),
(106, 106, 106, 106, 'İSTANBUL TEKNİK ÜNİVERSİTESİ'),
(107, 107, 107, 107, 'İSTANBUL TİCARET ÜNİVERSİTESİ'),
(108, 108, 108, 108, 'İSTANBUL ÜNİVERSİTESİ'),
(109, 109, 109, 109, 'İSTANBUL YENİ YÜZYIL ÜNİVERSİTESİ'),
(110, 110, 110, 110, 'İSTİNYE ÜNİVERSİTESİ'),
(111, 111, 111, 111, 'İZMİR DEMOKRASİ ÜNİVERSİTESİ'),
(112, 112, 112, 112, 'İZMİR EKONOMİ ÜNİVERSİTESİ'),
(113, 113, 113, 113, 'İZMİR KATİP ÇELEBİ ÜNİVERSİTESİ'),
(114, 114, 114, 114, 'İZMİR YÜKSEK TEKNOLOJİ ENSTİTÜSÜ'),
(115, 115, 115, 115, 'KADİR HAS ÜNİVERSİTESİ'),
(116, 116, 116, 116, 'KAFKAS ÜNİVERSİTESİ'),
(117, 117, 117, 117, 'KAHRAMANMARAŞ SÜTÇÜ İMAM ÜNİVERSİTESİ'),
(118, 118, 118, 118, 'KAPADOKYA ÜNİVERSİTESİ'),
(119, 119, 119, 119, 'KARABÜK ÜNİVERSİTESİ'),
(120, 120, 120, 120, 'KARADENİZ TEKNİK ÜNİVERSİTESİ'),
(121, 121, 121, 121, 'KARAMANOĞLU MEHMETBEY ÜNİVERSİTESİ'),
(122, 122, 122, 122, 'KASTAMONU ÜNİVERSİTESİ'),
(123, 123, 123, 123, 'KIBRIS AMERİKAN ÜNİVERSİTESİ'),
(124, 124, 124, 124, 'KIBRIS İLİM ÜNİVERSİTESİ'),
(125, 125, 125, 125, 'KIBRIS SOSYAL BİLİMLER ÜNİVERSİTESİ'),
(126, 126, 126, 126, 'KIRIKKALE ÜNİVERSİTESİ'),
(127, 127, 127, 127, 'KIRKLARELİ ÜNİVERSİTESİ'),
(128, 128, 128, 128, 'KİLİS 7 ARALIK ÜNİVERSİTESİ'),
(129, 129, 129, 129, 'KOCAELİ ÜNİVERSİTESİ'),
(130, 130, 130, 130, 'KOÇ ÜNİVERSİTESİ'),
(131, 131, 131, 131, 'KONYA GIDA VE TARIM ÜNİVERSİTESİ'),
(132, 132, 132, 132, 'KTO KARATAY ÜNİVERSİTESİ'),
(133, 133, 133, 133, 'LEFKE AVRUPA ÜNİVERSİTESİ'),
(134, 134, 134, 134, 'MALTEPE ÜNİVERSİTESİ'),
(135, 135, 135, 135, 'MANİSA CELAL BAYAR ÜNİVERSİTESİ'),
(136, 136, 136, 136, 'MARDİN ARTUKLU ÜNİVERSİTESİ'),
(137, 137, 137, 137, 'MARMARA ÜNİVERSİTESİ'),
(138, 138, 138, 138, 'MEF ÜNİVERSİTESİ'),
(139, 139, 139, 139, 'MEHMET AKİF ERSOY ÜNİVERSİTESİ'),
(140, 140, 140, 140, 'MERSİN ÜNİVERSİTESİ'),
(141, 141, 141, 141, 'MİLLİ SAVUNMA ÜNİVERSİTESİ'),
(142, 142, 142, 142, 'MİMAR SİNAN GÜZEL SANATLAR ÜNİVERSİTESİ'),
(143, 143, 143, 143, 'MUĞLA SITKI KOÇMAN ÜNİVERSİTESİ'),
(144, 144, 144, 144, 'MUNZUR ÜNİVERSİTESİ'),
(145, 145, 145, 145, 'MUSTAFA KEMAL ÜNİVERSİTESİ'),
(146, 146, 146, 146, 'MUŞ ALPARSLAN ÜNİVERSİTESİ'),
(147, 147, 147, 147, 'NAMIK KEMAL ÜNİVERSİTESİ'),
(148, 148, 148, 148, 'NECMETTİN ERBAKAN ÜNİVERSİTESİ'),
(149, 149, 149, 149, 'NEVŞEHİR HACI BEKTAŞ VELİ ÜNİVERSİTESİ'),
(150, 150, 150, 150, 'NİĞDE ÖMER HALİSDEMİR ÜNİVERSİTESİ'),
(151, 151, 151, 151, 'NİŞANTAŞI ÜNİVERSİTESİ'),
(152, 152, 152, 152, 'NUH NACİ YAZGAN ÜNİVERSİTESİ'),
(153, 153, 153, 153, 'OKAN ÜNİVERSİTESİ'),
(154, 154, 154, 154, 'ONDOKUZ MAYIS ÜNİVERSİTESİ'),
(155, 155, 155, 155, 'ORDU ÜNİVERSİTESİ'),
(156, 156, 156, 156, 'ORTA DOĞU TEKNİK ÜNİVERSİTESİ'),
(157, 157, 157, 157, 'OSMANİYE KORKUT ATA ÜNİVERSİTESİ'),
(158, 158, 158, 158, 'ÖZYEĞİN ÜNİVERSİTESİ'),
(159, 159, 159, 159, 'PAMUKKALE ÜNİVERSİTESİ'),
(160, 160, 160, 160, 'PİRİ REİS ÜNİVERSİTESİ'),
(161, 161, 161, 161, 'RECEP TAYYİP ERDOĞAN ÜNİVERSİTESİ'),
(162, 162, 162, 162, 'SABANCI ÜNİVERSİTESİ'),
(163, 163, 163, 163, 'SAĞLIK BİLİMLERİ ÜNİVERSİTESİ'),
(164, 164, 164, 164, 'SAKARYA ÜNİVERSİTESİ'),
(165, 165, 165, 165, 'SANKO ÜNİVERSİTESİ'),
(166, 166, 166, 166, 'SELÇUK ÜNİVERSİTESİ'),
(167, 167, 167, 167, 'SİİRT ÜNİVERSİTESİ'),
(168, 168, 168, 168, 'SİNOP ÜNİVERSİTESİ'),
(169, 169, 169, 169, 'SÜLEYMAN DEMİREL ÜNİVERSİTESİ'),
(170, 170, 170, 170, 'ŞIRNAK ÜNİVERSİTESİ'),
(171, 171, 171, 171, 'TED ÜNİVERSİTESİ'),
(172, 172, 172, 172, 'TOBB EKONOMİ VE TEKNOLOJİ ÜNİVERSİTESİ'),
(173, 173, 173, 173, 'TOROS ÜNİVERSİTESİ'),
(174, 174, 174, 174, 'TRAKYA ÜNİVERSİTESİ'),
(175, 175, 175, 175, 'TÜRK HAVA KURUMU ÜNİVERSİTESİ'),
(176, 176, 176, 176, 'TÜRK-ALMAN ÜNİVERSİTESİ'),
(177, 177, 177, 177, 'UFUK ÜNİVERSİTESİ'),
(178, 178, 178, 178, 'ULUDAĞ ÜNİVERSİTESİ'),
(179, 179, 179, 179, 'ULUSLAR ARASI KIBRIS ÜNİVERSİTESİ'),
(180, 180, 180, 180, 'UŞAK ÜNİVERSİTESİ'),
(181, 181, 181, 181, 'ÜSKÜDAR ÜNİVERSİTESİ'),
(182, 182, 182, 182, 'YAKINDOĞU ÜNİVERSİTESİ'),
(183, 183, 183, 183, 'YALOVA ÜNİVERSİTESİ'),
(184, 184, 184, 184, 'YAŞAR ÜNİVERSİTESİ'),
(185, 185, 185, 185, 'YEDİTEPE ÜNİVERSİTESİ'),
(186, 186, 186, 186, 'YILDIZ TEKNİK ÜNİVERSİTESİ'),
(187, 187, 187, 187, 'YÜKSEK İHTİSAS ÜNİVERSİTESİ'),
(188, 188, 188, 188, 'YÜZÜNCÜ YIL ÜNİVERSİTESİ'),
(189, 189, 189, 189, 'İSTANBUL BİLİM ÜNİVERSİTESİ');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_turkish_ci NOT NULL,
  `email` text COLLATE utf8_turkish_ci NOT NULL,
  `username` text COLLATE utf8_turkish_ci NOT NULL,
  `password` text COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`) VALUES
(2, 'Ahmet Furkan Bayram', 'bayramahmet48@gmail.com', 'ahmet_furkaann', '$5$rounds=535000$RELursFHcYh4/G4n$f04pEIu7W2U9SzfPyfDFWk.wjK8HURqztY2yCQGwX05'),
(6, 'Güzin Ulutaş', 'deneme@hotmail.com', 'gulutas', '$5$rounds=535000$/u2CR8iXM8yaNce6$9auvOV1TOR2QPfFvbJryd/gbzXuEvwMfOxIkzIFvh6C'),
(7, 'Hilal Küçük', 'deneme2@hotmail.com', 'hilalkucuk', '$5$rounds=535000$LaT8MtN4uEGpiEW2$jzoLEIS/E9iqByJj4X9iQ28evHlfDy8bTRk3jNGZhG2'),
(8, 'Sümeyye Akkuş', 'deneme3@hotmail.com', 'sumakkus', '$5$rounds=535000$XtYy2kkhKpRisulA$B.PYPwXR28klgd9sueMFTvLn2/0ilfo8EuZEIZurehA'),
(9, 'Yunus Arkan', 'yunusbaliklariyasasin@gmail.com', 'yunusarkan', '$5$rounds=535000$Ez9BVCZ5KnMnjxv1$GqkNQpqe9E09Oyu7uIr6P0uYwaszeRqj1mL6aQa8UzA');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `asilar`
--
ALTER TABLE `asilar`
  ADD PRIMARY KEY (`asi_id`),
  ADD KEY `asi_id` (`asi_id`);

--
-- Tablo için indeksler `belirtiler`
--
ALTER TABLE `belirtiler`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tc_no` (`tc_no`);

--
-- Tablo için indeksler `calisma_sureleri`
--
ALTER TABLE `calisma_sureleri`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`) USING BTREE,
  ADD KEY `tc_no` (`tc_no`);

--
-- Tablo için indeksler `covid`
--
ALTER TABLE `covid`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tc_no` (`tc_no`),
  ADD KEY `id` (`id`) USING BTREE,
  ADD KEY `asi_id` (`asi_id`);

--
-- Tablo için indeksler `eleman`
--
ALTER TABLE `eleman`
  ADD PRIMARY KEY (`tc_no`),
  ADD KEY `eleman_id` (`eleman_id`),
  ADD KEY `tc_no` (`tc_no`),
  ADD KEY `asi_id` (`asi_id`),
  ADD KEY `lisans` (`lisans`) USING BTREE,
  ADD KEY `yuksek_lisans` (`yuksek_lisans`),
  ADD KEY `doktora` (`doktora`);

--
-- Tablo için indeksler `eleman_hobileri`
--
ALTER TABLE `eleman_hobileri`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `tc_no` (`tc_no`);

--
-- Tablo için indeksler `hasta`
--
ALTER TABLE `hasta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `tc_no` (`tc_no`);

--
-- Tablo için indeksler `kronik_hastaliklar`
--
ALTER TABLE `kronik_hastaliklar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tc_no` (`tc_no`);

--
-- Tablo için indeksler `temasli_calisanlar`
--
ALTER TABLE `temasli_calisanlar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tc_no` (`tc_no`),
  ADD KEY `temasli_tcno` (`temasli_tcno`);

--
-- Tablo için indeksler `universite`
--
ALTER TABLE `universite`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `lisans` (`lisans`),
  ADD UNIQUE KEY `yuksek_lisans` (`yuksek_lisans`),
  ADD UNIQUE KEY `doktora` (`doktora`),
  ADD KEY `id` (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `asilar`
--
ALTER TABLE `asilar`
  MODIFY `asi_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `belirtiler`
--
ALTER TABLE `belirtiler`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- Tablo için AUTO_INCREMENT değeri `calisma_sureleri`
--
ALTER TABLE `calisma_sureleri`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- Tablo için AUTO_INCREMENT değeri `covid`
--
ALTER TABLE `covid`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Tablo için AUTO_INCREMENT değeri `eleman`
--
ALTER TABLE `eleman`
  MODIFY `eleman_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Tablo için AUTO_INCREMENT değeri `eleman_hobileri`
--
ALTER TABLE `eleman_hobileri`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- Tablo için AUTO_INCREMENT değeri `hasta`
--
ALTER TABLE `hasta`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Tablo için AUTO_INCREMENT değeri `kronik_hastaliklar`
--
ALTER TABLE `kronik_hastaliklar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Tablo için AUTO_INCREMENT değeri `temasli_calisanlar`
--
ALTER TABLE `temasli_calisanlar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Tablo için AUTO_INCREMENT değeri `universite`
--
ALTER TABLE `universite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=190;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `belirtiler`
--
ALTER TABLE `belirtiler`
  ADD CONSTRAINT `belirtiler_ibfk_1` FOREIGN KEY (`tc_no`) REFERENCES `covid` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `calisma_sureleri`
--
ALTER TABLE `calisma_sureleri`
  ADD CONSTRAINT `calisma_sureleri_ibfk_1` FOREIGN KEY (`tc_no`) REFERENCES `eleman` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `covid`
--
ALTER TABLE `covid`
  ADD CONSTRAINT `covid_ibfk_1` FOREIGN KEY (`tc_no`) REFERENCES `eleman` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `covid_ibfk_2` FOREIGN KEY (`asi_id`) REFERENCES `asilar` (`asi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `eleman`
--
ALTER TABLE `eleman`
  ADD CONSTRAINT `eleman_ibfk_1` FOREIGN KEY (`asi_id`) REFERENCES `asilar` (`asi_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `eleman_hobileri`
--
ALTER TABLE `eleman_hobileri`
  ADD CONSTRAINT `eleman_hobileri_ibfk_2` FOREIGN KEY (`tc_no`) REFERENCES `eleman` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `hasta`
--
ALTER TABLE `hasta`
  ADD CONSTRAINT `hasta_ibfk_1` FOREIGN KEY (`tc_no`) REFERENCES `eleman` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `kronik_hastaliklar`
--
ALTER TABLE `kronik_hastaliklar`
  ADD CONSTRAINT `kronik_hastaliklar_ibfk_1` FOREIGN KEY (`tc_no`) REFERENCES `covid` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Tablo kısıtlamaları `temasli_calisanlar`
--
ALTER TABLE `temasli_calisanlar`
  ADD CONSTRAINT `temasli_calisanlar_ibfk_1` FOREIGN KEY (`tc_no`) REFERENCES `covid` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `temasli_calisanlar_ibfk_2` FOREIGN KEY (`temasli_tcno`) REFERENCES `eleman` (`tc_no`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
