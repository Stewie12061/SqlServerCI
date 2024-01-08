----Create by Trương Ngọc Phương Thảo on 07/09/2016
----Purpose : Đồng bộ cấu trúc bảng giữa bảng gốc và bảng được tách
IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)
BEGIN
	DECLARE @sSQL Nvarchar(max),
			@StrTable Nvarchar(max),
			@StrIndex Nvarchar(max),
			@StrPK Nvarchar(max)

	SELECT COL.Name AS [Column Name], TAB.Name,
		(CASE WHEN TYP.Name like '%char%' THEN TYP.Name +' (' + LTRIM(RTRIM(STR(COL.Length/CASE WHEN TYP.Name LIKE 'n%char%' THEN 2 ELSE 1 END))) + ')'
			WHEN TYP.Name ='decimal' THEN TYP.Name +'(' + LTRIM(RTRIM(STR(COL.XPrec))) + ', ' + LTRIM(RTRIM(STR(COL.XScale))) + ')'
			ELSE TYP.Name END) AS [Data Type],
		IsNullAble AS [IsNull],
		(CASE WHEN IsNull(COM.Text, '') = '' THEN '' ELSE SUBSTRING(COM.Text,2,LEN(COM.Text)-2) END) AS [Default],
		ISNULL(i.is_primary_key, 0) 'Primary Key',
		i.type_desc
	INTO	#TABLE_ORIGINAL 
	FROM SYSCOLUMNS COL  WITH(NOLOCK)
	INNER JOIN SYSOBJECTS TAB  WITH(NOLOCK) ON COL.ID = TAB.ID
	INNER JOIN SYSTYPES TYP  WITH(NOLOCK) ON TYP.XType = COL.XType AND TYP.Name <> 'sysname'
	LEFT JOIN SYSOBJECTS TAB2  WITH(NOLOCK) ON TAB2.ID = COL.CDefault
	LEFT JOIN SYSCOMMENTS COM  WITH(NOLOCK) ON COM.ID = TAB2.ID
	LEFT OUTER JOIN sys.index_columns ic ON ic.object_id = COL.ID
										AND ic.column_id = COL.colid
	LEFT OUTER JOIN sys.indexes i ON ic.object_id = i.object_id
									AND ic.index_id = i.index_id
	WHERE TAB.Name IN (SELECT DISTINCT TableName FROM AV9991 WHERE Disable = 0 ) 
	ORDER BY TAB.Name, COL.ColOrder


	SELECT @StrTable = CASE WHEN Isnull(@StrTable,'') = '' THEN '(TAB.Name LIKE ''' + TableName + 'M%'' OR TAB.Name LIKE ''' + TableName + 'Y%'')'  
			ELSE @StrTable+  ' OR (TAB.Name LIKE ''' + TableName + 'M%'' OR TAB.Name LIKE ''' + TableName + 'Y%'')'  END
	FROM (SELECT DISTINCT TableName FROM AV9991 WHERE Disable = 0 ) T

	
	SELECT *, Convert(Varchar(50),'') AS OriginalTableName
	INTO	#TABLE_Period 
	FROM	#TABLE_ORIGINAL
	WHERE 1 = 0

	
	set @sSQL = '
	INSERT INTO #TABLE_Period 
	SELECT COL.Name AS [Column Name], TAB.Name,
		(CASE WHEN TYP.Name like ''%char%'' THEN TYP.Name +'' ('' + LTRIM(RTRIM(STR(COL.Length/CASE WHEN TYP.Name LIKE ''n%char%'' THEN 2 ELSE 1 END))) + '')''
			WHEN TYP.Name =''decimal'' THEN TYP.Name +''('' + LTRIM(RTRIM(STR(COL.XPrec))) + '', '' + LTRIM(RTRIM(STR(COL.XScale))) + '')''
			ELSE TYP.Name END) AS [Data Type],
		IsNullAble AS [IsNull],
		(CASE WHEN IsNull(COM.Text, '''') = '''' THEN '''' ELSE SUBSTRING(COM.Text,2,LEN(COM.Text)-2) END) AS [Default],
		ISNULL(i.is_primary_key, 0) ''Primary Key'',
		i.type_desc,  LEFT(TAB.Name,6) AS OriginalTableName
	--INTO	#TABLE_Period 
	FROM SYSCOLUMNS COL  WITH(NOLOCK)
	INNER JOIN SYSOBJECTS TAB  WITH(NOLOCK) ON COL.ID = TAB.ID
	INNER JOIN SYSTYPES TYP  WITH(NOLOCK) ON TYP.XType = COL.XType AND TYP.Name <> ''sysname''
	LEFT JOIN SYSOBJECTS TAB2  WITH(NOLOCK) ON TAB2.ID = COL.CDefault
	LEFT JOIN SYSCOMMENTS COM  WITH(NOLOCK) ON COM.ID = TAB2.ID
	LEFT OUTER JOIN sys.index_columns ic ON ic.object_id = COL.ID
										AND ic.column_id = COL.colid
	LEFT OUTER JOIN sys.indexes i ON ic.object_id = i.object_id
									AND ic.index_id = i.index_id
	WHERE  1= 1 AND ( '+@StrTable+' )
	ORDER BY TAB.Name, COL.ColOrder
	
	'
	--print @sSQL
	exec (@sSQL)
	Declare @Cur CURSOR,
			@TableName Varchar(50),
			@ColumnName Varchar(50),
			@Typedesc Varchar(50),
			@DataType Varchar(50),
			@IsNull Int,
			@Default Varchar(50),
			@Index Varchar(50)
		
	-------------------------------- ĐỒNG BỘ TRƯỜNG DỮ LIỆU CHO BẢNG CON TÁCH THEO KỲ, NĂM ---------------------------------------
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	T2.name, T1.[Column Name], T1.[Data Type], T1.IsNull--, T1.[Default]
	FROM	#TABLE_ORIGINAL T1
	INNER JOIN #TABLE_Period T2 ON T1.name = T2.OriginalTableName
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TABLE_Period T3 WHERE T1.name = T3.OriginalTableName AND T1.[Column Name] = T3.[Column Name])

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @DataType, @IsNull--, @Default
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		set @sSQL = '
			IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id=tab.id WHERE tab.name= '''+@TableName+''' AND col.name= '''+@ColumnName+''')
			ALTER TABLE '+@TableName+' ADD '+@ColumnName+' '+@DataType+ CASE WHEN @IsNull = 1 THEN' NULL '  ELSE ' NOT NULL ' END
				-- + CASE WHEN Isnull(@Default,'') <> '' THEN  'DEFAULT ('+@Default+') ' ELSE '' END
		--print @sSQL
		exec (@sSQL)

	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @DataType, @IsNull--, @Default
	END 
	Close @Cur 

	-------------------------------- ĐỒNG BỘ KIỂU DỮ LIỆU CHO BẢNG CON TÁCH THEO KỲ, NĂM  (CHANGE DATATYPE) ---------------------------------------
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	T1.name, T2.[Column Name], T2.[Data Type]
	FROM	#TABLE_Period  T1
	INNER JOIN #TABLE_ORIGINAL T2 ON T1.OriginalTableName = T2.Name AND T1.[Column Name] = T2.[Column Name]
	WHERE T1.[Data Type] <> T2.[Data Type]

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @DataType
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		set @sSQL = '
			ALTER TABLE '+@TableName+' ALTER COLUMN '+@ColumnName + ' '+ @DataType
		--print @sSQL
		exec (@sSQL)

	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @DataType
	END 
	Close @Cur 

	-------------------------------- SET KHÓA CHO BẢNG CON TÁCH THEO KỲ, NĂM ---------------------------------------
	SELECT	T1.name, T2.[Column Name]
	INTO	#TABLE_pk
	FROM	#TABLE_Period  T1
	INNER JOIN #TABLE_ORIGINAL T2 ON T1.OriginalTableName = T2.Name AND T1.[Column Name] = T2.[Column Name]
	WHERE T1.[Primary Key] = 0 AND T2.[Primary Key] = 1 


	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	 name, 
			CONVERT(VARCHAR(8000), SUBSTRING(
					(SELECT	[Column Name] + ', '
					FROM	#TABLE_pk A 
					WHERE	A.name = B.name										
					ORDER BY A.name
					FOR XML PATH ('') 
					), 1 , LEN(
								(SELECT	[Column Name] + ', '
								FROM	#TABLE_pk A 
								WHERE	A.name = B.name										
								ORDER BY A.name
								FOR XML PATH ('')
								)
							) - 1
			)) AS StrPK
			
	FROM		#TABLE_pk B 
	GROUP BY	name

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableName, @StrPK
	WHILE @@FETCH_STATUS = 0
	BEGIN
		set @sSQL = '
			ALTER TABLE '+@TableName+' ADD CONSTRAINT pk_'+@TableName+ ' PRIMARY KEY CLUSTERED
			( 
				'+@StrPK+'
			)  WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
			'
		--print @sSQL	
		exec (@sSQL)

	FETCH NEXT FROM @Cur INTO @TableName, @StrPK
	END 
	Close @Cur 


	-------------------------------- SET INDEX CHO BẢNG CON TÁCH THEO KỲ, NĂM ---------------------------------------
	--SELECT	T1.name, T2.[Column Name]
	--INTO	#TABLE_Index
	--FROM	#TABLE_Period  T1
	--INNER JOIN #TABLE_ORIGINAL T2 ON T1.OriginalTableName = T2.Name AND T1.[Column Name] = T2.[Column Name]
	--WHERE ISNULL(T1.type_desc,'') = '' AND ISNULL(T2.type_desc,'') = 'NONCLUSTERED'



	--SET @Cur = CURSOR SCROLL KEYSET FOR
	--SELECT	 name, 
	--		CONVERT(VARCHAR(8000), SUBSTRING(
	--				(SELECT	[Column Name] + ', '
	--				FROM	#TABLE_Index A 
	--				WHERE	A.name = B.name										
	--				ORDER BY A.name
	--				FOR XML PATH ('') 
	--				), 1 , LEN(
	--							(SELECT	[Column Name] + ', '
	--							FROM	#TABLE_Index A 
	--							WHERE	A.name = B.name										
	--							ORDER BY A.name
	--							FOR XML PATH ('')
	--							)
	--						) - 1
	--		)) AS StrIndex
			
	--FROM		#TABLE_Index B 
	--GROUP BY	name

	--OPEN @Cur
	--FETCH NEXT FROM @Cur INTO @TableName, @Index
	--WHILE @@FETCH_STATUS = 0
	--BEGIN	
	--	set @sSQL = '
	--		IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'''+@TableName+''') AND name = N''INDX_'+@TableName+''')
	--		DROP INDEX [INDX_'+@TableName+'] ON [dbo].['+@TableName+'] WITH ( ONLINE = OFF )		

	--		CREATE NONCLUSTERED INDEX [INDX_'+@TableName+'] ON [dbo].['+@TableName+'] 
	--		( 
	--			'+@Index+'
	--		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
		
	--		'
	--	print @sSQL
	--	exec (@sSQL)

	--FETCH NEXT FROM @Cur INTO @TableName, @Index
	--END 
	--Close @Cur 

	-------------------------------- SET ISNULL CHO BẢNG CON TÁCH THEO KỲ, NĂM ---------------------------------------
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	T1.name, T2.[Column Name], T2.[IsNull], T2.[Data Type]
	FROM	#TABLE_Period  T1
	INNER JOIN #TABLE_ORIGINAL T2 ON T1.OriginalTableName = T2.Name AND T1.[Column Name] = T2.[Column Name]
	WHERE T1.[IsNull] <> T2.[IsNull]

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @IsNull, @DataType
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		set @sSQL = '
			ALTER TABLE '+@TableName+' ALTER COLUMN '+@ColumnName + ' '+ @DataType + CASE WHEN @IsNull = 1 THEN ' NULL' ELSE ' NOT NULL' END
		--print @sSQL
		exec (@sSQL)

	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @IsNull, @DataType
	END 
	Close @Cur 

	-------------------------------- SET DEFAULT CHO BẢNG CON TÁCH THEO KỲ, NĂM ---------------------------------------
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	T1.name, T2.[Column Name], T2.[Default], T2.[Data Type]
	FROM	#TABLE_Period  T1
	INNER JOIN #TABLE_ORIGINAL T2 ON T1.OriginalTableName = T2.Name AND T1.[Column Name] = T2.[Column Name]
	WHERE T1.[Default] <> T2.[Default]

	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @Default, @DataType
	WHILE @@FETCH_STATUS = 0
	BEGIN	
		set @sSQL = '
			ALTER TABLE '+@TableName+' ADD DEFAULT ('+CASE WHEN @DataType LIKE '%char%' THEN ''+@Default+'' ELSE @Default END+') FOR '+@ColumnName+''
		--print @sSQL
		exec (@sSQL)

	FETCH NEXT FROM @Cur INTO @TableName, @ColumnName, @Default, @DataType
	END 
	Close @Cur 
	
	DROP TABLE #TABLE_Period 
	DROP TABLE #TABLE_ORIGINAL 
	DROP TABLE #TABLE_pk
END