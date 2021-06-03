use exemplo72
go


SET STATISTICS IO ON 
SELECT * 
FROM pffinanc a, pfunc b
where a.codcoligada = b.codcoligada
and a.chapa = b.chapa
SET STATISTICS IO OFF 


-- sem join
Table 'Worktable'. Scan count 14251, logical reads 71311, physical reads 0, read-ahead reads 0.
Table 'PFUNC'. Scan count 1, logical reads 6, physical reads 1, read-ahead reads 5.
Table 'PFFINANC'. Scan count 1, logical reads 245, physical reads 14, read-ahead reads 181.


-- somente com codcoligada
Table 'PFFINANC'. Scan count 1, logical reads 245, physical reads 1, read-ahead reads 0.
Table 'PFUNC'. Scan count 1, logical reads 6, physical reads 0, read-ahead reads 2.

-- com codcoligada e chapa
Table 'PFFINANC'. Scan count 1, logical reads 245, physical reads 0, read-ahead reads 0.
Table 'PFUNC'. Scan count 1, logical reads 6, physical reads 0, read-ahead reads 0.

