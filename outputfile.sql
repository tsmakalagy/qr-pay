-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: qr_pay
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_transaction`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_transaction` (
  `trans_id` bigint(20) NOT NULL,
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
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tbl_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_user` (
  `user_id` bigint(20) NOT NULL,
  `user_name` varchar(160) DEFAULT NULL,
  `user_password` varchar(160) DEFAULT NULL,
  `user_fb_id` varchar(30) DEFAULT NULL,
  `user_email` varchar(60) DEFAULT NULL,
  `user_phone` varchar(15) DEFAULT NULL,
  `app_token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'qr_pay'
--
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
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-09 15:00:24
