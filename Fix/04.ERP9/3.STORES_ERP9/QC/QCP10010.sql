IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP10010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP10010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn tiêu chuẩn
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Le Hoang 26/04/2021
----Modified by Đình Hòa on 06/05/2021 : Tách điều kiện where dùng (MECI) 
/*
	exec QCP10010 @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @TypeID = N'BOM'
*/

 CREATE PROCEDURE [dbo].[QCP10010] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @TypeID NVARCHAR(2000), ---SIZE: Kích thước, PROP: Tính chất ,APPE: Ngoại quan, PACK: Đóng gói, BOM:Tiêu chuẩn nguyên vật liệu (BOM), MACH: Thông số vận hàng,TECH	Thông số kỹ thuật
	 @StandardID NVARCHAR(MAX) = '',
	 @TypeSheetID NVARCHAR(MAX) = ''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)	
	

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'COUNT(*) OVER ()'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (QCT1000.StandardID LIKE N''%'+@TxtSearch+'%'' 
								OR QCT1000.StandardName LIKE N''%'+@TxtSearch+'%'' 
								OR QCT1000.StandardNameE LIKE N''%'+@TxtSearch+'%'' 
								OR QCT1000.TypeID LIKE N''%'+@TxtSearch+'%''
								OR AT1304.UnitID LIKE N''%'+@TxtSearch+'%''
								OR AT1304.UnitName LIKE N''%'+@TxtSearch+'%''
								OR QCT1000.Description LIKE N''%'+@TxtSearch+'%'')'

	-- MECI không cần load theo loại này
	IF EXISTS(SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 137)
		SET @TypeID = ''

	IF ISNULL(@TypeID, '') != ''
		SET @sWhere = @sWhere + 'AND QCT1000.TypeID IN ('''+REPLACE(@TypeID,'-',''',''')+''')'

	IF ISNULL(@TypeSheetID, '') != ''
		SET @sWhere = @sWhere + 'AND QCT1000.TypeSpreadsheetID =''' + @TypeSheetID + ''''


		SET @sSQL = '

		SELECT ROW_NUMBER() OVER (ORDER BY QCT1000.StandardID, QCT1000.StandardName) AS RowNum, '+@TotalRow+' AS TotalRow, 
		QCT1000.APK, QCT1000.DivisionID, QCT1000.StandardID, QCT1000.StandardName, QCT1000.StandardNameE, 
		QCT1000.TypeID, QCT0099.Description AS TypeName, AT1304.UnitID, AT1304.UnitName
		FROM QCT1000 WITH(NOLOCK)
		LEFT JOIN AT1304 WITH(NOLOCK) ON hashbytes(''SHA1'', CAST(TRIM(QCT1000.UnitID) AS nvarchar(50))) = hashbytes(''SHA1'', CAST(TRIM(AT1304.UnitID) AS nvarchar(50)))
		LEFT JOIN QCT0099 WITH(NOLOCK) ON QCT0099.CodeMaster = ''Standard'' AND QCT0099.ID = QCT1000.TypeID
		WHERE QCT1000.Disabled = 0 AND QCT1000.DivisionID in ('''+@DivisionID+''', ''@@@'') 
		--AND ((EXISTS (SELECT TOP 1 1 FROM QCT1000 A WHERE A.ParentID IS NOT NULL AND CONCAT('','',A.ParentID,'','') LIKE ''%,''+QCT1000.StandardID+'',%'') AND TypeID = ''APPE'') 
		--OR (ISNULL(TypeID,'''') <> ''APPE''))
		' + @sWhere + '
		ORDER BY QCT1000.StandardID, QCT1000.StandardName
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		
EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
