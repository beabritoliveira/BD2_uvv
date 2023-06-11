CREATE database teste;
use teste;

/*  CRIANDO TABELAS  */
CREATE table restaurante(
	id_restaurante int not null AUTO_INCREMENT,
  	nome varchar(50) not null, 
  	id_chefe int , /*FK que referencia a tabela funcionario*/
  	horario_abertura time,
  	horario_fechar time,
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
  	data_contratacao char(10) not null,
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
  	data_emissao char(10) not null,
  	validade char(10) not null,
  	cnpj char(14) not null,
	CONSTRAINT pk_LS PRIMARY KEY (num_licenca)
);

/*TABELA para povoamento da tabela licenca_sanitaria*/
CREATE table conexao(
		ordem int not null,
        num_lic char(3) not null
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
VALUES 
('Rio Branco', 'AC'),
('Maceió', 'AL'),
('Macapá', 'AP'),
('Manaus', 'AM'),
('Salvador', 'BA'),
('Fortaleza', 'CE'),
('Vitória', 'ES'),
('Goiânia', 'GO'),
('São Luís', 'MA'),
('Cuiabá', 'MT'),
('Campo Grande', 'MS'),
('Belo Horizonte', 'MG'),
('Belém', 'PA'),
('João Pessoa', 'PB'),
('Curitiba', 'PR'),
('Recife', 'PE'),
('Teresina', 'PI'),
('Rio de Janeiro', 'RJ'),
('Natal', 'RN'),
('Porto Alegre', 'RS'),
('Porto Velho', 'RO'),
('Boa Vista', 'RR'),
('Florianópolis', 'SC'),
('São Paulo', 'SP'),
('Aracaju', 'SE'),
('Palmas', 'TO');
 
/* YYYYMMDD  */
INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
VALUES ('109', '2020-03-10', '2021-03-10', '01234567895432'),
       ('278', '2019-10-28', '2019-10-28', '25836914701230'),
       ('325', '2020-03-10', '2021-03-10', '78945612308520'),
       ('412', '2022-05-27', '2023-05-27', '12365498774102'),
       ('569', '2021-08-05', '2022-08-05', '36985214707896'),
       ('613', '2019-10-03', '2020-10-03', '01478520369842'),
       ('747', '2020-10-10', '2021-10-10', '25836914701230'),
       ('856', '2021-07-30', '2022-07-30', '74125896301258'),
       ('981', '2020-12-28', '2021-12-28', '36985214707896'),
       ('023', '2023-06-06', '2024-06-06', '98745632102589');
       

INSERT INTO funcionario (id_funcionario, nome, sobrenome, sexo, data_contratacao, funcao, telefone)
VALUES
(1, 'Emery', 'Brown', 'M', '2017-02-14', 'Sou-chefe','XX-12345678'),
(18, 'Dominique', 'Moore', 'M', '2020-05-04', 'Chef','XX-98765432'),
(5, 'Sheryl', 'Mccarty', 'F', '2022-07-14', 'Chef',  'XX-74125896'),
(12, 'Alex', 'Perez', 'M', '2021-12-08', 'Chef',     'XX-12365478'),
(21, 'Taylor', 'Wright', 'M', '2018-02-28', 'Chef',  'XX-25896314'),
(32, 'Charlie', 'Hill', 'M', '2020-08-05', 'Chef',   'XX-85203697'),
(38, 'Ariel','Campbell', 'M', '2019-03-31', 'Chef',  'XX-84268974'),
(15, 'Brooke', 'Reed', 'M', '2022-09-02', 'Chef',    'XX-96321478'),
(29, 'Dakota', 'Bennet', 'F', '2023-11-04', 'Chef',  'XX-98741236'),
(31, 'Hayden', 'Carlson', 'M', '2021-06-27', 'Chef', 'XX-95123574'),
(11, 'Billie', 'Mccarty', 'F', '2020-09-29', 'Chef', 'XX-75321478'),
(57, 'Charlie', 'Perez', 'F', '2021-08-17', 'Chef',  'XX-78965412'),
(8,'Dominique', 'Bennet', 'M', '2019-06-19', 'Chef', 'XX-74102589');

ALTER TABLE restaurante AUTO_INCREMENT = 1;    
INSERT INTO restaurante (nome, id_chefe, horario_abertura, horario_fechar, alvara_sanitario, categoria, id_fed)
VALUES 
('azulee', 11, 190000, 233000, '325', 'Havaiano', 26),
('Olivetti', 29, 114000, 150000,'569', 'Koreano', 20),
('Santo Cupim', 18, 200000, 000000, '613', 'Brasileiro', 18),
('Cantina Gran Sapore', 5 , 110000, 163500, '023', 'Italiano', 33),
('Montebelo', 12, 114000, 150000, '856', 'Italiano', 22),
('Romeo & Giulietta', 21, 130000, 210000, '747', 'Italiano', 24),
('Blossoms', 32, 130000, 210000, '109', 'Frances', 24),
('The Tropical Road', 57 , 190000, 213000, '278', 'Mexicano', 19),
('The Caribbean Balcony', 38, 120000, 153000, '412', 'Cubano', 34),
('Pensão do Baião', 8, 110000, 143000, '981', 'Brasileiro', 36);

ALTER TABLE cardapio AUTO_INCREMENT = 1;    
INSERT INTO cardapio (id_restaurante)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
	   (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);


INSERT INTO itemCardapio (id_cardapio, nome_item, valor, minutos_preparo)
VALUES 
(12, 'Camarao', '69.90', '40'),
(6, 'Peito de frango', '13.50', '80'),
(11, 'Tomate', '58.99', '25'),
(9, 'Waffles', '25.80', '30'),
(13, 'Batata', '47.90', '45'),
(20, 'Tagliatelle', '58.90', '100'),
(7, 'Cookies', '15.00', '90'),
(4, 'Camarao', '60.30', '20');

INSERT INTO fornecedor (id_restaurante, item_fornecido, telefone)
VALUES 
(2, 1, 'XX-98765432'),
(6, 2, 'XX-12365478'),
(1, 3, 'XX-98745632'),
(9, 4, 'XX-10258963'),
(3, 5, 'XX-25896314'),
(10, 6,'XX-15935785'),
(7, 7, 'XX-85287469'),
(4, 8, 'XX-02147852');


DELIMITER $$
CREATE PROCEDURE
povoar_funcionario(in func_id int)
BEGIN
    DECLARE sex char(1);
    DECLARE func varchar(35);
    DECLARE alet int;
    DECLARE telef int;
    DECLARE tent int;
    DECLARE nom varchar(15);
    DECLARE sob varchar(15);    
    
    WHILE func_id > 0 DO
		SET alet = (RAND() * 10);
		SET telef = (RAND() *100000000); 

		/* Genero */
		IF alet % 2 <=> 0 THEN
			SET sex = 'M';
		ELSEIF alet % 2 <=> 1 THEN
			SET sex = 'F';
		END IF;
		/*Funcao no restaurante*/
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
	
		SET tent = RAND()*10;
		IF tent <=> 1 THEN
			SET sob = 'Brown';
		ELSEIF tent <=> 2 THEN
			SET sob = 'Moore';
		ELSEIF tent <=> 3 THEN
			SET sob = 'Mccarty';
		ELSEIF tent <=> 4 THEN
			SET sob = 'Perez';
		ELSEIF tent <=> 5 THEN
			SET sob = 'Wright';
		ELSEIF tent <=> 6 THEN
			SET sob = 'Hill';
		ELSEIF tent <=> 7 THEN
			SET sob = 'Campbell';
		ELSEIF tent <=> 8 THEN
			SET sob = 'Reed';
		ELSEIF tent <=> 9 THEN
			SET sob = 'Bennet';
		ELSE
			SET sob = 'Carlson';
		END IF;

		SET tent = RAND()*10;
		IF tent <=> 1 THEN
			SET nom = 'Emery';
		ELSEIF tent <=> 2 THEN
			SET nom = 'Dominique';
		ELSEIF tent <=> 3 THEN
			SET nom = 'Alex';
		ELSEIF tent <=> 4 THEN
			SET nom = 'Taylor';
		ELSEIF tent <=> 5 THEN
			SET nom = 'Charlie';
		ELSEIF tent <=> 6 THEN
			SET nom = 'Ariel';
		ELSEIF tent <=> 7 THEN
			SET nom = 'Brooke';
		ELSEIF tent <=> 8 THEN
			SET nom = 'Dakota';
		ELSEIF tent <=> 9 THEN
			SET nom = 'Hayden';
		ELSE
			SET nom = 'Billie';
		END IF;
        
        INSERT INTO funcionario (nome, sobrenome, sexo, 
						data_contratacao, funcao, telefone)
		VALUES (nom, sob , sex,
			(CONCAT('20', LPAD(FLOOR(RAND()*23), 2,'0'), /*ANO*/
			 '-' ,
             LPAD(FLOOR(1+RAND()*12),2,'0'), /*MES */
             '-',
             LPAD(FLOOR(1+RAND()*28),2,'0') /*DIA*/
             )),
                func, CONCAT('XX-', telef));
		/*INCREMENTO*/
        SET func_id = func_id - 1;
	END WHILE; 
END $$
DELIMITER ;


DELIMITER $$ 
CREATE PROCEDURE
criando_alvaraSanitaria(in vezes int)
BEGIN
	DECLARE lic int;
    DECLARE result char(3);
    DECLARE rando1 int;
    DECLARE rando2 int;
    DECLARE rando3 int;
    
    DECLARE R char(14);
    DECLARE ano int;
    DECLARE mes int;
    DECLARE dia int;
    
    DECLARE num int;
    SET num = 0;
   WHILE num < vezes DO 
		/*CNPJ*/
		SET rando1 = (FLOOR(RAND() * 10000));
		SET rando2 = (FLOOR(RAND() * 100000));
		SET rando3 = (FLOOR(RAND() * 100000));
		
		/* LICENCA */	
		SET lic = '000';
		WHILE 0 != (select COUNT(num_licenca) from licenca_sanitaria where num_licenca = lic) DO
			SET lic = (FLOOR(rand() * 1000));
		END WHILE;
            
		SET ano = FLOOR(RAND()* ( YEAR(NOW()) - 2000 ));
        SET mes = FLOOR(1+RAND()*12);
		SET dia = FLOOR(1+RAND()*28);
		INSERT INTO licenca_sanitaria (cnpj, num_licenca, validade, data_emissao)
		VALUES ((CONCAT(
				LPAD(rando3, 5, '0'),
				LPAD(rando2, 5, '0'),
				LPAD(rando1, 4, '0')
				)), 
				(CONCAT(LPAD(lic, 3, '0'))), 
				(CONCAT('20', LPAD((ano + 1), 2,'0'), '-' , /*ANO*/
				 LPAD(mes ,2,'0'), '-', /*MES */
				 LPAD(dia,2,'0') /*DIA*/
				 )),
				(CONCAT('20', LPAD((ano), 2,'0'), '-' , /*ANO*/
				 LPAD(mes ,2,'0'), '-', /*MES */
				 LPAD(dia ,2,'0') /*DIA*/
				 )));
        
        SET num = num + 1;
	END WHILE;
END $$
DELIMITER ;


CREATE INDEX index_licenca
 ON teste.licenca_sanitaria
 (num_licenca);


/*Povoamento restaurante*/
DELIMITER $$
CREATE PROCEDURE povoar_Restaurante()
BEGIN
	DECLARE incremento int;
    DECLARE alet int;
    DECLARE cat varchar(15); /*CATEGORIA RESTAURANTE */
    DECLARE nom varchar(30);
    DECLARE F int;
    DECLARE funci int;
    DECLARE alvara int;
    DECLARE HA int;
    DECLARE HF int;
    DECLARE alv char(3);
    
    SET incremento = 0;
    
while incremento < 100 DO		        
		SET alet = (RAND()*10);
		/*Categoria restaurante*/
		IF alet <=> 0 THEN
			SET cat = 'Peruano';
        ELSEIF alet <=> 1 THEN
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
		
        /*NOME RESTAURANTE*/
        SET alet = (RAND()*10);
		IF alet % 2 <=> 0 THEN
			IF alet <=> 0 THEN 
				SET nom = 'azulee';
			ELSEIF alet <=> 2 THEN 
				SET nom = 'Olivetti';
			ELSEIF alet <=> 4 THEN 
				SET nom = 'Santo Cupim';
			ELSEIF alet <=> 6 THEN 
				SET nom = 'Gran Sapore';
			ELSE 
				SET nom = 'Montebelo';
			end if;
		ELSE
			IF alet <=> 1 THEN
				SET nom = 'The Tropical Road';
			ELSEIF alet <=> 3 THEN
				SET nom = 'Flor de Alecrim';
			ELSEIF alet <=> 5 THEN
				SET nom = 'The Pepper Cloud';
			ELSEIF alet <=> 7 THEN
				SET nom = 'The Juniper Grill';
			ELSE
				SET nom = 'The Lily';
			END IF;
		END IF;
    
		/*ESCOLHENDO FEDERACAO*/
		SET F = RAND() * 100;
        WHILE F < 11 or F > 36 DO
			SET F = RAND() * 100;
		END WHILE;
        
        /*Escolhendo funcionario*/
        SET funci = RAND() * 1000;
		WHILE 0 <=> (SELECT COUNT(id_funcionario) from funcionario where id_funcionario = funci) DO
			SET funci = RAND() * 1000;
		END WHILE;
        
        /*DEFININDO O HORARIO DE ABERTURA E DE FECHAR */
		SET HA = RAND()*21;
		WHILE HA < 11 DO
			SET HA = RAND()*21;
		END WHILE;
		SET HF = RAND()*23;
		WHILE HF > 2 and HF < 15 DO
			SET HF = RAND()*23;
		END WHILE;

        
        /*ESCOLHENDO LICENCA SANITARIA*/
        SET alvara = RAND()*1000;
        WHILE 0 <=> (SELECT COUNT(num_licenca) FROM licenca_sanitaria WHERE num_licenca = alvara) or 
			  0 != (SELECT COUNT(alvara_sanitario) FROM restaurante WHERE alvara_sanitario = alvara)   DO
			SET alvara = RAND()*1000;
		END WHILE;
        SET alv = (LPAD(alvara, 3 ,'0'));
        
		IF 0 != (SELECT COUNT(id_funcionario) FROM funcionario WHERE funcao = 'Chef' and id_funcionario = funci) and 
		   0 <=> (SELECT COUNT(id_chefe) FROM restaurante WHERE id_chefe = funci) THEN
        
			INSERT INTO restaurante (nome, id_chefe, categoria, id_fed, alvara_sanitario, horario_abertura, horario_fechar)
			VALUES((CONCAT(nom, ' - ', CAST(funci as CHAR))),
					funci, cat, F,
                     alv,
                     (CONCAT(LPAD(FLOOR(HA), 2,'0'), /*HORAS*/
					  LPAD('0', 2 ,FLOOR(RAND()*5)), /*MINUTOS */
					  LPAD(0,2,'0') /*SEGUNDOS*/))
                     ,
                     (CONCAT(LPAD(FLOOR(HF), 2,'0'), /*HORAS*/
					  LPAD('0', 2 ,FLOOR(RAND()*5)), /*MINUTOS */
					  LPAD(0,2,'0') /*SEGUNDOS*/))
                     );
                    
		END IF;
	
    SET incremento = incremento + 1;
END while;
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
    SET total = (SELECT MAX(id_funcionario) from funcionario);
    SET incremento = 1;
    
    WHILE incremento <= total DO
    
		SET func = (SELECT funcao from funcionario where id_funcionario = incremento);
        SET choice = RAND() * 1000;
        WHILE 0 <=> (SELECT COUNT(id_restaurante) from restaurante where id_restaurante = choice) DO
			 SET choice = RAND() * 1000;
		END WHILE;
        
       
	
		IF 0 != (SELECT COUNT(id_funcionario) from funcionario where id_funcionario = incremento) THEN
			IF  0 <=> (SELECT COUNT(id_funcionario) from trabalha_em where id_funcionario = incremento and id_restaurante = choice) THEN
				INSERT INTO trabalha_em (id_restaurante, id_funcionario)
				VALUES (choice, incremento);
			END IF;
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
    DECLARE alet int;
    DECLARE nome varchar(60);
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
        
        SET alet = RAND()*10;
        IF alet <=> 0 THEN
			SET nome = 'Camarao';
        ELSEIF alet <=> 1 THEN
			SET nome = 'Tagliatelle';
		ELSEIF alet <=> 2 THEN
			SET nome = 'Tomate';
		ELSEIF alet <=> 3 THEN
			SET nome = 'Ovos';
		ELSEIF alet <=> 4 THEN
			SET nome = 'Waffles';
		ELSEIF alet <=> 5 THEN
			SET nome = 'Cookies';
		ELSEIF alet <=> 6 THEN
			SET nome = 'Abobrinha';
		ELSEIF alet <=> 7 THEN
			SET nome = 'Peito de frango';
		ELSEIF alet <=> 8 THEN
			SET nome = 'Batata';
		ELSEIF alet <=> 9 THEN
			SET nome = 'Espinafre';
		ELSEIF alet <=> 10 THEN
			SET nome = 'Beringela';
		END IF;
        
		INSERT INTO itemCardapio (id_cardapio, nome_item, valor, minutos_preparo)
		VALUES (carpio, nome, preco, tempo);
        
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

/*POVOAR FORNECEDOR*/
DELIMITER $$
CREATE PROCEDURE povoar_fornecedor(in vezes int)
BEGIN
	DECLARE search int;
    DECLARE min int;
    DECLARE max int;
    DECLARE incrementar int;
    DECLARE telef int;
    SET incrementar = 1;
    
	WHILE incrementar < vezes DO
		SET telef = (RAND() *100000000); 
        SET search = RAND()*1000;
        
		WHILE 0 <=> (SELECT COUNT(id_item) FROM itemcardapio WHERE id_item = search) DO
			SET search = RAND()*1000;
		END WHILE;

		INSERT INTO fornecedor (item_fornecido, id_restaurante, telefone)
		VALUES (
			search, (SELECT id_restaurante
					  FROM cardapio 
					  INNER JOIN itemCardapio USING (id_cardapio)
					  WHERE id_item = search), (CONCAT('XX-', telef))
		);
        
        SET incrementar = incrementar + 1;
	END WHILE;
END $$
DELIMITER ;

/*CHAMANDO PROCEDIMENTOS ARMAZENADOS PARA POVOAR O BD*/
select * from federacao;
CALL criando_alvaraSanitaria(100); SELECT * from licenca_sanitaria;
CALL povoar_funcionario(200); SELECT * from funcionario ;
CALL povoar_Restaurante(); SELECT * from restaurante;
CALL cadastrar_cardapio(100); SELECT * FROM cardapio;
CALL inserir_itemCardapio(100); SELECT * FROM itemcardapio;
CALL povoar_fornecedor(100); SELECT * FROM fornecedor;
CALL povoar_trabalha_em();  select * from trabalha_em;


