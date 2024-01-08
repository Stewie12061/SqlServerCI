IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2312]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2312]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load chi tiết WMF2312  
-- <Param>
---- 
-- <Return>
---- 
-- <History>
----Created by: Hồng Thắm, Date: 13/11/2023
-- <Example>
/*
EXEC [WMP2312]
	@DivisionID = N'GREE-SI', @DivisionIDList = N'', @FromDate = NULL, @ToDate = NULL, @IsPeriod = 0, 
	@PeriodList = N'', @VoucherNo = N'', @ObjectID = N'', @EmployeeID = N'', @KindVoucherID = N'', 
	@PageNumber = 1, @PageSize = 100
*/

CREATE PROCEDURE WMP2312 (
	@DivisionID VARCHAR(50),
	@APK NVARCHAR(250) = ''
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
 
SET @sSQL = N'
		SELECT TOP 1 T1.APK, T1.DivisionID, T1.TranMonth, T1.TranYear, T1.VoucherNo, T1.VoucherDate, T1.VoucherTypeID, T1.Description, T2.ExWareHouseID, T3.WareHouseName AS ImWareHouseName, 
        T6.WareHouseName AS ExWareHouseName, T1.ObjectID, T4.ObjectName, T1.EmployeeID, T5.FullName AS EmployeeName, T1.ApportionID,
        T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T7.FullName AS CreateUserName, T8.FullName AS LastModifyUserName, T1.LastModifyDate, T1.RefNo01 AS Ref01 , T1.RefNo02 AS Ref02, T9.VoucherTypeName, 
		T2.InventoryID, T10.InventoryName, T2.UnitID , T2.ActualQuantity, 
		(Select Top 1 (UnitPrice*100/Rate) from AT0113 WHERE VoucherID = T1.VoucherID) AS UnitPrice, 
		(Select SUM(OriginalAmount) from AT0113 WHERE VoucherId = T1.VoucherID) as OriginalAmount,
		T2.DebitAccountID, T2.ImStoreManID, T2.SourceNo, T2.LimitDate
        FROM AT0112 T1 WITH (NOLOCK)
        LEFT JOIN AT0113 T2 WITH (NOLOCK) ON T1.VoucherID = T2.VoucherID AND T2.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1303 T3 WITH (NOLOCK) ON T2.ImWareHouseID = T3.WareHouseID AND T2.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T1.ObjectID = T4.ObjectID AND T4.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T1.EmployeeID = T5.EmployeeID AND T5.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1303 T6 WITH (NOLOCK) ON T2.ImWareHouseID = T6.WareHouseID AND T6.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1103 T7 WITH (NOLOCK) ON T1.EmployeeID = T7.EmployeeID AND T7.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1103 T8 WITH (NOLOCK) ON T1.EmployeeID = T8.EmployeeID AND T8.DivisionID IN (T1.DivisionID,''@@@'')
        LEFT JOIN AT1007 T9 WITH (NOLOCK) ON T9.DivisionID = T1.DivisionID AND T9.VoucherTypeID = T1.VoucherTypeID
		LEFT JOIN AT1302 T10 WITH (NOLOCK) ON T10.InventoryID = T2.InventoryID AND T10.DivisionID IN (T1.DivisionID,''@@@'')
        WHERE T1.DivisionID = ''' + @DivisionID + ''' AND T1.APK = ''' + @APK + ''' 
	 '

PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

