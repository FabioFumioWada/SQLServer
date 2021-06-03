/* criação dos usuários */
/* inserida para delecao de usuarios*/
sp_configure 'allow updates','1'
go
reconfigure with override
go
select * from sysusers
go
delete from sysusers where name = '\rm'
go
delete from sysusers where name = 'sysdba'
go 
select * from sysusers
go
if not exists(select * from master.dbo.syslogins where name = 'rm')
   exec sp_addlogin rm,rm
go
sp_addalias rm,dbo
go
if not exists(select * from master.dbo.syslogins where name = 'sysdba')
  exec sp_addlogin sysdba,masterkey
go
sp_adduser sysdba,sysdba,db_owner
go
grant select,insert,delete,update on gparams to sysdba
go
grant select,insert,delete,update on gusuario to sysdba
go
grant select,insert,delete,update on gpermis  to sysdba
go
grant select,insert,delete,update on gacesso  to sysdba
go
grant select,insert,delete,update on gsistema  to sysdba
go
grant select,insert,delete,update on gcoligada  to sysdba
go
grant select,insert,delete,update on gusrperfil to sysdba
go
sp_configure 'allow updates','0'
go
reconfigure with override
go