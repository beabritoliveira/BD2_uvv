DELIMITER $$
CREATE TRIGGER add_telefone_funcionario 
AFTER INSERT ON trabalha_em for each row
BEGIN
	DECLARE ddd char(2);
    DECLARE telef int;
    DECLARE tel char(8);
    
	SET ddd = (SELECT id_fed
				FROM restaurante r
				INNER JOIN trabalha_em te ON (r.id_restaurante = te.id_restaurante)
				WHERE id_funcionario = new.id_funcionario );
	
    SET telef = (RAND() *100000000); 
    IF telef < 1 or telef <=> 100000000 THEN
		SET tel = '00000001';
	ELSEIF telef < 10 THEN
		SET tel = (CONCAT('0000000',(CAST(telef AS CHAR))));
	ELSEIF telef < 100 THEN
		SET tel = (CONCAT('000000',(CAST(telef AS CHAR))));
	ELSEIF telef < 1000 THEN
		SET tel = (CONCAT('00000',(CAST(telef AS CHAR))));
	ELSEIF telef < 10000 THEN
		SET tel = (CONCAT('0000',(CAST(telef AS CHAR))));
	ELSEIF telef < 100000 THEN
		SET tel = (CONCAT('000',(CAST(telef AS CHAR))));
	ELSEIF telef < 1000000 THEN
		SET tel = (CONCAT('00',(CAST(telef AS CHAR))));
	ELSEIF telef < 10000000 THEN
		SET tel = (CONCAT('0',(CAST(telef AS CHAR))));
	ELSEIF telef < 100000000 THEN
		SET tel = (CAST(rando2 AS CHAR));
	END IF;

	UPDATE funcionario 
    SET telefone = (CONCAT(ddd, '-', tel))
    WHERE id_funcionario = new.id_funcionario;
END $$
DELIMITER ;
