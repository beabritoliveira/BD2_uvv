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


INSERT INTO funcionario (id_funcionario, nome, sobrenome, sexo, data_contratacao, funcao, telefone)
VALUES
(1, 'Emery', 'Brown', 'M', 170214, 'Sou-chefe','XX-12345678'),
(18, 'Dominique', 'Moore', 'M', 200504, 'Chef','XX-98765432'),
(5, 'Sheryl', 'Mccarty', 'F', 220714, 'Chef',  'XX-74125896'),
(12, 'Alex', 'Perez', 'M', 211208, 'Chef',     'XX-12365478'),
(21, 'Taylor', 'Wright', 'M', 180228, 'Chef',  'XX-25896314'),
(32, 'Charlie', 'Hill', 'M', 200805, 'Chef',   'XX-85203697'),
(38, 'Ariel','Campbell', 'M', 190331, 'Chef',  'XX-84268974'),
(15, 'Brooke', 'Reed', 'M', 220902, 'Chef',    'XX-96321478'),
(29, 'Dakota', 'Bennet', 'F', 231104, 'Chef',  'XX-98741236'),
(31, 'Hayden', 'Carlson', 'M', 210627, 'Chef', 'XX-95123574'),
(11, 'Billie', 'Mccarty', 'F', 200929, 'Chef', 'XX-75321478'),
(57, 'Charlie', 'Perez', 'F', 210817, 'Chef',  'XX-78965412'),
(8,'Dominique', 'Bennet', 'M', 190619, 'Chef', 'XX-74102589');




SET alet = RAND()*10
	IF alet <=> 1 THEN
			SET sob = 'Brown';
		ELSEIF alet <=> 2 THEN
			SET sob = 'Moore';
		ELSEIF alet <=> 3 THEN
			SET sob = 'Mccarty';
		ELSEIF alet <=> 4 THEN
			SET sob = 'Perez';
		ELSEIF alet <=> 5 THEN
			SET sob = 'Wright';
		ELSEIF alet <=> 6 THEN
			SET sob = 'Hill';
		ELSEIF alet <=> 7 THEN
			SET sob = 'Campbell';
		ELSEIF alet <=> 8 THEN
			SET sob = 'Reed';
		ELSEIF alet <=> 9 THEN
			SET sob = 'Bennet';
		ELSE
			SET sob = 'Carlson';
		END IF;



	SET alet = RAND()*10
	IF alet <=> 1 THEN
			SET nom = 'Emery';
		ELSEIF alet <=> 2 THEN
			SET nom = 'Dominique';
		ELSEIF alet <=> 3 THEN
			SET nom = 'Alex';
		ELSEIF alet <=> 4 THEN
			SET nom = 'Taylor';
		ELSEIF alet <=> 5 THEN
			SET nom = 'Charlie';
		ELSEIF alet <=> 6 THEN
			SET nom = 'Ariel';
		ELSEIF alet <=> 7 THEN
			SET nom = 'Brooke';
		ELSEIF alet <=> 8 THEN
			SET nom = 'Dakota';
		ELSEIF alet <=> 9 THEN
			SET nom = 'Hayden';
		ELSE
			SET nom = 'Billie';
		END IF;




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
