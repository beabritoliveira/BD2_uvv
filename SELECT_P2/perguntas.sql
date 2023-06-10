INSERT INTO funcionario (id_funcionario, nome, sobrenome, sexo, data_contratacao, funcao, telefone)
VALUES
(1, 'Doe', 'John', 'M', 170214, 'Sou-chefe', 'XX-98765432'),
(18, 'Jacob', 'Lopez', 'M', 200504, 'Chef', 'XX-98765432'),
(5, 'Sheryl', 'Mccarty', 'F', 220714, 'Chef', null),
(12, 'Austin', 'Charles', 'M', 211208, 'Chef', null),
(21, 'Andrea', 'Morales', 'M', 180228, 'Chef', null),
(32, 'John', 'Diaz', 'M', 200805, 'Chef', null),
(38, 'William','Weber', 'M', 190331, 'Chef', null),
(15, 'Kristopher', 'Brown', 'M', 220902, 'Chef', null),
(29, 'Bridget', 'Fowler', 'F', 231104, 'Chef', null),
(31, 'William', 'Carlson', 'M', 210627, 'Chef', null),
(11, 'Kayla', 'Stout', 'F', 200929, 'Chef', null),
(57, 'Amanda', 'Peters', 'F', 210817, 'Chef', null),
(8,'William', 'Hayes', 'M', 190619, 'Chef', null);


ALTER TABLE itemCardapio AUTO_INCREMENT = 1;
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






QUESTAO 1
Escreva uma consulta que retorne por Chef o nome do restaurante que ele trabalha,
a cidade que ele está localizado e a, o nome do chef e o telefone.
    SELECT id_chefe, r.nome, f.nome, cidade
    FROM restaurante r
    INNER JOIN funcionario f ON (r.id_chefe = f.id_funcionario)
    INNER JOIN federacao fed ON (r.id_fed = fed.id_fed)
    ORDER BY id_chefe;



QUESTAO 2
Escreva uma consulta que conte por restaurante quantas licencas sanitárias eles possuem.

QUESTAO 3
Escreva uma consulta que identifique o restaurante que mais possui funcionarios e retorne 
o nome e o id de todos os que trabalham lá

QUESTAO 4
Escreva uma consulta que retorne o nome dos funcionarios as pessoas que trabalham
em mais de um restaurante a sua funcao nele

QUESTAO 5
Selecione por cardapio todos os fornecedores que mais entregam produtos para que eles sejam feitos

QUESTAO 6
Identifique todos os chefs que não trabalham em nenhum dos restaurantes, e para 
aqueles que trabalham identifique o alvara de funcionamento de onde eles trabalaham

QUESTAO 7
Identifique todos os cardapios e se for o caso a quantidade de itens nele.

QUESTAO 8
QUESTAO 9
QUESTAO 10
