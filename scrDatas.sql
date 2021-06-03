/***********************************************************/
/* CLIENTE:                  FÁBIO AUGUSTO                 */
/* BANCO DE DADOS:           ORACLE                        */
/* VERSÃO DO BANCO DE DADOS: 8.1.5                         */
/* VERSÃO DA BASE DE DADOS:  4.03                          */
/* DATA DE CRIAÇÃO:          23/08/2002                    */
/* ANALISTA RESPONSÁVEL:     FUMIO                         */
/* OCORRÊNCIA RMAGILIS:                                    */
/* OBJETIVO:                 TRAZER AS DATAS DA TABELA DLAF*/
/*                           SEPARANDO POR DIA, MÊS E ANO E*/ 
/*                           O DIA, MÊS, DO ANO ANTERIOR   */
/***********************************************************/


SELECT DLAF.IDLAF,
  TO_CHAR(DATALF,'DD') AS DIA, 
  TO_CHAR(DATALF,'MM') AS MES,
  TO_CHAR(DATALF,'YYYY') AS ANO,
  TO_CHAR(LAST_DAY(DATALF),'DD') AS DIAANT,
  DECODE(TO_CHAR(DATALF,'MM'),
         12,01,
         TO_CHAR(DATALF,'MM')) AS MESANT,
  DECODE(TO_CHAR(DATALF,'MM'),
         12,(TO_CHAR(DATALF,'YYYY')-1),
         TO_CHAR(DATALF,'YYYY')) AS ANOANT
FROM DLAF;