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
CREATE PROCEDURE povoar_Restaurante(in qnt_restaurante int)
BEGIN
	DECLARE num;
    DECLARE total_funcionario int;
    SET num = 1;
    SET total_funcionario = (SELECT COUNT(id_funcionario) FROM funcionario);
    
    WHILE total_funcionario > 1 DO
		IF total_funcionario <=> ( SELECT id_funcionario FROM funcionario WHERE funcao = chefe)
		
		INSERT INTO restaurante (nome, id_chefe, horario_abertura, horario_fechar,
						cnpj_responsavel, alvara_sanitario, categoria, id_fed)
		VALUES(,total_funcionario, null, null,
				(SELECT cnpj FROM licenca_sanitaria WHERE  )
                );
		
    END WHILE;
END $$
DELIMITER ;
CALL povoar_Restaurante(200);
