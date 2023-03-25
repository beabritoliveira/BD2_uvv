/*Create view na questão 2*/
Create OR REPLACE VIEW view_cliente AS (
	SELECT DISTINCT i.cust_id, CONCAT((i.fname), " ,", (i.lname)) as nomeCliente
    From customer c
  	INNER JOIN branch b ON (c.city != b.city)
  	INNER JOIN individual i ON (c.cust_id = i.cust_id)
    UNION
    SELECT DISTINCT o.cust_id, CONCAT((o.fname), " ,", (o.lname))
    From customer c, branch b, officer o
  	Where NOT b.city = c.city AND c.cust_id = o.cust_id
);
SELECT * 
from view_cliente;

/*Create view na questão 4*/
CREATE or REPLACE view view_quatro AS
  SELECT contas, nomeTitular, nomeAgencia, valor
  FROM(
	SELECT a.account_id as contas, 
    		CONCAT((i.fname), " ", (i.lname)) as nomeTitular, 
    		b.name as NomeAgencia,
    		pending_balance
  	FROM  account a
    INNER Join individual i ON (a.cust_id = i.cust_id)
    inner JOIN branch b on (a.open_branch_id = b.branch_id)
  	UNION
  	SELECT a.account_id as contas, 
    		CONCAT((o.fname), " ", (o.lname)) as nomeTitular, 
    		b.name as NomeAgencia,
    		pending_balance
  	FROM account a
    INNER JOIN officer o on (a.cust_id = o.cust_id)
    INNER JOIN branch b ON (a.open_branch_id = b.branch_id)
    ) as tbv, (
      SELECT MAX(pending_balance) as valor
      from account
      GROUP By open_branch_id
    ) AS saldo
  Where saldo.valor = tbv.pending_balance ;

SELECT * from view_quatro;
