DELIMITER $$
CREATE TRIGGER nome AFTER INSERT ON customer FOR EACH ROW
BEGIN
	 insert into account (cust_id, product_cd, open_date)
     VALUES (NEW.cust_id,'CHK', now());
END $$
DELIMITER ;
