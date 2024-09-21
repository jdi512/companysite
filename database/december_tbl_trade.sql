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
-- Table structure for table `tbl_trade`
--

DROP TABLE IF EXISTS `tbl_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_trade` (
  `tno` int NOT NULL AUTO_INCREMENT,
  `supplyer` varchar(100) NOT NULL,
  `producter` varchar(100) NOT NULL,
  `subAmount` int DEFAULT '0',
  `totalTax` int DEFAULT '0',
  `finalAmount` int DEFAULT '0',
  `regdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `receipt` char(1) DEFAULT '1' COMMENT '1 = 영수\\\\n0 = 청구',
  PRIMARY KEY (`tno`),
  KEY `fk_company_companyName_idx` (`supplyer`),
  CONSTRAINT `fk_company_companyName` FOREIGN KEY (`supplyer`) REFERENCES `tbl_company` (`companyName`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_trade`
--

LOCK TABLES `tbl_trade` WRITE;
/*!40000 ALTER TABLE `tbl_trade` DISABLE KEYS */;
INSERT INTO `tbl_trade` VALUES (9,'귀신회사','요괴회사',110000,11000,121000,'2023-12-27 15:06:51','1'),(10,'유령회사','요괴회사',60000,6000,66000,'2023-12-27 17:27:26','0'),(11,'귀신회사','요괴회사',180000,18000,198000,'2023-12-28 10:57:55','1'),(12,'유령회사','요괴회사',200000,20000,220000,'2023-12-28 14:49:42','0'),(13,'귀신회사','요괴회사',190000,19000,209000,'2023-12-28 14:51:47','1'),(14,'귀신회사','요괴회사',160000,16000,176000,'2023-12-28 14:58:10','0'),(15,'유령회사','요괴회사',230000,23000,253000,'2023-12-28 15:03:21','1'),(16,'유령회사','요괴회사',230000,23000,253000,'2023-12-28 15:04:35','0'),(17,'유령회사','요괴회사',270000,27000,297000,'2023-12-28 15:12:21','1'),(18,'유령회사','요괴회사',190000,19000,209000,'2023-12-28 16:31:38','1');
/*!40000 ALTER TABLE `tbl_trade` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-21 23:54:51
