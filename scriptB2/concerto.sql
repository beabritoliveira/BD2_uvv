/*DELIMITER $$ 
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




use testando;

/*Povoamento da tabela licenca_sanitaria*/
CREATE table conexao(
		ordem int not null,
        num_lic char(3) not null
    );
    

DELIMITER $$ 
CREATE PROCEDURE
criando_alvaraSanitaria()
BEGIN
    DECLARE no_licenca int;
    DECLARE id1 int;
    DECLARE id2 int;
    DECLARE incremento int;
    DECLARE ordenacao int ;
    DECLARE lic char(3);
    DECLARE id char(14);
    DECLARE p1 char(7);
    DECLARE p2 char(7);
    
    SET incremento = 0;
    
	WHILE incremento < 100 DO
		SET id1 = (RAND()*10000000);
        SET id2 = (RAND()*10000000);
        
        IF id1 < 1 THEN
			SET p1 = '0000000';
        ELSEIF id1 < 10 THEN
			SET p1 = (CONCAT('000000', (CAST(id1 AS char))));
		ELSEIF id1 < 100 THEN
			SET p1 = (CONCAT('00000',(CAST(id1 AS char))));
		ELSEIF id1 < 1000 THEN
			SET p1 = (CONCAT('0000', (CAST(id1 AS char))));
		ELSEIF id1 < 10000 THEN
			SET p1 = (CONCAT('000', (CAST(id1 AS char))));
		ELSEIF id1 < 100000 THEN
			SET p1 = (CONCAT('00', (CAST(id1 AS char));
		ELSEIF id1 < 1000000 THEN
			SET p1 = (CONCAT('0', (CAST(id1 AS char))));
		ELSE 
			SET id1 = (CAST(id1 AS CHAR));
		END IF;
        IF id2 < 1 THEN
			SET p2 = '0000000';
        ELSEIF id2 < 10 THEN
			SET p2 = (CONCAT('000000', CAST(id2 AS char)));
		ELSEIF id2 < 100 THEN
			SET p2 = (CONCAT('00000', CAST(id2 AS char)));
		ELSEIF id < 1000 THEN
			SET p2 = (CONCAT('0000', CAST(id2 AS CHAR)));
		ELSEIF id2 < 10000 THEN
			SET p2 = (CONCAT('000', CAST(id2 AS CHAR)));
		ELSEIF id2 < 100000 THEN
			SET p2 = (CONCAT('00', CAST(id2 AS CHAR)));
		ELSEIF id2 < 1000000 THEN
			SET p2 = (CONCAT('0', CAST(id2 AS CHAR)));
		ELSE 
			SET p2 = (CAST(id1 AS CHAR));
		END IF;
        
        /*'82212320512358'
				0000001
				0000010
				0000100
				0001000
                0010000
                0100000
                1000000
        */
        SET id = (CONCAT(p1, p2));
        
		SET no_licenca = 100;
        SET ordenacao = 1;
        WHILE ordenacao != 0 DO
			SET ordenacao = (select COUNT(num_lic) from conexao where num_lic = lic);
			IF ordenacao <=> 0 THEN	
                IF no_licenca < 10 THEN
					SET lic = (CONCAT('00', CAST(no_licenca AS char)));
				ELSEIF no_licenca < 100 THEN
					SET lic = (CONCAT('0', CAST(no_licenca AS char)));
				ELSE 
					SET lic = (CAST(no_licenca AS CHAR));
				END IF;
			ELSE 
				SET no_licenca = (RAND() * 1000); 
            END IF;
        END WHILE;
        
		INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
		VALUES 						  (lic , 191203, 201203, id);
			
        SET incremento = incremento + 1;    
	END WHILE;
END $$
DELIMITER ;

CALL criando_alvaraSanitaria();

select * from licenca_sanitaria;
					 
*/					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
DELIMITER $$ 
CREATE PROCEDURE
criando_alvaraSanitaria()
BEGIN
	DECLARE lic int;
    DECLARE result char(3);
    DECLARE rando1 int;
    DECLARE rando2 int;
    DECLARE rando3 int;
    
    DECLARE R char(14);
    DECLARE R1 char(14);
    DECLARE R2 char(14);
    DECLARE R3 char(14);
    
    
    /*CNPJ*/
    SET rando1 = RAND() * 10000;
    SET rando2 = RAND() * 100000;
    SET rando3 = RAND() * 100000;
    
    IF rando1 < 1 THEN
		SET R1 = '0001';
    ELSEIF rando1 < 10 THEN
		SET R1 = (CONCAT('000',(CAST(rando1 AS CHAR))));
    ELSEIF rando1 < 100 THEN
		SET R1 = (CONCAT('00',(CAST(rando1 AS CHAR))));
	ELSEIF rando1 < 1000 THEN
		SET R1 = (CONCAT('0',(CAST(rando1 AS CHAR))));
    ELSE 
		SET R1 = (CAST(rando1 AS CHAR));
    END IF;
    
    IF rando2 < 1 THEN
		SET R2 = '00001';
    ELSEIF rando2 < 10 THEN
		SET R2 = (CONCAT('0000',(CAST(rando2 AS CHAR))));
    ELSEIF rando2 < 100 THEN
		SET R2 = (CONCAT('000',(CAST(rando2 AS CHAR))));
	ELSEIF rando2 < 1000 THEN
		SET R2 = (CONCAT('00',(CAST(rando2 AS CHAR))));
	ELSEIF rando2 < 10000 THEN
		SET R2 = (CONCAT('0',(CAST(rando2 AS CHAR))));
    ELSE 
		SET R2 = (CAST(rando2 AS CHAR));
    END IF;
    
    IF rando3 < 1 THEN
		SET R3 = '00001';
    ELSEIF rando3 < 10 THEN
		SET R3 = (CONCAT('0000',(CAST(rando3 AS CHAR))));
    ELSEIF rando2 < 100 THEN
		SET R3 = (CONCAT('000',(CAST(rando3 AS CHAR))));
	ELSEIF rando3 < 1000 THEN
		SET R3 = (CONCAT('00',(CAST(rando3 AS CHAR))));
	ELSEIF rando3 < 10000 THEN
		SET R3 = (CONCAT('0',(CAST(rando3 AS CHAR))));
    ELSE 
		SET R3 = (CAST(rando3 AS CHAR));
    END IF;
    
    SET R = (CONCAT (R1, R2, R3));
    
	/* LICENCA */	
    SET result = '001';
    WHILE 0 != (select COUNT(num_licenca) from licenca_sanitaria where num_licenca = result) DO
		SET lic = (rand() * 1000);
        
        IF lic < 1 THEN
			SET result = '001';
		ELSEIF lic < 10 THEN
			SET result = (CONCAT('00',(CAST(lic AS CHAR))));
		ELSEIF lic < 100 THEN
			SET result = (CONCAT('0',(CAST(lic AS CHAR))));
		ELSE 
			SET result = (CAST(lic AS CHAR));
		END IF;
	END WHILE;
		
    INSERT INTO licenca_sanitaria (cnpj, num_licenca, validade, data_emissao)
    VALUES (R, result, 121212, 131212);
      
END $$
DELIMITER ;
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
					 
