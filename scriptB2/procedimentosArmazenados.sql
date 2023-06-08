/*create database projetoBD2;
use projetoBD2;
grant all on projetoBD2.* to 'Alteravel'@'%';
CREATE table funcionario(
	id_funcionario int NOT null AUTO_INCREMENT,
  	sobrenome varchar(25),
  	nome varchar(25),
  	sexo char(1),
  	data_contratacao date not null,
  	funcao varchar(35) not null, 
  	telefone char(11),
  	CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario)
);
*/

DELIMITER $$
CREATE PROCEDURE
povoar_funcionario(in func_id int)
BEGIN
    DECLARE sex char(1);
    DECLARE dat int;
    DECLARE func varchar(35);
    DECLARE alet int;
    DECLARE telef int;
    
    WHILE func_id > 0 DO
		SET alet = (RAND() * 10);
		SET dat = (RAND() *1000000);
		SET telef = (RAND() *100000000); 

		/* Genero */
		IF alet % 2 <=> 0 THEN
			SET sex = 'M';
		ELSEIF alet % 2 <=> 1 THEN
			SET sex = 'F';
		END IF;
		/*Data de contratação*/
		WHILE dat > 231231 && dat < 170101 DO
			SET dat = (CAST((RAND() *1000000) AS date));
		END WHILE;
		/*Funcao*/
		IF alet <=> 1 THEN
			SET func = 'Sou-chefe';
		ELSEIF alet <=> 2 THEN
			SET func = 'Gerente';
		ELSEIF alet <=> 3 THEN
			SET func = 'Maître';
		ELSEIF alet <=> 4 THEN
			SET func = 'Garçom';
		ELSEIF alet <=> 5 THEN
			SET func = 'Commins';
		ELSEIF alet <=> 6 THEN
			SET func = 'Chef';
		ELSEIF alet <=> 7 THEN
			SET func = 'Cozinheiro';
		ELSEIF alet <=> 8 THEN
			SET func = 'Barman/bartender';
		ELSEIF alet <=> 9 THEN
			SET func = 'Auxiliar de limpeza';
		ELSEIF alet <=> 10 THEN
			SET func = 'Sommelier';
		END IF;
    
		INSERT INTO funcionario (nome, sexo, 
						data_contratacao, funcao, telefone)
		VALUES ((CONCAT('Funcionario - ',CAST(func_id AS CHAR))), sex,
				191203,  func, CONCAT('XX-', telef));
		/*INCREMENTO*/
        SET func_id = func_id - 1;
	END WHILE; 
END $$
DELIMITER ;


CALL povoar_funcionario(100);
 
select * from funcionario;


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
		VALUES((select COUNT(num_licenca) from licenca_sanitaria)), (CAST(lic AS CHAR));
	END $$

CREATE PROCEDURE criando_alvaraSanitaria(in licenca int)
BEGIN
	DECLARE lic int;
	DECLARE id int;
    DECLARE num int;
    
	WHILE licenca >= 1 DO
		SET lic = RAND() * 1000; /*Sorteia a licenca*/
		SET id = RAND() * 100000000000000;  /*Sorteia o CNPJ*/
        SET num = (select COUNT(num_lic) from conexao);
        
        WHILE licenca > (licenca + num) && licenca != 0 DO
			IF lic <=> (select num_lic from conexao where ordem = licenca) THEN
				SET lic = RAND() * 1000;
			END IF;
            
            SET num = num - 1;
		END WHILE;
        
		INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
		VALUES ((CAST(lic AS CHAR)), 191203, 201203, (CAST(id AS CHAR)));
		
		SET licenca = licenca - 1;    
	END WHILE;
END $$
DELIMITER ;
CALL criando_alvaraSanitaria(200);

select * from licenca_sanitaria;



DELIMITER $$
CREATE PROCEDURE povoar_Restaurante()
BEGIN
	DECLARE num int;
    DECLARE total_funcionario int;
    DECLARE alet int;
    DECLARE cat varchar(15);
    DECLARE F int;
    DECLARE nom varchar(45);
    DECLARE incremento int;
    DECLARE qnt_restaurante int ;
    DECLARE quntDIN int;
    DECLARE quntFIXO int;
    DECLARE x int;
    DECLARE vezes int;
    
    SET vezes = 0;
    SET num = 1;
    SET incremento = 0;
    SET total_funcionario = (SELECT COUNT(id_funcionario) FROM funcionario);
    
    set quntDIN = 1;
    
while vezes != 100 DO
    
    SET qnt_restaurante = (SELECT COUNT(ordem) FROM conexao)- (SELECT COUNT(id_restaurante) from restaurante); /* 300 - 10 = 290 */
    SET quntFIXO = (SELECT COUNT(id_restaurante) FROM restaurante); /* 10 restaurantes já inseridos*/
    SET quntDIN = quntFIXO + 1; /* 10 + 1= 11 posicao pra comecar*/
    
    WHILE quntDIN < (qnt_restaurante + quntFIXO) DO
		        
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
        
        set x = (RAND()*100 * RAND()*10);
    
		IF total_funcionario <=> (SELECT id_funcionario FROM funcionario WHERE funcao = 'Chef' and id_funcionario = total_funcionario) 
        THEN
        
			INSERT INTO restaurante (nome, id_chefe, categoria, id_fed, alvara_sanitario, cnpj_responsavel)
			VALUES((CONCAT(nom, ' - ', CAST( x as CHAR))),
					total_funcionario, 
                    cat, 
                    (SELECT id_fed from federacao where id_fed = F),
                   (SELECT num_licenca       
					FROM 
					(SELECT ordem, num_licenca       
					 FROM licenca_sanitaria ls        
					 INNER JOIN conexao c ON (ls.num_licenca = c.num_lic)) as tabela                     
					 WHERE ordem = quntDIN ),
                    (SELECT cnpj       
					FROM 
					(SELECT ordem, cnpj         
					 FROM licenca_sanitaria ls        
					 INNER JOIN conexao c ON (ls.num_licenca = c.num_lic)) as tabela                     
					 WHERE ordem = quntDIN) );
                    
		END IF;
        
        SET quntDIN = quntDIN + 1;
		SET total_funcionario = total_funcionario -1;
    END WHILE;
	
    SET vezes = vezes + 1;
end while;

END $$
DELIMITER ;
CALL povoar_Restaurante();
