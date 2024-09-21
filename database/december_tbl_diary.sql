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
-- Table structure for table `tbl_diary`
--

DROP TABLE IF EXISTS `tbl_diary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_diary` (
  `dno` int NOT NULL AUTO_INCREMENT,
  `groupid` varchar(45) DEFAULT NULL,
  `title` text NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `allDay` char(1) DEFAULT '1',
  `writer` varchar(50) NOT NULL,
  PRIMARY KEY (`dno`),
  KEY `fk_diary_member_idx` (`writer`),
  CONSTRAINT `fk_diary_member` FOREIGN KEY (`writer`) REFERENCES `tbl_member` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_diary`
--

LOCK TABLES `tbl_diary` WRITE;
/*!40000 ALTER TABLE `tbl_diary` DISABLE KEYS */;
INSERT INTO `tbl_diary` VALUES (1,'','수료식','2023-12-29 00:00:00','2023-12-29 00:00:00','','1','admin'),(2,NULL,'디자인반수로','2023-12-20 09:00:00','2023-12-22 09:00:00','','1','admin'),(28,NULL,'화요일','2023-12-13 03:00:00','2023-12-14 03:00:00','','1','admin'),(29,NULL,'수요일','2023-12-13 09:00:00','2023-12-14 09:00:00','','1','admin'),(30,NULL,'목요일','2023-12-15 06:00:00','2023-12-16 06:00:00','','1','admin'),(32,NULL,'1','2023-12-01 15:44:00','2023-12-02 17:08:00','','1','admin'),(33,NULL,'6','2023-12-06 18:00:00','2023-12-07 18:00:00','','1','admin'),(34,NULL,'7-1','2023-12-07 14:02:00','2023-12-08 16:04:00','','1','admin'),(35,NULL,'파이썬','2023-12-12 09:00:00','2023-12-13 17:41:00','','1','admin'),(36,NULL,'8','2023-12-08 09:00:00','2023-12-09 11:01:00','','1','admin');
/*!40000 ALTER TABLE `tbl_diary` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-21 23:54:52
