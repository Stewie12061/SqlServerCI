IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

















-- <Summary>
---- Load Dropdown/Combo Dữ liệu đích màn hình SF2014 Cập nhật hành động
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trọng Kiên, Date: 25/09/2020
-- <Example> EXEC CIP10411  'AS' ,'','CRMT10101' ,'CRMF1011', 'vi-VN', 'AS_ADMIN_OKIA'

CREATE PROCEDURE SP2014 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@TableID nvarchar(50),
		@TableIDDetail nvarchar(50),
        @ScreenID nvarchar(250),		
		@LanguageID nvarchar(250), --Biến môi trường		
		@DBAdmin NVARCHAR(250) = null
) 
AS 
BEGIN
	DECLARE @sSQL01 NVARCHAR(MAX),
			@sSQL02 NVARCHAR(MAX) = '',
			@sSQL03 NVARCHAR(MAX),
			@sSQL04 NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX)

	DECLARE @Combo AS TABLE (DestColumn VARCHAR(50),
							 ColumnAliasName NVARCHAR(250),
							 ShowDescriptionName VARCHAR(50),
							 ScreenID VARCHAR(50),
							 ScreenName VARCHAR(50),
							 ShowDescriptionID VARCHAR(50),
							 TableID VARCHAR(50),
							 DestColumnName NVARCHAR(250),
							 ColumnAliasID VARCHAR(50)
	)

	SET @sWhere = ''
	IF ISNULL(@ScreenID, '') = '' AND ISNULL(@TableID, '') = '' AND ISNULL(@TableIDDetail, '') = ''
		BEGIN
			SET @sSQL01 = '	
				--Lấy các trường của bảng chính nếu Emailgroup chọn lấy từ trong view DRV0099
				SELECT NULL as ScreenID, NULL as ScreenName, NULL as TableID
						, ColumnID as DestColumn, ColumnName as ShowDescriptionName
						, EmailGroup+''.''+ ColumnID as ColumnAliasID
						, ''[''+EmailGroup+''].[''+ ColumnName+'']'' as ColumnAliasName
						, 1 as OrderNo 
						--into #ResultTableID
				FORM DRV0099'
			EXEC (@sSQL01)
		END
	ELSE
		BEGIN
			IF @TableID = 'CMNT90051_1'
				BEGIN
					SET @sSQL01 = '	
						DECLARE @RefScreenID  VARCHAR(50), 
						@RefTableID  VARCHAR(50), 
						@RefScreenName nVarchar(250), 
						@OrderNo  VARCHAR(50), 
						@cur_AllDivision CURSOR
						--Lấy các trường của bảng chính nếu Emailgroup chọn lấy từ trong DBadmin
						SELECT Distinct TabIndexPopup as ID, '''+@ScreenID+''' as ScreenID, D4.Name as ScreenName, M.Systable as TableID
								, M.ColumnName as ColumnID , ISNULL(D1.Name, M.ColumnName) as ColumnName, M.sysDataTypeID as TypeValue, M.sysComboBoxID
								, '''+@ScreenID+'''+''.''+M.ColumnName as ColumnAliasID
								, ''[''+D4.Name+''].[''+D1.Name+'']'' as ColumnAliasName, 1 as OrderNo 
								into #ResultTableID
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								LEFT JOIN A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID AND D1.LanguageID = N'''+@LanguageID+'''
								LEFT JOIN '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName AND D2.ScreenID = D.RefScreenMainID
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								LEFT JOIN A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  AND D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable IN ('''+ @TableID +''','''+ REPLACE(@TableIDDetail, ',', ''',''')+ ''') AND D1.Name is not null AND (M.TabIndexPopup is not null AND TabIndexPopup !=0) AND M.Visible = 1'

						SET @sSQL02 = '	UNION ALL
						--Lấy các trường Email
						SELECT Distinct TabIndexPopup as ID, '''+@ScreenID+''' as ScreenID, D4.Name as ScreenName, M.Systable as TableID
								, M.ColumnName as ColumnID
								, CASE 
									WHEN D1.Name IS NULL THEN M.ColumnName 
									ELSE D1.Name
								  END AS ColumnName
								, M.sysDataTypeID as TypeValue, M.sysComboBoxID
								, '''+@ScreenID+'''+''.''+M.ColumnName as ColumnAliasID
								, ''[''+D4.Name+''].[''+D1.Name+'']'' as ColumnAliasName, 1 as OrderNo 
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								LEFT JOIN A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID AND D1.LanguageID = N'''+@LanguageID+'''
								LEFT JOIN '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName AND D2.ScreenID = D.RefScreenMainID
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								LEFT JOIN A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  AND D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable = '''+@TableID +''' AND D1.Name is not null AND M.Visible = 1

						SELECT ColumnID as DestColumn, sysComboBoxID as ShowDescriptionName
							, ColumnAliasName
							, ScreenID, ScreenName, TypeValue as ShowDescriptionID
							, TableID, ColumnName as DestColumnName , ColumnAliasID
						FROM #ResultTableID
						ORDER BY DestColumnName, TableID'
				END
			ELSE
				BEGIN
					SET @sSQL01 = '	
						DECLARE @RefScreenID  VARCHAR(50), 
						@RefTableID  VARCHAR(50), 
						@RefScreenName nVarchar(250), 
						@OrderNo  VARCHAR(50), 
						@cur_AllDivision CURSOR
						--Lấy các trường của bảng chính nếu Emailgroup chọn lấy từ trong DBadmin
						SELECT Distinct TabIndexPopup as ID, '''+@ScreenID+''' as ScreenID, D4.Name as ScreenName, M.Systable as TableID
								, M.ColumnName as ColumnID
								, CASE 
									WHEN D1.Name IS NULL THEN M.ColumnName 
									ELSE D1.Name
								  END AS ColumnName
								, M.sysDataTypeID as TypeValue, M.sysComboBoxID
								, '''+@ScreenID+'''+''.''+M.ColumnName as ColumnAliasID
								, ''[''+D4.Name+''].[''+D1.Name+'']'' as ColumnAliasName, 1 as OrderNo 
								INTO #ResultTableID
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								LEFT JOIN A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID AND D1.LanguageID = N'''+@LanguageID+'''
								LEFT JOIN '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName AND D2.ScreenID = D.RefScreenMainID
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								LEFT JOIN A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  AND D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable IN ('''+ @TableID +''','''+ REPLACE(@TableIDDetail, ',', ''',''')+ ''') AND D1.Name is not null AND (M.TabIndexPopup is not null AND TabIndexPopup !=0) AND M.Visible = 1'
					SET @sSQL02 = '		UNION ALL
						--Lấy các trường bắt buộc là biến môi trường
						SELECT Distinct TabIndexPopup as ID, '''+@ScreenID+''' as ScreenID, D4.Name as ScreenName, M.Systable as TableID
								, M.ColumnName as ColumnID 
								, CASE 
									WHEN D1.Name IS NULL THEN M.ColumnName 
									ELSE D1.Name
								  END AS ColumnName
								, M.sysDataTypeID as TypeValue, NULL AS sysComboBoxID
								, '''+@ScreenID+'''+''.''+M.ColumnName as ColumnAliasID
								, ''[''+D4.Name+''].[''+D1.Name+'']'' as ColumnAliasName, 1 as OrderNo 
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								LEFT JOIN A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID AND D1.LanguageID = N'''+@LanguageID+'''
								LEFT JOIN '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName AND D2.ScreenID = D.RefScreenMainID
								LEFT JOIN '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								LEFT JOIN A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  AND D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable = '''+@TableID +''' AND M.ColumnName IN (''DivisionID'',''TranMonth'',''TranYear'')

						SELECT ColumnID as DestColumn
							, ColumnAliasName, sysComboBoxID as ShowDescriptionName
							, ScreenID, ScreenName, TypeValue as ShowDescriptionID
							, TableID, ColumnName as DestColumnName , ColumnAliasID
						FROM #ResultTableID
						ORDER BY DestColumnName, TableID'

				END
		END
	PRINT (@sSQL01+@sSQL02)
	INSERT INTO @Combo(DestColumn, ColumnAliasName, ShowDescriptionName, ScreenID, ScreenName, ShowDescriptionID, TableID, DestColumnName, ColumnAliasID)
	EXEC  (@sSQL01+@sSQL02)
					
	SELECT *
	INTO #Temp
	FROM @Combo
	WHERE ShowDescriptionName IS NOT NULL
					
	DECLARE @sysComboboxID VARCHAR(50);
	DECLARE @TableValid TABLE ( IsValid TINYINT )
	DECLARE @TableValid2 TABLE ( IsValid TINYINT )
	DECLARE @TableQuery TABLE ( Query NVARCHAR(MAX) )

	WHILE EXISTS (SELECT TOP 1 1 FROM #Temp)
	BEGIN
		SELECT TOP 1 @sysComboboxID = ShowDescriptionName
		FROM #Temp

		DECLARE @SQLQuery NVARCHAR(MAX);
						
		-- Kiểm tra có phải Combobox phụ thuộc sử dụng Store hay không
		SET @sSQL03 = '(SELECT IIF((LEN(StoreParameter) - LEN(REPLACE(StoreParameter, ''=@@'', ''++''))) = (LEN(StoreParameter) - LEN(REPLACE(StoreParameter, ''=@'', ''+''))), 1, 0) AS IsValid
						FROM ' + @DBAdmin + '.[dbo].[sysComboBox] WHERE sysComboBoxID = '+@sysComboboxID+' AND StoreParameter IS NOT NULL)'
		INSERT INTO @TableValid
		EXECUTE SP_EXECUTESQL @sSQL03
						
		-- BEGIN: Kiểm tra có phải Combobox phụ thuộc sử dụng Query hay không
		-- Xóa khoảng trắng và dấu nháy đơn (') khỏi câu Query
		SET @SQLQuery ='SELECT REPLACE(REPLACE(SQLQuery, '' '', ''''), '''''''', '''') AS Query
						FROM ' + @DBAdmin + '.[dbo].[sysComboBox]
						WHERE sysComboBoxID = '+@sysComboboxID+' AND SQLQuery IS NOT NULL'
		INSERT INTO @TableQuery
		EXECUTE SP_EXECUTESQL @SQLQuery
		SET @SQLQuery = (SELECT TOP 1 * FROM @TableQuery)

		SET @sSQL04 = '(SELECT IIF((LEN('''+@SQLQuery+''') - LEN(REPLACE('''+@SQLQuery+''', ''=@@'', ''++''))) = (LEN('''+@SQLQuery+''') - LEN(REPLACE('''+@SQLQuery+''', ''=@'', ''+''))), 1, 0) AS IsValid
						FROM ' + @DBAdmin + '.[dbo].[sysComboBox] WHERE sysComboBoxID = '+@sysComboboxID+')'
		INSERT INTO @TableValid2
		EXECUTE SP_EXECUTESQL @sSQL04
						
		-- END: Kiểm tra có phải Combobox phụ thuộc sử dụng Query hay không


		IF (SELECT * FROM @TableValid) = 0 OR (SELECT * FROM @TableValid2) = 0
		BEGIN
			UPDATE @Combo SET ShowDescriptionName = NULL WHERE ShowDescriptionName = @sysComboboxID
		END
		--select * from @TableValid2

		SET @SQLQuery = ''
		DELETE @TableValid
		DELETE @TableValid2
		DELETE @TableQuery
		DELETE #Temp WHERE ShowDescriptionName = @sysComboboxID
	END					
	SELECT * FROM @Combo
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
