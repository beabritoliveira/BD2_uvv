/* Escreva uma consulta que retorne o nome e sobrenome de todos os administradores (officer) com o nome
da empresa que eles administram (business.name) e cidade onde ela está presente (customer.city).
*/

SELECT CONCAT((officer.lname), " ,", (officer.fname)) as administrador, business.name, customer.city
from business 
INNER JOIN officer ON (business.cust_id = officer.cust_id)
INNER JOIN customer ON (business.cust_id = customer.cust_id);

