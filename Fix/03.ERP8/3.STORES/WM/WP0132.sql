IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0132]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0132]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Truy vấn thông tin quyết toán
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Bảo Thy on 03/02/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified on by 
-- <Example>
/*
    EXEC WP0132 'HT','ASOFTADMIN',11,2016,'BIDV','MK0007', '2016-11-01','2016-11-30', 'LK', 1
	EXEC WP0132 @DivisionID,@UserID,@TranMonth,@TranYear,@FromObjectID,@ToObjectID,@FromDate,@ToDate,@VoucherID, @Mode
*/

 CREATE PROCEDURE WP0132
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,
	 @FromObjectID VARCHAR(50),
	 @ToObjectID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @VoucherID VARCHAR(50),
	 @Mode TINYINT --0: truy vấn, 1: xem chi tiết/in báo cáo
)
AS
DECLARE @sSQL NVARCHAR(MAX) = ''
IF @Mode = 0
BEGIN
	SELECT T1.DivisionID, VoucherTypeID, VoucherID, VoucherNo, VoucherDate, T1.ObjectID, T4.ObjectName, FromDate, ToDate, T1.CreateUserID, T2.FullName AS CreateName, 
	T1.CreateDate, T1.LastModifyUserID, T3.FullName AS LastModifyUserName, T1.LastModifyDate
	FROM WT0100 T1 WITH (NOLOCK)
	LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T1.CreateUserID = T2.EmployeeID
	LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T1.LastModifyUserID = T3.EmployeeID
	LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T4.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T4.ObjectID
	WHERE T1.DivisionID = @DivisionID
	AND T1.VoucherDate BETWEEN @FromDate AND @ToDate
	AND T1.ObjectID BETWEEN @FromObjectID AND @ToObjectID
	ORDER BY T1.ObjectID, VoucherNo, VoucherDate
END
ELSE --@Mode = 1
BEGIN
	SELECT ROW_NUMBER() OVER (PARTITION BY  T2.Type, T1.VoucherNo ORDER BY  T2.Type, T1.VoucherNo) AS OrderNo, T1.DivisionID, T2.Type, T1.VoucherTypeID, T1.VoucherID, T1.VoucherNo, T1.VoucherDate, T1.ObjectID, T3.ObjectName, T1.FromDate, T1.ToDate, T1.ContractID, 
	T4.ContractNo, T2.DetailVoucherID, T2.DetailVoucherNo, T2.DetailVoucherDate, T2.CostID, ISNULL(T5.InventoryName,N'Chi phí lưu kho') AS CostName, T2.WareHouseID AS WareHouseID, 
	T6.InventoryName AS WareHouseName, T2.InventoryID, T7.InventoryName, T2.Quantity, T2.DetailFromDate, T2.DetailToDate, T2.UnitPrice, T2.OriginalAmount, T2.ConvertAmount,
	CEILING(DATEDIFF(d,T2.DetailFromDate, T2.DetailToDate)/CASE WHEN T1.DayUnit = 0 THEN 1
																WHEN T1.DayUnit = 1 THEN 7
																WHEN T1.DayUnit = 2 THEN 30 END) AS NumDate, CONVERT(VARCHAR(50),'') AS SearchWareHouse
	INTO #WP0132
	FROM WT0100 T1 WITH (NOLOCK)
	LEFT JOIN WT0103 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.VoucherID = T2.VoucherID
	LEFT JOIN AT1202 T3 WITH (NOLOCK) ON T3.DivisionID IN (@DivisionID, '@@@') AND T1.ObjectID = T3.ObjectID
	LEFT JOIN AT1020 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.ContractID = T4.ContractID
	LEFT JOIN AT1302 T5 WITH (NOLOCK) ON T2.CostID = T5.InventoryID
	LEFT JOIN AT1302 T6 WITH (NOLOCK) ON T2.WareHouseID = T6.InventoryID
	LEFT JOIN AT1302 T7 WITH (NOLOCK) ON T7.DivisionID IN ('@@@', T2.DivisionID) AND T2.InventoryID = T7.InventoryID
	WHERE T1.DivisionID = @DivisionID
	AND T1.VoucherID = @VoucherID

	SET @sSQL = N'
	UPDATE #WP0132
	SET SearchWareHouse = '+CASE WHEN (SELECT COUNT(WareHouseID) FROM (SELECT DISTINCT WareHouseID FROM #WP0132)A) > 1 THEN '''%''' ELSE 'WareHouseID' END+'
	'
	--PRINT (@sSQL)
	EXEC (@sSQL)
	SELECT * FROM  #WP0132 ORDER BY Type, ROW_NUMBER() OVER (PARTITION BY  Type, VoucherNo ORDER BY  Type, VoucherNo)
	DROP TABLE #WP0132
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
