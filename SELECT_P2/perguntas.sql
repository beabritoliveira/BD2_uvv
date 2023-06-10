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



/*QUESTAO 1
Escreva uma consulta que retorne por Chef o nome do restaurante que 
ele trabalha,
a cidade que ele está localizado e a, o nome do chef e o telefone.
*/

SELECT id_chefe, r.nome, CONCAT(f.nome, ' ', f.sobrenome) as nome, cidade
FROM restaurante r
INNER JOIN funcionario f ON (r.id_chefe = f.id_funcionario)
INNER JOIN federacao fed ON (r.id_fed = fed.id_fed)
ORDER BY id_chefe;


/*QUESTAO 2
Escreva uma consulta que retorne quantos restaurantes cada responsavel tem
*/

SELECT cnpj_responsavel, COUNT(id_restaurante)
FROM restaurante
GROUP BY cnpj_responsavel;


/*QUESTAO 3
Escreva uma consulta que identifique o restaurante que mais possui funcionarios e retorne 
o nome e o id de todos os que trabalham lá
*/
	/*SELECT id_restaurante, f.id_funcionario, CONCAT(nome, '  ' , sobrenome) as nome, funcao
    FROM trabalha_em te
    INNER JOIN funcionario f USING (id_funcionario)
    WHERE id_restaurante = 9;*/
    
    
    SELECT t.id_restaurante, f.id_funcionario, CONCAT(nome, '  ' , sobrenome) as nome, funcao
    FROM
    (SELECT id_restaurante, COUNT(id_funcionario) as quant_funci
	from trabalha_em
	GROUP BY id_restaurante) as t,
    (SELECT MAX(quant_funci) as max FROM
		(SELECT id_restaurante, COUNT(id_funcionario) as quant_funci
		from trabalha_em
		GROUP BY id_restaurante) as t
	) as r, 
    trabalha_em te, funcionario f
    WHERE max = quant_funci and te.id_funcionario = f.id_funcionario and t.id_restaurante = te.id_restaurante;
    

/*QUESTAO 4
Escreva uma consulta que retorne o nome dos funcionarios as pessoas que trabalham
em mais de um restaurante a sua funcao nele
*/
	SELECT id_funcionario, CONCAT(nome, '  ' , sobrenome) as nome, funcao
    FROM 
    (SELECT id_funcionario, COUNT(id_restaurante) as trab
		from trabalha_em
        GROUP BY id_funcionario) as t
	INNER JOIN funcionario USING(id_funcionario)
    WHERE trab > 1;


/*QUESTAO 5
Selecione todos os restaurantes, e se eles estiverem conectados com um fornecedor,
 o fornecedor e o que é forncecido a ele
*/
	SELECT id_fornecedor, nome, nome_item
    FROM fornecedor
    INNER JOIN itemCardapio ON (item_fornecido = id_item)
    RIGHT OUTER JOIN restaurante USING (id_restaurante);

/*QUESTAO 6
Selecione todos os funcionarios e caso estejam empregados onde ele trabalha
*/
	SELECT CONCAT(f.nome,'  ', f.sobrenome) as funcionario , r.nome as restaurante
	FROM trabalha_em
    INNER JOIN restaurante r USING (id_restaurante)
	RIGHT OUTER JOIN funcionario f USING(id_funcionario);


/*QUESTAO 7
Identifique todos os chefs, mesmo os que não trabalham em nenhum dos restaurantes, e para 
aqueles que trabalham identifique o alvara de funcionamento de onde eles trabalaham
*/

	SELECT id_funcionario, CONCAT(f.nome, '  ', f.sobrenome) as nome_chef,  te.id_restaurante, r.nome as nome_restaurante, alvara_sanitario
    FROM trabalha_em te
    RIGHT JOIN funcionario f USING(id_funcionario)
    LEFT JOIN restaurante r USING(id_restaurante)
    WHERE funcao = 'Chef';



/*	
Escreva uma consulta que retorne os nome de todos os funcionários com, se for o caso,
 os números detransações por ano envolvendo as contas que eles abriram (usando open_emp_id). 
Ordene os resultados por ordem alfabética, e depois por ano (do mais antigo para o mais recente).
*/


