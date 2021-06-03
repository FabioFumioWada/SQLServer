/*********************************************************/
/* CLIENTE                  :MAMBO                       */
/* BANCO DE DADOS           :MSSQL                       */
/* VERS�O DO BANCO DE DADOS :7.0/2000                    */
/* VERS�O DA BASE DE DADOS  :5.00                        */
/* DATA DE CRIA��O          :03/07/2003                  */
/* ANALISTA RESPONS�VEL     :FUMIO                       */
/* OCORR�NCIA RMAGILIS      :                            */
/* OBJETIVO:                :ALTERA A DESCRICAO DOS      */ 
/*                           EVENTOS QUE EST�O EM        */
/*                           CARACTERES MIN�SCULOS PARA  */
/*                           MAI�SCULOS                  */
/*********************************************************/


create procedure sp_AlteraEvento as
  declare @codcoligada int
  declare @codigo varchar(4)
  declare @descricao varchar(80)

  declare cur_tabevento cursor for
    select codcoligada,codigo,descricao
    from pevento
    where codcoligada=1

  open cur_tabevento
  fetch next from cur_tabevento into @codcoligada,@codigo,@descricao

  while (@@fetch_status=0)
  begin

    update pevento set descricao = upper(@descricao)
    where codcoligada = @codcoligada
    and codigo = @codigo

    fetch next from cur_tabevento into @codcoligada,@codigo,@descricao
  end
  close cur_tabevento
  deallocate cur_tabevento
go

exec sp_AlteraEvento
go

drop procedure alteraevento
go