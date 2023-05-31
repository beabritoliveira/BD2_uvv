Create database transporte;
use transporte;

Create table Motorista (
	Cod_Motorista int not null auto_increment,
    Placa_Van varchar(7) not null,
    Modelo numeric(4) not null,
    Cod_Escola int not null,
    Cod_Aluno int not null,
    fname varchar(20) default null,
    lname varchar(20) default null,
    cpf char(11) not null,
    telefone numeric(20) default null,
    email varchar(50) default null,
    constraint pk_motorista primary key (Cod_Motorista, Placa_Van)
);

Create table Escola(
	Cod_Escola int not null auto_increment,
    nome varchar(20) default null,
    endereco varchar(100) default null,
    constraint pk_escola primary key (Cod_Escola)
);

Create table Van(
	Modelo numeric(4) not null,
    Capacidade int not null,
    constraint pk_van primary key (Modelo)
);

Create table Aluno(
	Cod_Aluno int not null auto_increment,
    Cod_Escola int not null,
    Cod_Motorista int not null,
    Cod_Cliente int not null,
    fname varchar(20) default null,
    lname varchar(20) default null,
    endereco varchar(100) default null,
    constraint pk_aluno primary key (Cod_Aluno)
);

Create table Cliente(
	Cod_Cliente int not null auto_increment,
    Cod_Aluno int not null,
    fname varchar(20) default null,
    lname varchar(20) default null,
    cpf char(11) not null,
    telefone numeric(20) default null,
    email varchar(50) default null,
    constraint pk_motorista primary key (Cod_Cliente)
);

alter table Motorista add foreign key (Modelo) references Van (Modelo);
alter table Motorista add foreign key (Cod_Aluno) references Aluno (Cod_Aluno);
alter table Motorista add foreign key (Cod_Escola) references Escola (Cod_Escola);

alter table Aluno add foreign key (Cod_Motorista) references Motorista (Cod_Motorista);
alter table Aluno add foreign key (Cod_Cliente) references Cliente (Cod_Cliente);
alter table Aluno add foreign key (Cod_Escola) references Escola (Cod_Escola);

alter table Cliente add foreign key (Cod_Aluno) references Aluno (Cod_Aluno);
