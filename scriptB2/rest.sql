CREATE table restaurante(
	id_restaurante int not null AUTO_INCREMENT,
  	nome varchar(50) not null, 
  	id_chefe int not null, /*FK que referencia a tabela funcionario*/
  	horario_abertura time,
  	horario_fechar time,
  	cnpj_responsavel char(14) not null,
  	alvara_sanitario char(3) not null, /*FK que referencia a tabela licença sanitaria*/
  	categoria varchar(30),
  	id_fed int, /*FK que referencia a tabela federação*/
  	CONSTRAINT pk_restaurante PRIMARY KEY (id_restaurante),
  	UNIQUE KEY restaurante_nome_unique_idx (nome)
);

CREATE table fornecedor(
	id_fornecedor int not null AUTO_INCREMENT,
  	id_restaurante int, /*FK que referencia a tabela restaurante*/
  	item_fornecido int not null, /*FK que referencia a tabela item cardápio*/
  	telefone char(11),
  	CONSTRAINT pk_fornecedor PRIMARY KEY (id_fornecedor),  
);

CREATE table funcionario(
	id_funcionario int NOT null AUTO_INCREMENT,
  	id_restaurante int not null, /*FK que referencia a tabela restaurante*/
  	sobrenome varchar(25),
  	nome varchar(25),
  	sexo char(1),
  	data_contratacao date not null,
  	funcao varchar(35) not null, 
  	telefone char(11),
  	CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario),  
);

CREATE table federacao(
	id_fed int not null AUTO_INCREMENT,
  	cidade varchar(45) not null,
 	estado char(2) not null,
 	endereco varchar(100),
   	CONSTRAINT pk_federacao PRIMARY KEY (id_fed),    
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
  	desconto decimal(2,2),
  	minutos_preparo int,
  	CONSTRAINT pk_itemCardapio PRIMARY KEY (id_item)
);

CREATE table licenca_sanitaria(
	num_licenca int not null,
  	data_emissao date not null,
  	validade date not null,
  	cnpj char(14) not null
	CONSTRAINT pk_LS PRIMARY KEY (num_licenca)
);
