IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3033]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3033]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Biểu đồ số lượng và doanh số bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ tình hình doanh thu
-- <History>
---- Create on 10/09/2020 by Thành Luân
---- Modify on 17/09/2020 by Kiều Nga : Lấy thêm tên đối tượng
---- Modify on 03/10/2020 by Kiều Nga : Fix lỗi in báo cáo
--BP3033 'ABC','a','2019','2021','09/2019','02/2020', 1,''

CREATE PROC [dbo].[BP3033](
@DivisionID varchar(50),
@UserID varchar(50),
@FromDate varchar(50),
@ToDate varchar(50),
@IsPeriod tinyint,
@DivisionIDList AS NVARCHAR(MAX) = NULL
) AS
BEGIN

SET NOCOUNT ON

DECLARE @col_PivotSelect NVARCHAR(MAX) = ''
	, @col_PivotQuantity NVARCHAR(MAX) = ''
	, @col_PivotAmount NVARCHAR(MAX) = ''
	, @QuerySQL NVARCHAR(MAX) = ''

CREATE TABLE #tbl_DataSource(ObjectID VARCHAR(50),ObjectName NVARCHAR(Max),Quantity DECIMAL(28,8),  ConvertedAmount DECIMAL(28,8))

-- Bảng Divisions
DECLARE @Divisions TABLE (
	DivisionID NVARCHAR(50)
);

INSERT INTO @Divisions
SELECT DISTINCT * FROM [dbo].StringSplit(REPLACE(COALESCE(@DivisionIDList, @DivisionID), '''', ''), ',');

-- Hóa đơn bán hàng theo nhóm hàng
INSERT INTO #tbl_DataSource
SELECT A1.I02ID,A2.AnaName,SUM(COALESCE(O2.OrderQuantity, 0)) AS Quantity, SUM(COALESCE(O2.ConvertedAmount, 0)) AS ConvertedAmount
FROM OT2001 AS O1 WITH(NOLOCK)
 INNER JOIN OT2002 AS O2 WITH(NOLOCK) ON O1.SOrderID = O2.SOrderID
 INNER JOIN AT1302 AS A1 WITH (NOLOCK) ON O2.InventoryID = A1.InventoryID
 LEFT JOIN AT1015 AS A2 WITH (NOLOCK) ON A1.I02ID = A2.AnaID AND A1.DivisionID IN (A2.DivisionID,'@@@')
WHERE O1.DivisionID IN (SELECT DivisionID FROM @Divisions)
	AND O1.OrderType = 0
	AND A1.I02ID IS NOT NULL 
	AND O1.OrderDate BETWEEN @FromDate AND @ToDate
GROUP BY A1.I02ID,A2.AnaName

SELECT @col_PivotSelect = CONCAT(@col_PivotSelect, 'SUM(Quantity_' + ObjectID + ') AS Quantity_' + ObjectID
								, ', ', 'SUM(Amount_' + ObjectID + ') AS Amount_' + ObjectID, ', ')
FROM #tbl_DataSource
GROUP BY ObjectID

IF COALESCE(@col_PivotSelect,'') = ''
BEGIN
	SELECT 'NULL' AS ObjectID,'NULL' as ObjectName
	SELECT 0 AS Quantity_NULL, 0 AS Amount_NULL
	RETURN
END

SET @col_PivotSelect = LEFT(@col_PivotSelect, LEN(@col_PivotSelect) - 1)


SELECT @col_PivotQuantity = CONCAT(@col_PivotQuantity, 'Quantity_'+ObjectID, ', ')
FROM #tbl_DataSource
GROUP BY ObjectID

SET @col_PivotQuantity = LEFT(@col_PivotQuantity, LEN(@col_PivotQuantity) - 1)

SELECT @col_PivotAmount = CONCAT(@col_PivotAmount, 'Amount_' + ObjectID, ', ')
FROM #tbl_DataSource
GROUP BY ObjectID

SET @col_PivotAmount = LEFT(@col_PivotAmount, LEN(@col_PivotAmount) - 1)

PRINT @col_PivotAmount

----------------------LẤY NHÓM HÀNG
SELECT ObjectID,ObjectName
FROM #tbl_DataSource
Where ObjectName IS NOT NULL
GROUP BY ObjectID,ObjectName

SET @QuerySQL = '
	SELECT ' + @col_PivotSelect + ' 
	FROM 
	(
		SELECT Quantity, ConvertedAmount
		, QuantityName = ''Quantity_'' + ObjectID
		, AmountName = ''Amount_'' + ObjectID
		FROM #tbl_DataSource
	) AS tbl
	PIVOT(SUM(Quantity) FOR QuantityName IN (' + @col_PivotQuantity + ')) AS tbl_pvot_Quantity
	PIVOT(SUM(ConvertedAmount) FOR AmountName IN (' + @col_PivotAmount + ')) AS tbl_pvot_Amount	
	'

-------------THỰC THI PIVOT
exec sp_executesql @QuerySQL

DROP TABLE #tbl_DataSource

END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
