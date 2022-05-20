-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: testing
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `idorders` int NOT NULL AUTO_INCREMENT,
  `idcustomer` int NOT NULL,
  `carw` int NOT NULL,
  `carl` int NOT NULL,
  `roof` int NOT NULL,
  `shedw` int NOT NULL,
  `shedl` int NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Started',
  PRIMARY KEY (`idorders`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,510,630,2,570,300,'Færdigt'),(2,1,600,780,2,510,210,'Færdigt');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paycard`
--

DROP TABLE IF EXISTS `paycard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paycard` (
  `idcard` int NOT NULL,
  `cardnr` varchar(45) NOT NULL,
  `expmonth` int NOT NULL,
  `expyear` int NOT NULL,
  `cvc` int NOT NULL,
  PRIMARY KEY (`idcard`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paycard`
--

LOCK TABLES `paycard` WRITE;
/*!40000 ALTER TABLE `paycard` DISABLE KEYS */;
INSERT INTO `paycard` VALUES (1,'4571346123900182',8,93,545);
/*!40000 ALTER TABLE `paycard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rt`
--

DROP TABLE IF EXISTS `rt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rt` (
  `idrt` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `length` int NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`idrt`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rt`
--

LOCK TABLES `rt` WRITE;
/*!40000 ALTER TABLE `rt` DISABLE KEYS */;
INSERT INTO `rt` VALUES (1,'tree','25x200 mm. trykimp. Brædt',360,165.39),(2,'tree','25x200 mm. trykimp. Brædt',540,248.08),(3,'tree','25x125 mm. trykimp. Brædt',360,71.79),(4,'tree','25x125 mm. trykimp. Brædt',540,107.71),(5,'tree','38x73 mm. Lægte ubh.',420,75.39),(6,'tree','45x95 mm. Reglar ub.',270,61.39),(7,'tree','45x95 mm. Reglar ub.',240,53.98),(8,'tree','45x195 mm. spærtræ ubh.',600,386.94),(9,'tree','45x195 mm. spærtræ ubh.',480,280.8),(10,'tree','97x97 mm. trykimp. stolpe',300,155.55),(11,'tree','19x100 mm. trykimp. Brædt',210,23),(12,'tree','19x100 mm. trykimp. Brædt',540,59.13),(13,'tree','19x100 mm. trykimp. Brædt',360,39.43),(14,'roof','Plastmo Ecolite blåtonet',600,289.75),(15,'roof','Plastmo Ecolite blåtonet',360,174.75);
/*!40000 ALTER TABLE `rt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rtpiecelist`
--

DROP TABLE IF EXISTS `rtpiecelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rtpiecelist` (
  `rtpiecelistid` int NOT NULL AUTO_INCREMENT,
  `orderid` int NOT NULL,
  `rtid` int NOT NULL,
  `amount` int NOT NULL,
  `description` varchar(75) NOT NULL,
  PRIMARY KEY (`rtpiecelistid`)
) ENGINE=InnoDB AUTO_INCREMENT=428 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rtpiecelist`
--

LOCK TABLES `rtpiecelist` WRITE;
/*!40000 ALTER TABLE `rtpiecelist` DISABLE KEYS */;
INSERT INTO `rtpiecelist` VALUES (378,1,2,2,'understernbrædder til for & bag ende'),(379,1,1,4,'understernbrædder til siderne'),(380,1,4,1,'oversternbrædder til forenden'),(381,1,3,4,'oversternbrædder til siderne'),(382,1,5,1,'til z på bagside af dør'),(383,1,6,12,'løsholter til skur gavle'),(384,1,7,6,'løsholter til skur gavle'),(385,1,7,8,'løsholter til skur sider'),(386,1,8,1,'Remme i sider, sadles ned i stopler (skur del, deles)'),(387,1,11,200,'til beklædning af skur 1 på 2'),(388,1,9,2,'Remme i sider, sadles ned i stopler'),(389,1,8,12,'Spær, monteres på rem'),(390,1,10,11,'Stolper nedgraves 90 cm. i jord'),(391,1,13,4,'vandbrædt på stern i sider'),(392,1,12,1,'vandbrædt på stern i forende'),(393,1,14,8,'tagplader monteres på spær'),(394,2,1,4,'understernbrædder til for & bag ende'),(395,2,2,2,'understernbrædder til siderne'),(396,2,1,2,'understernbrædder til siderne'),(397,2,3,2,'oversternbrædder til forenden'),(398,2,4,2,'oversternbrædder til siderne'),(399,2,3,2,'oversternbrædder til siderne'),(400,2,5,1,'til z på bagside af dør'),(401,2,6,6,'løsholter til skur gavle'),(402,2,7,6,'løsholter til skur gavle'),(403,2,7,4,'løsholter til skur sider'),(404,2,9,1,'Remme i sider, sadles ned i stopler (skur del, deles)'),(405,2,11,200,'til beklædning af skur 1 på 2'),(406,2,8,2,'Remme i sider, sadles ned i stopler'),(407,2,8,15,'Spær, monteres på rem'),(408,2,10,11,'Stolper nedgraves 90 cm. i jord'),(409,2,12,2,'vandbrædt på stern i sider'),(410,2,13,2,'vandbrædt på stern i sider'),(411,2,13,2,'vandbrædt på stern i forende'),(412,2,14,10,'tagplader monteres på spær');
/*!40000 ALTER TABLE `rtpiecelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sf`
--

DROP TABLE IF EXISTS `sf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sf` (
  `idsf` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `unit` varchar(45) NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`idsf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sf`
--

LOCK TABLES `sf` WRITE;
/*!40000 ALTER TABLE `sf` DISABLE KEYS */;
INSERT INTO `sf` VALUES (1,'skrue','plastmo bundskruer 200 stk.','pakke',229),(2,'beslag','hulbånd 1x20 mm. 10 mtr.','rulle',109),(3,'beslag','universal 190 mm. højre','stk',21.2),(4,'beslag','universal 190 mm. venstre','stk',21.2),(5,'skrue','4,5x60 mm. skruer 200 stk.','pakke',195),(6,'skrue','4,0x50 mm. beslagskruer 250 stk.','pakke',169),(7,'skrue','bræddebolt 10x120 mm.','stk',18.5),(8,'beslag','firkantskiver 40x40x11 mm.','stk',124),(9,'skrue','4,5x70 mm. Skruer 400 stk.','pakke',169.34),(10,'skrue','4,5x50 mm. Skruer 300 stk.','pakke',84.63),(11,'beslag','stalddørsgreb 50x75','sæt',123),(12,'beslag','t hængsel 390 mm.','stk',79.95),(13,'beslag','vinkelbeslag 35','stk',1.95);
/*!40000 ALTER TABLE `sf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sfpiecelist`
--

DROP TABLE IF EXISTS `sfpiecelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sfpiecelist` (
  `sfpiecelistid` int NOT NULL AUTO_INCREMENT,
  `orderid` int NOT NULL,
  `sfid` int NOT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`sfpiecelistid`)
) ENGINE=InnoDB AUTO_INCREMENT=326 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sfpiecelist`
--

LOCK TABLES `sfpiecelist` WRITE;
/*!40000 ALTER TABLE `sfpiecelist` DISABLE KEYS */;
INSERT INTO `sfpiecelist` VALUES (287,1,1,3),(288,1,2,2),(289,1,3,11),(290,1,4,11),(291,1,5,1),(292,1,6,3),(293,1,7,13),(294,1,8,9),(295,1,9,2),(296,1,10,2),(297,1,11,1),(298,1,12,2),(299,1,13,22),(300,2,1,3),(301,2,2,2),(302,2,3,15),(303,2,4,15),(304,2,5,1),(305,2,6,3),(306,2,7,18),(307,2,8,12),(308,2,9,2),(309,2,10,2),(310,2,11,1),(311,2,12,2),(312,2,13,32);
/*!40000 ALTER TABLE `sfpiecelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `iduser` int NOT NULL,
  `mail` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `idcard` int DEFAULT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (0,'ad@mail.dk','1234','Troels','52679201',NULL,'admin'),(1,'ku@live.dk','4321','Mia','45823909',1,'user');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-20 10:25:57
