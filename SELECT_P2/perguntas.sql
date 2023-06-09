QUESTAO 1
Escreva uma consulta que retorne por Chef o nome do restaurante que ele trabalha,
a cidade que ele está localizado e a, o nome do chef e o telefone.
    SELECT id_chefe, r.nome, f.nome, cidade
    FROM restaurante r
    INNER JOIN funcionario f ON (r.id_chefe = f.id_funcionario)
    INNER JOIN federacao fed ON (r.id_fed = fed.id_fed)
    ORDER BY id_chefe;



QUESTAO 2
Escreva uma consulta que conte por restaurante quantas licencas sanitárias eles possuem.

QUESTAO 3
Escreva uma consulta que identifique o restaurante que mais possui funcionarios e retorne 
o nome e o id de todos os que trabalham lá

QUESTAO 4
Escreva uma consulta que retorne o nome dos funcionarios as pessoas que trabalham
em mais de um restaurante a sua funcao nele

QUESTAO 5
Selecione por cardapio todos os fornecedores que mais entregam produtos para que eles sejam feitos

QUESTAO 6
Identifique todos os chefs que não trabalham em nenhum dos restaurantes, e para 
aqueles que trabalham identifique o alvara de funcionamento de onde eles trabalaham

QUESTAO 7
Identifique todos os cardapios e se for o caso a quantidade de itens nele.

QUESTAO 8
QUESTAO 9
QUESTAO 10
