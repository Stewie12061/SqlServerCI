IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30024]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30024]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- Báo cáo phương án kinh doanh và thực tế
---Created by : ĐÌnh hoà, date: 20/08/2021
---purpose: In báo cáo tổng hợp tình hình giao hàng

---- exec SOP30024 'mk',0,5,5,2016,2016,'2016/05/21','2016/05/21'

CREATE PROCEDURE [dbo].[SOP30024]  
			@DivisionID nvarchar(50),
			@DivisionIDList NVARCHAR(2000),
			@IsDate tinyint,
			@PeriodIDList nvarchar(2000),
			@FromDate datetime,
			@ToDate datetime				
AS
DECLARE @sSQL nvarchar(MAX),
	@sSQLRow nvarchar(MAX),
	@sWhere nvarchar(MAX)= ''
	

IF @DivisionIDList IS NULL or @DivisionIDList = ''
	SET @sWhere = @sWhere + 'S1.DivisionID = '''+ @DivisionID+''''
ELSE 
	SET @sWhere = @sWhere + 'S1.DivisionID IN ('''+@DivisionIDList+''')'

--Search theo điều điện thời gian
IF @IsDate = 1 
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),S1.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
ELSE IF @IsDate = 0 
	SET @sWhere = @sWhere + ' AND CONCAT(FORMAT(S1.TranMonth,''00''),''/'',S1.TranYear) IN ('''+ @PeriodIDList +''')'

-- Count column cùng VocherNo
Set @sSQLRow = N'SELECT S1.VoucherNo ,COUNT(S1.VoucherNo) AS SameCount
INTO #CountVoucherNo
FROM SOT2140 S1 WITH(NOLOCK) 
LEFT JOIN SOT2141 S2 WITH(NOLOCK) ON S1.APK = S2.APKMaster AND S1.DivisionID = S2.DivisionID
WHERE '+ @sWhere +'
GROUP BY S1.VoucherNo

'
Set @sSQL = N'SELECT S1.APK, S1.VoucherNo, S1.VoucherDate, S2.InventoryID, S3.InventoryName, S2.Specification, S2.UnitID, S4.UnitName, S2.S01ID, S2.S02ID, S2.S03ID
, S5.StandardName AS S01Name, S6.StandardName AS S02Name, S7.StandardName AS S03Name, S2.Area, S2.Quantity, S2.Coefficient, S2.UnitPrice
, (S2.Area * S2.Quantity * S2.UnitPrice) AS Revenue, 0 AS ActuallySpent, (S2.Area * S2.Quantity * S2.UnitPrice) - 0 AS DifferenceActual, S8.SameCount
FROM SOT2140 S1 WITH(NOLOCK) 
LEFT JOIN SOT2141 S2 WITH(NOLOCK) ON S1.APK = S2.APKMaster AND S2.DivisionID = S1.DivisionID
LEFT JOIN AT1302 S3 WITH(NOLOCK) ON S2.InventoryID = S3.InventoryID AND S3.DivisionID IN (''@@@'', S1.DivisionID)
LEFT JOIN AT1304 S4 WITH(NOLOCK) ON S2.UnitID = S4.UnitID AND  S4.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S5 WITH(NOLOCK) ON S2.S01ID = S5.StandardID AND S5.StandardTypeID = ''S01'' AND S5.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S6 WITH(NOLOCK) ON S2.S02ID = S6.StandardID AND S6.StandardTypeID = ''S02'' AND S6.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN AT0128 S7 WITH(NOLOCK) ON S2.S03ID = S7.StandardID AND S7.StandardTypeID = ''S03'' AND S7.DivisionID IN(''@@@'', S1.DivisionID)
LEFT JOIN #CountVoucherNo S8 WITH(NOLOCK) ON S8.VoucherNo = S1.VoucherNo
WHERE '+ @sWhere +'
ORDER BY S1.VoucherNo, S1.VoucherDate'																					 
	
EXEC (@sSQLRow + @sSQL)

PRINT (@sSQLRow + @sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
