IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30231]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30231]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- In bao cao Doanh số bán hàng theo khu vực - SOR3023
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create On 02/01/2023 by Huỳnh Võ Hoàng Long
-- <Example>

CREATE PROCEDURE [dbo].[SOP30231] (
				@DivisionID			NVARCHAR(50),	--Biến môi trường
				@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
				@FromDate			DATETIME, 	
				@OID				NVARCHAR(MAX),
				@UserID				NVARCHAR(50)	--Biến môi trường
				)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sWhere NVARCHAR(max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max),
			@CustomerIndex int,
			@SQLLEFTJOINAREA nvarchar(max),
			@SQLDisplayArea nvarchar(max)
	Set @SQLLEFTJOINAREA = ''
	SET @SQLDisplayArea = ''
	Set @sWhere = ''

	SELECT @CustomerIndex = CONVERT(INT, c.CustomerName) FROM CustomerIndex c
    
	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND O01.DivisionID IN ('''+@DivisionIDList+''')'
	ELSE 
		SET @sWhere = @sWhere + ' AND O01.DivisionID = N'''+@DivisionID+''''	

		SET @sWhere = @sWhere + ' AND A02.O02ID IN ('''+@OID+''')'
		
	
	
	SET @sSQL = '  
	SELECT ROW_NUMBER() OVER (ORDER BY A02.O02ID) AS RowNum,
        A02.O02ID,
        SUM(CASE WHEN O01.OrderDate = ''' + CONVERT(NVARCHAR, @FromDate, 120) + N''' THEN ISNULL(O02.OrderQuantity, 0) ELSE 0 END) AS TotalQuantity,
        SUM(CASE WHEN O01.OrderDate = ''' + CONVERT(NVARCHAR, @FromDate, 120) + N''' THEN ISNULL(O02.OriginalAmount, 0) ELSE 0 END) AS TotalOriginalAmount,
        SUM(CASE WHEN MONTH(O01.OrderDate) = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') THEN ISNULL(O02.OrderQuantity, 0) ELSE 0 END) AS TotalQuantityMonth,
        SUM(CASE WHEN MONTH(O01.OrderDate) = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') AND A03.YEAR = YEAR(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') THEN ISNULL(A03.SalesMonth, 0) ELSE 0 END) AS TotalSalesMonth,
		(SUM(CASE WHEN MONTH(O01.OrderDate) = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') THEN ISNULL(O02.OrderQuantity, 0) ELSE 0 END) / NULLIF(SUM(CASE WHEN MONTH(O01.OrderDate) = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') AND A03.YEAR = YEAR(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') THEN ISNULL(A03.SalesMonth, 0) ELSE 0 END), 0)) * 100 AS PercentComplete,
        SUM(CASE WHEN MONTH(O01.OrderDate) = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') AND YEAR(O01.OrderDate) = YEAR(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') - 1 THEN ISNULL(O02.OrderQuantity, 0) ELSE 0 END) AS TotalQuantityLastMonth
    FROM 
        OT2001 O01 WITH (NOLOCK)
        INNER JOIN OT2002 O02 WITH (NOLOCK) ON O02.DivisionID IN (''@@@'', O01.DivisionID) AND O01.SorderID = O02.SorderID AND O01.OrderType = 0 AND O01.IsConfirm = 1
        LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.DivisionID IN (''@@@'', O01.DivisionID) AND A02.ObjectID = O01.ObjectID
        LEFT JOIN AT0170 A03 WITH (NOLOCK) ON A03.DivisionID IN (''@@@'', O01.DivisionID) AND A03.ObjectID = O01.ObjectID AND A03.Month = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') AND A03.Year = YEAR(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''')
    WHERE 
        A02.O02ID IS NOT NULL
        AND MONTH(O01.OrderDate) = MONTH(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''')
        AND (YEAR(O01.OrderDate) = YEAR(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') OR (YEAR(O01.OrderDate) = YEAR(''' + CONVERT(NVARCHAR, @FromDate, 120) + N''') - 1))
		'+@sWhere +'
    GROUP BY 
        A02.O02ID
					'
	PRINT(@sSQL)
	EXEC (@sSQL)

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
