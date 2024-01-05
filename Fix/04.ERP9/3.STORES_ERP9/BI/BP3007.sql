IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Biểu đồ sản lượng và doanh số bán SKU
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ sản lượng và doanh số bán SKU
-- <History>
---- Create on 04/07/2017 by Tiểu Mai
---- Modified by Phương Thảo on 08/02/2018: Bổ sung tùy chỉnh thời gian lấy dữ liệu khi lên dashboard
---- Modified by Phương Thảo on 08/03/2018: Bổ sung mode thời gian 2 năm gần nhất
---- Modified by Minh Chương on 05/02/2021: Tách SP34 không lấy chung dữ liệu với những type có SP3 ở đầu
-- <Example>
---- EXEC BP3007 'ANG', 1, 2017, 4,2017, 'SP21'


CREATE PROCEDURE BP3007
( 
	@DivisionID VARCHAR(50), 
	@FromMonth INT, 
	@FromYear INT, 
	@ToMonth INT, 
	@ToYear INT,
	@Type NVARCHAR(50),
	@TimeType Tinyint = null
) 
AS
SET NOCOUNT ON

DECLARE @Type1 NVARCHAR(100) ,@Ssql NVARCHAR(max)


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

	IF(@TimeType = 3) -- 2 năm gần nhất		
		SELECT	@FromMonth = MONTH(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) ,
				@FromYear = YEAR(DATEADD(yyyy,-2,DATEADD(mm,1,CONVERT(Datetime,STR(@ToMonth)+'/'+'1'+'/'++STR(@ToYear))) )) 

END


SET @Type1 = LEFT(@Type,3) + '%'

SET @Ssql ='

DECLARE @InventoryTypeName NVARCHAR(250)
SELECT CONVERT(NVARCHAR(50),'''') AS InventoryTypeID, CONVERT(NVARCHAR(250),'''') AS InventoryTypeName,  
	case when O01.TranMonth < 10 then 
	''0''+convert(nvarchar(10),O01.TranMonth) + ''/'' + convert(nvarchar(10),O01.TranYear) else 
	convert(nvarchar(10),O01.TranMonth) + ''/'' + convert(nvarchar(10),O01.TranYear) end as MonthYear,
	SUM(CASE WHEN ISNULL(IsProInventoryID,0) = 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS  OrderQuantity,
	SUM(CASE WHEN ISNULL(IsProInventoryID,0) <> 0 THEN ISNULL(OrderQuantity,0) ELSE 0 END) AS  ProOrderQuantity,
	SUM(ISNULL(O02.ConvertedAmount,0) - ISNULL(O02.DiscountConvertedAmount,0)) AS  Amount
INTO #BT3007
FROM OT2001 O01 WITH (NOLOCK)
LEFT JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID = O01.DivisionID AND O02.SOrderID = O01.SOrderID
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', O02.DivisionID) AND A02.InventoryID = O02.InventoryID
WHERE O01.DivisionID = '''+@DivisionID+'''
	AND O01.TranMonth + O01.TranYear*100 BETWEEN ' + str(@FROMMonth + @FROMYear*100) + ' AND '  + str(@TOMonth + @TOYear*100) + '
	 AND ISNULL(ClassifyID,'''') NOT IN (''PLB06'', ''PLB08'', ''PLB10'') AND ISNULL(ClassifyID,'''') <> '''''
	+Case when @Type = 'SP34' THEN ' AND ISNULL(A02.InventoryTypeID,'''') = ''SP34'''
							 else ' AND ISNULL(A02.InventoryTypeID,'''') LIKE '''+@Type1+''' AND ISNULL(A02.InventoryTypeID,'''') <> ''SP34''' END +
	'AND O01.OrderStatus = 1
GROUP BY O01.TranMonth, O01.TranYear
ORDER BY O01.TranMonth, O01.TranYear

SELECT @InventoryTypeName = InventoryTypeName + CHAR(13) + ISNULL(InventoryTypeNameE,'''') FROM AT1301 WITH (NOLOCK) WHERE DivisionID IN (''@@@'', ''' + @DivisionID  + ''') AND  [Disabled] = 0 AND InventoryTypeID =  ''' + @Type + '''

UPDATE #BT3007
SET InventoryTypeID = '''+@Type+''',
	InventoryTypeName = @InventoryTypeName

SELECT * FROM #BT3007
ORDER BY RIGHT(MonthYear,4), LEFT( MonthYear,2)


'
print @ssql
EXEC (@SSql)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

