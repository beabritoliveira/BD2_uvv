/*  CRIANDO TABELAS  */
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

ALTER TABLE funcionario ADD CONSTRAINT ck_func_sexo 
CHECK (sexo IN('M', 'F'));

CREATE TABLE trabalha_em(
  	id_funcionario int NOT null,
  	id_restaurante int not null,
    CONSTRAINT pk_trabalha_em PRIMARY KEY (id_funcionario, id_restaurante)
  );

CREATE table fornecedor(
	id_fornecedor int not null AUTO_INCREMENT,
  	id_restaurante int, /*FK que referencia a tabela restaurante*/
  	item_fornecido int not null, /*FK que referencia a tabela item cardápio*/
  	telefone char(11),
  	CONSTRAINT pk_fornecedor PRIMARY KEY (id_fornecedor)
);

CREATE table federacao(
	id_fed int not null AUTO_INCREMENT,
  	cidade varchar(45) not null,
 	estado char(2) not null,
 	endereco varchar(100),
   	CONSTRAINT pk_federacao PRIMARY KEY (id_fed)   
);

CREATE TABLE cardapio(
	id_restaurante int not null,
    id_cardapio int not null AUTO_INCREMENT,
    CONSTRAINT pk_cardapio PRIMARY KEY(id_cardapio, id_restaurante)
);

CREATE table itemCardapio(
	id_item int not null AUTO_INCREMENT,
  	id_cardapio int not null, /*FK que referencia a tabela cardapio*/ 
  	valor decimal(5,2),
  	minutos_preparo int,
  	nome_item varchar(60) null,
  	CONSTRAINT pk_itemCardapio PRIMARY KEY (id_item)
);

ALTER TABLE itemCardapio ADD CONSTRAINT ck_itemCardapio_minutos_preparo 
CHECK (minutos_preparo >= 0);

CREATE table licenca_sanitaria(
	num_licenca char(3) not null,
  	data_emissao date not null,
  	validade date not null,
  	cnpj char(14) not null,
	CONSTRAINT pk_LS PRIMARY KEY (num_licenca)
);

/*  TRIGGERS  */
DELIMITER $$   
CREATE TRIGGER testando AFTER INSERT ON licenca_sanitaria FOR EACH ROW 
	BEGIN
		INSERT INTO conexao (ordem, num_lic)
		VALUES((select COUNT(num_licenca) from licenca_sanitaria), new.num_licenca);
        /*(CAST(lic AS CHAR));*/
END $$

DELIMITER $$   
CREATE TRIGGER povoar_trabalha_em_CHEF AFTER INSERT ON restaurante FOR EACH ROW 
	BEGIN
    INSERT Into trabalha_em (id_restaurante, id_funcionario)
	VALUES (new.id_restaurante, new.id_chefe);
END $$


/* 	CRIANDO FOREIGN KEYS 	*/
ALTER TABLE restaurante ADD CONSTRAINT fk_restaurante_idChefe
FOREIGN KEY (id_chefe) REFERENCES funcionario (id_funcionario)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE restaurante ADD CONSTRAINT fk_restaurante_lSanitaria
FOREIGN KEY (alvara_sanitario) REFERENCES licenca_sanitaria (num_licenca)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE restaurante ADD CONSTRAINT fk_restaurante_idFederecao
FOREIGN KEY (id_fed) REFERENCES federacao (id_fed)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_idRestaurante
FOREIGN KEY (id_restaurante) REFERENCES restaurante (id_restaurante)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE fornecedor ADD CONSTRAINT fk_fornecedor_item
FOREIGN KEY (item_fornecido) REFERENCES itemCardapio (id_item)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE trabalha_em ADD CONSTRAINT fk_trabalha_em_idRestaurante
FOREIGN KEY (id_restaurante) REFERENCES restaurante (id_restaurante)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE trabalha_em ADD CONSTRAINT fk_trabalha_em_idFuncionario
FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE cardapio ADD CONSTRAINT fk_cardapio_idRestaurante
FOREIGN KEY (id_restaurante) REFERENCES restaurante (id_restaurante)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE itemCardapio ADD CONSTRAINT fk_itemCardapio_idCardapio
FOREIGN KEY (id_cardapio) REFERENCES cardapio (id_cardapio)
ON DELETE CASCADE ON UPDATE CASCADE;

/* 	INSERÇÃO TABELA FEDERACAO 	*/
ALTER TABLE federacao AUTO_INCREMENT = 11;         
INSERT INTO federacao (cidade, estado)
VALUES ('Acre', 'AC'),
('Alagoas', 'AL'),
('Amapá', 'AP'),
('Amazonas', 'AM'),
('Bahia', 'BA'),
('Ceará', 'CE'),
('Espírito Santo', 'ES'),
('Goiás', 'GO'),
('Maranhão', 'MA'),
('Mato Grosso', 'MT'),
('Mato Grosso do Sul', 'MS'),
('Minas Gerais', 'MG'),
('Pará', 'PA'),
('Paraíba', 'PB'),
('Paraná', 'PR'),
('Pernambuco', 'PE'),
('Piauí', 'PI'),
('Rio de Janeiro', 'RJ'),
('Rio Grande do Norte', 'RN'),
('Rio Grande do Sul', 'RS'),
('Rondônia', 'RO'),
('Roraima', 'RR'),
('Santa Catarina', 'SC'),
('São Paulo', 'SP'),
('Sergipe', 'SE'),
('Tocantins', 'TO');

/* Povoamento da tabela funcionario */
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
		WHILE dat > 231231 and dat < 170101 DO
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


/*Povoamento da tabela licenca_sanitaria*/
CREATE table conexao(
		ordem int not null,
        num_lic char(3) not null
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
    
CREATE INDEX index_licenca
 ON projetobd2.licenca_sanitaria
 (num_licenca);
    
CALL criando_alvaraSanitaria();




/*Povoamento restaurante*/
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

/*POVOANDO TRABALHA_EM*/
DELIMITER $$
CREATE PROCEDURE povoar_trabalha_em()
BEGIN
	DECLARE func varchar(35);
    DECLARE total int;
    DECLARE incremento int;
    DECLARE restaurante int;
    DECLARE choice int;
    
    SET incremento = 1;
	SET total = (SELECT count(id_funcionario) from funcionario);
	SET restaurante = (SELECT count(id_restaurante) from restaurante);
    
    WHILE incremento <= total DO
    
		SET func = (SELECT funcao from funcionario where id_funcionario = incremento);
        SET choice = RAND() * 1000;
        WHILE choice > restaurante DO
			 SET choice = RAND() * 1000;
		END WHILE;
		IF func !='Chef' THEN
			INSERT INTO trabalha_em (id_restaurante, id_funcionario)
            VALUES (choice, incremento);
		END IF;
		SET incremento = incremento + 1;
	END WHILE;
END $$
DELIMITER ;


/*POVOAR ITENS PEDIDO*/
DELIMITER $$
CREATE PROCEDURE inserir_itemCardapio(in registro int)
BEGIN
	DECLARE preco DECIMAL(5,2);
    DECLARE tempo int;
    DECLARE c_possivel int;
    DECLARE carpio int;
    SET carpio = 0;
    
    WHILE registro > 0 DO
		SET preco = RAND()*100;
		SET tempo = RAND()*1000;
		SET carpio = ROUND(RAND()*1000);
		
		WHILE 0 <=> (SELECT COUNT(id_cardapio) from cardapio where id_cardapio = carpio) DO
			SET carpio = ROUND(RAND()*1000);
		END WHILE;
		WHILE tempo > 300 DO
			SET tempo = RAND()*1000;
		END WHILE;
        
		INSERT INTO itemCardapio (id_cardapio, nome_item, valor, minutos_preparo)
		VALUES (carpio, null, preco, tempo);
        
        SET registro = registro - 1;
	END WHILE;
END $$
DELIMITER ;


/*POVOAR CARDAPIO*/
DELIMITER $$
CREATE PROCEDURE cadastrar_cardapio(in vezes int)
BEGIN
	DECLARE cardap int;
    DECLARE incrementar int;
    DECLARE sorteio int;
    DECLARE num int;
    SET incrementar = 0;
    
    
    WHILE incrementar < vezes DO
		SET sorteio = RAND()*1000;
        
		WHILE 0 <=> (SELECT COUNT(id_restaurante) FROM restaurante WHERE id_restaurante = sorteio) DO
			SET sorteio = RAND()*1000;
		END WHILE;
		
		INSERT INTO cardapio (id_restaurante)
		VALUES(sorteio);
        
        SET incrementar = incrementar + 1;
    END WHILE;
END $$
DELIMITER ;

CALL cadastrar_cardapio(100);


/*POVOAR FORNECEDOR*/
DELIMITER $$
CREATE PROCEDURE povoar_fornecedor(in vezes int)
BEGIN
	DECLARE search int;
    DECLARE min int;
    DECLARE max int;
    DECLARE incrementar int;
    SET incrementar = 1;
    
	WHILE incrementar < vezes DO
		SET search = RAND()*1000;
        
		WHILE 0 <=> (SELECT COUNT(id_item) FROM itemcardapio WHERE id_item = search) DO
			SET search = RAND()*1000;
		END WHILE;

		INSERT INTO fornecedor (item_fornecido, id_restaurante, telefone)
		VALUES (
			search, (SELECT id_restaurante
					  FROM cardapio 
					  INNER JOIN itemCardapio USING (id_cardapio)
					  WHERE id_item = search), null
		);
        
        SET incrementar = incrementar + 1;
	END WHILE;
END $$
DELIMITER ;
