CREATE table conexao(
		ordem int not null,
        num_lic char(3) not null
    );
    
DELIMITER $$   
CREATE TRIGGER testando AFTER INSERT ON licenca_sanitaria FOR EACH ROW 
	BEGIN
		INSERT INTO conexao (ordem, num_lic)
		VALUES((select COUNT(num_licenca) from licenca_sanitaria), new.num_licenca);
        /*(CAST(lic AS CHAR));*/
	END $$

CREATE PROCEDURE
criando_alvaraSanitaria(INOUT quantidade_licenca int)
BEGIN
    
	WHILE quantidade_licenca >= 1 DO
		SET no_licenca = (RAND() * 1000); /*Sorteia a licenca*/
		SET id = (RAND() * 100000000000000);  /*Sorteia o CNPJ*/
        SET num = (select COUNT(num_lic) from conexao);
        
        WHILE no_licenca < 100 DO
			SET no_licenca = (RAND() * 1000); 
        END WHILE;
        
         WHILE id < 10000000000000 DO
			SET id = (RAND() * 100000000000000); 
        END WHILE;
        
        WHILE quantidade_licenca > (quantidade_licenca - num) && licenca != 0 DO
			WHILE no_licenca <=> (select num_lic from conexao where ordem = licenca) or lic < 100 DO
				SET no_licenca = RAND() * 1000;
                IF no_licenca <=> (select num_lic from conexao where ordem = licenca) then
					SET incremento = 1;
                ELSE
					SET incremento = 1;
				END IF;
			END WHILE;
            SET num = num + incremento;
		END WHILE;
        
		INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
		VALUES ((CAST(no_licenca AS CHAR)), 191203, 201203, (CAST(id AS CHAR)));
		
		SET quantidade_licenca = quantidade_licenca - 1;    
	END WHILE;
END $$
DELIMITER ;
CALL criando_alvaraSanitaria(200);

select * from licenca_sanitaria;






CREATE table restaurante(
	id_restaurante int not null AUTO_INCREMENT,
  	nome varchar(50) not null, 
  	id_chefe int , /*FK que referencia a tabela funcionario*/
  	horario_abertura time,
  	horario_fechar time,
  	cnpj_responsavel char(14) not null,
  	alvara_sanitario char(3) not null, /*FK que referencia a tabela licença sanitaria*/
  	categoria varchar(30),
  	id_fed int, /*FK que referencia a tabela federação*/
  	CONSTRAINT pk_restaurante PRIMARY KEY (id_restaurante),
  	UNIQUE KEY restaurante_nome_unique_idx (nome)
);


    
DELIMITER $$
CREATE PROCEDURE povoar_Restaurante(in qnt_restaurante int)
BEGIN
	DECLARE num int;
    DECLARE total_funcionario int;
    DECLARE alet int;
    DECLARE cat varchar(15);
    DECLARE F int;
    DECLARE nom varchar(45);
    SET num = 1;
    SET total_funcionario = (SELECT COUNT(id_funcionario) FROM funcionario);
    
    WHILE total_funcionario > 1 DO
		SET alet = (RAND()*10);
		/*Categoria restaurante*/
		IF alet <=> 1 THEN
			SET cat = 'Marroquino';
		ELSEIF alet <=> 2 THEN
			SET cat = 'Mexicano';
		ELSEIF alet <=> 3 THEN
			SET cat = 'Italiano';
		ELSEIF alet <=> 4 THEN
			SET cat = 'Frances';
		ELSEIF alet <=> 5 THEN
			SET cat = 'Brasileiro';
		ELSEIF alet <=> 6 THEN
			SET cat = 'Koreano';
		ELSEIF alet <=> 7 THEN
			SET cat = 'Japones';
		ELSEIF alet <=> 8 THEN
			SET cat = 'Thailandes';
		ELSEIF alet <=> 9 THEN
			SET cat = 'Cubano';
		ELSEIF alet <=> 10 THEN
			SET cat = 'Havaiano';
		END IF;
		
        SET alet = (RAND()*10);
		IF alet % 2 <=> 0 THEN
			SET alet = alet % 7;
			IF alet <=> 0 THEN
				SET nom = 'azulee';
			ELSEIF alet <=> 1 THEN
				SET nom = 'Olivetti';
			ELSEIF alet <=> 2 THEN
				SET nom = 'Santo Cupim';
			ELSEIF alet <=> 3 THEN
				SET nom = 'Frances';
			ELSEIF alet <=> 4 THEN
				SET nom = 'Gran Sapore';
			ELSEIF alet <=> 5 THEN
				SET nom = 'Montebelo';
			ELSEIF alet <=> 6 THEN
				SET nom = 'Romeo & Giulietta';
			END IF;
		ELSEIF alet % 2 <=> 1 THEN
			SET alet = alet % 7;
			IF alet <=> 0 THEN
				SET nom = 'The Tropical Road';
			ELSEIF alet <=> 1 THEN
				SET nom = 'The Caribbean Balcony';
			ELSEIF alet <=> 2 THEN
				SET nom = 'Flor de Alecrim';
			ELSEIF alet <=> 3 THEN
				SET nom = 'The Pepper Cloud';
			ELSEIF alet <=> 4 THEN
				SET nom = 'The Juniper Grill';
			ELSEIF alet <=> 5 THEN
				SET nom = 'The Lily';
			ELSEIF alet <=> 6 THEN
				SET nom = 'Green house';
			END IF;
		END IF;
    
		SET F = RAND() * 1000;
        WHILE F > 136 or F < 111 DO
			SET F = RAND() * 1000;
		END WHILE;
    
		IF total_funcionario <=> ( SELECT id_funcionario FROM funcionario WHERE funcao = 'Chef') THEN
        
			INSERT INTO restaurante (nome, id_chefe, horario_abertura, horario_fechar, alvara_sanitario, cnpj_responsavel, categoria, id_fed)
			VALUES((CONCAT(nom, CAST(id_restaurante AS CHAR))),total_funcionario, null, null,
					(SELECT num_lic FROM conexao WHERE ordem = total_funcionario), (select cnpj FROM licenca_sanitaria Where num_licenca = alvara_sanitario),
                    cat, (SELECT id_fed from federacao where id_fed = F));
		END IF;
		SET total_funcionario = total_funcionario -1;
    END WHILE;
END $$
DELIMITER ;
CALL povoar_Restaurante(200);





CREATE table licenca_sanitaria(
	num_licenca char(3) not null,
  	data_emissao date not null,
  	validade date not null,
  	cnpj char(14) not null,
	CONSTRAINT pk_LS PRIMARY KEY (num_licenca)
);

CREATE table conexao(
		ordem int not null,
        num_lic char(3) not null
    );
    
DELIMITER $$   
CREATE TRIGGER testando AFTER INSERT ON licenca_sanitaria FOR EACH ROW 
	BEGIN
		INSERT INTO conexao (ordem, num_lic)
		VALUES((select COUNT(num_licenca) from licenca_sanitaria), new.num_licenca);
        /*(CAST(lic AS CHAR));*/
	END $$

CREATE PROCEDURE
criando_alvaraSanitaria(IN quantidade_licenca int)
BEGIN
	DECLARE no_licenca int DEFAULT 99;
    

	WHILE quantidade_licenca >= 1 DO
		/*SET no_licenca = (RAND() * 1000); /*Sorteia a licenca*/
		SET id = (RAND() * 100000000000000);  /*Sorteia o CNPJ*/
        SET num = (select COUNT(num_lic) from conexao);
        
        WHILE no_licenca < 100 DO
			SET no_licenca = (RAND() * 1000); 
        END WHILE;
        
         WHILE id < 10000000000000 DO
			SET id = (RAND() * 100000000000000); 
        END WHILE;
        
        WHILE quantidade_licenca > (quantidade_licenca - num) && licenca != 0 DO
			WHILE no_licenca <=> (select num_lic from conexao where ordem = licenca) or lic < 100 DO
				SET no_licenca = RAND() * 1000;
                IF no_licenca <=> (select num_lic from conexao where ordem = licenca) then
					SET incremento = 1;
                ELSE
					SET incremento = 1;
				END IF;
			END WHILE;
            SET num = num + incremento;
		END WHILE;
        
		INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
		VALUES ((CAST(no_licenca AS CHAR)), 191203, 201203, (CAST(id AS CHAR)));
		
		SET quantidade_licenca = quantidade_licenca - 1;    
	END WHILE;
END $$
DELIMITER ;
CALL criando_alvaraSanitaria(200);

select * from licenca_sanitaria;


