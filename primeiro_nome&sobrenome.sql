-- primeiro nome
select substring(nome,1,patindex('% %',nome)) as primeiro_nome, 
       nome as nome_completo
from pfunc


-- ultimo nome (sobrenome)
select reverse(substring(reverse(nome),1,patindex('% %',reverse(nome)))) as sobrenome, 
       nome as nome_completo
from pfunc