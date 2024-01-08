IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0203]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0203]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo thống kê thành phẩm sản xuất cho khách hàng Bê tông Long An (CustomizeIndex = 80) tại ERP 9.0\T
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 22/09/2017
---- Modified by Bảo Thy on 02/03/2018: lấy dữ liệu loại sản phẩm từ quy cách 01
---- Modified by Văn Tài on 20/09/2021: Sửa lỗi truyền rỗng vào store.
-- <Example>
/*
exec sp_executesql N'MP0203 @DivisionID=N''BT'',@FromMonth=07,@FromYear=2017,@ToMonth=07,@ToYear=2017,@FromDate='''',@ToDate='''',@IsDate=0,@WareHouseID=N''%'',@FromI02ID=N''D300'',@ToI02ID=N''D600C'',@FromInventoryID=N''010501'',@ToInventoryID=N''CT''',N'@CreateUserID nvarchar(10),@LastModifyUserID nvarchar(10),@DivisionID nvarchar(2)',@CreateUserID=N'ASOFTADMIN',@LastModifyUserID=N'ASOFTADMIN',@DivisionID=N'BT'


*/


CREATE PROCEDURE [dbo].[MP0203]
				 	@DivisionID NVARCHAR(50) ,
					@FromDate DATETIME,
					@ToDate DATETIME,
					@FromMonth INT,
					@FromYear INT,
					@ToMonth INT,
					@ToYear INT,
					@IsDate TINYINT,	--- 0: theo kỳ
										--- 1: theo ngày
					@WareHouseID NVARCHAR(50),
					@FromI02ID NVARCHAR(50),
					@ToI02ID NVARCHAR(50),
					@FromInventoryID NVARCHAR(50),
					@ToInventoryID NVARCHAR(50) 
 AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)

SET @sSQL = N''
SET @sSQL1 = N''
SET @sWhere = N''

IF @IsDate = 1
BEGIN
	SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),M01.VoucherDate,101) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,101)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,101)+''''
END
ELSE
BEGIN
	SET @sWhere = @sWhere + N' AND M01.TranMonth + M01.TranYear*100 BETWEEN '+CONVERT(NVARCHAR(10),@FromMonth+@FromYear*100)+' AND '+CONVERT(NVARCHAR(10),@ToMonth+@ToYear*100)
END

SET @sSQL = N'
	SELECT M01.DivisionID, CASE WHEN '''+ ISNULL(@WareHouseID,'')+''' <> ''%'' THEN '''+ ISNULL(@WareHouseID,'')+''' ELSE N''%'' END AS WareHouseID, 
		CASE WHEN '''+ ISNULL(@WareHouseID,'')+''' <> ''%'' THEN A33.WareHouseName ELSE N''' +N'Tất cả'+ ''' END AS WareHouseName,
		M02.Ana08ID, A08.AnaName AS Ana08Name, ISNULL(M02.Ana09ID,'''') AS Ana09ID, ISNULL(A09.AnaName,'''') AS Ana09Name, 
		M02.ProductID AS InventoryID, M02.ProductUnitID AS UnitID, 
		M02.S01ID, M02.S02ID, M02.S03ID, M02.S04ID, M02.S05ID, M02.S06ID, M02.S07ID, M02.S08ID, M02.S09ID, M02.S10ID,
		M02.S11ID, M02.S12ID, M02.S13ID, M02.S14ID, M02.S15ID, M02.S16ID, M02.S17ID, M02.S18ID, M02.S19ID, M02.S20ID,
		SUM(ISNULL(M02.ActualQuantity,0)) AS ActualQuantity
	INTO #TEMP
	FROM MT1801 M01 WITH (NOLOCK)
	INNER JOIN MT1802 M02 WITH (NOLOCK) ON M01.DivisionID = M02.DivisionID AND M01.VoucherID = M02.VoucherID
	LEFT JOIN AT1011 A08 WITH (NOLOCK) ON M02.Ana08ID = A08.AnaID AND A08.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON M02.Ana09ID = A09.AnaID AND A09.AnaTypeID = ''A09''
	LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.WareHouseID  = M02.WareHouseID
	WHERE M01.DivisionID = '''+@DivisionID+'''
		'+ CASE WHEN ISNULL(@FromInventoryID,'') <> '' AND ISNULL(@ToInventoryID,'') <> '' THEN ' AND M02.ProductID BETWEEN '''+ISNULL(@FromInventoryID,'')+''' AND '''+ISNULL(@ToInventoryID,'')+''' ' ELSE '' END + '
		'+ CASE WHEN ISNULL(@FromI02ID,'') <> '' AND ISNULL(@ToI02ID,'') <> '' THEN ' AND M02.S01ID BETWEEN '''+ISNULL(@FromI02ID,'')+''' AND '''+ ISNULL(@ToI02ID,'')+''' ' ELSE '' END +'
		'+ CASE WHEN ISNULL(@WareHouseID,'') <> '' THEN ' AND M02.WareHouseID LIKE '''+ISNULL(@WareHouseID,'')+''' ' ELSE '' END + '
		AND ISNULL(M02.IsImport,0) <> 0
		' + @sWhere + '
	GROUP BY M01.DivisionID, A33.WareHouseName, M02.Ana08ID, A08.AnaName, M02.Ana09ID, A09.AnaName, M02.ProductID, M02.ProductUnitID, 
		M02.S01ID, M02.S02ID, M02.S03ID, M02.S04ID, M02.S05ID, M02.S06ID, M02.S07ID, M02.S08ID, M02.S09ID, M02.S10ID,
		M02.S11ID, M02.S12ID, M02.S13ID, M02.S14ID, M02.S15ID, M02.S16ID, M02.S17ID, M02.S18ID, M02.S19ID, M02.S20ID
'	
SET @sSQL1 = '
	SELECT T.*, B.TotalProductAna08/A.TotalProduct as RateAna08, C.TotalProductAna09/B.TotalProductAna08 as RateAna09   
	FROM #TEMP T
	LEFT JOIN (
		SELECT DivisionID, SUM(ISNULL(ActualQuantity,0)) AS TotalProduct FROM #TEMP
		GROUP BY DivisionID ) A ON T.DivisionID = A.DivisionID
	LEFT JOIN (
		SELECT DivisionID, Ana08ID, SUM(ISNULL(ActualQuantity,0)) AS TotalProductAna08 FROM #TEMP
		GROUP BY DivisionID, Ana08ID ) B ON T.DivisionID = B.DivisionID AND ISNULL(T.Ana08ID,'''') = ISNULL(B.Ana08ID,'''')
	LEFT JOIN (
		SELECT DivisionID, Ana08ID, Ana09ID, SUM(ISNULL(ActualQuantity,0)) AS TotalProductAna09 FROM #TEMP
		GROUP BY DivisionID, Ana08ID, Ana09ID ) C ON T.DivisionID = C.DivisionID AND ISNULL(T.Ana08ID,'''') = ISNULL(C.Ana08ID,'''') 
													AND ISNULL(T.Ana09ID,'''') = ISNULL(C.Ana09ID,'''')
	ORDER BY Ana08ID, Ana09ID, InventoryID, 
		S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
		S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
'

PRINT @sSQL
PRINT @sSQL1

EXEC (@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

