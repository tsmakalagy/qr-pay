DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getUserIdAndPhoneByPhoneAndUID`(
   IN p_phone VARCHAR(15),
   IN p_fb_id VARCHAR(30),
   IN p_app_token VARCHAR(255)
)
BEGIN
    SET @update_id := 0;
    SET @user_email:= "";
    SET @user_phone:= "";
UPDATE tbl_user SET app_token = p_app_token, user_id = (SELECT @update_id := user_id), user_email = (SELECT @user_email := user_email), user_phone = (SELECT @user_phone := user_phone)
WHERE user_phone=p_phone AND user_fb_id=p_fb_id LIMIT 1; 
SELECT @update_id, @user_email, @user_phone;
END ;;
DELIMITER ;
