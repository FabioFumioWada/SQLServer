  /*********************************************************/
  /* CLIENTE                  :DANIEL PEREIRA BIANCHI      */
  /* BANCO DE DADOS           :ORACLE                      */
  /* VERSÃO DO BANCO DE DADOS :                            */
  /* VERSÃO DA BASE DE DADOS  :4.02                        */
  /* DATA DE CRIAÇÃO          :                            */
  /* ANALISTA RESPONSÁVEL     :FUMIO                       */
  /* OCORRÊNCIA RMAGILIS      :                            */
  /* OBJETIVO:                :ALTERAR O CGC DA TABELA FCFO*/
  /*                           POIS O MESMO SE ENCONTRA SEM*/
  /*                           OS PONTOS E OS TRAÇOS       */ 
  /*********************************************************/

/* A Função: */

CREATE OR REPLACE FUNCTION ALTERACGC(CGCCFO VARCHAR) 
RETURN VARCHAR IS
BEGIN
    RETURN(
      (SUBSTR(CGCCFO,1,2))||'.'
    ||(SUBSTR(CGCCFO,4,3))||'.'
    ||(SUBSTR(CGCCFO,7,3))||'/'
    ||(SUBSTR(CGCCFO,10,4))||'-'
    ||(SUBSTR(CGCCFO,12,2))
    );
END;


/* O Teste */

SELECT CODCOLIGADA,ALTERACGC(CGCCFO) FROM FCFO;


/*##MAGNA##*/