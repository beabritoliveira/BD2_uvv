SELECT DISTINCT customer.cust_id, CONCAT((individual.lname), " ,", (individual.fname)) as pessoaFisica, customer.fed_id /*, customer.city, branch.city*/
from individual, customer, branch
WHERE individual.cust_id = customer.cust_id AND NOT customer.city = branch.city
UNION
SELECT DISTINCT business.cust_id as ID, CONCAT((officer.lname), " ,", (officer.fname)) as pessoaJuridica, customer.fed_id /*, customer.city, branch.city */
FROM business
INNER JOIN customer ON (business.cust_id = customer.cust_id) 
INNER JOIN officer ON (officer.cust_id = customer.cust_id)
INNER JOIN branch ON (customer.city != branch.city);
