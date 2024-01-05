IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
---- Load Dropdown/Combo Dữ liệu tham chiếu màn hình Cập nhật hành động
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trọng Kiên, Date: 25/09/2020
-- <Example> EXEC CIP10411  'AS' ,'','CRMT10101' ,'CRMF1011', 'vi-VN', 'AS_ADMIN_OKIA'

CREATE PROCEDURE SP2013 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@TableID nvarchar(50),
		@TableIDDetail nvarchar(50),
		@Type NVARCHAR(50),
		@DestColumn NVARCHAR (50),
		@Bcc NVARCHAR (50),
		@Cc NVARCHAR (50),
		@From NVARCHAR (50),
		@To NVARCHAR (50),
        @ScreenID nvarchar(250),		
		@LanguageID nvarchar(250), --Biến môi trường		
		@DBAdmin NVARCHAR(250) = null
) 
AS 
BEGIN
	DECLARE @sSQL01 nvarchar(Max),
			@sSQL02 nvarchar(Max),
			@sSQL03 nvarchar(Max),
			@sWhere nvarchar(Max)
	SET @sWhere = ''
	IF (@Type LIKE N'Biến môi trường')
		BEGIN
			SET @sSQL01 = '	
				--Lấy danh sách các biến môi trường từ AT0099

				SELECT ID AS RefColumn, Description AS RefColumnName, NULL AS TableID
				FROM AT0099
				WHERE CodeMaster = ''Environment'''
			EXEC (@sSQL01)
		END
	ELSE
	BEGIN
		IF Isnull(@ScreenID, '') = '' and Isnull(@TableID, '') = '' and Isnull(@TableIDDetail, '') = ''
			BEGIN
				SET @sSQL01 = '	
				--Lấy các trường của bảng chính nếu Emailgroup chọn lấy từ trong view DRV0099
				SELECT NULL as ScreenID, NULL as ScreenName, NULL as TableID
						, ColumnID as RefColumn, ColumnName as RefColumnName
						, EmailGroup+''.''+ ColumnID as ColumnAliasID
						, ''[''+EmailGroup+''].[''+ ColumnName+'']'' as ColumnAliasName
						, 1 as OrderNo 
						--into #ResultTableID
				FROM DRV0099'
				EXEC (@sSQL01)
			END
		ELSE
			BEGIN
				IF (@DestColumn LIKE N'Mẫu Email')
					BEGIN
						SET @sSQL01 = '	
						--Lấy danh sách EmailTemplate từ AT0129

						SELECT TemplateID AS RefColumn, TemplateName AS RefColumnName, NULL AS TableID
						FROM AT0129'
						EXEC  (@sSQL01)
					END
				IF (@Bcc LIKE N'Bcc' OR @Cc LIKE N'Cc' OR @From LIKE N'Người gửi' OR @To LIKE N'Người nhận')
					BEGIN
						SET @sSQL01 = '	
						--Lấy danh sách đối tượng liên quan đến Email 

						SELECT ID AS RefColumn, Description AS RefColumnName, NULL AS TableID
						FROM AT0099
						WHERE CodeMaster =''EmailObject''
							
						UNION ALL
						--Lấy các trường UserRole > 0
						SELECT Distinct M.ColumnName as RefColumn, ''[''+D4.Name+''].[''+D1.Name+'']'' as RefColumnName, M.Systable as TableID
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								left join '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								Left join A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID and D1.LanguageID = N'''+@LanguageID+'''
								Left join '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName and D2.ScreenID = D.RefScreenMainID
								Left join '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								Left join A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  and D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable = '''+@TableID +''' and D1.Name is not null AND M.UserRoleLevel > 0 AND M.Visible = 1'
						EXEC  (@sSQL01)
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
								, M.ColumnName as ColumnID , D1.Name as ColumnName
								, '''+@ScreenID+'''+''.''+M.ColumnName as ColumnAliasID
								, ''[''+D4.Name+''].[''+D1.Name+'']'' as ColumnAliasName, 1 as OrderNo 
								into #ResultTableID
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								left join '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								Left join A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID and D1.LanguageID = N'''+@LanguageID+'''
								Left join '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName and D2.ScreenID = D.RefScreenMainID
								Left join '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								Left join A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  and D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable IN ('''+ @TableID +''','''+ REPLACE(@TableIDDetail, ',', ''',''')+ ''') and D1.Name is not null and (M.TabIndexPopup is not null and TabIndexPopup !=0) AND M.Visible = 1'
						SET @sSQL02 = '		UNION ALL
						--Lấy các trường chung đơn vị hay thông tin công ty (Luôn có biến môi trường)
						SELECT Distinct TabIndexPopup, N''CIF1121'' as ScreenID, D4.Name as ScreenName, M.Systable as TableID
								, M.ColumnName as ColumnID , D1.Name as ColumnName
								, ''CIF1121''+''.''+M.ColumnName as ColumnAliasID
								, ISNULL(''[''+D4.Name+''].[''+D1.Name+'']'', M.ColumnName) as ColumnAliasName, 3 as OrderNo 
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M With (NOLOCK)  
								left join '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK)  on M.Systable = D.TableName
								Left join A00001 D1 With (NOLOCK)  on ''CIF1121''+''.''+M.ColumnName = D1.ID and D1.LanguageID = N'''+@LanguageID+'''
								Left join '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK)  on  D2.sysTable = D.TableName and D2.ScreenID = D.RefScreenMainID
								Left join '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK)  on  D2.Parent = D3.sysScreenID
								Left join A00001 D4 With (NOLOCK)  on D3.MenuText = D4.ID  and D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable = N''AT1101'' and D1.Name is not null and (M.TabIndexPopup is not null and TabIndexPopup !=0) AND M.Visible = 1
											Union all
						--Lấy các trường bắt buộc là biến môi trường
						SELECT Distinct TabIndexPopup as ID, '''+@ScreenID+''' as ScreenID, D4.Name as ScreenName, M.Systable as TableID
								, M.ColumnName as ColumnID , D1.Name as ColumnName
								, '''+@ScreenID+'''+''.''+M.ColumnName as ColumnAliasID
								, ''[''+D4.Name+''].[''+D1.Name+'']'' as ColumnAliasName, 1 as OrderNo 
						FROM '+@DBAdmin +'.[dbo].[sysFields]  M  With (NOLOCK) 
								left join '+@DBAdmin +'.[dbo].[sysTable] D With (NOLOCK) on M.Systable = D.TableName
								Left join A00001 D1 With (NOLOCK) on '''+@ScreenID+'''+''.''+M.ColumnName = D1.ID and D1.LanguageID = N'''+@LanguageID+'''
								Left join '+@DBAdmin +'.[dbo].sysScreen D2 With (NOLOCK) on  D2.sysTable = D.TableName and D2.ScreenID = D.RefScreenMainID
								Left join '+@DBAdmin +'.[dbo].[sysMenu] D3 With (NOLOCK) on  D2.Parent = D3.sysScreenID
								Left join A00001 D4 With (NOLOCK) on D3.MenuText = D4.ID  and D4.LanguageID = N'''+@LanguageID+'''
						WHERE M.Systable = '''+@TableID +''' and D1.Name is not null AND M.ColumnName IN (''DivisionID'')
						SELECT ColumnID as RefColumn
							, ColumnAliasName as RefColumnName
							, ScreenID, ScreenName
							, TableID, ColumnName , ColumnAliasID
						FROM #ResultTableID
						ORDER BY  RefColumnName, TableID'
						EXEC  (@sSQL01+@sSQL02+@sSQL03)
						PRINT (@sSQL01+@sSQL02+@sSQL03)
					END
			END	
	END		
END













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
