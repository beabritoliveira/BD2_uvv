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
ALTER TABLE federacao AUTO_INCREMENT = 111;         
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
