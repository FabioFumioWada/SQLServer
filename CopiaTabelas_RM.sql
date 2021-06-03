


create procedure Sp_Copia_Coligada ( @de int , @para int , @tabela varchar(256) )

As

Declare @campos varchar(8000)
Declare @campos1 varchar(8000)
Declare @campos2 varchar(8000)
Declare @campos3 varchar(8000)
Declare @campos4 varchar(8000)
Declare @campos5 varchar(8000)
Declare @comando varchar(8000)
Declare @Colid int
Declare @I 	int 
Set @i = 1

set @Colid =(Select Max(colid) From Syscolumns where object_name(id)=@tabela)


	While @i <=@Colid

	Begin

	
	Set @Campos=(select name from syscolumns where object_name(id)=@tabela and Colid=@i)

		Begin

		
		If @i = @colid
		Begin
			
		Set @Campos3= @Campos+','+@Campos1+'[]'
		Set @Campos5= @Campos+','+@campos5+'[]'
		Set @Campos5= Replace(@Campos5,',[]','')
		Set @Campos3= Replace(@Campos3,',[]','')
	
		Set @Comando =( 'Insert into '+@Tabela+ ' ('+@Campos3+') '+
				'Select '+@Campos5+' From '+@Tabela+' Where CodColigada='+Convert(Varchar,@De) )

		Exec (@Comando)
		
	
		End

		Set @Campos1=@Campos+','+Isnull(@Campos1,'')
		

		
		if @Campos like 'CodColigada%' or @Campos like 'CodCol%' or @Campos like '%Coligada%'
		Begin
		Set @Campos5=Convert(varchar,@Para)+','+Isnull(@Campos5,'')
		End
		else
		Begin 
		Set @Campos5=@Campos+','+Isnull(@Campos5,'')
		End



		Set @i=@i + 1

		end	

	End




