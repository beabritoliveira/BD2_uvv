DELIMITER $$ 
CREATE PROCEDURE
criando_alvaraSanitaria(IN quantidade_licenca int)
BEGIN
    DECLARE no_licenca int;
    DECLARE id bigint;
    DECLARE incremento int;
    DECLARE ordenacao int ;
    SET incremento = 0;
    
	WHILE incremento < quantidade_licenca DO
		SET no_licenca = (RAND() * 1000); /*Sorteia a licenca*/
		SET id = (RAND() * 100000000000000);  /*Sorteia o CNPJ*/
        
		WHILE no_licenca < 100 DO
			SET no_licenca = (RAND() * 1000); 
		END WHILE;
	
		 WHILE id < 10000000000000 DO
			SET id = (RAND() * 100000000000000); 
		END WHILE;
		
        SET ordenacao = 1;
        WHILE ordenacao != 0 DO
			SET ordenacao = (select COUNT(num_lic) from conexao where num_lic = no_licenca);
			WHILE no_licenca < 100 or ordenacao > 0 DO
						SET no_licenca = (RAND() * 1000); 
			END WHILE;
		END WHILE;
        
		INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
		VALUES ((CAST(no_licenca AS CHAR)), 191203, 201203, (CAST(id AS CHAR)));
			
        SET incremento = incremento + 1;    
	END WHILE;
END $$
DELIMITER ;
