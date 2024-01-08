IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP10603]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP10603]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid Detail Form SOF1063 Kế thừa chỉ tiêu doanh số nhân viên bán sỉ (Sale In)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by	: Hoài Bảo, Date: 15/07/2022
----Modified by	: Văn Tài, 	Date: 14/06/2023 - [2023/06/IS/0102] Bổ sung trường hợp khách hàng muốn tạo ở Division Sellout để áp dụng chỉ tiêu.
-- <Example> EXEC SOP10603 'AS' , 'VoucherNo' , 'NV01' ,1 ,20

Create PROCEDURE SOP10603
(
    @DivisionID VARCHAR(50),		--Biến môi trường
    @TargetsIDList VARCHAR(MAX),	--Giá trị chọn trên lưới master
	@UserID  VARCHAR(50),			--Biến môi trường
	@PageNumber INT,		
	@PageSize INT
)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere AS NVARCHAR(4000),
		@OrderBy NVARCHAR(500)

SET @sWhere = ''
SET @OrderBy = ' A01.CreateDate '

IF Isnull(@DivisionID, '') != ''
	SET @sWhere = @sWhere + ' (A01.DivisionID = ''' + @DivisionID + ''' OR ST01.KeyValue = ''' + @DivisionID + ''')'
		
IF Isnull(@TargetsIDList, '') != ''
	SET @sWhere = @sWhere + ' AND A01.TargetsID IN ('+@TargetsIDList+')'


SET @sSQL = '
		SELECT DISTINCT A01.APK, A01.DivisionID, A01.TransactonID, A01.EmployeeID, O02.AnaName AS EmployeeName, A01.EmployeeLevel, O05.UserName AS EmployeeLevelName
			, A01.ObjectID, A03.ObjectName, A01.DepartmentID, A02.DepartmentName, A01.TeamID, H01.TeamName, A01.InventoryTypeID, A04.AnaName AS InventoryTypeName
			, A01.InventoryTypeID2, A05.AnaName AS InventoryTypeName2, A01.SOAna01ID, S01.AnaName AS SOAna01Name, A01.SOAna02ID, S02.AnaName AS SOAna02Name
			, A01.SOAna03ID, S03.AnaName AS SOAna03Name, A01.SOAna04ID, S04.AnaName AS SOAna04Name, A01.SOAna05ID, S05.AnaName AS SOAna05Name
			, A01.SalesMonth, A01.SalesQuarter, A01.SalesYear, A01.CreateDate
		INTO #TempAT0161
		FROM AT0161 A01 WITH (NOLOCK)
			LEFT JOIN OT1002 O02 WITH (NOLOCK) ON A01.EmployeeID = O02.AnaID
			LEFT JOIN OT1005 O05 WITH (NOLOCK) ON O05.AnaTypeID LIKE ''S%'' AND A01.EmployeeLevel = O05.AnaTypeID
			LEFT JOIN AT1102 A02 WITH (NOLOCK) ON A02.DepartmentID = A01.DepartmentID
			LEFT JOIN AT1202 A03 WITH (NOLOCK) ON A03.ObjectID = A01.ObjectID
			LEFT JOIN HT1101 H01 WITH (NOLOCK) ON A01.TeamID = H01.TeamID
			LEFT JOIN AT1015 A04 WITH (NOLOCK) ON A04.AnaID = A01.InventoryTypeID AND A04.AnaTypeID = ''I08''
			LEFT JOIN AT1015 A05 WITH (NOLOCK) ON A05.AnaID = A01.InventoryTypeID2 AND A05.AnaTypeID = ''I04''
			LEFT JOIN OT1002 S01 WITH (NOLOCK) ON A01.DivisionID = S01.DivisionID AND S01.AnaID = A01.SOAna01ID
			LEFT JOIN OT1002 S02 WITH (NOLOCK) ON A01.DivisionID = S02.DivisionID AND S02.AnaID = A01.SOAna02ID
			LEFT JOIN OT1002 S03 WITH (NOLOCK) ON A01.DivisionID = S03.DivisionID AND S03.AnaID = A01.SOAna03ID
			LEFT JOIN OT1002 S04 WITH (NOLOCK) ON A01.DivisionID = S04.DivisionID AND S04.AnaID = A01.SOAna04ID
			LEFT JOIN OT1002 S05 WITH (NOLOCK) ON A01.DivisionID = S05.DivisionID AND S05.AnaID = A01.SOAna05ID
			OUTER APPLY
			(
				SELECT TOP 1 ST01.*
				FROM ST2101 ST01 WITH (NOLOCK)
				WHERE ST01.KeyName = ''DealerDivisionID''
			) ST01
		WHERE '+@sWhere+'

		DECLARE @Count INT
		SELECT @Count = COUNT(APK) FROM #TempAT0161

		SELECT @Count AS TotalRow, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum
			   , A01.APK, A01.DivisionID, A01.TransactonID, A01.EmployeeID, A01.EmployeeName, A01.EmployeeLevel, A01.EmployeeLevelName
			   , A01.ObjectID, A01.ObjectName, A01.DepartmentID, A01.DepartmentName, A01.TeamID, A01.TeamName, A01.InventoryTypeID, A01.InventoryTypeName
			   , A01.InventoryTypeID2, A01.InventoryTypeName2, A01.SOAna01ID, A01.SOAna01Name, A01.SOAna02ID, A01.SOAna02Name
			   , A01.SOAna03ID, A01.SOAna03Name, A01.SOAna04ID, A01.SOAna04Name, A01.SOAna05ID, A01.SOAna05Name
			   , A01.SalesMonth, A01.SalesQuarter, A01.SalesYear, A01.CreateDate
		FROM #TempAT0161 A01
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT (@sSQL)
EXEC (@sSQL)
	


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
