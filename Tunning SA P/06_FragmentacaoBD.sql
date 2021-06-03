DECLARE @db_id int;
DECLARE db_cursor CURSOR FOR
SELECT dbid
FROM MASTER.dbo.sysdatabases
WHERE name NOT IN ('master','model','msdb','tempdb')

OPEN db_cursor

FETCH NEXT FROM db_cursor INTO @db_id

WHILE @@FETCH_STATUS = 0
BEGIN
select DB_NAME(@db_id) as [Database]
,object_name(IPS.[object_id]) as [TableName]
,SI.index_id as [SI.index_id]
,SI.name AS [IndexName]
,IPS.index_type_desc
,IPS.index_id
,ROUND(IPS.avg_fragmentation_in_percent,2) AS avg_fragmentation_in_percent
,ROUND(IPS.avg_fragmentation_in_percent,2) AS avg_fragmentation_in_percent
,IPS.record_count
,IPS.fragment_count
from sys.dm_db_index_physical_stats(@db_id, null, null, null, 'detailed') as IPS
inner join sys.indexes as SI with (nolock) on IPS.[object_id] = SI.[object_id] and IPS.index_id = SI.index_id
inner join sys.tables as ST with (nolock) on IPS.[object_id] = ST.[object_id]
where ST.is_ms_shipped = 0
and IPS.avg_fragmentation_in_percent>=10 
and IPS.page_count>25 
and IPS.index_type_desc<>'heap' 
and IPS.index_level=0 
order by IPS.avg_fragmentation_in_percent desc

FETCH NEXT FROM db_cursor INTO @db_id
END
CLOSE db_cursor
DEALLOCATE db_cursor

 /*
 Pra quem quer entender o script, estou apenas dando um select na DMV que comentamos acima e relacionando ela com as tabelas de sistema sys.indexes e sys.tables, para obtermos os nomes dos objetos. Na cláusula where temos:

 

is_ms_shipped = para distinguir objetos criados por você dos objetos que já vem no SQL Server;

avg_fragmentation_in_percent > 10 = não queremos saber sobre os objetos contíguos, somente os fragmentados;

page_count > 25 = objetos muito pequenos nem compensa levantar fragmentação. Uma tabela que ocupa duas páginas, por exemplo, se estas não estiverem uma ao lado da outra, já estaria 50% fragmentada. Vamos ver somente objetos com mais de 25 páginas;

index_type_desc <> 'heap'  = eu geralmente comento esta linha pois se é heap e tem mais de 25 páginas, deveria ao menos ter um índice, então já aproveito este report para levantar essas heaps;

index_level = para o relatório não ficar confuso, vamos analisar o nível onde ficam os dados, já que durante o REBUILD todos os níveis são refeitos;



avg_fragmentation_in_percent: diz respeito a fragmentação lógica, ou seja, de todas as páginas do objeto quantas estão fora de ordem, em porcentagem;

avg_page_space_used_in_percent: aqui podemos ver a fragmentação física, o quanto as páginas de dados estão preenchidas com registros. Depois de fazer um REBUILD com o FILL FACTOR em 90%, por exemplo, devemos ver esta coluna com 90% no caso dos índices;

record_count: quantos registros este objeto possui. É uma informação útil pra saber se é um objeto grande, com muitos registros;

fragment_count: suponhamos que você tem um objeto de 30 páginas e as dez primeiras estão contíguas em um bloco, outras dez estão 50 páginas depois e as últimas 10 em um outro bloco de páginas mais adiante. Neste caso teríamos fragment_count igual a 3.

 

*/

