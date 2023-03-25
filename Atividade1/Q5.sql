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
