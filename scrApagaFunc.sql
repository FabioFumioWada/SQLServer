DELETE FROM PFDESCEMPRT WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFMOVTOMADOR WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VDISTRVERBATREINA WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFFERIAS WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFPERFER WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFFINANC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFPERFF WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VADVERTENCIA WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFFINANCCOMPL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFMOVCCCOMPL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFPERFFCOMPL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE TMOV SET CHAPARESP=NULL WHERE CODCOLIGADA=1 AND CHAPARESP = '00002'
GO

DELETE FROM ASECVIS WHERE CODCOLIGADA=1 AND RESPONSAVEL = '00002'
GO

DELETE FROM PFRATEIOFIXO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFRATEIOTOMADOR WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AABONFUN WHERE CODCOLIGADA=1 AND RESPONSAVEL = '00002'
GO

DELETE FROM PFSALCMP WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AABONFUTURO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFSUBSTITUICAO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFSUBSTITUICAO WHERE CODCOLIGADA=1 AND CHAPASUBST = '00002'
GO

DELETE FROM VTAREFAPESSOAL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM IBEMFUNC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE PDADQUIOSQUE SET CHAPA=NULL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE IBEMINVENTARIO SET CHAPA=NULL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE VPOSTOSFUNC SET CHAPA=NULL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE AVISITA SET RESPONSAVEL=NULL WHERE CODCOLIGADA=1 AND RESPONSAVEL = '00002'
GO

DELETE FROM PFUNCVAL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM  PFVALETR WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM  VFLUXOREQPROMOCAO WHERE CODCOLIGADA=1 AND CHAPARESPPARECER = '00002'
GO

UPDATE PSUBSTCHEFE SET CHAPASUBST=NULL WHERE CODCOLSUBST=1 AND CHAPASUBST = '00002'
GO

UPDATE PSUBSTSUP SET CHAPASUBST=NULL WHERE CODCOLIGADA=1 AND CHAPASUBST = '00002'
GO

UPDATE MPRJ SET CHAPARESP=NULL WHERE CODCOLIGADA=1 AND CHAPARESP = '00002'
GO

DELETE FROM VFUNCIONARIO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VBENEFFUNC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM  PFAAS WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFADICFER WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VMOVFUNC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFAVISO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFCODFIX WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFDEPENDCOMPL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFDEPMOV WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFDEPEND WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE TITMMOV SET CHAPA=NULL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VPOSTOSFUNC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM  KAPONTAFUNCIONARIO WHERE CODCOLCHAPA=1 AND CHAPA = '00002'
GO

DELETE FROM VCHAPAATESTADO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VOCORRENCIA WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFEMPRT WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFENCARGO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFFERPROG WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE MMAOOBRAPDO SET CHAPA=NULL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTAFT WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VRANKFUNCIONAL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTCSD WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VHISTPOSTOPFUNC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE PPARDIRF SET CHAPAFUNC=NULL WHERE CODCOLIGADA=1 AND CHAPAFUNC = '00002'
GO

DELETE FROM PFHSTFCO WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

UPDATE VCONTROLESISTEMA SET CHAPAFUNCAVISO=NULL WHERE CODCOLIGADA=1 AND CHAPAFUNCAVISO = '00002'
GO

DELETE FROM PFHSTFER WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTHOR WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFCOMPL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTNDP WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTPROV WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VFLUXOREQPROMOCAO WHERE CODREQPROMOCAO IN (SELECT CODREQPROMOCAO FROM VREQPROMOCAO WHERE CODCOLIGADA=1 AND CHAPABENEFICIADO = '00002')
GO

UPDATE VFLUXOREQPROMOCAO SET CHAPARESPPARECER=NULL WHERE CODCOLIGADA=1 AND CHAPARESPPARECER = '00002'
GO

DELETE FROM VREQPROMOCAO WHERE CODCOLIGADA=1 AND CHAPABENEFICIADO = '00002'
GO

DELETE FROM VREQPROMOCAO WHERE CODCOLIGADA=1 AND CHAPAREQUISITANTE = '00002'
GO

DELETE FROM PFHSTSAL WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AAFHTFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AATUALFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM ABANCOHORFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM ABATFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM ABATREFFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AEAUTFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AIREFFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AJUSTFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM ASALDOBANCOHOR WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AMOVFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM APERFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM APERMFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM AREFFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM ARELFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM APARFUN WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTSEC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM VCURSOSPESSOAIS WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM PFHSTSIT WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO

DELETE FROM IBEMTRANSFERENCIA WHERE CODCOLIGADA=1 AND CHAPADESTINO = '00002'
GO

DELETE FROM PFUNC WHERE CODCOLIGADA=1 AND CHAPA = '00002'
GO