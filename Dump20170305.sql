-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: simpadk1
-- ------------------------------------------------------
-- Server version	5.7.14-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `apikey`
--

DROP TABLE IF EXISTS `apikey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `apikey` (
  `user_id` int(11) NOT NULL,
  `apikey` text NOT NULL,
  `user_level` int(11) NOT NULL,
  `expired_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apikey`
--

LOCK TABLES `apikey` WRITE;
/*!40000 ALTER TABLE `apikey` DISABLE KEYS */;
INSERT INTO `apikey` VALUES (1,'c89ba5b91d1ed6642892fea04314bd2a7c12893a',1,'2017-02-17 16:48:24'),(8,'d19ea5b21a19dd226ac2bdfe0417be2a72158438e23573f3663a',1,'2017-03-05 14:21:23'),(11,'db9bbbb206429e672f92fca04210b92a7110',2,'2017-03-05 11:18:02'),(12,'dd9bbab01104c7387f91f9a04114bb2a70158031ef39',3,'2017-03-05 11:17:26');
/*!40000 ALTER TABLE `apikey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cashflow`
--

DROP TABLE IF EXISTS `cashflow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cashflow` (
  `cashflow_id` int(11) NOT NULL AUTO_INCREMENT,
  `cashflow_date` datetime NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `restock_id` int(11) DEFAULT NULL,
  `value` int(11) NOT NULL,
  `remarks` text,
  PRIMARY KEY (`cashflow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cashflow`
--

LOCK TABLES `cashflow` WRITE;
/*!40000 ALTER TABLE `cashflow` DISABLE KEYS */;
INSERT INTO `cashflow` VALUES (1,'2016-12-17 01:00:21',NULL,2,2000000,NULL),(3,'2016-12-19 00:00:00',NULL,1,500000,'BESOK SISANYA'),(4,'2016-12-19 00:00:00',NULL,1,500000,'BESOK SISANYA'),(5,'2016-12-19 00:00:00',NULL,1,500000,'BESOK SISANYA'),(6,'2016-12-19 00:00:00',NULL,1,500000,'BESOK SISANYA'),(7,'2016-12-14 00:00:00',26,NULL,35000,'ok'),(8,'2016-12-14 00:00:00',26,NULL,35000,'ok'),(9,'2016-12-16 00:00:00',27,NULL,1000000,'ok'),(10,'2016-12-17 00:00:00',NULL,2,1000,'asd'),(11,'2016-12-17 00:00:00',NULL,2,1000,'asd'),(12,'2016-12-17 00:00:00',29,NULL,1000,'asd'),(13,'2016-12-24 00:00:00',26,NULL,5000,''),(14,'2016-12-24 00:00:00',26,NULL,20000,''),(15,'2016-12-24 00:00:00',26,NULL,40000,''),(16,'2016-12-24 00:00:00',26,NULL,940000,''),(17,'2016-12-24 00:00:00',28,NULL,20000,''),(18,'2016-12-24 00:00:00',29,NULL,4000,''),(19,'2016-12-24 00:00:00',29,NULL,6000,''),(20,'2016-12-24 00:00:00',26,NULL,100000,''),(21,'2016-12-24 00:00:00',26,NULL,200000,''),(22,'2016-12-24 00:00:00',26,NULL,100000,''),(23,'2016-12-24 00:00:00',26,NULL,100000,''),(24,'2016-12-24 00:00:00',26,NULL,300000,''),(25,'2016-12-24 00:00:00',26,NULL,500000,''),(26,'2016-12-24 00:00:00',29,NULL,994000,''),(27,'2016-12-24 00:00:00',1,NULL,500000,''),(28,'2016-12-24 00:00:00',3,NULL,10000,''),(29,'2016-12-24 00:00:00',3,NULL,10000,''),(30,'2016-12-24 00:00:00',3,NULL,10000,''),(31,'2016-12-24 00:00:00',NULL,3,6500,''),(32,'2016-12-24 00:00:00',NULL,3,193500,''),(33,'2016-12-24 00:00:00',NULL,1,20000,''),(34,'2016-12-24 00:00:00',NULL,1,10000,''),(35,'2016-12-24 00:00:00',NULL,1,10000,''),(36,'2016-12-24 00:00:00',NULL,1,10000,''),(37,'2016-12-24 00:00:00',NULL,1,10000,''),(38,'2016-12-24 00:00:00',NULL,1,10000,''),(39,'2016-12-24 00:00:00',NULL,1,1000,''),(40,'2016-12-24 00:00:00',NULL,1,10000,''),(41,'2017-01-06 00:00:00',NULL,1,419000,''),(42,'2017-01-07 00:00:00',30,NULL,90000,''),(43,'2017-02-25 00:00:00',2,NULL,1500000,''),(44,'2017-03-05 00:00:00',26,NULL,280000,''),(45,'2017-03-05 00:00:00',27,NULL,2800000,''),(46,'2017-03-05 12:06:47',28,NULL,1500000,''),(47,'2017-03-05 12:09:43',29,NULL,150000,'');
/*!40000 ALTER TABLE `cashflow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  `phone_no` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Tiara Futsal','078872783123','Bogor','rumah lotengs',''),(3,'Debest Hotel','Bogor','078872783123','rumah loteng',''),(4,'Joeang Hotel','Bogor','078872783123','rumah loteng',''),(5,'Rizen Kedaton','Bogor','078872783123','rumah loteng',''),(6,'Wisma Abdi','Bogor','078872783123','rumah loteng',''),(7,'SMESCO','Bogor','078872783123','rumah loteng',''),(8,'LPPAI','Bogor','078872783123','rumah loteng',''),(9,'Q-Mat','Bogor','078872783123','rumah loteng',''),(10,'Sentul 8 Hotel','bogor','078872783123','rumah loteng',''),(11,'Bumi Cikeas','bogor','078872783123','rumah loteng',''),(12,'BMKG','bogor','078872783123','rumah loteng',''),(13,'Niki Sae','bogor','078872783123','rumah loteng',''),(14,'Parahyangan','bogor','078872783123','rumah loteng',''),(15,'Santa Monica','bogor','078872783123','rumah loteng',''),(16,'Jambuluwuk','bogor','078872783123','rumah loteng',''),(17,'Camp Hulu Cai','Bogor','078872783123','',''),(18,'Bogor Nirwana','Bogor','078872783123','',''),(19,'Bintang Jadayat','Bogor','078872783123','',''),(20,'Baleza','Bogor','078872783123',' ',''),(21,'Lurus','Bogor','078872783123','',''),(22,'Aries Biru','Bogor','078872783123','',''),(23,'Arwana Safari','Bogor','078872783123','',''),(24,'Kartini Futsal','Bogor','078872783123','',''),(25,'Garbera','Bogor','078872783123','',''),(26,'Village','Bogor','078872783123','',''),(27,'Prima Resort','Bogor','078872783123','',''),(28,'Prima Resort Safari','Bogor','078872783123','',''),(29,'Grand Diara','Bogor','078872783123',' ',''),(30,'Ririn + Hayati','Bogor','078872783123','',''),(31,'Bogor Guest House','Bogor','078872783123','',''),(32,'Ritz Carlton','Bogor','078872783123','',''),(33,'Rizen Premiere','Bogor','078872783123','',''),(34,'The Rizen','Bogor','078872783123','',''),(35,'Prioritas','Bogor','078872783123','',''),(36,'Santiago Futsal','Bogor','078872783123','',''),(37,'Bale Arimbi','Bogor','078872783123','',''),(38,'Arga Mulya','Bogor','078872783123','',''),(39,'Gunung Geulis','Bogor','078872783123','',''),(40,'Bonarindo','Bogor','078872783123','',''),(41,'Hotel Bayak','Bogor','078872783123','',''),(42,'Engkus','Bogor','078872783123','',''),(43,'Baban Supir Tengki','Bogor','078872783123','',''),(44,'Emas','Bogor','078872783123','Muara Jaya',''),(45,'Mas Oying','Bogor','078872783123','',''),(46,'Didin','Bogor','078872783123','',''),(47,'Nusantara Pak Jaelani','Bogor','078872783123','',''),(48,'Pak Lilih','Lengis','078872783123','',''),(49,'Bidan Eti','Bogor','078872783123','',''),(50,'Warnet Pasir Muncang','Bogor','078872783123','Amanda RS',''),(51,'Agus Bagol','Caringin Lengis','078872783123','',''),(52,'Bu Enting Cikerud','Bogor','078872783123','Bp. Otang',''),(53,'Adiyaksa','Bogor','078872783123','',''),(54,'MG','Bogor','078872783123','',''),(55,'Watana Hotel','Bogor','078872783123','',''),(56,'Darmawanfak','Sentul','078872783123','Pajapa',''),(57,'Ajun','082822818','cijantung','ok',''),(58,'asd','s','asd','a','\0'),(59,'Pak alam','123123213','bogor','lalala','');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_price`
--

DROP TABLE IF EXISTS `customer_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_price` (
  `customer_price_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`customer_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_price`
--

LOCK TABLES `customer_price` WRITE;
/*!40000 ALTER TABLE `customer_price` DISABLE KEYS */;
INSERT INTO `customer_price` VALUES (1,1,3,28000),(2,3,3,27000),(3,4,3,30000),(4,4,6,14000),(5,5,3,27000),(6,5,6,14000),(7,6,3,28000),(8,7,3,29000),(9,7,5,28000),(10,8,3,28000),(11,9,3,27000),(12,10,5,27000),(13,11,3,28000),(14,12,3,28000),(15,13,3,27000),(16,14,5,28000),(17,53,7,18000),(18,53,3,28000),(19,54,5,27000),(20,54,7,18000),(21,54,1,12000),(22,55,3,28000),(23,56,3,28000);
/*!40000 ALTER TABLE `customer_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merk`
--

DROP TABLE IF EXISTS `merk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merk` (
  `merk_id` int(11) NOT NULL AUTO_INCREMENT,
  `merk_nama` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL,
  PRIMARY KEY (`merk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merk`
--

LOCK TABLES `merk` WRITE;
/*!40000 ALTER TABLE `merk` DISABLE KEYS */;
INSERT INTO `merk` VALUES (1,'Club','Air mineral galon',''),(2,'Pristine','Air mineral botol',''),(3,'Summit','Air mineral murah',''),(4,'Sumbit','Knock-off Summit','\0');
/*!40000 ALTER TABLE `merk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `total` float NOT NULL,
  `discount` float NOT NULL,
  `grand_total` float NOT NULL,
  `delivery_date` datetime DEFAULT NULL,
  `isdelivered` bit(1) DEFAULT NULL,
  `remarks` text,
  `iscredit` bit(1) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,'2017-01-07 00:00:00',1,0,165000,0,165000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(2,'2017-01-07 00:00:00',1,1,1500000,0,1500000,'0000-00-00 00:00:00','\0','','','2017-01-31 00:00:00'),(3,'2017-01-07 00:00:00',1,3,3000000,0,3000000,'0000-00-00 00:00:00','\0','','','2017-01-31 00:00:00'),(4,'2017-01-07 00:00:00',1,7,560000,0,560000,'0000-00-00 00:00:00','\0','','','2017-01-31 00:00:00'),(5,'2017-01-07 00:00:00',1,1,336000,0,336000,'0000-00-00 00:00:00','\0','','','2017-01-11 00:00:00'),(6,'2017-01-21 00:00:00',1,0,15000,0,15000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(7,'2017-01-21 00:00:00',1,0,60000,0,60000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(8,'2017-03-05 00:00:00',1,1,60000,0,60000,NULL,'\0','','',NULL),(9,'2017-03-05 00:00:00',1,9,30000,0,30000,NULL,'\0','','',NULL),(10,'2017-03-05 00:00:00',1,1,150000,0,150000,NULL,'\0','','',NULL),(11,'2017-03-05 00:00:00',1,1,30000,0,30000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(12,'2017-03-05 00:00:00',1,0,150000,0,150000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(13,'2017-03-05 00:00:00',1,7,675000,0,675000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(14,'2017-03-05 00:00:00',1,4,180000,0,180000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(15,'2017-03-05 00:00:00',1,5,280000,0,280000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(16,'2017-03-05 00:00:00',1,0,300000,0,300000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(17,'2017-03-05 00:00:00',1,0,180000,0,180000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(18,'2017-03-05 00:00:00',1,1,270000,0,270000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(19,'2017-03-05 00:00:00',1,0,280000,0,280000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(20,'2017-03-05 00:00:00',1,0,280000,0,280000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(21,'2017-03-05 00:00:00',1,0,270000,0,270000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(22,'2017-03-05 00:00:00',1,0,27000,0,27000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(23,'2017-03-05 00:00:00',1,0,27000,0,27000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(24,'2017-03-05 00:00:00',8,1,27000,0,27000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(25,'2017-03-05 00:00:00',8,1,54000,0,54000,'0000-00-00 00:00:00','\0','','','0000-00-00 00:00:00'),(26,'2017-03-05 00:00:00',8,4,280000,0,280000,'0000-00-00 00:00:00','\0','','\0','0000-00-00 00:00:00'),(27,'2017-03-05 00:00:00',8,7,2800000,0,2800000,'0000-00-00 00:00:00','\0','','\0','0000-00-00 00:00:00'),(28,'2017-03-05 12:06:47',8,7,1500000,0,1500000,'0000-00-00 00:00:00','\0','','\0','0000-00-00 00:00:00'),(29,'2017-03-05 12:09:43',8,3,150000,0,150000,'0000-00-00 00:00:00','\0','','\0','0000-00-00 00:00:00'),(30,'2017-03-05 12:12:18',8,12,1500000,0,1500000,'0000-00-00 00:00:00','\0','','','2017-03-24 00:00:00');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `order_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_price_id` int(11) NOT NULL,
  `customer_price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  PRIMARY KEY (`order_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (1,1,1,0,45000,3,135000),(2,1,2,0,120000,4,480000),(3,2,1,0,1500000,100,150000000),(4,3,2,0,3000000,100,300000000),(5,4,3,0,560000,20,11200000),(6,5,3,0,336000,12,4032000),(7,6,1,0,15000,1,15000),(8,7,1,0,60000,4,240000),(9,8,2,0,60000,2,120000),(10,9,1,0,30000,2,60000),(11,10,1,0,150000,10,1500000),(12,11,6,0,30000,2,60000),(13,12,23,0,150000,10,1500000),(14,13,5,0,675000,25,16875000),(15,14,7,0,180000,10,1800000),(16,15,3,0,280000,10,2800000),(17,16,2,0,300000,10,3000000),(18,17,2,0,180000,6,1080000),(19,18,5,0,270000,10,2700000),(20,19,3,0,280000,10,2800000),(21,20,3,0,280000,10,2800000),(22,21,5,0,270000,10,2700000),(23,22,5,0,27000,1,27000),(24,23,5,0,27000,1,27000),(25,24,5,0,27000,1,27000),(26,25,5,0,54000,2,108000),(27,26,3,0,280000,10,2800000),(28,27,3,0,2800000,100,280000000),(29,28,1,0,1500000,100,150000000),(30,29,1,0,150000,10,1500000),(31,30,1,0,1500000,100,150000000);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piutang`
--

DROP TABLE IF EXISTS `piutang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `piutang` (
  `piutang_id` int(11) NOT NULL AUTO_INCREMENT,
  `piutang_date` datetime DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  PRIMARY KEY (`piutang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piutang`
--

LOCK TABLES `piutang` WRITE;
/*!40000 ALTER TABLE `piutang` DISABLE KEYS */;
INSERT INTO `piutang` VALUES (1,'2016-12-16 00:00:00',1,26,1000000,1000000,0,'2016-12-19 00:00:00'),(2,'2016-12-17 12:32:01',1,28,20000,1060000,-60000,'2016-12-23 00:00:00'),(3,'2016-12-17 12:32:01',1,29,20000,1994000,-994000,'2016-12-23 00:00:00'),(4,'2017-00-06 00:00:00',4,30,90000,1090000,-90000,'2017-01-26 00:00:00'),(5,'2017-00-07 00:00:00',0,31,525000,0,525000,'0000-00-00 00:00:00'),(6,'2017-00-07 00:00:00',0,32,30000,0,30000,'0000-00-00 00:00:00'),(7,'2017-00-07 00:00:00',0,33,15000,0,15000,'0000-00-00 00:00:00'),(8,'2017-00-07 00:00:00',0,34,15000,0,15000,'0000-00-00 00:00:00'),(9,'2017-00-07 00:00:00',0,35,30000,0,30000,'0000-00-00 00:00:00'),(10,'2017-00-07 00:00:00',0,36,15000,0,15000,'0000-00-00 00:00:00'),(11,'2017-00-07 00:00:00',0,37,15000,0,15000,'0000-00-00 00:00:00'),(12,'2017-01-07 00:00:00',0,38,30000,0,30000,'0000-00-00 00:00:00'),(13,'2017-01-07 00:00:00',0,1,165000,0,165000,'0000-00-00 00:00:00'),(14,'2017-01-07 00:00:00',1,2,1500000,2500000,-1500000,'2017-01-31 00:00:00'),(15,'2017-01-07 00:00:00',3,3,3000000,0,3000000,'2017-01-31 00:00:00'),(16,'2017-01-07 00:00:00',7,4,560000,0,560000,'2017-01-31 00:00:00'),(17,'2017-01-07 00:00:00',1,5,336000,0,336000,'2017-01-11 00:00:00'),(18,'2017-01-21 00:00:00',0,6,15000,0,15000,'0000-00-00 00:00:00'),(19,'2017-01-21 00:00:00',0,7,60000,0,60000,'0000-00-00 00:00:00'),(20,'2017-03-05 00:00:00',1,8,60000,0,60000,NULL),(21,'2017-03-05 00:00:00',9,9,30000,0,30000,NULL),(22,'2017-03-05 00:00:00',1,10,150000,0,150000,NULL),(23,'2017-03-05 00:00:00',1,11,30000,0,30000,'0000-00-00 00:00:00'),(24,'2017-03-05 00:00:00',0,12,150000,0,150000,'0000-00-00 00:00:00'),(25,'2017-03-05 00:00:00',7,13,675000,0,675000,'0000-00-00 00:00:00'),(26,'2017-03-05 00:00:00',4,14,180000,0,180000,'0000-00-00 00:00:00'),(27,'2017-03-05 00:00:00',5,15,280000,0,280000,'0000-00-00 00:00:00'),(28,'2017-03-05 00:00:00',0,16,300000,0,300000,'0000-00-00 00:00:00'),(29,'2017-03-05 00:00:00',0,17,180000,0,180000,'0000-00-00 00:00:00'),(30,'2017-03-05 00:00:00',1,18,270000,0,270000,'0000-00-00 00:00:00'),(31,'2017-03-05 00:00:00',0,19,280000,0,280000,'0000-00-00 00:00:00'),(32,'2017-03-05 00:00:00',0,20,280000,0,280000,'0000-00-00 00:00:00'),(33,'2017-03-05 00:00:00',0,21,270000,0,270000,'0000-00-00 00:00:00'),(34,'2017-03-05 00:00:00',0,22,27000,0,27000,'0000-00-00 00:00:00'),(35,'2017-03-05 00:00:00',0,23,27000,0,27000,'0000-00-00 00:00:00'),(36,'2017-03-05 00:00:00',1,24,27000,0,27000,'0000-00-00 00:00:00'),(37,'2017-03-05 00:00:00',1,25,54000,0,54000,'0000-00-00 00:00:00'),(38,'2017-03-05 12:12:18',12,30,1500000,0,1500000,'2017-03-24 00:00:00');
/*!40000 ALTER TABLE `piutang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `merk_id` int(11) NOT NULL,
  `satuan_id` int(11) NOT NULL,
  `product_nama` varchar(100) NOT NULL,
  `default_price` int(11) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL,
  `stock` int(11) NOT NULL,
  `min_stock` int(11) NOT NULL,
  `supplier_price` int(11) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,1,'Galon Club',15000,'Galon Club','',1697,10,12000),(2,2,2,'Botol Pristine 400ml',30000,'Botol tutup hijau','',0,15,28000),(3,1,2,'Botol Club 600ml',28000,'Botol tanggung','',828,15,25000),(5,1,2,'Botol Club 330ml',27000,'Botol kecil','',0,15,24000),(6,3,2,'Cup Summit 240ml',15000,'Gelas plastik','',0,20,12000),(7,1,2,'Cup Club 240ml',18000,'Gelas plastik','',0,20,15000),(18,1,2,'Botol Club 1500ml',28000,'Botol besar','',0,10,24000),(19,2,2,'Pristine Cup 240ml',15000,'-','\0',0,10,17000),(20,1,1,'Galon Club',15000,'Galon Club','\0',50,10,12000),(21,1,1,'Galon Club',15000,'Galon Club','\0',50,10,12000),(22,1,1,'Galon Club',15000,'Galon Club','\0',50,10,12000),(23,2,1,'Pristine Cup 240ml',15000,'cup hijaua','',0,1,18000);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restock`
--

DROP TABLE IF EXISTS `restock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restock` (
  `restock_id` int(11) NOT NULL AUTO_INCREMENT,
  `restock_date` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `discount` int(11) DEFAULT NULL,
  `grand_total` int(11) DEFAULT NULL,
  `isdebt` bit(1) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  PRIMARY KEY (`restock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restock`
--

LOCK TABLES `restock` WRITE;
/*!40000 ALTER TABLE `restock` DISABLE KEYS */;
INSERT INTO `restock` VALUES (1,'2016-12-18 00:00:00',1,1,200000,0,200000,'','2016-12-22 00:00:00'),(2,'2016-12-18 00:00:00',1,1,200000,0,200000,'','2016-12-22 00:00:00'),(3,'2016-11-24 00:00:00',1,1,15000000,0,15000000,'','2016-12-24 00:00:00'),(4,'2016-11-24 00:00:00',1,1,15000000,0,15000000,'','2016-12-24 00:00:00'),(5,'2017-00-06 00:00:00',1,1,28000000,0,28000000,'','0000-00-00 00:00:00'),(6,'2017-00-21 00:00:00',1,3,600000,0,600000,'','0000-00-00 00:00:00'),(7,'2017-02-05 00:00:00',1,1,180000,0,180000,'','0000-00-00 00:00:00'),(8,'2017-02-05 00:00:00',1,1,300000,0,300000,'','0000-00-00 00:00:00'),(9,'2017-02-05 00:00:00',1,1,30000,0,30000,'','0000-00-00 00:00:00'),(10,'2017-02-05 00:00:00',1,1,150000,0,150000,'','0000-00-00 00:00:00'),(11,'2017-02-05 00:00:00',1,1,30000,0,30000,'','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `restock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restock_item`
--

DROP TABLE IF EXISTS `restock_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restock_item` (
  `restock_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `restock_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `subtotal` float NOT NULL,
  PRIMARY KEY (`restock_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restock_item`
--

LOCK TABLES `restock_item` WRITE;
/*!40000 ALTER TABLE `restock_item` DISABLE KEYS */;
INSERT INTO `restock_item` VALUES (1,1,1,12000,50,600000),(2,1,5,30000,50,15000000),(3,2,2,28000,100,2800000),(4,3,1,15000000,1000,15000000000),(5,4,1,15000000,1000,15000000000),(6,5,3,28000000,1000,28000000000),(7,6,2,600000,20,12000000),(8,7,7,180000,10,1800000),(9,8,2,300000,10,3000000),(10,9,6,30000,2,60000),(11,10,2,150000,5,750000),(12,11,2,30000,1,30000);
/*!40000 ALTER TABLE `restock_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satuan`
--

DROP TABLE IF EXISTS `satuan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `satuan` (
  `satuan_id` int(11) NOT NULL AUTO_INCREMENT,
  `satuan_nama` varchar(100) NOT NULL,
  `remarks` text NOT NULL,
  `isactive` bit(1) NOT NULL,
  PRIMARY KEY (`satuan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satuan`
--

LOCK TABLES `satuan` WRITE;
/*!40000 ALTER TABLE `satuan` DISABLE KEYS */;
INSERT INTO `satuan` VALUES (1,'Galon','Galon',''),(2,'Dus','Dus botol/gelas plastik',''),(3,'Galon','-','\0');
/*!40000 ALTER TABLE `satuan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `address` text,
  `phone_no` varchar(100) DEFAULT NULL,
  `remarks` text,
  `isactive` bit(1) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Supplier Club','Caringin','0251-823121','',''),(2,'Supplier Summit','Bogor','0251-8113241','',''),(3,'Supplier Pristine','0251-878761','Ciletuh','a',''),(4,'Supplier-n','121212','asd01030','-','\0');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tempsales`
--

DROP TABLE IF EXISTS `tempsales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tempsales` (
  `order_date` datetime DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tempsales`
--

LOCK TABLES `tempsales` WRITE;
/*!40000 ALTER TABLE `tempsales` DISABLE KEYS */;
/*!40000 ALTER TABLE `tempsales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL,
  `password` text NOT NULL,
  `user_level` int(11) NOT NULL,
  `isactive` bit(1) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (8,'administrator','admin',1,''),(11,'kasir','1',2,''),(12,'marketing','1',3,'');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utang`
--

DROP TABLE IF EXISTS `utang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utang` (
  `utang_id` int(11) NOT NULL AUTO_INCREMENT,
  `utang_date` datetime DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `restock_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `paid` int(11) DEFAULT NULL,
  `balance` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  PRIMARY KEY (`utang_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utang`
--

LOCK TABLES `utang` WRITE;
/*!40000 ALTER TABLE `utang` DISABLE KEYS */;
INSERT INTO `utang` VALUES (1,'2016-12-16 01:00:21',1,1,1000000,1000000,0,'2016-12-28 00:00:00'),(2,'2016-12-18 00:00:00',1,3,200000,200000,0,'2016-12-22 00:00:00'),(3,'2016-11-24 00:00:00',1,3,15000000,200000,0,'2016-12-24 00:00:00'),(4,'2016-11-24 00:00:00',1,4,15000000,0,15000000,'2016-12-24 00:00:00'),(5,'2017-00-06 00:00:00',1,5,28000000,0,28000000,'0000-00-00 00:00:00'),(6,'2017-00-21 00:00:00',3,6,600000,0,600000,'0000-00-00 00:00:00'),(7,'2017-02-05 00:00:00',1,7,180000,0,180000,'0000-00-00 00:00:00'),(8,'2017-02-05 00:00:00',1,8,300000,0,300000,'0000-00-00 00:00:00'),(9,'2017-02-05 00:00:00',1,9,30000,0,30000,'0000-00-00 00:00:00'),(10,'2017-02-05 00:00:00',1,10,150000,0,150000,'0000-00-00 00:00:00'),(11,'2017-02-05 00:00:00',1,11,30000,0,30000,'0000-00-00 00:00:00');
/*!40000 ALTER TABLE `utang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'simpadk1'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_api_checkapikey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_api_checkapikey`(
_apikey TEXT
,_userid INT
)
BEGIN

IF(SELECT COUNT(*) FROM apikey WHERE (apikey=_apikey OR user_id=_userid) AND NOW()>expired_date)>0
THEN DELETE FROM apikey where apikey=_apikey;
end if;
UPDATE apikey SET expired_date = DATE_ADD(NOW(), INTERVAL 2 HOUR) WHERE apikey=_apikey  OR user_id=_userid;
SELECT * FROM apikey WHERE apikey=_apikey  OR user_id=_userid;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_api_insertapikey` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_api_insertapikey`(
_user_id INT
,_apikey TEXT
,_user_level int
)
BEGIN
INSERT INTO apikey (user_id,apikey,user_level,expired_date)
VALUES(_user_id,_apikey,_user_level,DATE_ADD(NOW(), INTERVAL 2 HOUR));

SELECT * FROM apikey WHERE apikey=_apikey;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cf_viewcashflow` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cf_viewcashflow`(datefrom DATETIME, dateto DATETIME)
BEGIN

CREATE TABLE IF NOT EXISTS temp AS
(SELECT *, CASE WHEN restock_id is not null then 0-`value` else `value` end as absolutevalue
FROM simpadk1.cashflow WHERE cashflow_date BETWEEN datefrom AND dateto);

SELECT *,(select sum(absolutevalue) FROM temp) as Balance FROM temp;

DROP TABLE temp;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cp_deletecustomerprice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_deletecustomerprice`(IN `customer_price_id` INT, IN `delete_permanent` BIT)
BEGIN
    delete from customer_price where customer_price.customer_price_id=customer_price_id;
    select 'successfully delete record' as result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cp_savecustomerprice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_savecustomerprice`(IN `customer_price_id` INT, IN `customer_id` INT, IN `product_id` INT, IN `price` FLOAT)
BEGIN
if customer_price_id=0 then

	INSERT INTO `customer_price`
	(`customer_id`,
	`product_id`,
	`price`)
	VALUES(
	customer_id,
	product_id,
	price);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE `customer_price`
	SET
	`customer_id` = customer_id,
	`product_id` = product_id,
	`price` = price
	WHERE customer_price.`customer_price_id` = customer_price_id;


select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cp_viewcustomerpricelist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cp_viewcustomerpricelist`(IN `customer_id` INT, IN `product_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);


if row_ct>0 and customer_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(select cp.customer_price_id,cu.name
	,cu.address,cu.phone_no,cu.remarks,pr.product_nama,cp.price,pr.remarks AS price_remarks,mr.merk_nama,st.satuan_nama
	 from customer_price cp
	INNER JOIN customer cu ON cu.customer_id=cp.customer_id
	INNER JOIN product pr ON pr.product_id=cp.product_id
	INNER JOIN merk mr ON mr.merk_id=pr.merk_id
	INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	where cp.customer_id=customer_id and (cp.product_id=product_id OR product_id=0)
	);

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    SELECT total_row, tbl.* FROM tbl;
else
	select cp.customer_price_id,cu.name
	,cu.address,cu.phone_no,cu.remarks,pr.product_nama,cp.price,pr.remarks AS price_remarks,mr.merk_nama,st.satuan_nama
	 from customer_price cp
	INNER JOIN customer cu ON cu.customer_id=cp.customer_id
	INNER JOIN product pr ON pr.product_id=cp.product_id
	INNER JOIN merk mr ON mr.merk_id=pr.merk_id
	INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	where cp.customer_id=customer_id and (cp.product_id=product_id OR product_id=0);

end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cs_deletecustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_deletecustomer`(customer_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from customer where customer.customer_id=customer_id;
    select 'successfully delete record' as result;
else
	update customer cs set cs.isactive=0 where cs.customer_id=customer_id;
    select 'successfully deactivate record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cs_savecustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_savecustomer`(
customer_id INT
,name NVARCHAR(100)
,address TEXT
,phone_no NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if customer_id=0 then

	INSERT INTO `customer`
	(
	`name`,
	`address`,
	`phone_no`,
	`remarks`,
	`isactive`)
	VALUES
	(name
	,address
	,phone_no
	,remarks
	,1);
    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `customer`
SET
`name` = name,
`address` = address,
`phone_no` = phone_no,
`remarks` = remarks
WHERE customer.`customer_id` = customer_id;

select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cs_viewcustomerlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cs_viewcustomerlist`(IN `customer_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and customer_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT cus.`customer_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `customer` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.customer_id=customer_id or customer_id=0 OR customer_id is null)
	);

    SET total_row = (SELECT COUNT(*) FROM tbl);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else

    SELECT cus.`customer_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `customer` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.customer_id=customer_id or customer_id=0 OR customer_id is null);

end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ds_getgraphic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getgraphic`(IN `_type` nvarchar(20), IN `pointdate` DATETIME)
BEGIN

if _type='month' then
SELECT MONTH(oo.order_date) as order_date,SUM(oi.quantity) as Qty  FROM `order` oo
INNER JOIN order_item oi ON oo.order_id = oi.order_id
WHERE MONTH(oo.order_date)=MONTH(pointdate) AND YEAR(oo.order_date)=YEAR(pointdate)
GROUP BY CONCAT_WS(' ', DATE(oo.order_date), '00:00:00');
else
SELECT DATE_FORMAT(oo.order_date,'%d') order_date,SUM(oi.quantity) as Qty  FROM `order` oo
INNER JOIN order_item oi ON oo.order_id = oi.order_id
WHERE YEAR(oo.order_date)=YEAR(pointdate)
GROUP BY MONTH(oo.order_date);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ds_getminstock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getminstock`()
BEGIN
SELECT product_nama,mr.merk_nama,st.satuan_nama,stock,min_stock,pr.remarks FROM product pr
INNER JOIN merk mr ON pr.merk_id=mr.merk_id
INNER JOIN satuan st ON pr.satuan_id=st.satuan_id

 WHERE stock<=min_stock;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ds_getpendingdeliveredorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getpendingdeliveredorder`()
BEGIN
SELECT oo.order_id,oo.order_date,cs.name,cs.phone_no,grand_total,delivery_date,us.user_name,oo.remarks FROM `order` oo
INNER JOIN customer cs ON oo.customer_id=cs.customer_id
INNER JOIN `user` us ON oo.user_id=us.user_id
WHERE isdelivered=0;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ds_getsalescount` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ds_getsalescount`(
_pointdate DATETIME
)
BEGIN
if _pointdate is null then
	set _pointdate=CURDATE();
end if;
CREATE TABLE IF NOT EXISTS tempSales(order_date DATETIME,quantity INT);

DELETE FROM tempSales;

INSERT INTO tempSales
SELECT oo.order_date,oi.quantity  FROM `order` oo
INNER JOIN order_item oi ON oo.order_id = oi.order_id;

SELECT
(SELECT IFNULL(SUM(quantity),0) as qty FROM tempSales WHERE order_date between CONCAT_WS(' ', _pointdate, '00:00:00') and CONCAT_WS(' ', _pointdate, '23:59:59')) as DailySales,
(SELECT IFNULL(SUM(quantity),0) as qty FROM tempSales WHERE order_date between DATE_SUB(CONCAT_WS(' ', _pointdate, '00:00:00'), INTERVAL 7 DAY) and CONCAT_WS(' ', _pointdate, '23:59:59')) as WeeklySales,
(SELECT IFNULL(SUM(quantity),0) as qty FROM tempSales WHERE order_date between DATE_SUB(CONCAT_WS(' ', _pointdate, '00:00:00'), INTERVAL 1 MONTH) and CONCAT_WS(' ', _pointdate, '23:59:59')) as MonthlySales;

DELETE FROM tempSales;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_fk_reportfakturcustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fk_reportfakturcustomer`(order_id INT)
BEGIN
SELECT DATE_FORMAT(order_date, '%Y/%m/%d %H:%i:%s')
,o.order_id
,cs.name
,cs.address
,cs.phone_no
,mr.merk_nama
,pr.product_nama
,cs.address
,cs.phone_no
,oi.customer_price
,oi.quantity
,oi.subtotal
,o.grand_total
,us.user_name
FROM `order` as o
INNER JOIN order_item as oi ON o.order_id=oi.order_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `customer` as cs ON cs.customer_id=o.customer_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.order_id=order_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_fk_reportfaktursupplier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_fk_reportfaktursupplier`(restock_id INT)
BEGIN
SELECT restock_date
,o.restock_id
,cs.name
,cs.address
,cs.phone_no
,mr.merk_nama
,pr.product_nama
,pr.supplier_price
,oi.quantity
,oi.subtotal
,o.grand_total
,us.user_name
FROM `restock` as o
INNER JOIN restock_item as oi ON o.restock_id=oi.restock_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `supplier` as cs ON cs.supplier_id=o.supplier_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.restock_id=restock_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mr_deletemerk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_deletemerk`(merk_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from merk where merk.merk_id=merk_id;
    select 'successfully delete record' as result;
else
	update merk mr set mr.isactive=0 where mr.merk_id=merk_id;
    select 'successfully deactivate record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mr_savemerk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_savemerk`(
merk_id INT
,merk_nama NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if merk_id=0 then

	INSERT INTO `merk`
(`merk_nama`,
`remarks`,
`isactive`)
VALUES
(merk_nama,
remarks,
isactive);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `merk`
SET
`merk_nama` = merk_nama,
`remarks` = remarks,
`isactive` = isactive
WHERE merk.`merk_id` = merk_id;


select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_mr_viewmerklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_mr_viewmerklist`(merk_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);


if row_ct>0 and merk_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT mr.`merk_id`,
    mr.`merk_nama`,
    mr.`remarks`,
    mr.`isactive`
	FROM `merk` mr
	WHERE ((mr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (mr.merk_id=merk_id or merk_id=0 OR merk_id is null))
	;
    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT mr.`merk_id`,
    mr.`merk_nama`,
    mr.`remarks`,
    mr.`isactive`
	FROM `merk` mr
	WHERE ((mr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (mr.merk_id=merk_id or merk_id=0 OR merk_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_od_deleteorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_deleteorder`(order_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from `order` where `order`.order_id=order_id;
    select 'successfully delete record' as result;
else
	update `order` cs set cs.isactive=0 where cs.order_id=order_id;
    select 'successfully deactivate record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_od_reportorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_reportorder`(date_from DATETIME, date_to DATETIME, customer_id INT)
BEGIN

SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS 
(SELECT order_date
,o.order_id
,cs.name
,mr.merk_nama
,pr.product_nama
,oi.customer_price
,oi.quantity
,oi.subtotal
,o.grand_total
,CASE WHEN o.iscredit=1 THEN 'KREDIT' ELSE 'TUNAI' END as payment
,due_date 
FROM `order` as o
INNER JOIN order_item as oi ON o.order_id=oi.order_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `customer` as cs ON cs.customer_id=o.customer_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.order_date BETWEEN date_from AND date_to
AND (customer_id=o.customer_id OR customer_id=0 OR customer_id IS NULL)
);

SELECT 
DATE_FORMAT(order_date, '%d/%m/%Y %H:%i:%s') as order_date
,main.order_id
,main.name
,main.merk_nama
,main.product_nama
,FORMAT(main.customer_price, 0) as customer_price
,FORMAT(main.quantity,0) as quantity
,FORMAT(main.grand_total, 0) as grand_total
,main.payment
,DATE_FORMAT(due_date , '%d/%m/%Y') as due_date 
,totalquantity
,totalgrand_total
 FROM temp as main,
(SELECT  FORMAT(SUM(quantity),0) as totalquantity, FORMAT(SUM(grand_total),0) as totalgrand_total FROM temp) as total;
DROP TABLE temp;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_od_saveorder` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_saveorder`(
order_id INT,
order_date DATETIME,
user_id INT,
customer_id INT,
total FLOAT,
discount FLOAT,
grand_total FLOAT,
delivery_date DATETIME,
isdelivered BIT,
remarks TEXT,
due_date DATETIME,
iscredit BIT
)
BEGIN
DECLARE new_id INT DEFAULT 0;

if order_id=0 then

	INSERT INTO `order`
	(`order_date`,
	`user_id`,
	`customer_id`,
	`total`,
	`discount`,
	`grand_total`,
	`delivery_date`,
	`isdelivered`,
	`remarks`,
    `due_date`,
    `iscredit`)
	VALUES
	(NOW(),
	user_id,
	customer_id,
	total,
	discount,
	grand_total,
	delivery_date,
	isdelivered,
	remarks,
    due_date,
    iscredit);

	SET new_id = LAST_INSERT_ID();
	IF iscredit=1 THEN
		INSERT INTO `simpadk1`.`piutang`
		(`piutang_date`,
		`customer_id`,
		`order_id`,
		`value`,
		`paid`,
		`balance`,
		`due_date`)
		VALUES
		(NOW(),
		customer_id,
		new_id,
		grand_total,
		0,
		grand_total,
		due_date);
	ELSE
		INSERT INTO `cashflow`
		(`cashflow_date`,
		`order_id`,
		`restock_id`,
		`value`,
		`remarks`)
		VALUES
		(NOW(),
		new_id,
		NULL,
		grand_total,
		remarks);

	END IF;
    select 'successfully save record' as result, new_id  as insert_id;
else

	UPDATE `order`
	SET

	`total` = total,
	`discount` = discount,
	`grand_total` = grand_total,
	`delivery_date` = delivery_date,
	`isdelivered` = isdelivered,
	`remarks` = remarks,
    `due_date`=due_date
    #iscredit ga boleh diedit, nanti mesti ngehapus
	WHERE `order`.`order_id` = order_id;

	IF iscredit=1 THEN
		UPDATE `piutang` as t1,
		(SELECT paid FROM piutang WHERE `order_id`=order_id) as t2
		SET
		t1.`value` = grand_total,
		t1.`balance` = grand_total-t2.paid,
		t1.`due_date` = due_date
		WHERE t1.`order_id` = order_id;
	else

        UPDATE `cashflow`
		SET
		`value` = grand_total,
		`remarks` = remarks
		WHERE cashflow.`order_id` = order_id;

	END IF;

	select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_od_vieworderlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_od_vieworderlist`(IN `order_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and order_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT od.`order_id`,
    od.`order_date`,
    od.`user_id`,
    us.user_name,
    od.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    od.`total`,
    od.`discount`,
    od.`grand_total`,
    od.`delivery_date`,
    od.`isdelivered`,
    od.`remarks`,
    od.`due_date`,
    od.`iscredit`
FROM `order`od

	INNER JOIN user us ON us.user_id=od.user_id
    LEFT JOIN customer cs ON cs.customer_id=od.customer_id

	WHERE (od.order_id=order_id or order_id=0 OR order_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT od.`order_id`,
    od.`order_date`,
    od.`user_id`,
    us.user_name,
    od.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    od.`total`,
    od.`discount`,
    od.`grand_total`,
    od.`delivery_date`,
    od.`isdelivered`,
    od.`remarks`,
    od.`due_date`,
    od.`iscredit`
FROM `order`od
	INNER JOIN user us ON us.user_id=od.user_id
    LEFT JOIN customer cs ON cs.customer_id=od.customer_id

	WHERE (od.order_id=order_id or order_id=0 OR order_id is null)
;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_oi_deleteorderitem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_deleteorderitem`(order_item_id int)
BEGIN

    delete from `order_item` where `order_item`.order_item_id=order_item_id;
    select 'successfully delete record' as result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_oi_saveorderitem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_saveorderitem`(IN `order_item_id` INT, IN `order_id` INT, IN `product_id` INT, IN `customer_price_id` INT, IN `customer_price` FLOAT, IN `quantity` INT, IN `subtotal` FLOAT)
BEGIN
if order_item_id=0 then

	INSERT INTO `order_item`
(
`order_id`,
`product_id`,
`customer_price_id`,
`customer_price`,
`quantity`,
`subtotal`)
VALUES
(
order_id,
product_id,
customer_price_id,
customer_price,
quantity,
subtotal);

UPDATE product as t1,
(SELECT * FROM product WHERE product.`product_id`= product_id) as t2
SET t1.stock = t2.stock- quantity
WHERE t1.product_id = product_id;

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `order_item`
SET
`order_id` = order_id,
`product_id` = product_id,
`customer_price_id` = customer_price_id,
`customer_price` = customer_price,
`quantity` = quantity,
`subtotal` = subtotal
WHERE order_item.`order_item_id` = order_item_id;



select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_oi_vieworderitemlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_oi_vieworderitemlist`(IN `order_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and order_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT
	oi.`order_item_id`,
    oi.`order_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`customer_price_id`,
    oi.`customer_price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `order_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (oi.order_id=order_id or order_id=0 OR order_id is null))
	;

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT
	oi.`order_item_id`,
    oi.`order_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`customer_price_id`,
    oi.`customer_price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `order_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (oi.order_id=order_id or order_id=0 OR order_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pi_bayarpiutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_bayarpiutang`(IN bayar_date DATETIME,
IN `order_id` INT,
IN `value_bayar` INT,
IN `remarks` TEXT

)
BEGIN
	INSERT INTO `cashflow`
(`cashflow_date`,
`order_id`,
`value`,
`remarks`)
VALUES
(NOW(),
order_id,
value_bayar,
remarks);

UPDATE `piutang` as t1,
		(SELECT paid,`value` FROM piutang WHERE `order_id`=order_id) as t2
		SET
		t1.`paid` = t2.paid+value_bayar,
		t1.`balance` = t2.`value`-t2.paid-value_bayar
		WHERE t1.`order_id` = order_id;

select 'successfully insert record' as result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pi_deletepiutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_deletepiutang`(piutang_id int, delete_permanent bit)
BEGIN
    delete from piutang where piutang.piutang_id=piutang_id;
    select 'successfully delete record' as result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pi_reportpiutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_reportpiutang`(date_from DATETIME,date_to DATETIME,customer_id INT)
BEGIN

SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS 
(SELECT pi.`piutang_id`,
    pi.`piutang_date`,
    pi.`customer_id`,
    cs.name,
    pi.`order_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	
    FROM `piutang` pi
    INNER JOIN customer cs ON cs.customer_id=pi.customer_id
    WHERE (pi.`piutang_date`BETWEEN date_from AND date_to)
    AND (pi.`customer_id` =customer_id OR customer_id=0 OR customer_id IS NULL)
);
SELECT 
DATE_FORMAT(main.`piutang_date`, '%d/%m/%Y %H:%i:%s') as `piutang_date`,
    main.`customer_id`,
    main.name,
    main.`order_id`,
    FORMAT(main.`value`,0) as `value`,
    FORMAT(main.`paid`,0) as paid,
	  FORMAT(main.`balance`,0) as balance,
	  DATE_FORMAT(main.`due_date`, '%d/%m/%Y') as due_date,
      totalvalue,
      totalpaid,
      totalbalance
	
 FROM temp as main,
(SELECT  FORMAT(SUM(`value`),0) as totalvalue, FORMAT(SUM(paid),0) as totalpaid , FORMAT(SUM(paid),0) as totalbalance FROM temp) as total;
DROP TABLE temp;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pi_savepiutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_savepiutang`(IN `piutang_id` INT
, IN `piutang_date` DATETIME, IN `customer_id` INT, IN `order_id` INT, IN `value` INT, IN `paid` INT, IN `balance` INT, IN `due_date` DATETIME)
BEGIN
if piutang_id=0 then

	INSERT INTO `simpadk1`.`piutang`
(`piutang_id`,
`piutang_date`,
`customer_id`,
`order_id`,
`value`,
`paid`,
`balance`,
`due_date`)
VALUES
(piutang_id,
piutang_date,
customer_id,
order_id,
value,
paid,
balance,
due_date);


    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE `piutang`
SET
`value` = value,
`paid` = paid,
`balance` = balance,
`due_date` = due_date
WHERE piutang.`piutang_id` = piutang_id;



select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pi_viewpiutanglist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pi_viewpiutanglist`(IN `piutang_id` INT, IN `page_no` INT, IN `row_ct` INT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and piutang_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT pi.`piutang_id`,
    pi.`piutang_date`,
    pi.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`order_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `piutang` pi
    INNER JOIN customer cs ON cs.customer_id=pi.customer_id


	WHERE (pi.piutang_id=piutang_id or piutang_id=0 OR piutang_id is null)
    AND pi.`balance`>0);

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT pi.`piutang_id`,
    pi.`piutang_date`,
    pi.`customer_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`order_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `piutang` pi
    INNER JOIN customer cs ON cs.customer_id=pi.customer_id

	WHERE (pi.piutang_id=piutang_id or piutang_id=0 OR piutang_id is null)
    AND pi.`balance`>0;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pr_deleteproduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_deleteproduct`(product_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from product where product.product_id=product_id;
    select 'successfully delete record' as result;
else

	update product pr set pr.isactive=0 where pr.product_id=product_id;
    select 'successfully deactivate record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pr_reportstock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_reportstock`()
BEGIN
	SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i:%s') as pertoday ,merk_nama,product_nama,FORMAT(stock,0) as stock FROM product a
	INNER JOIN merk b ON a.merk_id=b.merk_id
	ORDER BY merk_nama,product_nama;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pr_saveproduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_saveproduct`(IN `product_id` INT, IN `merk_id` INT, IN `satuan_id` INT, IN `product_nama` TEXT, IN `remarks` TEXT, IN `isactive` BIT, IN `stock` INT, IN `min_stock` INT,IN `supplier_price` INT,IN `default_price` INT)
BEGIN
if product_id=0 then

	INSERT INTO `product`
	(`merk_id`,
	`satuan_id`,
	`product_nama`,
	`remarks`,
    `stock`,
    `min_stock`,
    `supplier_price`,
	`default_price`,
	`isactive`)
	VALUES
	(merk_id,
	satuan_id,
	product_nama,
	remarks,
	stock,
    min_stock,
    supplier_price,
    default_price,
    isactive);

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE`product`
	SET
	`merk_id` = merk_id,
	`satuan_id` = satuan_id,
	`product_nama` = product_nama,
	`remarks` = remarks,
	`stock`=stock,
    `min_stock`=min_stock,
    `supplier_price`=supplier_price,
    `default_price`=default_price,
	`isactive` = isactive
	WHERE product.`product_id` = product_id;


select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pr_viewproductlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_viewproductlist`(IN `product_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and product_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT pr.`product_id`,
    pr.`merk_id`,
    mr.merk_nama,
    pr.`satuan_id`,
    st.satuan_nama,
    pr.`product_nama`,
    pr.`remarks`,
    pr.`stock`,
    pr.`min_stock`,
	  pr.`isactive`,
	  pr.`default_price`,
      pr.supplier_price
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id

	WHERE ((pr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT pr.`product_id`,
    pr.`merk_id`,
    mr.merk_nama,
    pr.`satuan_id`,
    st.satuan_nama,
    pr.`product_nama`,
    pr.`remarks`,
	  pr.`stock`,
    pr.`min_stock`,
	  pr.`isactive`,
	  pr.`default_price`,
      pr.supplier_price
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id

	WHERE ((pr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_pr_viewproductlistcustomer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_pr_viewproductlistcustomer`(IN `product_id` INT,IN customer_id INT)
BEGIN

	SELECT pr.`product_id`,
    pr.`merk_id`,
    mr.merk_nama,
    pr.`satuan_id`,
    st.satuan_nama,
    pr.`product_nama`,
    pr.`remarks`,
    pr.`stock`,
    pr.`min_stock`,
	  pr.`isactive`,
	  pr.`default_price`,
      cp.price as customer_price
	FROM `product` pr
    INNER JOIN merk mr ON mr.merk_id=pr.merk_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	LEFT JOIN customer_price cp ON (cp.customer_id=customer_id AND cp.product_id = pr.product_id)
	WHERE ((pr.isactive=1))
	AND (pr.product_id=product_id or product_id=0 OR product_id is null);


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ri_deleterestockitem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ri_deleterestockitem`(restock_item_id int,permanent bit)
BEGIN

    delete from `restock_item` where `restock_item`.restock_item_id=restock_item_id;
    select 'successfully delete record' as result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ri_saverestockitem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ri_saverestockitem`(IN `restock_item_id` INT
, IN `restock_id` INT
, IN `product_id` INT
,  IN `price` FLOAT
, IN `quantity` INT
, IN `subtotal` FLOAT)
BEGIN
if restock_item_id=0 then

	INSERT INTO `restock_item`
(
`restock_id`,
`product_id`,
`price`,
`quantity`,
`subtotal`)
VALUES
(
restock_id,
product_id,
price,
quantity,
subtotal);
UPDATE product as t1,
(SELECT * FROM product WHERE product.`product_id`= product_id) as t2
SET t1.stock = t2.stock+ quantity
WHERE t1.product_id = product_id;

    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `restock_item`
SET
`restock_id` = restock_id,
`product_id` = product_id,
`price` = price,
`quantity` = quantity,
`subtotal` = subtotal
WHERE restock_item.`restock_item_id` = restock_item_id;



select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ri_viewrestockitemlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ri_viewrestockitemlist`(IN `restock_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and restock_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT
	oi.`restock_item_id`,
    oi.`restock_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `restock_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (oi.restock_id=restock_id or restock_id=0 OR restock_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT
	oi.`restock_item_id`,
    oi.`restock_id`,
    pr.product_nama,
    oi.`product_id`,
    st.satuan_nama,
    oi.`price`,
    oi.`quantity`,
    oi.`subtotal`
FROM `restock_item` oi
	INNER JOIN product pr ON pr.product_id=oi.product_id
    INNER JOIN satuan st ON st.satuan_id=pr.satuan_id
	WHERE  (oi.restock_id=restock_id or restock_id=0 OR restock_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rs_deleterestock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_deleterestock`(restock_id int, delete_permanent bit)
BEGIN

    delete from `restock` where `restock`.restock_id=restock_id;
    select 'successfully delete record' as result;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rs_reportrestock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_reportrestock`(date_from DATETIME, date_to DATETIME, supplier_id INT)
BEGIN

SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS 
(
SELECT restock_date
,o.restock_id
,cs.name
,mr.merk_nama
,pr.product_nama
,pr.supplier_price
,oi.quantity
,oi.subtotal
,o.grand_total
,CASE WHEN o.isdebt=1 THEN 'KREDIT' ELSE 'TUNAI' END as payment
,due_date 
FROM `restock` as o
INNER JOIN restock_item as oi ON o.restock_id=oi.restock_id
INNER JOIN `user` as us ON us.user_id=o.user_id
LEFT JOIN `supplier` as cs ON cs.supplier_id=o.supplier_id
INNER JOIN `product` as pr ON pr.product_id=oi.product_id
INNER JOIN `merk` as mr ON mr.merk_id=pr.merk_id
INNER JOIN `satuan` as st ON st.satuan_id=pr.satuan_id
WHERE o.restock_date BETWEEN date_from AND date_to
AND (supplier_id=o.supplier_id OR supplier_id=0 OR supplier_id IS NULL)
);

SELECT 
DATE_FORMAT(restock_date, '%d/%m/%Y %H:%i:%s') as restock_date
,main.restock_id
,main.name
,main.merk_nama
,main.product_nama
,FORMAT(main.supplier_price,0) as supplier_price
,FORMAT(main.quantity,0) as quantity
,FORMAT(main.grand_total,0) as grand_total
,main.payment
,DATE_FORMAT(due_date , '%d/%m/%Y') as due_date 
,totalquantity
,totalgrand_total
 FROM temp as main,
(SELECT  FORMAT(SUM(quantity),0) as totalquantity, FORMAT(SUM(grand_total),0) as totalgrand_total FROM temp) as total;
DROP TABLE temp;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rs_saverestock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_saverestock`(
restock_id INT,
restock_date DATETIME,
user_id INT,
supplier_id INT,
total FLOAT,
discount FLOAT,
grand_total FLOAT,
due_date DATETIME,
isdebt BIT
)
BEGIN
DECLARE new_id INT DEFAULT 0;

if restock_id=0 then

	INSERT INTO `restock`
	(`restock_date`,
	`user_id`,
	`supplier_id`,
	`total`,
	`discount`,
	`grand_total`,
    `due_date`,
    `isdebt`)
	VALUES
	(NOW(),
	user_id,
	supplier_id,
	total,
	discount,
	grand_total,
    due_date,
    isdebt);

	SET new_id = LAST_INSERT_ID();
	IF isdebt=1 THEN
		INSERT INTO `simpadk1`.`utang`
		(`utang_date`,
		`supplier_id`,
		`restock_id`,
		`value`,
		`paid`,
		`balance`,
		`due_date`)
		VALUES
		(NOW(),
		supplier_id,
		new_id,
		grand_total,
		0,
		grand_total,
		due_date);
	ELSE
		INSERT INTO `cashflow`
		(`cashflow_date`,
		`restock_id`,
		`value`,
		`remarks`)
		VALUES
		(restock_date,
		new_id,
		grand_total,
		remarks);

	END IF;
    select 'successfully save record' as result, new_id  as insert_id;
else

	UPDATE `restock`
	SET
	`restock_date` = NOW(),
	`user_id` = user_id,
	`supplier_id` = supplier_id,
	`total` = total,
	`discount` = discount,
	`grand_total` = grand_total,
    `due_date` = due_date,
    `isdebt` = isdebt
	WHERE `restock`.`restock_id` = restock_id;

	IF isdebt=1 THEN
		UPDATE `utang` as t1,
		(SELECT paid FROM piutang WHERE `restock_id`=restock_id) as t2
		SET
		t1.`value` = grand_total,
		t1.`balance` = grand_total-t2.paid,
		t1.`due_date` = due_date
		WHERE t1.`restock_id` = restock_id;
	else

        UPDATE `cashflow`
		SET
		`value` = grand_total,
		`remarks` = remarks
		WHERE cashflow.`restock_id` = restock_id;

	END IF;

	select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_rs_viewrestocklist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_rs_viewrestocklist`(IN `restock_id` INT, IN `page_no` INT, IN `row_ct` INT, IN `isactive` BIT)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and restock_id=0
then
CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT rs.`restock_id`,
    rs.`restock_date`,
    rs.`user_id`,
    us.user_name,
    rs.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    rs.`total`,
    rs.`discount`,
    rs.`grand_total`,
    rs.`due_date`,
    rs.`isdebt`
FROM `restock`rs

	INNER JOIN user us ON us.user_id=rs.user_id
    LEFT JOIN supplier cs ON cs.supplier_id=rs.supplier_id

	WHERE (rs.restock_id=restock_id or restock_id=0 OR restock_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT rs.`restock_id`,
    rs.`restock_date`,
    rs.`user_id`,
    us.user_name,
    rs.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    rs.`total`,
    rs.`discount`,
    rs.`grand_total`,
    rs.`due_date`,
    rs.`isdebt`
FROM `restock`rs
	INNER JOIN user us ON us.user_id=rs.user_id
    LEFT JOIN supplier cs ON cs.supplier_id=rs.supplier_id

	WHERE (rs.restock_id=restock_id or restock_id=0 OR restock_id is null)
;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_sp_deletesupplier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sp_deletesupplier`(supplier_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from supplier where supplier.supplier_id=supplier_id;
    select 'successfully delete record' as result;
else
	update supplier cs set cs.isactive=0 where cs.supplier_id=supplier_id;
    select 'successfully deactivate record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_sp_savesupplier` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sp_savesupplier`(
supplier_id INT
,name NVARCHAR(100)
,address TEXT
,phone_no NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if supplier_id=0 then
	INSERT INTO `supplier`
	(
	`name`,
	`address`,
	`phone_no`,
	`remarks`,
	`isactive`)
	VALUES
	(name
	,address
	,phone_no
	,remarks
	,1);
    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `supplier`
SET
`name` = name,
`address` = address,
`phone_no` = phone_no,
`remarks` = remarks
WHERE supplier.`supplier_id` = supplier_id;

select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_sp_viewsupplierlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_sp_viewsupplierlist`(supplier_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);
if row_ct>0 and supplier_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT cus.`supplier_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `supplier` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.supplier_id=supplier_id or supplier_id=0 OR supplier_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT cus.`supplier_id`,
		cus.`name`,
		cus.`address`,
		cus.`phone_no`,
		cus.`remarks`,
		cus.`isactive`
	FROM `supplier` cus
	WHERE ((cus.isactive=1 AND isactive=1) OR (isactive=0))
	AND (cus.supplier_id=supplier_id or supplier_id=0 OR supplier_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_st_deletesatuan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_deletesatuan`(satuan_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from satuan where satuan.satuan_id=satuan_id;
    select 'successfully delete record' as result;
else
	update satuan st set st.isactive=0 where st.satuan_id=satuan_id;
    select 'successfully deactivate record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_st_savesatuan` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_savesatuan`(
satuan_id INT
,satuan_nama NVARCHAR(100)
,remarks TEXT
,isactive BIT
)
BEGIN
if satuan_id=0 then

	INSERT INTO `satuan`
(`satuan_nama`,
`remarks`,
`isactive`)
VALUES
(satuan_nama,
remarks,
isactive);


    select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
UPDATE `satuan`
SET
`satuan_nama` = satuan_nama,
`remarks` = remarks,
`isactive` = isactive
WHERE satuan.`satuan_id` = satuan_id;



select 'successfully update record' as result;
end if;



END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_st_viewsatuanlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_st_viewsatuanlist`(satuan_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and satuan_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT st.`satuan_id`,
    st.`satuan_nama`,
    st.`remarks`,
    st.`isactive`
	FROM `satuan` st
	WHERE ((st.isactive=1 AND isactive=1) OR (isactive=0))
	AND (st.satuan_id=satuan_id or satuan_id=0 OR satuan_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT st.`satuan_id`,
    st.`satuan_nama`,
    st.`remarks`,
    st.`isactive`
	FROM `satuan` st
	WHERE ((st.isactive=1 AND isactive=1) OR (isactive=0))
	AND (st.satuan_id=satuan_id or satuan_id=0 OR satuan_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_us_changepassword` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_changepassword`(user_id int, old_password text,new_password text)
BEGIN
if((select count(us.password) from user us where us.user_id=user_id and us.password=old_password)>0)
then
update user set password=new_password where user.user_id=user_id;
select 1 as result;
else
select 0 as result;
end if;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_us_checklogin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_checklogin`(
_user_name NVARCHAR(20),
_password TEXT)
BEGIN
SELECT user_id,user_name,user_level FROM user WHERE user_name=_user_name AND password=_password;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_us_deleteuser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_deleteuser`(user_id int, delete_permanent bit)
BEGIN
if (delete_permanent=1) then

    delete from user where user.user_id=user_id;
    select 'successfully delete record' as result;

else
	update user us set us.isactive=0 where us.user_id=user_id;
    select 'successfully delete record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_us_saveuser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_saveuser`(
user_id INT,
user_name NVARCHAR(20),
password TEXT,
user_level INT,
isactive BIT
)
BEGIN
if user_id=0 then

	INSERT INTO `user`
	(`user_id`,
	`user_name`,
	`password`,
	`user_level`,
	`isactive`)
	VALUES
	(user_id,
	user_name,
	password,
	user_level,
	1);
	select 'successfully save record' as result, LAST_INSERT_ID() as insert_id;
else
	UPDATE `user`
	SET
    `user_name`=user_name,
	`user_level` = user_level
	WHERE user.`user_id` = user_id;

	select 'successfully update record' as result;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_us_viewuserlist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_us_viewuserlist`(user_id int, page_no int, row_ct int, isactive bit)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and user_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT usr.`user_id`,
    usr.`user_name`,
    usr.`password`,
    usr.`user_level`,
    usr.`isactive`
	FROM `user`usr
	WHERE ((usr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (usr.user_id=user_id or user_id=0 OR user_id is null));

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT usr.`user_id`,
    usr.`user_name`,
    usr.`password`,
    usr.`user_level`,
    usr.`isactive`
	FROM `user`usr
	WHERE ((usr.isactive=1 AND isactive=1) OR (isactive=0))
	AND (usr.user_id=user_id or user_id=0 OR user_id is null);
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ut_bayarutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_bayarutang`(IN bayar_date DATETIME,
IN `restock_id` INT,
IN `value_bayar` INT,
IN `remarks` TEXT

)
BEGIN
	INSERT INTO `cashflow`
(`cashflow_date`,
`restock_id`,
`value`,
`remarks`)
VALUES
(NOW(),
restock_id,
value_bayar,
remarks);

UPDATE `utang` as t1,
		(SELECT paid,`value` FROM utang WHERE utang.`restock_id`=restock_id) as t2
		SET
		t1.`paid` = t2.paid+value_bayar,
		t1.`balance` = t2.`value`-t2.paid-value_bayar
		WHERE t1.`restock_id` = restock_id;

select 'successfully insert record' as result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ut_deleteutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_deleteutang`(utang_id int, delete_permanent bit)
BEGIN
    delete from utang where utang.utang_id=utang_id;
    select 'successfully delete record' as result;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ut_reportutang` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_reportutang`(date_from DATETIME,date_to DATETIME,supplier_id INT)
BEGIN
SET date_to = CONCAT(DATE_FORMAT(date_to, '%Y-%m-%d'), ' 23:59:59');
CREATE TABLE IF NOT EXISTS temp AS 
(SELECT 
pi.`utang_id`,
    pi.`utang_date`,
    pi.`supplier_id`,
    cs.name,
    pi.`restock_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	
    FROM `utang` pi
    INNER JOIN supplier cs ON cs.supplier_id=pi.supplier_id
    WHERE (pi.`utang_date`BETWEEN date_from AND date_to)
    AND (pi.`supplier_id` =supplier_id OR supplier_id=0 OR supplier_id IS NULL)
);
SELECT 
utang_id,
    DATE_FORMAT(`utang_date`, '%d/%m/%Y %H:%i:%s') as utang_date,
    supplier_id,
    name,
    restock_id,
    FORMAT(`value`,0) as value,
    FORMAT(`paid`,0) as paid,
	  FORMAT(`balance`,0) as balance,
	  DATE_FORMAT(`due_date`, '%d/%m/%Y %H:%i:%s') as due_date,
	totalvalue,
    totalpaid,
    totalbalance
 FROM temp as main,
(SELECT  FORMAT(SUM(`value`),0) as totalvalue, FORMAT(SUM(paid),0) as totalpaid , FORMAT(SUM(paid),0) as totalbalance FROM temp) as total;
DROP TABLE temp;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ut_viewutanglist` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ut_viewutanglist`(IN `utang_id` INT, IN `page_no` INT, IN `row_ct` INT)
BEGIN
declare start_no int;
declare end_no int;

declare total_row INT;

if(page_no<1) then set page_no=1;end if;
set start_no = ((page_no-1)*row_ct);

if row_ct>0 and utang_id=0
then
	CREATE TEMPORARY TABLE IF NOT EXISTS tbl AS
	(SELECT pi.`utang_id`,
    pi.`utang_date`,
    pi.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`restock_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `utang` pi
    INNER JOIN supplier cs ON cs.supplier_id=pi.supplier_id


	WHERE (pi.utang_id=utang_id or utang_id=0 OR utang_id is null)
    AND pi.`balance`>0);

    SET total_row = (SELECT COUNT(*) FROM tbl LIMIT start_no,row_ct);
    SELECT CEILING(total_row/row_ct) as page_count, tbl.* FROM tbl LIMIT start_no,row_ct;
    DROP TABLE tbl;
else
	SELECT pi.`utang_id`,
    pi.`utang_date`,
    pi.`supplier_id`,
    cs.name,
    cs.address,
    cs.phone_no,
    pi.`restock_id`,
    pi.`value`,
    pi.`paid`,
	  pi.`balance`,
	  pi.`due_date`
	FROM `utang` pi
    INNER JOIN supplier cs ON cs.supplier_id=pi.supplier_id


	WHERE (pi.utang_id=utang_id or utang_id=0 OR utang_id is null)
    AND pi.`balance`>0;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-05 12:24:34
