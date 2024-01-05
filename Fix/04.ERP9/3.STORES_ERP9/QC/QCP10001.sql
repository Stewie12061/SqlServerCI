IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP10001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP10001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load màn hình chọn đối tượng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Nguyễn Hoàng Tấn Tài 28/10/2020
----Modified by Le Hoang on 26/04/2021 : Chuyển điều kiện của TypeID từ EQUAL sang IN
----Modified by Thanh Lượng on 05/04/2023 : Bổ sung load thêm các cột SRange06,SRange07
----Modified by Viết Toàn on 30/05/2023 : Bổ sung load thêm cột SRange02, SRange03, SRange04
----Modified by ... on ... 
/*
	exec QCP10001 @DivisionID=N'VNP',  @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'25', @TypeID = N'BOM'
*/

 CREATE PROCEDURE [dbo].[QCP10001] (
     @DivisionID NVARCHAR(2000),
     @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @TypeID NVARCHAR(2000), ---CHE: Hóa tính, PHY: Lý tính ,APPE: Ngoại quan, PACK: Đóng gói,OTH: KHÁC, BOM:Tiêu chuẩn nguyên vật liệu (BOM), MACH: Thông số vận hàng,TECH	Thông số kỹ thuật
	 @InventoryID VARCHAR(50) = '%'
)
AS
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerIndex int
SELECT @CustomerIndex = CustomerName from CustomerIndex

--Customize Nếu là MAITHU sẽ truyền vào loại tiêu chuẩn "Đóng gói"
if (@CustomerIndex = 117 and @TypeID = 'OTH') set @TypeID='PACK' 

	SET @sWhere = ''
	SET @TotalRow = ''

	IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'COUNT(*) OVER ()'
	
	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
								AND (QCT1000.StandardID LIKE N''%'+@TxtSearch+'%'' 
								OR QCT1000.StandardName LIKE N''%'+@TxtSearch+'%'' 
								OR QCT1000.StandardNameE LIKE N''%'+@TxtSearch+'%'' 
								OR QCT1000.Description LIKE N''%'+@TxtSearch+'%'')'

		SET @sSQL = '
		SELECT DISTINCT QCT1021.StandardID,QCT1021.SRange06,QCT1021.SRange07,SRange02,SRange03,SRange04,QCT1021.SRange08 INTO #TempStandard FROM QCT1020 WITH(NOLOCK)
		LEFT JOIN QCT1021 WITH(NOLOCK) ON QCT1020.APK = QCT1021.APKMaster
		WHERE QCT1020.InventoryID LIKE '''+@InventoryID+'''

		SELECT ROW_NUMBER() OVER (ORDER BY QCT1000.StandardID, QCT1000.StandardName) AS RowNum, '+@TotalRow+' AS TotalRow, 
		QCT1000.APK, QCT1000.DivisionID, QCT1000.StandardID, QCT1000.StandardName, QCT1000.StandardNameE, QCT1000.TypeID, AT1304.UnitID, AT1304.UnitName,temp.SRange06,temp.SRange07,temp.SRange08 AS OrderDrawing, SRange02 AS MinValue, SRange04 AS MaxValue, SRange03 AS Target
		FROM QCT1000 WITH(NOLOCK)
		LEFT JOIN AT1304 WITH(NOLOCK) ON hashbytes(''SHA1'', CAST(TRIM(QCT1000.UnitID) AS nvarchar(50))) = hashbytes(''SHA1'', CAST(TRIM(AT1304.UnitID) AS nvarchar(50)))
		LEFT JOIN #TempStandard temp WITH(NOLOCK) ON QCT1000.StandardID = temp.StandardID
		WHERE QCT1000.Disabled = 0 AND QCT1000.DivisionID in ('''+@DivisionID+''', ''@@@'') 
		AND ((ISNULL(LTRIM(RTRIM(QCT1000.ParentID)),'''') = '''' AND TypeID = ''APPE'') OR (TypeID <> ''APPE''))
		--AND ((EXISTS (SELECT TOP 1 1 FROM QCT1000 A WHERE A.ParentID IS NOT NULL AND CONCAT('','',A.ParentID,'','') LIKE ''%,''+QCT1000.StandardID+'',%'') AND TypeID = ''APPE'') OR (TypeID <> ''APPE''))
		AND QCT1000.TypeID IN ('''+REPLACE(@TypeID,',',''',''')+''')
		AND EXISTS (SELECT TOP 1 1 FROM #TempStandard A WHERE QCT1000.StandardID = A.StandardID) ' + @sWhere + '
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
