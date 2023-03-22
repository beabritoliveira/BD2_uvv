SELECT CONCAT((officer.lname), " ,", (officer.fname)) as administrador, business.name, customer.city
from business 
INNER JOIN officer ON (business.cust_id = officer.cust_id)
INNER JOIN customer ON (business.cust_id = customer.cust_id);

