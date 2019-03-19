-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: qr_pay
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

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
-- Table structure for table `tbl_transaction`
--

DROP TABLE IF EXISTS `tbl_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_transaction` (
  `trans_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `trans_amount` decimal(10,2) DEFAULT NULL,
  `trans_emitter` bigint(20) DEFAULT NULL,
  `trans_receiver` bigint(20) DEFAULT NULL,
  `trans_date` datetime DEFAULT NULL,
  `trans_type` int(11) DEFAULT NULL,
  `trans_description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `trans_emitter` (`trans_emitter`,`trans_receiver`),
  KEY `trans_receiver` (`trans_receiver`),
  CONSTRAINT `tbl_transaction_ibfk_1` FOREIGN KEY (`trans_emitter`) REFERENCES `tbl_user` (`user_id`) ON UPDATE CASCADE,
  CONSTRAINT `tbl_transaction_ibfk_2` FOREIGN KEY (`trans_receiver`) REFERENCES `tbl_user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_transaction`
--

LOCK TABLES `tbl_transaction` WRITE;
/*!40000 ALTER TABLE `tbl_transaction` DISABLE KEYS */;
INSERT INTO `tbl_transaction` VALUES (1,320000.00,1,2,'2017-09-04 13:11:20',1,NULL),(2,124000.00,2,1,'2017-09-04 13:13:18',1,NULL),(3,96000.00,2,1,'2017-09-04 15:32:43',1,NULL),(4,20000.00,2,1,'2017-09-04 15:34:06',1,NULL),(5,5000.00,2,1,'2017-09-04 15:36:32',1,NULL),(6,1250.00,2,1,'2017-09-04 15:40:41',1,NULL),(7,1250.00,2,1,'2017-09-04 15:40:41',1,NULL),(8,3450.00,2,1,'2017-09-04 15:42:44',1,NULL),(9,7000.00,2,1,'2017-09-05 13:24:02',1,NULL),(10,1000.00,1,2,'2017-09-05 13:27:17',1,NULL),(11,500.00,1,2,'2017-09-05 13:34:05',1,NULL),(12,1200.00,2,1,'2017-09-05 13:35:38',1,NULL),(13,3500.00,2,1,'2017-09-05 13:37:30',1,NULL),(14,12000.00,2,1,'2017-09-05 13:56:10',1,NULL),(15,1500.00,2,1,'2017-09-05 13:56:58',1,NULL),(16,12500.00,1,2,'2017-09-05 13:57:58',1,NULL),(17,1200.00,2,1,'2017-09-06 14:06:02',1,NULL),(18,3000.00,1,2,'2017-09-06 14:14:45',1,NULL),(19,12500.00,1,11,'2017-09-12 11:57:50',1,NULL),(20,1500.00,11,1,'2017-09-12 11:58:45',1,NULL),(21,12000.00,1,11,'2017-09-13 11:44:42',1,NULL),(22,12000.00,11,1,'2017-09-13 11:45:08',1,NULL);
/*!40000 ALTER TABLE `tbl_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(160) DEFAULT NULL,
  `user_password` varchar(160) DEFAULT NULL,
  `user_fb_id` varchar(30) DEFAULT NULL,
  `user_email` varchar(60) DEFAULT NULL,
  `user_phone` varchar(15) DEFAULT NULL,
  `app_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (1,'fano','pbkdf2:sha256:50000$Xqff1AJ6$9ed7c964def737c749b8d353a78115a3a3a03d2a3f2cd6ac31b612b901d4012d','xTwxijqeMIZMiWNt4qXWPmzJSpq1','tsmakalagy@yahoo.fr','+261338183056','fYyYUNulV94:APA91bG31HxcgB6M8ritqWTrP--b5AVcSU68avzy01MGbRLhHZWo5_JCJWxoNIscoblBB3zgqdnl6VAFY537mhvvFDEY8Vz4Hby3MLilH8RRIzPLICkTjRyQ9dRYrwajCQA4-GFIbH0S'),(2,'mytester','pbkdf2:sha256:50000$kinbI8be$2281622a39891112dbd12e2f900c8affe7947bdda7ebe577363715d745585a84','AmdM9Sjks7OT7qa9JTyVGRQyiTd2','testing@google.com',NULL,'dS0TE2YxeQ8:APA91bGTjHDXi2gJwhInVJY6fOuW9xaisb_7Qv9M4AV-QWGuIumM1M_DHD0_ORa0WwqZ0LU1J6xSB_InyZTtddQpyxg2BxV-IuxQFPY-M14m3Ebn_KbEYDbduCJSJcGmSQIgulolvw4Z'),(3,'rakoto','pbkdf2:sha256:50000$WxQ0SLzm$f286349aa3a67ec2db2cef5c6a9a50bf9ba48ae03d24c5ebacc17ef3000106b7','tYs1unmNNOOEICrVANi6A2uLOX42','rakoto@qrpay.com',NULL,NULL),(4,'randria','pbkdf2:sha256:50000$RaxaGgQr$257f9ed690bbd16a7ed5ea25cc7b774dff5379bb811ad2a3b7eeb6d4b48d2647','CVpoOKCbr9TTonP6CJpNVdgdcf62','randria@hotmail.com',NULL,'fYyYUNulV94:APA91bG31HxcgB6M8ritqWTrP--b5AVcSU68avzy01MGbRLhHZWo5_JCJWxoNIscoblBB3zgqdnl6VAFY537mhvvFDEY8Vz4Hby3MLilH8RRIzPLICkTjRyQ9dRYrwajCQA4-GFIbH0S'),(5,'adrien','pbkdf2:sha256:50000$dISVUf0J$a7f44a11e2e6f9d85b7e8139685d755fdbf45ba6424caf6e17b3277064dcfa47','MuvMuNlFsfbbNclWpBRlEkJWL973','adrien@yahoo.com',NULL,NULL),(6,'jean','pbkdf2:sha256:50000$Ge0aNZPp$b0f1cc74a52557acf66501638cbe97253f5e03bf5b6d64c245303ee7a61d90cc','zwkdHbFvPvYFMjs2LsnD0jx4X2J3','randria@qrpay.com',NULL,NULL),(11,'batoto','pbkdf2:sha256:50000$BLIDj01D$2f333e417ee760a4ede32a31f5d767f3425653234932696407eeab7559a6f776','7uVaFTSwCuNOhfu4mWWQFlFR4ut2','batoto@hotmail.com','+261346449569','dS0TE2YxeQ8:APA91bGTjHDXi2gJwhInVJY6fOuW9xaisb_7Qv9M4AV-QWGuIumM1M_DHD0_ORa0WwqZ0LU1J6xSB_InyZTtddQpyxg2BxV-IuxQFPY-M14m3Ebn_KbEYDbduCJSJcGmSQIgulolvw4Z');
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'qr_pay'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_createTransaction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createTransaction`(
   IN p_amount DECIMAL(10, 2),
   IN p_emitter BIGINT,
   IN p_receiver BIGINT,
   IN p_type INT
)
BEGIN
     insert into tbl_transaction
        (
            trans_amount,trans_emitter,trans_receiver,trans_date,trans_type
        )
        values
        (
            p_amount,p_emitter,p_receiver,NOW(),p_type
        );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_createUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUser`(
    IN p_name VARCHAR(160),
    IN p_password VARCHAR(160)
)
BEGIN
    if ( select exists (select 1 from tbl_user where user_name = p_name) ) THEN
     
        select 'Name Exists !!';
     
    ELSE
     
        insert into tbl_user
        (
            user_name,
            user_password
        )
        values
        (
            p_name,
            p_password
        );
     
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_createUserEmail` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUserEmail`(
   IN p_name VARCHAR(160),
   IN p_email VARCHAR(60),
   IN p_password VARCHAR(160),
   IN p_fb_id VARCHAR(30),
   IN p_app_token VARCHAR(255)
)
BEGIN
     insert into tbl_user
        (
            user_name, user_password, user_fb_id, user_email, app_token
        )
        values
        (
            p_name, p_password,p_fb_id,p_email, p_app_token
        );
     select LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_createUserPhone` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_createUserPhone`(
   IN p_name VARCHAR(160),
   IN p_email VARCHAR(60),
   IN p_phone VARCHAR(15),
   IN p_password VARCHAR(160),
   IN p_fb_id VARCHAR(30),
   IN p_app_token VARCHAR(255)
)
BEGIN
     insert into tbl_user
        (
            user_name, user_password, user_fb_id, user_email, user_phone, app_token
        )
        values
        (
            p_name, p_password,p_fb_id,p_email, p_phone, p_app_token
        );
     select LAST_INSERT_ID();
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getAllTransactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllTransactions`()
BEGIN
     SELECT tbl_tr.trans_id, tbl_tr.trans_amount, tbl_u.user_name as trans_emitter, tbl_t.user_name as trans_receiver, tbl_tr.trans_date, tbl_tr.trans_type, tbl_tr.trans_description
     FROM tbl_transaction tbl_tr
     LEFT JOIN tbl_user tbl_u ON tbl_tr.trans_emitter = tbl_u.user_id
     LEFT JOIN tbl_user tbl_t ON tbl_tr.trans_receiver = tbl_t.user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getAllTransactionsByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllTransactionsByUser`(IN p_id BIGINT)
BEGIN
     SELECT tbl_tr.trans_id, tbl_tr.trans_amount, tbl_u.user_name as trans_emitter, tbl_t.user_name as trans_receiver, tbl_tr.trans_date, tbl_tr.trans_type, tbl_tr.trans_description
     FROM tbl_transaction tbl_tr
     LEFT JOIN tbl_user tbl_u ON tbl_tr.trans_emitter = tbl_u.user_id
     LEFT JOIN tbl_user tbl_t ON tbl_tr.trans_receiver = tbl_t.user_id
     WHERE tbl_tr.trans_emitter = p_id OR tbl_tr.trans_receiver = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getAllUsers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllUsers`()
BEGIN
     SELECT * FROM tbl_user;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getBalanceByUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getBalanceByUser`(IN p_id BIGINT)
BEGIN
DECLARE total_received DECIMAL(10,2);
DECLARE total_sent DECIMAL(10,2);
    SELECT SUM(tbl_tr.trans_amount) INTO total_received FROM tbl_transaction tbl_tr WHERE tbl_tr.trans_receiver=p_id;
    SELECT SUM(tbl_tr.trans_amount) INTO total_sent FROM tbl_transaction tbl_tr WHERE tbl_tr.trans_emitter=p_id;
    SELECT SUM(total_received) - IFNULL(SUM(total_sent), 0);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getUserAppToken` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserAppToken`(
   IN p_user_id BIGINT
)
BEGIN
    SELECT app_token, user_name FROM tbl_user WHERE user_id=p_user_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getUserByEmailAndUID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserByEmailAndUID`(
   IN p_email VARCHAR(60),
   IN p_fb_id VARCHAR(30),
   IN p_app_token VARCHAR(255)
)
BEGIN
    SET @update_id := 0;
UPDATE tbl_user SET app_token = p_app_token, user_id = (SELECT @update_id := user_id)
WHERE user_email=p_email AND user_fb_id=p_fb_id LIMIT 1; 
SELECT @update_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getUserById` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserById`(IN p_id BIGINT)
BEGIN
     SELECT * FROM tbl_user WHERE tbl_user.user_id = p_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_getUserByPhoneAndUID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserByPhoneAndUID`(
   IN p_phone VARCHAR(15),
   IN p_fb_id VARCHAR(30),
   IN p_app_token VARCHAR(255)
)
BEGIN
    SET @update_id := 0;
    SET @user_email:= "";
UPDATE tbl_user SET app_token = p_app_token, user_id = (SELECT @update_id := user_id), user_email = (SELECT @user_email := user_email)
WHERE user_phone=p_phone AND user_fb_id=p_fb_id LIMIT 1; 
SELECT @update_id, @user_email;
END ;;
DELIMITER ;

/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_updateTableTrans` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_updateTableTrans`(
IN p_password VARCHAR(160),
IN p_amount DECIMAL(10, 2),
    IN p_emitter BIGINT,
    IN p_receiver BIGINT,
    IN p_type INT,
    OUT result INTEGER
)
BEGIN       
        INSERT INTO tbl_transaction (
            trans_amount, trans_emitter, trans_receiver, trans_date, trans_type
        )
        SELECT p_amount AS trans_amount,
        user_id AS trans_emitter,
        p_receiver AS trans_receiver,
        NOW() AS trans_date,
        p_type AS trans_type
        FROM tbl_user
        WHERE user_id = p_emitter
        AND user_password = p_password;

        SELECT ROW_COUNT() INTO result;
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_validateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validateUser`(
IN p_id BIGINT,
IN p_password VARCHAR(160)
)
BEGIN
    select * from tbl_user where user_id = p_id and user_password = p_password;
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

-- Dump completed on 2019-03-16  5:42:00
