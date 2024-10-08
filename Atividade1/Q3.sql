/*
Escreva uma consulta que retorne os nome de todos os funcionários com, se for o caso, os números de
transações por ano envolvendo as contas que eles abriram (usando open_emp_id). Ordene os resultados
por ordem alfabética, e depois por ano (do mais antigo para o mais recente).
*/

SELECT COUNT(YEAR(open_date)) as Transacao_Ano, CONCAT((employee.fname), " ", (employee.lname)) as Nome, YEAR(account.open_date) as Ano
from employee
LEFT OUTER Join account on (employee.emp_id = account.open_emp_id)
GROUP BY employee.emp_id, YEAR(open_date)
ORDER BY employee.fname ASC, YEAR(open_date) ASC;

