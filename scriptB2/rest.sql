create database projetoBD2;
use projetoBD2;

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

CREATE table cardapio(
	id_cardapio int not null AUTO_INCREMENT,  	
  	id_restaurante int not null, /*FK que referencia a tabela restaurante*/ 
	CONSTRAINT pk_cardapio PRIMARY KEY (id_cardapio, id_restaurante)
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


/* YYYYMMDD  */
INSERT INTO licenca_sanitaria (num_licenca, data_emissao, validade, cnpj)
VALUES ('109', 200310, 210310, '01234567895432'),
       ('278', 191028, 191028, '25836914701230'),
       ('325', 200310, 210310, '78945612308520'),
       ('412', 220527, 230527, '12365498774102'),
       ('569', 210805, 220805, '36985214707896'),
       ('613', 191003, 201003, '01478520369842'),
       ('747', 201010, 211010, '25836914701230'),
       ('856', 210730, 220730, '74125896301258'),
       ('981', 201228, 211228, '36985214707896'),
       ('023', 230606, 240606, '98745632102589');
       
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
       
ALTER TABLE funcionario AUTO_INCREMENT = 1;
INSERT INTO funcionario (id_funcionario, nome, sobrenome, sexo, data_contratacao, funcao, telefone)
VALUES
(1, 'Doe', 'John', 'M', 170214, 'sou-chef', 'XX-98765432'),
(18, 'Jacob', 'Lopez', 'M', 200504, 'chefe', 'XX-98765432'),
(5, 'Sheryl', 'Mccarty', 'F', 220714, 'chefe', null),
(12, 'Austin', 'Charles', 'M', 211208, 'chefe', null),
(21, 'Andrea', 'Morales', 'M', 180228, 'chefe', null),
(32, 'John', 'Diaz', 'M', 200805, 'chefe', null),
(38, 'William','Weber', 'M', 190331, 'chefe', null),
(15, 'Kristopher', 'Brown', 'M', 220902, 'chefe', null),
(29, 'Bridget', 'Fowler', 'F', 231104, 'chefe', null),
(31, 'William', 'Carlson', 'M', 210627, 'chefe', null),
(11, 'Kayla', 'Stout', 'F', 200929, 'chefe', null),
(57, 'Amanda', 'Peters', 'F', 210817, 'chefe', null),
(8,'William', 'Hayes', 'M', 190619, 'chefe', null);

ALTER TABLE restaurante AUTO_INCREMENT = 1;       
INSERT INTO restaurante (nome, id_chefe, horario_abertura, horario_fechar, cnpj_responsavel, alvara_sanitario, categoria, id_fed)
VALUES 
('azulee', 11, 190000, 233000,'78945612308520', '325', 'havaiano', 126),
('Olivetti', 29, 114000, 150000,'12365478995175', '569', 'italiano', 120),
('Santo Cupim', 18, 200000, 000000, '25896314703574', '613', 'brasileiro', 118),
('Cantina Gran Sapore', 5 , 110000, 163500, '98745632102589', '023', 'italiano', 133),
('Montebelo', 12, 114000, 150000,'12365478995175', '856', 'italiano', 122),
('Romeo & Giulietta', 21, 130000, 210000, '12365478985203', '747', 'doceria', 124),
('Blossoms', 32, 130000, 210000, '95175368425031', '109', 'doceria', 124),
('The Tropical Road', 57 , 190000, 213000,'78945612308520', '278', 'havaiano', 119),
('The Caribbean Balcony', 38, 120000, 153000, '14785236987423','412', 'cubana', 134),
('Pensão do Baião', 8, 110000, 143000, '95175368425031', '981', 'brasileiro', 136);

ALTER TABLE cardapio AUTO_INCREMENT = 1;
INSERT INTO cardapio (id_restaurante)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
	   (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

ALTER TABLE itemCardapio AUTO_INCREMENT = 1;
INSERT INTO itemCardapio (id_cardapio, nome_item, valor, minutos_preparo)
VALUES 
(12, 'risotto de camarão', '69.90', '40'),
(6, 'pistache brownie', '13.50', '80'),
(11, 'poke de atum', '58.99', '25'),
(9, 'Chicharrones', '25.80', '30'),
(13, 'Arroz Maria Isabel', '47.90', '45'),
(20, 'Baião de Dois', '58.90', '100'),
(7, 'Red Velvet cupcacke', '15.00', '90'),
(4, 'Arancine', '60.30', '20');

ALTER TABLE fornecedor AUTO_INCREMENT = 1;
INSERt INTO fornecedor (id_restaurante, item_fornecido, telefone)
VALUES 
(2, 1, 'XX-98765432'),
(6, 2, 'XX-12365478'),
(1, 3, 'XX-98745632'),
(9, 4, 'XX-10258963'),
(3, 5, 'XX-25896314'),
(10, 6,'XX-15935785'),
(7, 7, 'XX-85287469'),
(4, 8, 'XX-02147852');


INSERT Into trabalha_em (id_restaurante, id_funcionario)
VALUES 
(1, (SELECT id_chefe From restaurante where id_restaurante = 1)), 
(2, (SELECT id_chefe From restaurante where id_restaurante = 2)),
(3, (SELECT id_chefe From restaurante where id_restaurante = 3)), 
(4, (SELECT id_chefe From restaurante where id_restaurante = 4)),
(5, (SELECT id_chefe From restaurante where id_restaurante = 5)), 
(6, (SELECT id_chefe From restaurante where id_restaurante = 6)),
(7, (SELECT id_chefe From restaurante where id_restaurante = 7)), 
(8, (SELECT id_chefe From restaurante where id_restaurante = 8)),
(9, (SELECT id_chefe From restaurante where id_restaurante = 9)), 
(10, (SELECT id_chefe From restaurante where id_restaurante = 10));
  
  
