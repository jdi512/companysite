-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: december
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_tradedetail`
--

DROP TABLE IF EXISTS `tbl_tradedetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tradedetail` (
  `seq` int NOT NULL AUTO_INCREMENT,
  `refTno` int NOT NULL,
  `tradeDate` datetime NOT NULL,
  `productCode` char(3) NOT NULL,
  `productName` varchar(100) DEFAULT NULL,
  `qty` int DEFAULT '0',
  `unitPrice` int DEFAULT '0',
  `assortment` varchar(1000) DEFAULT '',
  `remarks` varchar(1000) DEFAULT '',
  PRIMARY KEY (`seq`),
  KEY `fk_product_productCode_idx` (`productCode`),
  KEY `fk_trade_rno_idx` (`refTno`),
  CONSTRAINT `fk_product_productCode` FOREIGN KEY (`productCode`) REFERENCES `tbl_product` (`productCode`),
  CONSTRAINT `fk_trade_rno` FOREIGN KEY (`refTno`) REFERENCES `tbl_trade` (`tno`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tradedetail`
--

LOCK TABLES `tbl_tradedetail` WRITE;
/*!40000 ALTER TABLE `tbl_tradedetail` DISABLE KEYS */;
INSERT INTO `tbl_tradedetail` VALUES (5,9,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(6,9,'2023-12-27 00:00:00','P03','물품명3',1,30000,'',''),(7,9,'2023-12-27 00:00:00','P01','물품명1',2,10000,'',''),(10,11,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(11,11,'2023-12-27 00:00:00','P03','물품명3',4,30000,'',''),(12,10,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(13,12,'2023-12-26 00:00:00','P02','물품명2',3,20000,'',''),(14,12,'2023-12-26 00:00:00','P03','물품명3',4,30000,'',''),(15,12,'2023-12-26 00:00:00','P01','물품명1',2,10000,'',''),(16,13,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(17,13,'2023-12-27 00:00:00','P03','물품명3',3,30000,'',''),(18,13,'2023-12-27 00:00:00','P01','물품명1',4,10000,'',''),(22,15,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(23,15,'2023-12-27 00:00:00','P03','물품명3',4,30000,'',''),(27,17,'2023-12-27 00:00:00','P02','물품명2',4,20000,'',''),(28,17,'2023-12-27 00:00:00','P03','물품명3',5,30000,'',''),(29,17,'2023-12-27 00:00:00','P01','물품명1',4,10000,'',''),(30,16,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(31,16,'2023-12-27 00:00:00','P03','물품명3',4,30000,'',''),(32,16,'2023-12-27 00:00:00','P01','물품명1',5,10000,'',''),(33,14,'2023-12-27 00:00:00','P02','물품명2',3,20000,'',''),(34,14,'2023-12-27 00:00:00','P03','물품명3',2,30000,'',''),(35,14,'2023-12-27 00:00:00','P01','물품명1',4,10000,'',''),(36,18,'2023-12-27 00:00:00','P02','물품명2',4,20000,'',''),(37,18,'2023-12-27 00:00:00','P03','물품명3',2,30000,'',''),(38,18,'2023-12-27 00:00:00','P01','물품명1',5,10000,'','');
/*!40000 ALTER TABLE `tbl_tradedetail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-21 23:54:54
