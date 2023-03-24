SELECT agencia, nomeAgencia, conta, ID, nome_titulares, valor
FROM(
	SELECT open_branch_id as agencia,
  			b.name AS nomeAgencia,
  			a.account_id as conta,i.cust_id as ID, 
  			CONCAT((i.lname), " ,", (i.fname)) as nome_titulares, 
  			a.pending_balance as valor
	FROM account a
	INNER JOIN individual i ON (i.cust_id = a.cust_id)
	INNER JOIN branch b ON (a.open_branch_id = b.branch_id)
	UNION
	SELECT open_branch_id as agencia,
  			b.name AS nomeAgencia,
  			a.account_id as conta, o.cust_id as ID, 
  			CONCAT((o.lname), " ,", (o.fname)) as nome_titulares, 
  			a.pending_balance as valor
  	FROM account a
	INNER JOIN officer o ON (o.cust_id = a.cust_id)
	INNER JOIN branch b ON (a.open_branch_id = b.branch_id)
  ) AS tabela_virtual, (
    SELECT open_branch_id, ac.cust_id, account_id, MAX(pending_balance) as pb
    FROM account ac
    INNER JOIN customer c ON (ac.cust_id = c.cust_id)
    GROUP BY open_branch_id
  	) as a
Where tabela_virtual.valor = a.pb
ORDER BY agencia, valor DESC;
