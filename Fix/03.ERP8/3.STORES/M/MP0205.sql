IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0205]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0205]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








--- Created by Kim Thư on 12/04/2019: 
--- Purpose: In báo cáo tình hình thực hiện kế hoạch sản xuất (CustomizeIndex = 57)
--- Modified by

--- EXEC MP0205 @DivisionID='ANG', @FromMonth=6, @FromYear=2018, @ToMonth=6, @ToYear=2018, @FromDate='2018-06-01 00:00:00.000', @ToDate='2018-06-30 00:00:00.000', @IsDate = 0, @FromTeamID='TKU', @ToTeamID='TKU'
CREATE PROCEDURE [dbo].[MP0205] 
		@DivisionID nvarchar(50),
		@FromMonth int,
		@FromYear int,
		@ToMonth int,	
		@ToYear int,			
		@FromDate DATETIME,
		@ToDate DATETIME,
		@IsDate TINYINT, 
		@FromTeamID NVARCHAR(50),
		@ToTeamID NVARCHAR(50)
AS

DECLARE @sSQL NVARCHAR(max),
		@sSQL1 NVARCHAR(max),
		@sSQL2 NVARCHAR(max),
		@sSQL3 NVARCHAR(max),
		@sSQLTimePlan NVARCHAR(max),
		@sSQLTimeReal NVARCHAR(max),
		@FromPeriod INT,
		@ToPeriod INT

SET @FromPeriod=@FromMonth+@FromYear*100
SET @ToPeriod= @ToMonth+@ToYear*100

IF @IsDate=0 
BEGIN 
	SET @sSQLTimePlan='AND (MONTH(M71.RequestDate)+YEAR(M71.RequestDate)*100 BETWEEN ' + LTRIM(@FromPeriod) + ' AND ' + LTRIM(@ToPeriod) + ')'
	SET @sSQLTimeReal='AND (MONTH(MT1801.VoucherDate)+YEAR(MT1801.VoucherDate)*100 BETWEEN ' + LTRIM(@FromPeriod) + ' AND ' + LTRIM(@ToPeriod) + ')'

END 
ELSE
BEGIN 
	SET @sSQLTimePlan='AND convert(NVARCHAR(10),M71.RequestDate,21) BETWEEN ''' + CONVERT(NVARCHAR(10),@FromDate,21)+''' AND ''' + CONVERT(NVARCHAR(10),@ToDate,21)+''''
	SET @sSQLTimeReal='AND convert(NVARCHAR(10),MT1801.VoucherDate,21) BETWEEN ''' + CONVERT(NVARCHAR(10),@FromDate,21)+''' AND ''' + CONVERT(NVARCHAR(10),@ToDate,21)+''''
END
 --PRINT @sSQLTimePlan + ' - ' + @sSQLTimeReal
SET @sSQL='
SELECT M69.DivisionID, M69.VoucherNo, M70.TeamID, M71.RequestDate, M70.InventoryID, ISNULL(M71.Quantity,0) AS Quantity
INTO #MainPlanTemp
FROM MT0169 M69 WITH (NOLOCK)
LEFT JOIN MT0170 M70 WITH (NOLOCK) ON M70.DivisionID = M69.DivisionID AND M70.VoucherID = M69.VoucherID
RIGHT JOIN MT0171 M71 WITH (NOLOCK) ON M71.DivisionID = M69.DivisionID AND M70.VoucherID = M71.VoucherID AND M70.TransactionID = M71.TransactionID
WHERE M69.DivisionID = '''+@DivisionID+''' 
	AND M70.TeamID BETWEEN '''+@FromTeamID+''' AND '''+@ToTeamID+'''
	AND M70.Change <> 1
	' + @sSQLTimePlan + '
	AND M71.Quantity>0
	
SELECT * INTO #MainPlan FROM #MainPlanTemp WHERE #MainPlanTemp.VoucherNo NOT IN (select InheritVoucherID from MT0169 where InheritVoucherID <> '''')
'
-- Lấy số liệu điều chỉnh tăng
SET @sSQL1='
SELECT M69.DivisionID, M69.VoucherNo, M70.TeamID, M71.RequestDate, M70.InventoryID, ISNULL(M71.Quantity,0) AS InQuantity, M70.AdjustReason
INTO #InPlanTemp
FROM MT0169 M69 WITH (NOLOCK)
LEFT JOIN MT0170 M70 WITH (NOLOCK) ON M70.DivisionID = M69.DivisionID AND M70.VoucherID = M69.VoucherID
RIGHT JOIN MT0171 M71 WITH (NOLOCK) ON M71.DivisionID = M69.DivisionID AND M70.VoucherID = M71.VoucherID AND M70.TransactionID = M71.TransactionID
WHERE M69.DivisionID = '''+@DivisionID+'''
	AND M70.TeamID BETWEEN '''+@FromTeamID+''' AND '''+@ToTeamID+'''
	AND ISNULL(M69.TypeOfAdjustPlan,0) = 1 AND M71.Quantity > 0
	AND M70.Change=1
	' + @sSQLTimePlan + '

SELECT * INTO #InPlan FROM #InPlanTemp WHERE #InPlanTemp.VoucherNo NOT IN (select InheritVoucherID from MT0169 where InheritVoucherID <> '''')
'
-- Lấy số liệu điều chỉnh giảm
SET @sSQL2='
SELECT M69.DivisionID, M69.VoucherNo, M70.TeamID, M71.RequestDate, M70.InventoryID, ISNULL(M71.Quantity,0) AS DeQuantity, M70.AdjustReason
INTO #DePlanTemp
FROM MT0169 M69 WITH (NOLOCK)
LEFT JOIN MT0170 M70 WITH (NOLOCK) ON M70.DivisionID = M69.DivisionID AND M70.VoucherID = M69.VoucherID
RIGHT JOIN MT0171 M71 WITH (NOLOCK) ON M71.DivisionID = M69.DivisionID AND M70.VoucherID = M71.VoucherID AND M70.TransactionID = M71.TransactionID
WHERE M69.DivisionID = '''+@DivisionID+'''
	AND M70.TeamID BETWEEN '''+@FromTeamID+''' AND '''+@ToTeamID+'''
	AND ISNULL(M69.TypeOfAdjustPlan,0) =2 AND M71.Quantity < 0
	AND M70.Change=1
	' + @sSQLTimePlan + '

SELECT * INTO #DePlan FROM #DePlanTemp WHERE #DePlanTemp.VoucherNo NOT IN (select InheritVoucherID from MT0169 where InheritVoucherID <> '''')
'
-- TỔNG HỢP SỐ LIỆU TỪ KẾ HOẠCH
SET @sSQL3='
	SELECT T1.DivisionID, ISNULL(ISNULL(T1.TeamID,T2.TeamID), T3.TeamID) AS TeamID, H01.Teamname, ISNULL(ISNULL(T1.InventoryID,T2.InventoryID),T3.InventoryID) AS InventoryID, ISNULL(ISNULL(T1.RequestDate,T2.RequestDate),T3.RequestDate) AS BeginDate, A02.InventoryName, A04.Unitname, 
T1.Quantity, T2.InQuantity, ABS(T3.DeQuantity) AS DeQuantity, (T1.Quantity+T2.InQuantity+T3.DeQuantity) AS FinalQuantity,
CASE WHEN ISNULL(T2.AdjustReason,'''') <> '''' THEN T2.AdjustReason + '' & '' + T3.AdjustReason ELSE T3.AdjustReason END AS Note
INTO #PlanQuantity
FROM #MainPlan T1 FULL JOIN #InPlan T2 ON T1.InventoryID=T2.InventoryID AND T1.TeamID=T2.TeamID AND T1.RequestDate=T2.RequestDate
FULL JOIN #DePlan T3 ON  T1.InventoryID=T3.InventoryID AND T1.TeamID=T3.TeamID AND T1.RequestDate=T3.RequestDate
LEFT JOIN HT1101 H01 WITH (NOLOCK) ON H01.TeamID = ISNULL(ISNULL(T1.TeamID,T2.TeamID), T3.TeamID)
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = ISNULL(ISNULL(T1.InventoryID,T2.InventoryID),T3.InventoryID) 
LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID = T1.DivisionID AND A02.UnitID = A04.UnitID


-- SỐ LIỆU THỰC TẾ TỪ PHIẾU THỐNG KÊ
SELECT MT1801.DivisionID, MT1801.VoucherDate, MT1801.TeamID, MT1802.ProductID, A02.InventoryName AS ProductName, A04.UnitName AS ProductUnitName, ISNULL(MT1802.ActualQuantity,0) AS ActualQuantity 
INTO #RealQuantity
FROM MT1801 WITH (NOLOCK)
LEFT JOIN MT1802 WITH (NOLOCK) ON MT1802.DivisionID = MT1801.DivisionID AND MT1802.VoucherID = MT1801.VoucherID
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID = MT1801.DivisionID AND A02.InventoryID = MT1802.ProductID
LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.DivisionID = MT1801.DivisionID AND A02.UnitID = A04.UnitID
WHERE MT1801.DivisionID = '''+@DivisionID+''' AND TypeTab = 2 
AND MT1801.TeamID BETWEEN '''+@FromTeamID+''' AND '''+@ToTeamID+'''
' + @sSQLTimeReal + '


SELECT * FROM #PlanQuantity ORDER BY BeginDate

SELECT * FROM #RealQuantity ORDER BY VoucherDate
'

PRINT @sSQL
PRINT @sSQL1
PRINT @sSQL2
PRINT @sSQL3
	EXEC (@sSQL+@sSQL1+@sSQL2+@sSQL3)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
