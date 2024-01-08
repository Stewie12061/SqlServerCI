IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BP3016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo doanh số bán hàng theo nhà máy 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 18/12/2017 by Khả Vi 
---- 
---- Modified on by 
-- <Example>
----  
/* EXEC BP3016 @DivisionID = 'DD', @TranYear = 2017, @FactoryID1 = 'FAC1', @FactoryID2 = 'FAC2', 
	@FactoryID3 = 'FAC3', @FactoryID4 = '', @FactoryID5 = '', @CurrencyID = 'USD'
	
	EXEC BP3016 @DivisionID, @TranYear, @FactoryID1, @FactoryID2, @FactoryID3, @FactoryID4, @FactoryID5, @CurrencyID
*/


CREATE PROCEDURE [dbo].[BP3016] 
(
	@DivisionID VARCHAR(50),
	@TranYear INT, 
	@FactoryID1 VARCHAR(50),
	@FactoryID2 VARCHAR(50),
	@FactoryID3 VARCHAR(50),
	@FactoryID4 VARCHAR(50),
	@FactoryID5 VARCHAR(50), 
	@CurrencyID VARCHAR(50)
)
AS
	DECLARE @sSQL NVARCHAR(MAX) = N'', 
			@sSQL1 NVARCHAR(MAX) = N''

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[Temp_OT2001]') AND TYPE IN (N'U'))
DROP TABLE Temp_OT2001

CREATE TABLE Temp_OT2001 (TranYear INT, CurrencyID VARCHAR(50), CurrencyName NVARCHAR(250), Quarter VARCHAR(50), FactoryID VARCHAR(50), FactoryName NVARCHAR(250), 
Sales DECIMAL(28,8))

INSERT INTO Temp_OT2001
SELECT OT2001.TranYear, OT2001.CurrencyID, AT1004.CurrencyName, CASE WHEN OV9999.Quarter LIKE '01%' THEN N'QuarterSale1'
WHEN OV9999.Quarter LIKE '02%' THEN N'QuarterSale2'
WHEN OV9999.Quarter LIKE '03%' THEN N'QuarterSale3'
WHEN OV9999.Quarter LIKE '04%' THEN N'QuarterSale4' END AS Quarter, 
OT2001.ClassifyID AS FactoryID, OT1001.ClassifyName AS FactoryName, 
SUM (ISNULL(OT2002.OrderQuantity, 0) * ISNULL (OT2002.SalePrice, 0)) AS Sales
FROM OT2001 WITH (NOLOCK) 
INNER JOIN OT2002 WITH (NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2001.SOrderID = OT2002.SOrderID
INNER JOIN OT1001 WITH (NOLOCK) ON OT2001.DivisionID = OT1001.DivisionID AND OT2001.ClassifyID = OT1001.ClassifyID 
LEFT JOIN OV9999 WITH (NOLOCK) ON OT2001.DivisionID = OV9999.DivisionID AND OT2001.TranMonth = OV9999.TranMonth AND OT2001.TranYear = OV9999.TranYear 
LEFT JOIN AT1004 WITH (NOLOCK) ON OT2001.CurrencyID = AT1004.CurrencyID AND AT1004.DivisionID IN (@DivisionID, '@@@')
WHERE OT2001.DivisionID = @DivisionID
AND OT2001.TranYear = ISNULL(@TranYear, '') 
AND (OT2001.ClassifyID LIKE ISNULL(@FactoryID1, '') OR OT2001.ClassifyID LIKE ISNULL(@FactoryID2, '') OR 
OT2001.ClassifyID LIKE ISNULL(@FactoryID3, '') OR OT2001.ClassifyID LIKE ISNULL(@FactoryID4, '') OR 
OT2001.ClassifyID LIKE ISNULL(@FactoryID5, ''))
AND OT2001.CurrencyID = @CurrencyID
GROUP BY OT2001.TranYear, OT2001.CurrencyID, AT1004.CurrencyName, OV9999.Quarter, OT2001.ClassifyID, OT1001.ClassifyName
ORDER BY OT2001.ClassifyID

SET @sSQL = @sSQL + N'
SELECT 
* FROM (
	SELECT TranYear, Quarter, CurrencyID, CurrencyName, FactoryID, FactoryName, Sales
	FROM Temp_OT2001) AS P
PIVOT (SUM(Sales) FOR Quarter IN ([QuarterSale1], [QuarterSale2], [QuarterSale3], [QuarterSale4])) AS #OT2001_Pivot
'
	
--PRINT @sSQL
EXEC (@sSQL)
		
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
