CREATE table federacao (
	id_fed int not null AUTO_INCREMENT,
  	cidade varchar(45) not null,
 	estado char(2) not null,
 	endereco varchar(100),
 	pais varchar(35) not null,
  	CONSTRAINT pk_federacao PRIMARY KEY (id_fed)
);

CREATE TABLE genero(
	id_filme int not null,
  	genero varchar(20) not null,
  	CONSTRAINT pk_genero PRIMARY KEY (genero)
);

create table atores (
	id_ator int not null AUTO_INCREMENT,
  	id_func int not null,
  	papel_interpretado varchar(45) not null,
    CONSTRAINT pk_atores PRIMARY KEY (id_ator, id_func)
);

CREATE TABLE funcionario (
	id_func int not null AUTO_INCREMENT,
  	sobrenome varchar(25),
  	nome varchar(25),
  	sexo char(1),
  	data_contratacao date not null,
  	id_fed int,
  	id_filmes int not null,
  	funcao varchar(45) not null,
    CONSTRAINT pk_funcionario PRIMARY KEY (id_func)
);

alter table funcionario
add constraint check (sexo in('M', 'F'));

create table filme (
	id_filme int not null AUTO_INCREMENT,
  	titulo varchar(45),
  	ano_lancamento date,
  	id_fed int,
  	id_diretor int not null,
  	id_roteirista int not null,
  	genero varchar(20) not null,
  	duracao time,
  	UNIQUE KEY filme_idx (titulo),
    CONSTRAINT pk_filme PRIMARY KEY (id_filme)
);
