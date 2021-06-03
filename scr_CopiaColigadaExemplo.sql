/*********************************************************/
/* CLIENTE                  :RM SISTEMAS                 */
/* BANCO DE DADOS           :MSSQL                       */
/* VERSÃO DO BANCO DE DADOS :2000/2005                   */
/* VERSÃO DA BASE DE DADOS  :10.0                        */
/* DATA DE CRIAÇÃO          :15/10/2007                  */
/* OBJETIVO:                :COPIA COLIGADA EXEMPLO      */
/* BASE ORIGEM (SCRIPT)     :EXEMPLO10                   */
/* BASE DESTINO (SCRIPT)    :IMPLANTACAO                 */
/*********************************************************/

------------------------
-- Atualiza GCOLIGADA --
------------------------

update implantacao..gcoligada set nomefantasia = 'RM Sistemas'
where codcoligada = 1
go

update implantacao..gcoligada set cgc = '21.867.387/0001-58'
where codcoligada = 1
go

update implantacao..gcoligada set nome = 'RM SISTEMAS LTDA'
where codcoligada = 1
go

update implantacao..gcoligada set telefone = '31-21229000'
where codcoligada = 1
go

update implantacao..gcoligada set fax = '31-21229155'
where codcoligada = 1
go

update implantacao..gcoligada set email = 'http://www.rm.com.br'
where codcoligada = 1
go

update implantacao..gcoligada set rua = 'AVENIDA RAJA GABAGLIA'
where codcoligada = 1
go

update implantacao..gcoligada set numero = '2664'
where codcoligada = 1
go

update implantacao..gcoligada set complemento = '2º ANDAR'
where codcoligada = 1
go

update implantacao..gcoligada set bairro = 'SANTA LÚCIA'
where codcoligada = 1
go

update implantacao..gcoligada set cidade = 'Belo Horizonte'
where codcoligada = 1
go

update implantacao..gcoligada set estado = 'MG'
where codcoligada = 1
go

update implantacao..gcoligada set pais = 'Brasil'
where codcoligada = 1
go

update implantacao..gcoligada set cep = '30350-540'
where codcoligada = 1
go

update implantacao..gcoligada set controlacgc = '1'
where codcoligada = 1
go

update implantacao..gcoligada set controle1 = '10214'
where codcoligada = 1
go

update implantacao..gcoligada set controle2 = '-5594'
where codcoligada = 1
go

update implantacao..gcoligada set controle3 = '30641'
where codcoligada = 1
go

--update implantacao..gcoligada set idimagem = '1'
--where codcoligada = 1
--go

update implantacao..gcoligada set produtorrural = 'F'
where codcoligada = 1
go

update implantacao..gcoligada set ativo = 'F'
where codcoligada = 1
go


--------------------
-- Demais tabelas --
--------------------

delete from implantacao..gusrperfil where codcoligada = 1
go

delete from implantacao..gpermis where codcoligada = 1
go

delete from implantacao..glicenca where codcoligada = 1
go

delete from implantacao..gautzmenu 
go

delete from implantacao..gperfil
go

delete from implantacao..gautzmenu
go

insert into implantacao..gperfil
select *
from exemplo10..gperfil
go

insert into implantacao..glicenca
select *
from exemplo10..glicenca
where codcoligada = 1
go

insert into implantacao..gpermis
select *
from exemplo10..gpermis
where codcoligada = 1
and codusuario = 'mestre'
go

insert into implantacao..gusrperfil
select *
from exemplo10..gusrperfil
where codcoligada = 1
and codusuario = 'mestre'
go

insert into implantacao..gautzmenu
select *
from exemplo10..gautzmenu
go
