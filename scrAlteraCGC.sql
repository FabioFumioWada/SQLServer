  /*********************************************************/
  /* CLIENTE                  :DANIEL PEREIRA BIANCHI      */
  /* BANCO DE DADOS           :ORACLE                      */
  /* VERS�O DO BANCO DE DADOS :                            */
  /* VERS�O DA BASE DE DADOS  :4.02                        */
  /* DATA DE CRIA��O          :                            */
  /* ANALISTA RESPONS�VEL     :FUMIO                       */
  /* OCORR�NCIA RMAGILIS      :                            */
  /* OBJETIVO:                :ALTERAR O CGC DA TABELA FCFO*/
  /*                           POIS O MESMO SE ENCONTRA SEM*/
  /*                           OS PONTOS E OS TRA�OS       */ 
  /*********************************************************/

/* A Fun��o: */

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