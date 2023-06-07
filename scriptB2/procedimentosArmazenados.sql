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
