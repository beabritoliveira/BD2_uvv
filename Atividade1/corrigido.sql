/*Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome
da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).*/

SELECT CONCAT((lname), " ,", (fname)) as administrador, name as nomeEmpresa, city
from business 
JOIN officer USING (cust_id)
JOIN customer USING (cust_id);


/*Escreva uma consulta que retorne os nome dos clientes (nome das pessoas jurídicas ou nome + sobrenome
das pessoas físicas) que possuem uma conta em uma cidade diferente da cidade de estabelecimento.*/

SELECT DISTINCT CONCAT((individual.lname), " ,", (individual.fname)) as nomeCliente /*customer.city, branch.city*/
from individual, customer, branch
WHERE individual.cust_id = customer.cust_id AND NOT customer.city = branch.city
UNION
SELECT DISTINCT business.name as nomeClient /*customer.city, branch.city */
FROM business
INNER JOIN customer Using (cust_id) 
INNER JOIN branch ON (customer.city != branch.city);


/*Escreva uma consulta que retorne os nomes dos funcionários com os números de transações por ano envolvendo
as contas que eles abriram (usando open_emp_id). Ordene os resultados por ordem alfabética,
e depois por ano (do mais antigo para o mais recente)*/

SELECT CONCAT((employee.fname), " ", (employee.lname)) as NomeFuncionario, 
		COUNT(YEAR(open_date)) as TransacaoNoAno, YEAR(account.open_date) as Ano
from employee
JOIN account on (employee.emp_id = account.open_emp_id)
GROUP BY employee.emp_id, YEAR(open_date)
ORDER BY employee.fname ASC, YEAR(open_date) ASC;



/*Escreva uma consulta que retorne os identificadores de contas com maior saldo de dinheiro por agência,
juntamente com os nomes dos titulares (nome da empresa ou nome e sobrenome da pessoa física) e os
nomes dessas agências.*/

SELECT agencia, nomeAgencia, conta, nome_titulares, valor
FROM(
	SELECT open_branch_id as agencia,
  			name AS nomeAgencia,
  			account_id as conta,
  			CONCAT((lname), " ,", (fname)) as nome_titulares, 
  			pending_balance as valor
	FROM account 
	INNER JOIN individual USING (cust_id)
	INNER JOIN branch ON (open_branch_id = branch_id)
	UNION
	SELECT open_branch_id as agencia,
  			br.name AS nomeAgencia,
  			account_id as conta, 
  			bu.name as nome_titulares,
  			pending_balance as valor
  	FROM account a
	INNER JOIN business bu USING (cust_id)
	INNER JOIN branch br ON (open_branch_id = branch_id)
  ) AS tabela_virtual, (
    SELECT open_branch_id, ac.cust_id, account_id, MAX(pending_balance) as pb
    FROM account ac JOIN customer USING (cust_id)
    GROUP BY open_branch_id
  ) as a
Where tabela_virtual.valor = a.pb
ORDER BY agencia, valor DESC;



/* Escreva de novo as consultas 2. e 4. utilizando uma visualização (CREATE VIEW) */

Create OR REPLACE VIEW view_cliente AS (
	SELECT DISTINCT CONCAT((lname), " ,", (fname)) as nomeCliente /*customer.city, branch.city*/
    from individual, customer, branch
	WHERE individual.cust_id = customer.cust_id AND NOT customer.city = branch.city
	UNION
	SELECT DISTINCT business.name as nomeCliente /*customer.city, branch.city */
	FROM business
	INNER JOIN customer Using (cust_id) 
	INNER JOIN branch ON (customer.city != branch.city)
);

select * from view_cliente;

CREATE or REPLACE view view_quatro AS
  SELECT contas, nomeTitular, nomeAgencia, valor
  FROM(
	SELECT account_id as contas, 
    		CONCAT((fname), " ", (lname)) as nomeTitular, 
    		name as NomeAgencia,
    		pending_balance
  	FROM  account 
    INNER Join individual USING(cust_id)
    inner JOIN branch b on (open_branch_id = branch_id)
  	UNION
  	SELECT  account_id as contas, 
    		bs.name as nomeTitular, 
    		b.name as NomeAgencia,
    		pending_balance
  	FROM account 
    INNER JOIN business bs USING(cust_id)
    INNER JOIN branch b ON (open_branch_id = branch_id)
    ) as tbv, (
      SELECT MAX(pending_balance) as valor
      from account
      GROUP By open_branch_id
    ) AS saldo
  Where saldo.valor = tbv.pending_balance ;

select * FROM view_quatro;
