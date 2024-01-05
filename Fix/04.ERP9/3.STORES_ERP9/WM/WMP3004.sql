IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In báo cáo thống kê lỗi sản phẩm giao công trình cho khách hàng Bê tông Long An (CustomizeIndex = 80) tại ERP 9.0\WM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 22/09/2017
---- Modified by Bảo Thy on 02/03/2018: lấy dữ liệu loại sản phẩm từ quy cách 01
---- Modified by Hoài Bảo on 23/06/2022: Cập nhật dữ quy cách, mặt hàng cho phép chọn nhiều
-- <Example>
/*
exec WMP3004 'PC', '2016-09-18 00:00:00.000', '2016-09-18 00:00:00.000', 9, 2016, 9, 2016, 0, '%', 'COC.PHC.D300C', 'TRU.D300A', '-000000016', 'VXTH-00002'

*/


CREATE PROCEDURE [dbo].[WMP3004]
				 	@DivisionID NVARCHAR(50) ,
					@DivisionIDList NVARCHAR(MAX),
					@FromDate DATETIME,
					@ToDate DATETIME,
					@PeriodList	NVARCHAR(MAX),
					@IsDate TINYINT,	--- 0: theo kỳ
										--- 1: theo ngày
					@WareHouseID NVARCHAR(50),
					@StandardID NVARCHAR(MAX),
					@InventoryID NVARCHAR(MAX)
AS

DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX)

SET @sSQL = N''
SET @sSQL1 = N''
SET @sWhere = N''

IF @IsDate = 1
BEGIN
	IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWhere = @sWhere + N' AND CONVERT(NVARCHAR(10),A06.VoucherDate,101) BETWEEN '''+CONVERT(NVARCHAR(10),@FromDate,101)+''' AND '''+CONVERT(NVARCHAR(10),@ToDate,101)+''''
END
ELSE
BEGIN
	IF ISNULL(@PeriodList,'') <> ''
		--SET @sWhere = @sWhere + N' AND A06.TranMonth + A06.TranYear*100 BETWEEN '+CONVERT(NVARCHAR(10),@FromMonth+@FromYear*100)+' AND '+CONVERT(NVARCHAR(10),@ToMonth+@ToYear*100)
		SET @sWhere = @sWhere + N' AND CONVERT(varchar(20),A06.TranMonth/100*A06.TranYear) IN ('''+ @PeriodList +''')'
END

SET @sSQL = N'
	SELECT A06.DivisionID, CASE WHEN '''+@WareHouseID+''' <> ''%'' THEN '''+@WareHouseID+''' ELSE N''%'' END AS WareHouseID, 
		CASE WHEN '''+@WareHouseID+''' <> ''%'' THEN (CASE WHEN ISNULL(A06.IsDelivery,0) = 1 THEN A33.WareHouseName ELSE A34.WareHouseName END ) ELSE N'''+N'Tất cả'+''' END AS WareHouseName,
		A07.Ana09ID, A09.AnaName AS Ana09Name, A07.InventoryID, A07.UnitID,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		SUM(ISNULL(A07.ActualQuantity,0)) AS ActualQuantity,
		A06.IsReturn, A06.IsDelivery
	INTO #TEMP
	FROM AT2006 A06 WITH (NOLOCK)
	INNER JOIN AT2007 A07 WITH (NOLOCK) ON A07.DivisionID = A06.DivisionID AND A07.VoucherID = A06.VoucherID
	LEFT JOIN WT8899 O99 WITH (NOLOCK) ON O99.DivisionID = A07.DivisionID AND O99.TransactionID = A07.TransactionID AND O99.VoucherID = A07.VoucherID
	LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.InventoryID = A07.InventoryID
	LEFT JOIN AT1323 I02 WITH (NOLOCK) ON I02.InventoryID = A32.InventoryID AND I02.StandardTypeID = ''S01''
	LEFT JOIN AT1011 A09 WITH (NOLOCK) ON A07.Ana09ID = A09.AnaID AND A09.AnaTypeID = ''A09''
	LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.WareHouseID = A06.WareHouseID
	LEFT JOIN AT1303 A34 WITH (NOLOCK) ON A34.WareHouseID = A06.WareHouseID2
	WHERE A06.DivisionID = '''+@DivisionID+'''
		AND A07.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' + @InventoryID + ''', '',''))
		AND I02.StandardID IN (SELECT Value FROM dbo.StringSplit(''' + @StandardID + ''', '',''))
		AND A06.KindVoucherID = 3
		AND ((A06.WareHouseID2 LIKE '''+@WareHouseID+''' AND A06.IsReturn IN (1,2)) OR (A06.IsDelivery = 1 AND A06.WareHouseID LIKE '''+@WareHouseID+'''))
		' + @sWhere + '
	GROUP BY A06.DivisionID, A33.WareHouseName, A34.WareHouseName, A07.Ana09ID, A09.AnaName, A07.InventoryID, A07.UnitID,
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		A06.IsReturn, A06.IsDelivery
'	
SET @sSQL1 = N'
	SELECT T.*, N''Hàng đạt'' AS HD_Name, N''Cọc loại'' AS CL_Name, N''Sự cố'' AS SC_Name, 
		CASE WHEN ISNULL(A.TotalDelivery,0) <> 0 THEN ISNULL(C.Total_CocLoai,0)/A.TotalDelivery*100 ELSE 0 END AS Rate_CocLoai, 
		CASE WHEN ISNULL(A.TotalDelivery,0) <> 0 THEN ISNULL(D.Total_SuCo,0)/A.TotalDelivery*100 ELSE 0 END AS Rate_SuCo,
		CASE WHEN ISNULL(C.Total_CocLoai,0) <> 0 THEN ISNULL(E.Total_Ana09ID_CL,0)/C.Total_CocLoai*100 ELSE 0 END AS Rate_Ana09_CL, 
		CASE WHEN ISNULL(D.Total_SuCo,0) <> 0 THEN ISNULL(F.Total_Ana09ID_SC,0)/D.Total_SuCo ELSE 0 END AS Rate_Ana09_SC 
	FROM #TEMP T
	LEFT JOIN (
		SELECT DivisionID, SUM(ISNULL(ActualQuantity,0)) AS TotalDelivery FROM #TEMP
		WHERE ISNULL(IsDelivery,0) = 1
		GROUP BY DivisionID ) A ON T.DivisionID = A.DivisionID
	LEFT JOIN (
		SELECT DivisionID, SUM(ISNULL(ActualQuantity,0)) AS TotalReturn FROM #TEMP
		WHERE ISNULL(IsReturn,0) IN ( 1,2)
		GROUP BY DivisionID ) B ON T.DivisionID = B.DivisionID
	LEFT JOIN (
		SELECT DivisionID, SUM(ISNULL(ActualQuantity,0)) AS Total_CocLoai FROM #TEMP
		WHERE ISNULL(IsReturn,0) = 1
		GROUP BY DivisionID 
		) C ON T.DivisionID = C.DivisionID 
	LEFT JOIN (
		SELECT DivisionID, SUM(ISNULL(ActualQuantity,0)) AS Total_SuCo FROM #TEMP
		WHERE ISNULL(IsReturn,0) = 2
		GROUP BY DivisionID 
		) D ON T.DivisionID = D.DivisionID 
	LEFT JOIN (
		SELECT DivisionID, Ana09ID, SUM(ISNULL(ActualQuantity,0)) AS Total_Ana09ID_CL FROM #TEMP
		WHERE ISNULL(IsReturn,0) = 1
		GROUP BY DivisionID, Ana09ID 
		) E ON T.DivisionID = E.DivisionID AND ISNULL(T.Ana09ID,'''') = ISNULL(E.Ana09ID,'''')
	LEFT JOIN (
		SELECT DivisionID, Ana09ID, SUM(ISNULL(ActualQuantity,0)) AS Total_Ana09ID_SC FROM #TEMP
		WHERE ISNULL(IsReturn,0) = 2
		GROUP BY DivisionID, Ana09ID 
		) F ON T.DivisionID = F.DivisionID AND ISNULL(T.Ana09ID,'''') = ISNULL(F.Ana09ID,'''')
	ORDER BY Ana09ID, InventoryID,
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
