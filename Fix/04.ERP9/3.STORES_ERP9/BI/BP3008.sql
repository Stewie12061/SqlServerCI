IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3008]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[BP3008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Biểu đồ sản lượng và doanh số bán SKU chi tiết theo nhóm hàng và ASM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ sản lượng và doanh số bán SKU\ASM
-- <History>
---- Create on 04/07/2017 by Tiểu Mai
---- Modified by Phương Thảo on 08/02/2018: Bổ sung tùy chỉnh thời gian lấy dữ liệu khi lên dashboard
---- Modified by Văn Tài on 12/11/2019: Bổ sung thời gian lấy dữ liệu (2 Năm gần đây) khi lên dashboard
---- Modified by Huỳnh Thử on 27/07/2021: Bổ sung Loại SKU
-- <Example>
---- EXEC BP3008 'ANG', 1, 2017, 4,2017, 'SP11'


CREATE PROCEDURE BP3008
( 
	@DivisionID NVARCHAR(50), 
	@FromMonth INT, 
	@FromYear INT, 
	@ToMonth INT, 
	@ToYear INT,
	@InventoryTypeID NVARCHAR(50),
	@TimeType Tinyint = null
) 
AS
SET NOCOUNT ON

DECLARE @Type1 NVARCHAR(50), @InventoryTypeName NVARCHAR(250)

IF(@TimeType is not null)
BEGIN
	SELECT  TOP 1 @ToMonth = TranMonth, @ToYear = TranYear
	FROM OT2001 WITH(NOLOCK)
	ORDER BY TranYear desc, TranMonth desc

	IF(@TimeType = 0 ) -- 1 năm gần nhất
		SELECT	@FromMonth = MONTH(DATEADD(yyyy,-1,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
				@FromYear = YEAR(DATEADD(yyyy,-1,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

	IF(@TimeType = 1) -- 6 tháng gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(mm,-6,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )),
				@FromYear = YEAR(DATEADD(mm,-6,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

	IF(@TimeType = 2) -- 3 tháng gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(mm,-3,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )),
				@FromYear = YEAR(DATEADD(mm,-3,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) ))

	IF(@TimeType = 3 ) -- 2 năm gần nhất
		SELECT	@FromMonth = MONTH(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
			@FromYear = YEAR(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 
END

IF LEFT(@InventoryTypeID,3) ='SKU'
BEGIN
	SET @Type1 = SUBSTRING(@InventoryTypeID,4,LEN(@InventoryTypeID)) + '%'
	SELECT ISNULL(A02.I04ID,'') Ana03ID, ISNULL(A05.AnaName,'') +CHAR(13)+ ISNULL(A05.Notes,'') AnaName, 0 AS OrdersArea, 
		CONVERT(NVARCHAR(50),'') AS InventoryTypeID, CONVERT(NVARCHAR(250),'') AS InventoryTypeName, 
		O01.TranMonth, O01.TranYear,
		 case when O01.TranMonth < 10 then 
		'0'+convert(nvarchar(10),O01.TranMonth) + '/' + convert(nvarchar(10),O01.TranYear) else 
		convert(nvarchar(10),O01.TranMonth) + '/' + convert(nvarchar(10),O01.TranYear) end as MonthYear,
		SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS OrderQuantity,
		SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS ProOrderQuantity,
		SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS Amount
	INTO #BT3008SKU
	FROM OT2001 O01 WITH (NOLOCK)
	LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID
	LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN ('@@@', O02.DivisionID) AND A02.InventoryID = O02.InventoryID
	--LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND O01.Ana03ID = O12.AnaID AND O12.AnaTypeID = 'S03'
	LEFT JOIN AT1015 A05 WITH (NOLOCK) ON A05.DivisionID = O02.DivisionID AND A05.AnaID = A02.I04ID AND A05.AnaTypeID ='I04'
	WHERE O01.DivisionID = @DivisionID 
		AND O01.TranMonth + O01.TranYear*100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
		AND ISNULL(ClassifyID,'') NOT IN ('PLB06', 'PLB08', 'PLB10') AND ISNULL(ClassifyID,'') <> ''
		AND ISNULL(A02.I04ID,'') LIKE LEFT(@InventoryTypeID,3) + '%'
		AND ISNULL(A02.InventoryTypeID,'') LIKE LEFT(@Type1,3) + '%'
		AND O01.OrderStatus = 1
	GROUP BY A02.I04ID, A05.AnaName,  O01.TranMonth, O01.TranYear, A05.Notes
	ORDER BY  A02.I04ID, O01.TranMonth, O01.TranYear

	SELECT @InventoryTypeName = InventoryTypeName FROM AT1301 WITH (NOLOCK) WHERE DivisionID IN ('@@@', @DivisionID) AND [Disabled] = 0 AND InventoryTypeID = SUBSTRING(@InventoryTypeID,4,LEN(@InventoryTypeID))

	UPDATE #BT3008SKU
	SET InventoryTypeID = SUBSTRING(@InventoryTypeID,4,LEN(@InventoryTypeID)),
		InventoryTypeName = @InventoryTypeName

	SELECT * FROM #BT3008SKU
	ORDER BY Ana03ID, RIGHT(MonthYear,4), LEFT( MonthYear,2)
END
ELSE
BEGIN
	SET @Type1 = LEFT(@InventoryTypeID,3) + '%'

	SELECT ISNULL(O01.Ana03ID,'') Ana03ID, ISNULL(O12.AnaName,'') AnaName, ISNULL(O12.OrdersArea,0) AS OrdersArea, 
		CONVERT(NVARCHAR(50),'') AS InventoryTypeID, CONVERT(NVARCHAR(250),'') AS InventoryTypeName, 
		O01.TranMonth, O01.TranYear,
		 case when O01.TranMonth < 10 then 
		'0'+convert(nvarchar(10),O01.TranMonth) + '/' + convert(nvarchar(10),O01.TranYear) else 
		convert(nvarchar(10),O01.TranMonth) + '/' + convert(nvarchar(10),O01.TranYear) end as MonthYear,
		SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS OrderQuantity,
		SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS ProOrderQuantity,
		SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS Amount
	INTO #BT3008
	FROM OT2001 O01 WITH (NOLOCK)
	LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID
	LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN ('@@@', O02.DivisionID) AND A02.InventoryID = O02.InventoryID
	LEFT JOIN OT1002 O12 WITH (NOLOCK) ON O12.DivisionID = O01.DivisionID AND O01.Ana03ID = O12.AnaID AND O12.AnaTypeID = 'S03'
	WHERE O01.DivisionID = @DivisionID 
		AND O01.TranMonth + O01.TranYear*100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
		AND ISNULL(ClassifyID,'') NOT IN ('PLB06', 'PLB08', 'PLB10') AND ISNULL(ClassifyID,'') <> ''
		AND ISNULL(A02.InventoryTypeID,'') LIKE @Type1
		AND O01.OrderStatus = 1
	GROUP BY O01.Ana03ID, O12.AnaName, ISNULL(O12.OrdersArea,0), O01.TranMonth, O01.TranYear
	ORDER BY ISNULL(O12.OrdersArea,0), O01.Ana03ID, O01.TranMonth, O01.TranYear

	SELECT @InventoryTypeName = InventoryTypeName FROM AT1301 WITH (NOLOCK) WHERE DivisionID IN ('@@@', @DivisionID) AND [Disabled] = 0 AND InventoryTypeID = @InventoryTypeID

	UPDATE #BT3008
	SET InventoryTypeID = @InventoryTypeID,
		InventoryTypeName = @InventoryTypeName

	SELECT * FROM #BT3008
	ORDER BY OrdersArea, RIGHT(MonthYear,4), LEFT( MonthYear,2)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

