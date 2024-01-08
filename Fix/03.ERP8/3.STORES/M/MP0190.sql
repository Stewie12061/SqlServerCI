IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0190]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0190]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Customize Angel: In báo cáo thống kê hàng đạt - hàng hư tại MF0189 (ANGEL)
---- Created by Tiểu Mai on 10/04/2017
---- Modified by Tiểu Mai on 29/05/2017: Bổ sung TeamName, lấy dữ liệu theo kỳ kế toán
---- Modified by Kim Thư on 10/10/2018: Bổ sung xử lý khi truyền biến %
---- Modified by Kim Thư on 20/06/2019: Bổ sung định dạng số lẻ của số lượng theo thiết lập đơn vị
---- Modified by Huỳnh Thử on 12/03/2021: Bổ sung tỉ lệ lỗi

---- EXEC MP0190 'ANG', 201705, 201705, '2017-03-01 00:00:00.000', '2017-03-31 00:00:00.000', 'TCR', 'BPMUA1', 'VL', 'BBCN01', 'XOABO', 0

CREATE PROCEDURE [dbo].[MP0190] 
    @DivisionID NVARCHAR(50),
    @FromPeriod INT,
	@ToPeriod INT,
    @FromDate DATETIME,
    @ToDate DATETIME,
    @TeamID NVARCHAR(50),
    @InventoryTypeID NVARCHAR(50),
    @InventoryID NVARCHAR(50),
    @TimeMode TINYINT,
	@ErrorRate FLOAT
AS

DECLARE @sSQl NVARCHAR(4000), @sWhere NVARCHAR(4000),
		@sWhere1 NVARCHAR(4000) = '',
		@sWhere2 NVARCHAR(4000) = '',
		@QuantityDecimals INT,
		@sSQl2 NVARCHAR(MAX),
		@sSQl3 NVARCHAR(MAX),
		@Res NVARCHAR(50)


SELECT @QuantityDecimals = QuantityDecimals FROM AT1101 WHERE DivisionID=@DivisionID

SET @sSQl = N''
SET @sSQl2 = N''
SET @sSQl3 = N''
SET @sWhere = N''

IF @TimeMode = 0
BEGIN
	SET @sWhere = @sWhere + N'
	AND M81.TranMonth + M81.TranYear * 100 BETWEEN '+Convert(Nvarchar(10),@FromPeriod)+' AND '+CONVERT(NVARCHAR(10),@ToPeriod)										
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + N'
	AND M81.VoucherDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''''								
END	

-- Xử lý trường hợp truyền biến %
IF @InventoryID <> '%'
	SET @sWhere1=@sWhere1+' AND M82.ProductID = ''' + @InventoryID + ''' '

IF @InventoryTypeID <>'%'
	SET @sWhere2=@sWhere2+' AND A13.InventoryTypeID = ''' + @InventoryTypeID + ''' '
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductIDNotIn]') AND type in (N'U'))
CREATE TABLE ProductIDNotIn (ProductID NVARCHAR(250))
DELETE ProductIDNotIn

SET @sSQl2 = N'
DECLARE @Cur_Ware AS CURSOR, 
		@ProductID NVARCHAR(250),
		@SumHangHu DECIMAL(28,8),
		@SumHangDat DECIMAL(28,8)

SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
			SELECT DISTINCT  M82.ProductID
FROM MT1802 M82 WITH (NOLOCK)
LEFT JOIN MT1801 M81 WITH (NOLOCK) ON M81.DivisionID = M82.DivisionID AND M81.VoucherID = M82.VoucherID
LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID = M82.DivisionID AND A13.InventoryID = M82.ProductID
LEFT JOIN AT1301 A11 WITH (NOLOCK) ON A11.DivisionID = M82.DivisionID AND A11.InventoryTypeID = A13.InventoryTypeID
LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.DivisionID = A13.DivisionID AND A15.AnaID = A13.I04ID AND A15.AnaTypeID = ''I04''
LEFT JOIN AT0148 A48 WITH (NOLOCK) ON M82.DivisionID = A48.DivisionID AND M82.ErrorTypeID = A48.ProErrorID
LEFT JOIN AT1304 A34 WITH (NOLOCK) ON A13.DivisionID = A34.DivisionID AND A34.UnitID = A13.UnitID
LEFT JOIN HT1101 H11 WITH (NOLOCK) ON M81.DivisionID = H11.DivisionID AND H11.TeamID = M81.TeamID
WHERE M81.DivisionID = '''+@DivisionID+''' 
	' +@sWhere1+ @sWhere2+'
	AND M81.TeamID LIKE '''+@TeamID+'''
	AND M82.TypeTab IN (2, 3) ' + @sWhere + '
ORDER BY M82.ProductID
OPEN @Cur_Ware
FETCH NEXT FROM @Cur_Ware INTO  @ProductID
WHILE @@Fetch_Status = 0 
BEGIN
	SET @SumHangHu = 0
	SET @SumHangDat = 0
	SELECT @SumHangHu = ROUND(SUM(CASE WHEN TypeTab = 2 THEN ISNULL(M82.ActualQuantity,0) ELSE ISNULL(M82.ErrorQuantity,0) END),3) 
	FROM MT1802 M82 WITH (NOLOCK)
	LEFT JOIN MT1801 M81 WITH (NOLOCK) ON M81.DivisionID = M82.DivisionID AND M81.VoucherID = M82.VoucherID
	LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID = M82.DivisionID AND A13.InventoryID = M82.ProductID
	LEFT JOIN AT1301 A11 WITH (NOLOCK) ON A11.DivisionID = M82.DivisionID AND A11.InventoryTypeID = A13.InventoryTypeID
	LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.DivisionID = A13.DivisionID AND A15.AnaID = A13.I04ID AND A15.AnaTypeID = ''I04''
	LEFT JOIN AT0148 A48 WITH (NOLOCK) ON M82.DivisionID = A48.DivisionID AND M82.ErrorTypeID = A48.ProErrorID
	LEFT JOIN AT1304 A34 WITH (NOLOCK) ON A13.DivisionID = A34.DivisionID AND A34.UnitID = A13.UnitID
	LEFT JOIN HT1101 H11 WITH (NOLOCK) ON M81.DivisionID = H11.DivisionID AND H11.TeamID = M81.TeamID
	WHERE M81.DivisionID = '''+@DivisionID+''' 
	' +@sWhere1+ @sWhere2+'
	AND M81.TeamID LIKE '''+@TeamID+'''
	AND M82.TypeTab IN (3) ' + @sWhere + '
	AND M82.ProductID = @ProductID
GROUP BY M81.TeamID, H11.TeamName, M82.ProductID, A13.InventoryName , M82.UnitID, A34.UnitName, A13.I04ID, A15.AnaName, TypeTab

SELECT @SumHangDat = ROUND(SUM(CASE WHEN TypeTab = 2 THEN ISNULL(M82.ActualQuantity,0) ELSE ISNULL(M82.ErrorQuantity,0) END),3) 
	FROM MT1802 M82 WITH (NOLOCK)
	LEFT JOIN MT1801 M81 WITH (NOLOCK) ON M81.DivisionID = M82.DivisionID AND M81.VoucherID = M82.VoucherID
	LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID = M82.DivisionID AND A13.InventoryID = M82.ProductID
	LEFT JOIN AT1301 A11 WITH (NOLOCK) ON A11.DivisionID = M82.DivisionID AND A11.InventoryTypeID = A13.InventoryTypeID
	LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.DivisionID = A13.DivisionID AND A15.AnaID = A13.I04ID AND A15.AnaTypeID = ''I04''
	LEFT JOIN AT0148 A48 WITH (NOLOCK) ON M82.DivisionID = A48.DivisionID AND M82.ErrorTypeID = A48.ProErrorID
	LEFT JOIN AT1304 A34 WITH (NOLOCK) ON A13.DivisionID = A34.DivisionID AND A34.UnitID = A13.UnitID
	LEFT JOIN HT1101 H11 WITH (NOLOCK) ON M81.DivisionID = H11.DivisionID AND H11.TeamID = M81.TeamID
	WHERE M81.DivisionID = '''+@DivisionID+''' 
	' +@sWhere1+ @sWhere2+'
	AND M81.TeamID LIKE '''+@TeamID+'''
	AND M82.TypeTab IN (2) ' + @sWhere + '
	AND M82.ProductID = @ProductID'
	SET @sSQl3 = '
GROUP BY M81.TeamID, H11.TeamName, M82.ProductID, A13.InventoryName , M82.UnitID, A34.UnitName, A13.I04ID, A15.AnaName, TypeTab
	
	
	IF( ( Case when (@SumHangHu + @SumHangDat) * 100 > 0 Then (@SumHangHu + @SumHangDat) * 100 Else 1 End ) = 1  )
	BEGIN
	    Print @ProductID
	END
	ELSE IF @SumHangHu /  (@SumHangHu + @SumHangDat) * 100 > ISNULL('+ltrim(@ErrorRate)+',0)
	BEGIN
		INSERT INTO dbo.ProductIDNotIn
	    VALUES
	    (
			@ProductID -- ProductID - nvarchar(250)
		)
	END
    FETCH NEXT FROM @Cur_Ware INTO @ProductID
END

CLOSE @Cur_Ware
'
set @Res = N'Hàng đạt'
SET @sSQl = N'
SELECT M81.TeamID, H11.TeamName, M81.VoucherDate, M82.ProductID, A13.InventoryName AS ProductName, M82.UnitID, A34.UnitName, A13.I04ID, A15.AnaName,
	ROUND(SUM(CASE WHEN TypeTab = 2 THEN ISNULL(M82.ActualQuantity,0) ELSE ISNULL(M82.ErrorQuantity,0) END),'+LTRIM(@QuantityDecimals)+') AS ActualQuantity,  
	A48.ProErrorID, (CASE WHEN ISNULL(A48.ProErrorID,'''') <> '''' THEN A48.ProErrorName ELSE N'''+@Res+''' END ) AS ProErrorName, M82.TypeTab,
	A13.InventoryTypeID, A11.InventoryTypeName
FROM MT1802 M82 WITH (NOLOCK)
LEFT JOIN MT1801 M81 WITH (NOLOCK) ON M81.DivisionID = M82.DivisionID AND M81.VoucherID = M82.VoucherID
LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID = M82.DivisionID AND A13.InventoryID = M82.ProductID
LEFT JOIN AT1301 A11 WITH (NOLOCK) ON A11.DivisionID = M82.DivisionID AND A11.InventoryTypeID = A13.InventoryTypeID
LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.DivisionID = A13.DivisionID AND A15.AnaID = A13.I04ID AND A15.AnaTypeID = ''I04''
LEFT JOIN AT0148 A48 WITH (NOLOCK) ON M82.DivisionID = A48.DivisionID AND M82.ErrorTypeID = A48.ProErrorID
LEFT JOIN AT1304 A34 WITH (NOLOCK) ON A13.DivisionID = A34.DivisionID AND A34.UnitID = A13.UnitID
LEFT JOIN HT1101 H11 WITH (NOLOCK) ON M81.DivisionID = H11.DivisionID AND H11.TeamID = M81.TeamID
WHERE M81.DivisionID = '''+@DivisionID+''' 
	' +@sWhere1+ @sWhere2+'
	AND M81.TeamID LIKE '''+@TeamID+'''
	AND M82.TypeTab IN (2, 3) ' + @sWhere + '
	AND M82.ProductID  IN (SELECT * FROM  ProductIDNotIn)
GROUP BY M81.TeamID, H11.TeamName, M81.VoucherDate, M82.ProductID, A48.ProErrorID, A48.ProErrorName, M82.TypeTab, A13.InventoryName, M82.UnitID, A34.UnitName, A13.I04ID, A15.AnaName,
		A13.InventoryTypeID, A11.InventoryTypeName
ORDER BY M82.ProductID, M82.TypeTab DESC 
'
--SELECT @sSQl
--PRINT @sSQl2
--PRINT @sSQl3
--PRINT @sSQl
EXEC (@sSQl2+ @sSQl3)
EXEC (@sSQl)

--SET @sSQl = ''
--SET @sSQL1 = ''
--SET @sSQL2 = ''

--SELECT	DISTINCT VoucherDate
--INTO	#MV0190_2
--FROM	#MV0190
--ORDER BY VoucherDate

--IF EXISTS (SELECT TOP 1 1 FROM #MV0190_2)
--BEGIN 
--	SELECT @sSQL1 = @sSQL1 +
--	'
--	SELECT	*
--	INTO  #MV0190_3
--	FROM	
--	(
--	SELECT	*
--	FROM	 #MV0190	
--	) P
--	PIVOT
--	(SUM(ActualQuantity) FOR VoucherDate IN ('
--	SELECT	@sSQL2 = @sSQL2 + CASE WHEN @sSQL2 <> '' THEN ',' ELSE '' END + '['+CONVERT(NVARCHAR(10),VoucherDate,120)+''+']'
--	FROM	#MV0190_2
	
--	SELECT	@sSQL2 = @sSQL2 +')
--	) As T
	
--	SELECT *
--	FROM	#MV0190_3 T1
--	ORDER BY T1.I04ID, T1.ProductID, TypeTab DESC
--	'
--	PRINT (@sSQL1+@sSQL2)

--END
--ELSE
--BEGIN
--	SELECT @sSQL2 = @sSQL2 +
--	'
--	SELECT	*
--	FROM	 #MV0190
--	WHERE 1 = 0
--	'
--END
--EXEC (@sSQl1+@sSQL2)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
