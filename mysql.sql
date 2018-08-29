-- phpMyAdmin SQL Dump
-- version 4.7.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: 2018-03-22 21:32:28
-- 服务器版本： 5.5.58-log
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vps`
--

-- --------------------------------------------------------

--
-- 表的结构 `xm_company`
--

CREATE TABLE `xm_company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xm_company`
--

INSERT INTO `xm_company` (`id`, `name`, `url`, `create_time`, `update_time`, `delete_time`) VALUES
(1, 'MineCloud', '', 1512637526, 1512637526, NULL),
(2, 'test', '', 1521160775, 1521160775, NULL),
(3, '搬瓦工', '', 1521206330, 1521206330, NULL),
(4, 'DGCHost', '', 1521262192, 1521262192, NULL),
(5, 'LightCloud', '', 1521382370, 1521382370, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `xm_index`
--

CREATE TABLE `xm_index` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `companyid` int(10) unsigned DEFAULT NULL,
  `placeid` int(10) unsigned DEFAULT NULL,
  `ram` varchar(255) DEFAULT NULL,
  `disk` text,
  `cpu` smallint(5) unsigned DEFAULT NULL,
  `ip4` smallint(5) unsigned DEFAULT NULL,
  `ip6` smallint(5) unsigned DEFAULT NULL,
  `frame` varchar(25) DEFAULT NULL,
  `flow` varchar(150) DEFAULT NULL,
  `bandwidth` varchar(25) DEFAULT NULL,
  `stock` tinyint(1) DEFAULT '1',
  `remark` text,
  `buy` text,
  `monthly` varchar(55) DEFAULT NULL,
  `yearly` varchar(55) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `delete_time` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `vurl` varchar(255) NOT NULL,
  `vf` text NOT NULL,
  `status` tinyint(3) unsigned DEFAULT '0',
  `route` varchar(255) NOT NULL,
  `ceping` varchar(1024) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xm_index`
--

INSERT INTO `xm_index` (`id`, `companyid`, `placeid`, `ram`, `disk`, `cpu`, `ip4`, `ip6`, `frame`, `flow`, `bandwidth`, `stock`, `remark`, `buy`, `monthly`, `yearly`, `create_time`, `update_time`, `delete_time`, `name`, `vurl`, `vf`, `status`, `route`, `ceping`) VALUES
(9, 3, 3, '2GB', '40GB', 2, 1, 0, 'KVM', '2000G', 1000, 0, 'CN2 GIA', 'https://bwh1.net/aff.php?aff=5745&pid=70', '$10.58', '', 1521206330, 1521461288, NULL, 'Basic VPS BETA CN2 GIA', 'https://bwh1.net/aff.php?aff=5745&pid=70', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(10, 3, 3, '512M', '10G', 1, 1, 1, 'KVM', '1000G', 1000, 0, '', 'https://bwh1.net/aff.php?aff=5745&pid=53', '$2.99', '$19.99', 1521206651, 1521260990, NULL, 'SPECIAL 10G KVM PROMO V3', 'https://bwh1.net/aff.php?aff=5745&pid=53', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(11, 4, 4, '512MB', '20G', 1, 1, 0, 'KVM', '1000GB', 1000, 0, 'LAX SKVM - 01', 'https://www.dgchost.net/client/aff.php?aff=599&pid=80', '$3', '', 1521262192, 1521272230, NULL, 'LAX SKVM - 01', 'https://www.dgchost.net/client/cart.php?a=add&pid=80', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(12, 4, 4, '1G', '30G', 1, 1, 0, 'KVM', '2000G', 1000, 0, 'LAX SKVM - 02', 'https://www.dgchost.net/client/aff.php?aff=599&pid=81', '$5', '', 1521265528, 1521272284, NULL, 'LAX SKVM - 02', 'https://www.dgchost.net/client/cart.php?a=add&pid=81', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(13, 4, 4, '2G', '40G', 1, 1, 0, 'KVM', '3000G', 1000, 0, 'LAX SKVM - 03', 'https://www.dgchost.net/client/aff.php?aff=599&pid=82', '$10', '', 1521265654, 1521272286, NULL, 'LAX SKVM - 03', 'https://www.dgchost.net/client/cart.php?a=add&pid=82', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(14, 4, 4, '512M', '10G', 1, 1, 0, 'KVM', '300G', 1000, 0, 'LAX CRKVM - SP01', 'https://www.dgchost.net/client/aff.php?aff=599&pid=84', '$1.66', '', 1521265849, 1521272230, NULL, 'LAX CRKVM - SP01', 'https://www.dgchost.net/client/cart.php?a=add&pid=84', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(15, 4, 4, '512M', '10G', 1, 1, 0, 'KVM', '500G', 1000, 0, 'LAX CRKVM - SP02', 'https://www.dgchost.net/client/aff.php?aff=599&pid=89', '$3.5', '', 1521266663, 1521272346, NULL, 'LAX CRKVM - SP02', 'https://www.dgchost.net/client/cart.php?a=add&pid=89', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(16, 4, 4, '512M', '20G', 1, 1, 0, 'KVM', '1000G', 1000, 1, 'LAX CRKVM - 01', 'https://www.dgchost.net/client/aff.php?aff=599&pid=58', '$7', '', 1521266809, 1521725211, NULL, 'LAX CRKVM - 01', 'https://www.dgchost.net/client/cart.php?a=add&pid=58', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(17, 4, 5, '512M', '20G', 1, 1, 1, 'KVM', '1000G', 30, 1, 'HK CRKVM 香港直连', 'https://www.dgchost.net/client/aff.php?aff=599&pid=85', '$5', '', 1521267029, 1521725508, NULL, 'HK CRKVM - 02', 'https://www.dgchost.net/client/cart.php?a=add&pid=95', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(18, 4, 5, '1G', '30G', 1, 1, 1, 'KVM', '2000G', 30, 0, 'HK CRKVM - 香港直连', 'https://www.dgchost.net/client/aff.php?aff=599&pid=86', '$10', '', 1521267282, 1521267311, NULL, 'HK CRKVM - 05', 'https://www.dgchost.net/client/cart.php?a=add&pid=86', 'if(strpos($str,\"Out of Stock\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, '', ''),
(19, 5, 6, '512M', '4G', 1, 1, 0, 'KVM', '600G OUT', 300, 0, 'Korea-KVM-Special', 'https://my.lightvm.com/cart.php?a=add&pid=22', '￥49', '', 1521382370, 1521436802, NULL, 'Korea-KVM-Special', 'https://my.lightvm.com/cart.php?a=add&pid=22', 'if(strpos($str,\"缺貨中\")!==false){\r\n    return false;\r\n}\r\nreturn true;', 1, 'KINX', '');

-- --------------------------------------------------------

--
-- 表的结构 `xm_log`
--

CREATE TABLE `xm_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `indexid` int(10) unsigned DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xm_log`
--

INSERT INTO `xm_log` (`id`, `indexid`, `status`, `create_time`, `update_time`, `delete_time`) VALUES
(1, 1, 0, NULL, NULL, NULL),
(2, 1, 1, 1512821722, 1512821722, NULL),
(3, 1, 0, 1512822608, 1512822608, NULL),
(4, 4, 1, 1513332058, 1513332058, NULL),
(5, 4, 0, 1513332912, 1513332912, NULL),
(6, 1, 1, 1513518303, 1513518303, NULL),
(7, 1, 0, 1513519205, 1513519205, NULL),
(8, 3, 1, 1513775715, 1513775715, NULL),
(9, 3, 0, 1513791007, 1513791007, NULL),
(10, 6, 1, 1514124938, 1514124938, NULL),
(11, 6, 0, 1514125834, 1514125834, NULL),
(12, 1, 1, 1514353521, 1514353521, NULL),
(13, 1, 0, 1514354404, 1514354404, NULL),
(14, 3, 1, 1514467830, 1514467830, NULL),
(15, 3, 0, 1514468717, 1514468717, NULL),
(16, 6, 1, 1514553347, 1514553347, NULL),
(17, 6, 0, 1514554213, 1514554213, NULL),
(18, 1, 1, 1514794522, 1514794522, NULL),
(19, 1, 0, 1514795405, 1514795405, NULL),
(20, 1, 1, 1514800822, 1514800822, NULL),
(21, 1, 0, 1514801703, 1514801703, NULL),
(22, 2, 1, 1514812526, 1514812526, NULL),
(23, 2, 0, 1514813407, 1514813407, NULL),
(24, 5, 1, 1514871041, 1514871041, NULL),
(25, 5, 0, 1514871913, 1514871913, NULL),
(26, 5, 1, 1514896257, 1514896257, NULL),
(27, 5, 0, 1514897110, 1514897110, NULL),
(28, 2, 1, 1514959224, 1514959224, NULL),
(29, 2, 0, 1514960110, 1514960110, NULL),
(30, 1, 1, 1514984421, 1514984421, NULL),
(31, 1, 0, 1514985307, 1514985307, NULL),
(32, 6, 0, 1514986213, 1514986213, NULL),
(33, 3, 1, 1514988032, 1514988032, NULL),
(34, 3, 0, 1514988909, 1514988909, NULL),
(35, 1, 1, 1514991623, 1514991623, NULL),
(36, 1, 0, 1514992506, 1514992506, NULL),
(37, 4, 1, 1515238232, 1515238232, NULL),
(38, 4, 0, 1515239118, 1515239118, NULL),
(39, 2, 1, 1515241826, 1515241826, NULL),
(40, 2, 0, 1515242711, 1515242711, NULL),
(41, 1, 1, 1515252621, 1515252621, NULL),
(42, 1, 0, 1515253507, 1515253507, NULL),
(43, 6, 1, 1515318345, 1515318345, NULL),
(44, 1, 1, 1515319222, 1515319222, NULL),
(45, 1, 0, 1515320106, 1515320106, NULL),
(46, 4, 1, 1515324650, 1515324650, NULL),
(47, 4, 0, 1515325522, 1515325522, NULL),
(48, 5, 1, 1515339037, 1515339037, NULL),
(49, 5, 0, 1515339928, 1515339928, NULL),
(50, 1, 1, 1515401122, 1515401122, NULL),
(51, 1, 0, 1515402006, 1515402006, NULL),
(52, 1, 1, 1515402921, 1515402921, NULL),
(53, 1, 0, 1515403805, 1515403805, NULL),
(54, 2, 1, 1515421827, 1515421827, NULL),
(55, 2, 0, 1515422709, 1515422709, NULL),
(56, 2, 1, 1515469534, 1515469534, NULL),
(57, 2, 0, 1515470411, 1515470411, NULL),
(58, 3, 1, 1515482135, 1515482135, NULL),
(59, 3, 0, 1515483013, 1515483013, NULL),
(60, 6, 1, 1515484878, 1515484878, NULL),
(61, 6, 0, 1515485712, 1515485712, NULL),
(62, 1, 1, 1515490221, 1515490221, NULL),
(63, 1, 0, 1515491105, 1515491105, NULL),
(64, 4, 1, 1515499240, 1515499240, NULL),
(65, 4, 0, 1515500138, 1515500138, NULL),
(66, 4, 1, 1515503748, 1515503748, NULL),
(67, 4, 0, 1515504610, 1515504610, NULL),
(68, 1, 1, 1515507321, 1515507321, NULL),
(69, 1, 0, 1515508204, 1515508204, NULL),
(70, 4, 1, 1515509153, 1515509153, NULL),
(71, 2, 1, 1515510933, 1515510933, NULL),
(72, 2, 0, 1515511811, 1515511811, NULL),
(73, 4, 1, 1515513638, 1515513638, NULL),
(74, 4, 0, 1515514509, 1515514509, NULL),
(75, 3, 1, 1515568520, 1515568520, NULL),
(76, 4, 1, 1515573951, 1515573951, NULL),
(77, 4, 0, 1515574810, 1515574810, NULL),
(78, 1, 1, 1515575722, 1515575722, NULL),
(79, 1, 0, 1515576604, 1515576604, NULL),
(80, 5, 1, 1515578439, 1515578439, NULL),
(81, 5, 0, 1515579319, 1515579319, NULL),
(82, 4, 1, 1515582948, 1515582948, NULL),
(83, 4, 0, 1515583817, 1515583817, NULL),
(84, 2, 1, 1515591028, 1515591028, NULL),
(85, 2, 0, 1515591907, 1515591907, NULL),
(86, 1, 1, 1515598222, 1515598222, NULL),
(87, 1, 0, 1515599106, 1515599106, NULL),
(88, 5, 1, 1515600058, 1515600058, NULL),
(89, 5, 0, 1515600913, 1515600913, NULL),
(90, 3, 0, 1515614407, 1515614407, NULL),
(91, 1, 1, 1515646821, 1515646821, NULL),
(92, 1, 0, 1515647706, 1515647706, NULL),
(93, 5, 1, 1515861040, 1515861040, NULL),
(94, 5, 0, 1515861924, 1515861924, NULL),
(95, 1, 1, 1515947421, 1515947421, NULL),
(96, 1, 0, 1515948304, 1515948304, NULL),
(97, 4, 1, 1515983473, 1515983473, NULL),
(98, 4, 0, 1515984308, 1515984308, NULL),
(99, 4, 1, 1516090531, 1516090531, NULL),
(100, 4, 0, 1516091408, 1516091408, NULL),
(101, 5, 1, 1516720530, 1516720530, NULL),
(102, 5, 0, 1516721411, 1516721411, NULL),
(103, 4, 1, 1516731328, 1516731328, NULL),
(104, 4, 0, 1516732209, 1516732209, NULL),
(105, 1, 1, 1516739422, 1516739422, NULL),
(106, 1, 0, 1516740304, 1516740304, NULL),
(107, 5, 1, 1517047233, 1517047233, NULL),
(108, 5, 0, 1517048118, 1517048118, NULL),
(109, 3, 1, 1517066127, 1517066127, NULL),
(110, 3, 0, 1517067010, 1517067010, NULL),
(111, 6, 1, 1517121970, 1517121970, NULL),
(112, 6, 0, 1517122813, 1517122813, NULL),
(113, 4, 1, 1517333432, 1517333432, NULL),
(114, 4, 0, 1517334310, 1517334310, NULL),
(115, 4, 1, 1517457630, 1517457630, NULL),
(116, 4, 0, 1517458514, 1517458514, NULL),
(117, 5, 1, 1517591737, 1517591737, NULL),
(118, 5, 0, 1517592610, 1517592610, NULL),
(119, 1, 1, 1517637621, 1517637621, NULL),
(120, 1, 0, 1517638505, 1517638505, NULL),
(121, 4, 1, 1517661945, 1517661945, NULL),
(122, 4, 0, 1517662823, 1517662823, NULL),
(123, 6, 1, 1517841046, 1517841046, NULL),
(124, 6, 0, 1517841918, 1517841918, NULL),
(125, 1, 1, 1518063301, 1518063301, NULL),
(126, 2, 1, 1518064201, 1518064201, NULL),
(127, 3, 1, 1518065101, 1518065101, NULL),
(128, 4, 1, 1518066002, 1518066002, NULL),
(129, 5, 1, 1518066901, 1518066901, NULL),
(130, 6, 1, 1518067801, 1518067801, NULL),
(131, 1, 0, 1518165004, 1518165004, NULL),
(132, 2, 0, 1518165905, 1518165905, NULL),
(133, 3, 0, 1518166808, 1518166808, NULL),
(134, 4, 0, 1518167710, 1518167710, NULL),
(135, 5, 0, 1518168611, 1518168611, NULL),
(136, 6, 0, 1518169514, 1518169514, NULL),
(137, 6, 1, 1518176757, 1518176757, NULL),
(138, 6, 0, 1518177650, 1518177650, NULL),
(139, 1, 1, 1518228921, 1518228921, NULL),
(140, 1, 0, 1518229804, 1518229804, NULL),
(141, 1, 1, 1518347721, 1518347721, NULL),
(142, 1, 0, 1518348603, 1518348603, NULL),
(143, 1, 1, 1518349522, 1518349522, NULL),
(144, 1, 0, 1518350403, 1518350403, NULL),
(145, 4, 1, 1518409830, 1518409830, NULL),
(146, 4, 0, 1518410709, 1518410709, NULL),
(147, 1, 1, 1518495304, 1518495304, NULL),
(148, 6, 1, 1518538513, 1518538513, NULL),
(149, 6, 0, 1518539416, 1518539416, NULL),
(150, 1, 0, 1518622204, 1518622204, NULL),
(151, 3, 1, 1518721226, 1518721226, NULL),
(152, 3, 0, 1518722107, 1518722107, NULL),
(153, 1, 1, 1518760803, 1518760803, NULL),
(154, 2, 1, 1518761705, 1518761705, NULL),
(155, 1, 0, 1518762603, 1518762603, NULL),
(156, 2, 0, 1518763504, 1518763504, NULL),
(157, 2, 1, 1518867027, 1518867027, NULL),
(158, 2, 0, 1518867904, 1518867904, NULL),
(159, 1, 1, 1518897604, 1518897604, NULL),
(160, 2, 1, 1518898503, 1518898503, NULL),
(161, 3, 1, 1518899405, 1518899405, NULL),
(162, 4, 1, 1518900305, 1518900305, NULL),
(163, 5, 1, 1518901206, 1518901206, NULL),
(164, 6, 1, 1518902107, 1518902107, NULL),
(165, 1, 0, 1518906604, 1518906604, NULL),
(166, 2, 0, 1518907527, 1518907527, NULL),
(167, 3, 0, 1518908417, 1518908417, NULL),
(168, 4, 0, 1518909310, 1518909310, NULL),
(169, 5, 0, 1518910220, 1518910220, NULL),
(170, 6, 0, 1518911113, 1518911113, NULL),
(171, 1, 1, 1518949804, 1518949804, NULL),
(172, 2, 1, 1518950708, 1518950708, NULL),
(173, 3, 1, 1518951611, 1518951611, NULL),
(174, 4, 1, 1518952513, 1518952513, NULL),
(175, 5, 1, 1518953406, 1518953406, NULL),
(176, 1, 0, 1518954307, 1518954307, NULL),
(177, 2, 0, 1518955203, 1518955203, NULL),
(178, 3, 0, 1518956105, 1518956105, NULL),
(179, 4, 0, 1518957013, 1518957013, NULL),
(180, 5, 0, 1518957913, 1518957913, NULL),
(181, 1, 1, 1518986702, 1518986702, NULL),
(182, 2, 1, 1518987602, 1518987602, NULL),
(183, 3, 1, 1518988501, 1518988501, NULL),
(184, 4, 1, 1518989402, 1518989402, NULL),
(185, 5, 1, 1518990301, 1518990301, NULL),
(186, 6, 1, 1518991202, 1518991202, NULL),
(187, 2, 0, 1521161433, 1521161433, NULL),
(188, 1, 0, 1521161463, 1521161463, NULL),
(189, 3, 0, 1521161474, 1521161474, NULL),
(190, 4, 0, 1521161513, 1521161513, NULL),
(191, 5, 0, 1521161642, 1521161642, NULL),
(192, 6, 0, 1521161823, 1521161823, NULL),
(193, 9, 0, 1521260915, 1521260915, NULL),
(194, 10, 0, 1521260942, 1521260942, NULL),
(195, 9, 0, 1521260982, 1521260982, NULL),
(196, 10, 0, 1521260990, 1521260990, NULL),
(197, 9, 0, 1521261025, 1521261025, NULL),
(198, 11, 0, 1521262203, 1521262203, NULL),
(199, 12, 0, 1521265564, 1521265564, NULL),
(200, 13, 0, 1521265685, 1521265685, NULL),
(201, 14, 0, 1521265866, 1521265866, NULL),
(202, 15, 0, 1521266708, 1521266708, NULL),
(203, 17, 0, 1521267070, 1521267070, NULL),
(204, 18, 0, 1521267311, 1521267311, NULL),
(205, 11, 1, 1521271762, 1521271762, NULL),
(206, 12, 1, 1521271837, 1521271837, NULL),
(207, 13, 1, 1521271922, 1521271922, NULL),
(208, 13, 1, 1521271979, 1521271979, NULL),
(209, 14, 1, 1521271988, 1521271988, NULL),
(210, 15, 1, 1521272122, 1521272122, NULL),
(211, 15, 1, 1521272155, 1521272155, NULL),
(212, 14, 0, 1521272230, 1521272230, NULL),
(213, 11, 0, 1521272230, 1521272230, NULL),
(214, 12, 0, 1521272284, 1521272284, NULL),
(215, 15, 0, 1521272346, 1521272346, NULL),
(216, 17, 1, 1521290148, 1521290148, NULL),
(217, 17, 0, 1521290202, 1521290202, NULL),
(218, 9, 1, 1521436269, 1521436269, NULL),
(219, 19, 0, 1521436802, 1521436802, NULL),
(220, 9, 0, 1521461288, 1521461288, NULL),
(221, 16, 0, 1521461342, 1521461342, NULL),
(222, 16, 1, 1521725211, 1521725211, NULL),
(223, 17, 1, 1521725244, 1521725244, NULL),
(224, 17, 1, 1521725508, 1521725508, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `xm_place`
--

CREATE TABLE `xm_place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  `delete_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xm_place`
--

INSERT INTO `xm_place` (`id`, `name`, `create_time`, `update_time`, `delete_time`) VALUES
(1, 'HK Pacnet', 1512637883, 1512637883, NULL),
(2, 'china', 1521160775, 1521160775, NULL),
(3, '美国洛杉矶', 1521206330, 1521206330, NULL),
(4, '洛杉矶LAX', 1521262192, 1521262192, NULL),
(5, 'HongKong', 1521267029, 1521267029, NULL),
(6, '韩国', 1521382370, 1521382370, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `xm_user`
--

CREATE TABLE `xm_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(64) NOT NULL,
  `pass` varchar(32) NOT NULL,
  `ftsckey` varchar(256) DEFAULT '',
  `tgsckey` varchar(256) DEFAULT '',
  `subscribe` text DEFAULT '',
  `create_time` int(10) unsigned DEFAULT NULL,
  `update_time` int(10) unsigned DEFAULT NULL,
  `delete_time` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `xm_user`
--

INSERT INTO `xm_user` (`id`, `user`, `pass`, `ftsckey`, `tgsckey`, `subscribe`, `create_time`, `update_time`, `delete_time`) VALUES
(1, 'admin', '', '', '', ',19,18,17', 1521724322, 1521725459, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
