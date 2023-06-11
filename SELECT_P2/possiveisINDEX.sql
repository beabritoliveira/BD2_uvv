ALTER TABLE licenca_sanitaria
ADD INDEX index_licenca_cnpj(cnpj);

ALTER TABLE funcionario
ADD INDEX index_func_nome(nome,sobrenome);

ALTER TABLE funcionario
ADD INDEX index_func_funcao(funcao);	

ALTER TABLE restaurante
ADD INDEX index_rest_chef(id_chefe);









