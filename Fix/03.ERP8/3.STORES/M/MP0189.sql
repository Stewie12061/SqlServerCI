IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0189]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0189]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






---- Customize Angel: In báo cáo hiệu suất sx so sánh thực tế và kế hoạch
---- Created by Tiểu Mai on 10/04/2017
---- Modified by Tiểu Mai on 25/05/2017: Fix bug khi chia cho 0
---- EXEC MP0189 'ANG', 201703, '%', 'BPMUA1', 'VL', 'BBCN01', 'XOABO'

CREATE PROCEDURE [dbo].[MP0189] 
    @DivisionID NVARCHAR(50),
    @Period DECIMAL(28,8),
    @TeamID NVARCHAR(50),
    @FromI03ID NVARCHAR(50),
    @ToI03ID NVARCHAR(50),
    @FromInventoryID NVARCHAR(50),
    @ToInventoryID NVARCHAR(50)
AS


SELECT DAY(M81.VoucherDate) AS VoucherDate, M82.CombineID, M82.TableID, M82.ProductID, M70.EmployeeNum, M70.EmployeePower, DAY(M70.BeginDate) AS BeginDate, 
		ISNULL(M70.[Power],0) AS [Power], 
		CASE WHEN ISNULL(M70.[Power],0) <> 0 THEN M70.Quantity/M70.[Power] ELSE 0 END AS [Hours], 
		ISNULL(M70.Quantity,0) AS Quantity_KH ,
		SUM(M82.ActualQuantity) AS ActualQuantity, SUM([dbo].[convertHours](M82.ActualTime)) AS ActualTime, M18.ActualTimePause
INTO #Temp
FROM MT1802 M82 WITH (NOLOCK)
LEFT JOIN MT1801 M81 WITH (NOLOCK) ON M81.DivisionID = M82.DivisionID AND M81.VoucherID = M82.VoucherID
LEFT JOIN AT1302 A32 WITH (NOLOCK) ON A32.DivisionID = M82.DivisionID AND A32.InventoryID = M82.InventoryID
LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID = M82.DivisionID AND A13.InventoryID = M82.ProductID
LEFT JOIN AT1015 A15 WITH (NOLOCK) ON A15.DivisionID = A13.DivisionID AND A15.AnaID = A13.I03ID AND A15.AnaTypeID = 'I03'
LEFT JOIN AT0156 A56 WITH (NOLOCK) ON M82.DivisionID = A56.DivisionID AND A56.CombineID = M82.CombineID
LEFT JOIN (SELECT MT0170.DivisionID, MT0170.InventoryID, MT0171.FinishDate AS BeginDate, EmployeeNum, EmployeePower, MT0170.[Power], SUM(MT0171.Quantity) AS Quantity, SUM(MT0170.Hours) AS [Hours]
            FROM MT0170 WITH (NOLOCK) 
            LEFT JOIN MT0169 WITH (NOLOCK) ON MT0169.DivisionID = MT0170.DivisionID AND MT0169.VoucherID = MT0170.VoucherID
			LEFT JOIN MT0171 WITH (NOLOCK) ON MT0171.DivisionID = MT0170.DivisionID AND MT0171.VoucherID = MT0170.VoucherID AND MT0171.TransactionID = MT0170.TransactionID
			WHERE MT0169.TranMonth + MT0169.TranYear * 100 = @Period AND MT0170.DivisionID = @DivisionID
			GROUP BY MT0170.InventoryID, MT0171.FinishDate, MT0170.DivisionID, EmployeeNum, EmployeePower, MT0170.[Power]) M70 ON M70.DivisionID = M82.DivisionID AND M70.InventoryID = M82.ProductID
LEFT JOIN (SELECT MT1802.DivisionID, MT1802.VoucherID, MT1802.ProductID, SUM([dbo].[convertHours](ActualTime)) AS ActualTimePause
             FROM MT1802 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND TypeTab = 4 
           GROUP BY  MT1802.DivisionID, MT1802.VoucherID, MT1802.ProductID) M18 ON M82.DivisionID = M18.DivisionID AND M82.VoucherID = M18.VoucherID AND M82.ProductID = M18.ProductID
WHERE M81.DivisionID = @DivisionID AND M81.TranMonth + M81.TranYear *100 = @Period
	AND M82.ProductID BETWEEN @FromInventoryID AND @ToInventoryID
	AND A13.I03ID BETWEEN @FromI03ID AND @ToI03ID
	AND M81.TeamID LIKE @TeamID
	AND M82.TypeTab = 2
GROUP BY M81.VoucherDate, M82.CombineID, M82.TableID, M82.ProductID, M70.BeginDate, M70.EmployeeNum, M70.EmployeePower, M70.[Power], M70.Quantity, M18.ActualTimePause
ORDER BY M82.ProductID


SELECT 0 AS [Type], CombineID, TableID, ProductID, EmployeeNum, EmployeePower, [Power], 
	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
	[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
	[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31],
	(ISNULL([1],0)) +(ISNULL([2],0)) + 
	(ISNULL([3],0)) +(ISNULL([4],0)) + (ISNULL([5],0)) + (ISNULL([6],0)) + (ISNULL([7],0)) + (ISNULL([8],0)) + (ISNULL([9],0)) +(ISNULL([10],0))+ 
	(ISNULL([11],0))+(ISNULL([12],0))+ (ISNULL([13],0))+ (ISNULL([14],0))+ (ISNULL([15],0))+ (ISNULL([16],0))+ (ISNULL([17],0))+(ISNULL([18],0))+ (ISNULL([19],0))+ (ISNULL([20],0))+ 
	(ISNULL([21],0))+(ISNULL([22],0))+ (ISNULL([23],0))+ (ISNULL([24],0))+ (ISNULL([25],0))+ (ISNULL([26],0))+ (ISNULL([27],0))+(ISNULL([28],0))+ (ISNULL([29],0))+ (ISNULL([30],0))+ (ISNULL([31],0)) AS Quantity

INTO #Temp_1
FROM
(SELECT ProductID, CombineID, TableID, EmployeeNum, EmployeePower, [Power], BeginDate, [Hours]
    FROM #Temp) AS SourceTable
PIVOT
(
MAX([Hours])
FOR BeginDate IN (	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31])
) AS PivotTable

UNION 
SELECT 1 AS [Type], CombineID, TableID, ProductID, EmployeeNum, EmployeePower, [Power],
	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
	[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
	[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31],
	(ISNULL([1],0)) +(ISNULL([2],0)) + 
	(ISNULL([3],0)) +(ISNULL([4],0)) + (ISNULL([5],0)) + (ISNULL([6],0)) + (ISNULL([7],0)) + (ISNULL([8],0)) + (ISNULL([9],0)) +(ISNULL([10],0))+ 
	(ISNULL([11],0))+(ISNULL([12],0))+ (ISNULL([13],0))+ (ISNULL([14],0))+ (ISNULL([15],0))+ (ISNULL([16],0))+ (ISNULL([17],0))+(ISNULL([18],0))+ (ISNULL([19],0))+ (ISNULL([20],0))+ 
	(ISNULL([21],0))+(ISNULL([22],0))+ (ISNULL([23],0))+ (ISNULL([24],0))+ (ISNULL([25],0))+ (ISNULL([26],0))+ (ISNULL([27],0))+(ISNULL([28],0))+ (ISNULL([29],0))+ (ISNULL([30],0))+ (ISNULL([31],0)) AS Quantity
FROM
(SELECT ProductID, CombineID, TableID, EmployeeNum, EmployeePower, [Power], Quantity_KH, BeginDate
    FROM #Temp) AS SourceTable
PIVOT
(
MAX(Quantity_KH)
FOR BeginDate IN (	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31])
) AS PivotTable
UNION
SELECT 2 AS [Type], CombineID, TableID, ProductID, EmployeeNum, EmployeePower, [Power],
	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
	[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
	[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31],
	(ISNULL([1],0)) +(ISNULL([2],0)) + 
	(ISNULL([3],0)) +(ISNULL([4],0)) + (ISNULL([5],0)) + (ISNULL([6],0)) + (ISNULL([7],0)) + (ISNULL([8],0)) + (ISNULL([9],0)) +(ISNULL([10],0))+ 
	(ISNULL([11],0))+(ISNULL([12],0))+ (ISNULL([13],0))+ (ISNULL([14],0))+ (ISNULL([15],0))+ (ISNULL([16],0))+ (ISNULL([17],0))+(ISNULL([18],0))+ (ISNULL([19],0))+ (ISNULL([20],0))+ 
	(ISNULL([21],0))+(ISNULL([22],0))+ (ISNULL([23],0))+ (ISNULL([24],0))+ (ISNULL([25],0))+ (ISNULL([26],0))+ (ISNULL([27],0))+(ISNULL([28],0))+ (ISNULL([29],0))+ (ISNULL([30],0))+ (ISNULL([31],0)) AS Quantity
FROM
(SELECT ProductID, CombineID, TableID, EmployeeNum, EmployeePower, [Power], VoucherDate, ActualTime
    FROM #Temp) AS SourceTable
PIVOT
(
MAX(ActualTime)
FOR VoucherDate IN (	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31])
) AS PivotTable

UNION 
SELECT 3 AS [Type], CombineID, TableID, ProductID, EmployeeNum, EmployeePower, [Power],
	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
	[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
	[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31],
	(ISNULL([1],0)) +(ISNULL([2],0)) + 
	(ISNULL([3],0)) +(ISNULL([4],0)) + (ISNULL([5],0)) + (ISNULL([6],0)) + (ISNULL([7],0)) + (ISNULL([8],0)) + (ISNULL([9],0)) +(ISNULL([10],0))+ 
	(ISNULL([11],0))+(ISNULL([12],0))+ (ISNULL([13],0))+ (ISNULL([14],0))+ (ISNULL([15],0))+ (ISNULL([16],0))+ (ISNULL([17],0))+(ISNULL([18],0))+ (ISNULL([19],0))+ (ISNULL([20],0))+ 
	(ISNULL([21],0))+(ISNULL([22],0))+ (ISNULL([23],0))+ (ISNULL([24],0))+ (ISNULL([25],0))+ (ISNULL([26],0))+ (ISNULL([27],0))+(ISNULL([28],0))+ (ISNULL([29],0))+ (ISNULL([30],0))+ (ISNULL([31],0)) AS Quantity
FROM
(SELECT ProductID, CombineID, TableID, EmployeeNum, EmployeePower, [Power], VoucherDate, ActualQuantity
    FROM #Temp) AS SourceTable
PIVOT
(
MAX(ActualQuantity)
FOR VoucherDate IN (	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31])
) AS PivotTable

UNION 
SELECT 4 AS [Type], CombineID, TableID, ProductID, EmployeeNum, EmployeePower, [Power],
	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
	[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
	[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31],
	(ISNULL([1],0)) +(ISNULL([2],0)) + 
	(ISNULL([3],0)) +(ISNULL([4],0)) + (ISNULL([5],0)) + (ISNULL([6],0)) + (ISNULL([7],0)) + (ISNULL([8],0)) + (ISNULL([9],0)) +(ISNULL([10],0))+ 
	(ISNULL([11],0))+(ISNULL([12],0))+ (ISNULL([13],0))+ (ISNULL([14],0))+ (ISNULL([15],0))+ (ISNULL([16],0))+ (ISNULL([17],0))+(ISNULL([18],0))+ (ISNULL([19],0))+ (ISNULL([20],0))+ 
	(ISNULL([21],0))+(ISNULL([22],0))+ (ISNULL([23],0))+ (ISNULL([24],0))+ (ISNULL([25],0))+ (ISNULL([26],0))+ (ISNULL([27],0))+(ISNULL([28],0))+ (ISNULL([29],0))+ (ISNULL([30],0))+ (ISNULL([31],0)) AS Quantity
FROM
(SELECT ProductID, CombineID, TableID, EmployeeNum, EmployeePower, [Power], VoucherDate, ActualTimePause
    FROM #Temp) AS SourceTable
PIVOT
(
MAX(ActualTimePause)
FOR VoucherDate IN (	[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], 
				[11], [12], [13], [14], [15], [16], [17], [18], [19], [20], 
				[21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31])
) AS PivotTable

SELECT A02.I07ID, A05.AnaName, A02.InventoryName AS ProductName, A02.UnitID, T1.[Type],	
	MAX(CombineID) CombineID,	MAX(TableID) TableID,	ProductID,	EmployeeNum,	EmployeePower,	[Power],	
	MAX([1]) AS  [1] , MAX( [2]) AS  [2], MAX( [3]) AS  [3], MAX( [4]) AS  [4], MAX( [5]) AS  [5], MAX( [6]) AS  [6], MAX( [7]) AS  [7], MAX( [8]) AS  [8], MAX( [9]) AS  [9], MAX([10]) AS [10], 
	MAX([11]) AS [11], MAX([12]) AS [12], MAX([13]) AS [13], MAX([14]) AS [14], MAX([15]) AS [15], MAX([16]) AS [16], MAX([17]) AS [17], MAX([18]) AS [18], MAX([19]) AS [19], MAX([20]) AS [20], 
	MAX([21]) AS [21], MAX([22]) AS [22], MAX([23]) AS [23], MAX([24]) AS [24], MAX([25]) AS [25], MAX([26]) AS [26], MAX([27]) AS [27], MAX([28]) AS [28], MAX([29]) AS [29], MAX([30]) AS [30], 
	MAX([31]) AS [31],	MAX(Quantity) AS Quantity
  FROM #Temp_1 T1
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON T1.ProductID = A02.InventoryID
LEFT JOIN AT1015 A05 WITH (NOLOCK) ON A02.DivisionID = A05.DivisionID AND A02.I07ID = A05.AnaID AND A05.AnaTypeID = 'I07'
GROUP BY A02.I07ID, A05.AnaName, A02.InventoryName, A02.UnitID, T1.[Type],	
ProductID, EmployeeNum,	EmployeePower,[Power]
ORDER BY A02.I07ID, ProductID, [Type]




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
