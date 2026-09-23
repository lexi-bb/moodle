/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: bitnami_moodle
-- ------------------------------------------------------
-- Server version	12.2.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Dumping data for table `mdl_config_plugins`
--
-- WHERE:  plugin='theme_academi'

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `mdl_config_plugins` WRITE;
/*!40000 ALTER TABLE `mdl_config_plugins` DISABLE KEYS */;
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2126,'theme_academi','address','308 Negra Narrow Lane, Albeeze, New york, 87104');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2090,'theme_academi','autoslideshow','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2082,'theme_academi','availablecoursetype','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2085,'theme_academi','backToTop_status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2083,'theme_academi','comboListboxType','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2115,'theme_academi','copyright_footer','Copyright &copy; 2017 - Developed by <a href=\"http://lmsace.com\">LMSACE.com</a>. Powered by <a href=\"https://moodle.org\">Moodle</a>');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2086,'theme_academi','customcss','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2127,'theme_academi','emailid','info@example.com');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2075,'theme_academi','favicon','/BB-logo.png');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2081,'theme_academi','fontsize','16');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2116,'theme_academi','footerb1_status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2121,'theme_academi','footerb2_status','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2124,'theme_academi','footerb3_status','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2129,'theme_academi','footerb4_status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2113,'theme_academi','footerbgimg','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2114,'theme_academi','footerbgOverlay','0.4');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2117,'theme_academi','footerbtitle1','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2122,'theme_academi','footerbtitle2','lang:footerbtitle2default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2125,'theme_academi','footerbtitle3','lang:footerbtitle3default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2130,'theme_academi','footerbtitle4','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2119,'theme_academi','footerlogo','/BB-logo.png');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2118,'theme_academi','footlogostatus','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2120,'theme_academi','footnote','<p>Keep up to date with Basilica Bio through our <a href=\"https://www.instagram.com/basilicabio/?hl=en\"><strong>Instagram</strong></a></p>');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2123,'theme_academi','infolink','Moodle community|https://moodle.org Moodle free\r\nsupport|https://moodle.org/support\r\nMoodle development|https://moodle.org/development\r\nMoodle Docs|http://docs.moodle.org|Moodle Docs\r\nMoodle.com|http://moodle.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2111,'theme_academi','jumbotronbtnlink','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2112,'theme_academi','jumbotronbtntarget','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2110,'theme_academi','jumbotronbtntext','lang:viewallcourses');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2109,'theme_academi','jumbotrondesc','lang:learnanytimedesc');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2107,'theme_academi','jumbotronstatus','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2108,'theme_academi','jumbotrontitle','lang:learnanytime');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2084,'theme_academi','loginbg','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2074,'theme_academi','logo','/BB-logo.png');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2105,'theme_academi','mspotcontent','<p>Ipsum in aspernatur ut possimus sint. Quia omnis est occaecati possimus ea. Quas molestiae perspiciatis occaecati qui rerum. Deleniti quod porro sed quisquam saepe. Numquam mollitia recusandae non ad at et a.</p>\r\n<p>Ad vitae recusandae odit possimus. Quaerat cum ipsum corrupti. Odit qui asperiores ea corporis deserunt veritatis quidem expedita perferendis. Qui rerum eligendi ex doloribus quia sit. Porro rerum eum eum.</p>\r\n<p>Ad vitae recusandae odit possimus. Quaerat cum ipsum corrupti. Odit qui asperiores ea corporis deserunt veritatis quidem expedita perferendis.</p>');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2104,'theme_academi','mspotdesc','lang:description_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2106,'theme_academi','mspotmedia','/mspotmedia.png');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2102,'theme_academi','mspotstatus','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2103,'theme_academi','mspottitle','lang:aboutus');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2073,'theme_academi','navstyle','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2101,'theme_academi','numberofsitefeature','4');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2093,'theme_academi','numberofslides','3');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2131,'theme_academi','numofsocialmedia','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2079,'theme_academi','pagesize','default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2080,'theme_academi','pagesizecustomval','100');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2094,'theme_academi','pcoursestatus','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2128,'theme_academi','phoneno','(000) 123-456');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2087,'theme_academi','preset','default.scss');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2088,'theme_academi','presetfiles','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2076,'theme_academi','primarycolor','#4D4E4E');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2096,'theme_academi','promotedcoursedesc','lang:description_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2097,'theme_academi','promotedcourses','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2095,'theme_academi','promotedtitle','lang:promotedtitledefault');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2077,'theme_academi','secondarycolor','#A6D2A9');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2164,'theme_academi','sitefblock1content','lang:sb_default_content');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2165,'theme_academi','sitefblock1icon','lang:sitefblockicon1_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2162,'theme_academi','sitefblock1status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2163,'theme_academi','sitefblock1title','lang:sb1_default_title');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2166,'theme_academi','sitefblock1url','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2169,'theme_academi','sitefblock2content','lang:sb_default_content');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2170,'theme_academi','sitefblock2icon','lang:sitefblockicon2_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2167,'theme_academi','sitefblock2status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2168,'theme_academi','sitefblock2title','lang:sb2_default_title');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2171,'theme_academi','sitefblock2url','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2174,'theme_academi','sitefblock3content','lang:sb_default_content');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2175,'theme_academi','sitefblock3icon','lang:sitefblockicon3_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2172,'theme_academi','sitefblock3status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2173,'theme_academi','sitefblock3title','lang:sb3_default_title');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2176,'theme_academi','sitefblock3url','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2179,'theme_academi','sitefblock4content','lang:sb_default_content');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2180,'theme_academi','sitefblock4icon','lang:sitefblockicon4_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2177,'theme_academi','sitefblock4status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2178,'theme_academi','sitefblock4title','lang:sb4_default_title');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2181,'theme_academi','sitefblock4url','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2098,'theme_academi','sitefblockstatus','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2100,'theme_academi','sitefeaturedesc','lang:description_default');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2099,'theme_academi','sitefeaturetitle','lang:sitefeaturesdefault');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2139,'theme_academi','slide1btntarget','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2137,'theme_academi','slide1btntext','lang:knowmore');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2138,'theme_academi','slide1btnurl','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2135,'theme_academi','slide1caption','Bootstrap Based Slider - 01');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2141,'theme_academi','slide1contentPosition','centerRight');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2134,'theme_academi','slide1contentstatus','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2140,'theme_academi','slide1contFullwidth','50');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2136,'theme_academi','slide1desc','Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2133,'theme_academi','slide1image','/slide1image.jpg');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2132,'theme_academi','slide1status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2149,'theme_academi','slide2btntarget','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2147,'theme_academi','slide2btntext','lang:knowmore');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2148,'theme_academi','slide2btnurl','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2145,'theme_academi','slide2caption','Bootstrap Based Slider - 02');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2151,'theme_academi','slide2contentPosition','centerRight');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2144,'theme_academi','slide2contentstatus','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2150,'theme_academi','slide2contFullwidth','50');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2146,'theme_academi','slide2desc','Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2143,'theme_academi','slide2image','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2142,'theme_academi','slide2status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2159,'theme_academi','slide3btntarget','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2157,'theme_academi','slide3btntext','lang:knowmore');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2158,'theme_academi','slide3btnurl','http://www.example.com/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2155,'theme_academi','slide3caption','Bootstrap Based Slider - 03');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2161,'theme_academi','slide3contentPosition','centerRight');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2154,'theme_academi','slide3contentstatus','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2160,'theme_academi','slide3contFullwidth','50');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2156,'theme_academi','slide3desc','Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2153,'theme_academi','slide3image','');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2152,'theme_academi','slide3status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2091,'theme_academi','slideinterval','3500');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2092,'theme_academi','slideOverlay','0.4');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2183,'theme_academi','socialmedia1_icon','instagram');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2185,'theme_academi','socialmedia1_iconcolor','#A6D2A9');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2182,'theme_academi','socialmedia1_status','1');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2184,'theme_academi','socialmedia1_url','https://www.instagram.com/basilicabio/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2187,'theme_academi','socialmedia2_icon','google-plus');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2189,'theme_academi','socialmedia2_iconcolor','#e84c3d');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2186,'theme_academi','socialmedia2_status','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2188,'theme_academi','socialmedia2_url','https://www.google.com/+yourgoogleplusid');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2191,'theme_academi','socialmedia3_icon','pinterest-p');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2193,'theme_academi','socialmedia3_iconcolor','#cd2129');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2190,'theme_academi','socialmedia3_status','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2192,'theme_academi','socialmedia3_url','https://in.pinterest.com/yourpinterestname/');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2195,'theme_academi','socialmedia4_icon','facebook-f');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2197,'theme_academi','socialmedia4_iconcolor','#3598dc');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2194,'theme_academi','socialmedia4_status','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2196,'theme_academi','socialmedia4_url','https://www.facebook.com/yourfacebookid');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2078,'theme_academi','themestyleheader','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2089,'theme_academi','toggleslideshow','0');
INSERT INTO `mdl_config_plugins` (`id`, `plugin`, `name`, `value`) VALUES (2071,'theme_academi','version','2025121800');
/*!40000 ALTER TABLE `mdl_config_plugins` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-09-23 23:50:48
