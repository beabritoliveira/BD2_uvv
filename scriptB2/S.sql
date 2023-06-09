/*Povoamento da tabela licenca_sanitaria*/
CREATE table conexao(
		ordem int not null,
        num_lic char(3) not null
    );
    

CREATE table licenca_sanitaria(
	num_licenca char(3) not null,
  	data_emissao date not null,
  	validade date not null,
  	cnpj char(14) not null,
	CONSTRAINT pk_LS PRIMARY KEY (num_licenca)
);

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
    
    IF rando1 < 1 or rando2 <=> 10000 THEN
		SET R1 = '0000';
    ELSEIF rando1 < 10 THEN
		SET R1 = (CONCAT('000',(CAST(rando1 AS CHAR))));
    ELSEIF rando1 < 100 THEN
		SET R1 = (CONCAT('00',(CAST(rando1 AS CHAR))));
	ELSEIF rando1 < 1000 THEN
		SET R1 = (CONCAT('0',(CAST(rando1 AS CHAR))));
    ELSE 
		SET R1 = (CAST(rando1 AS CHAR));
    END IF;
    
    IF rando2 < 1 or rando2 <=> 100000 THEN
		SET R2 = '00000';
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
    
    IF rando3 < 1 or rando3 <=> 10000 THEN
		SET R3 = '0000';
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
    SET result = '000';
    WHILE 0 != (select COUNT(num_licenca) from licenca_sanitaria where num_licenca = result) DO
		SET lic = (rand() * 1000);
        IF lic < 1 or lic <=> 1000 THEN
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


CREATE table teste_cnpj(
	ordem int not null auto_increment,
    cnpj char(14) not null,
    CONSTRAINT pk_teste PRIMARY KEY (ordem)
);

CALL criando_alvaraSanitaria();

CREATE INDEX index_licenca
 ON projetobd2.licenca_sanitaria
 (num_licenca);

select * from licenca_sanitaria;
