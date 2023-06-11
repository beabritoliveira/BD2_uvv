
*/ESTAO 1
Escreva uma consulta que retorne por Chef o nome do restaurante que ele trabalha,
a cidade que ele está localizado e a, o nome do chef /*
    SELECT id_chefe, r.nome, f.nome, cidade
    FROM restaurante r
    INNER JOIN funcionario f ON (r.id_chefe = f.id_funcionario)
    INNER JOIN federacao fed ON (r.id_fed = fed.id_fed)
    ORDER BY id_chefe;



/*QUESTAO 1
Escreva uma consulta que retorne por Chef o nome do restaurante que 
ele trabalha,
a cidade que ele está localizado e a, o nome do chef 
*/

SELECT id_chefe, r.nome, CONCAT(f.nome, ' ', f.sobrenome) as nome, cidade
FROM restaurante r
INNER JOIN funcionario f ON (r.id_chefe = f.id_funcionario)
INNER JOIN federacao fed ON (r.id_fed = fed.id_fed)
ORDER BY id_chefe;


/*QUESTAO 2
Escreva uma consulta que retorne quantos restaurantes cada responsavel tem
*/

SELECT cnpj, COUNT(id_restaurante)
FROM restaurante
INNER JOIN licenca_sanitaria ON (alvara_sanitario = num_licenca)
GROUP BY cnpj;


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


