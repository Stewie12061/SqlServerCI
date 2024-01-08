IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0127]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0127]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load lưới truy vấn chi phí nhập xuất kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 11/01/2017
---- Modified by Bảo Thy on 26/05/2017: Sửa danh mục dùng chung
---- Modified  by Khánh Đoan on 04/11/2019 : Bổ sung  danh mục chi phí khác
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
	 WP0127 @DivisionID=N'HT',@UserID = 'ASOFTADMIN', @FromDate='2016-11-01 15:30:09.077',@ToDate='2016-11-30 15:30:09.077', @Mode=2
*/
CREATE PROCEDURE [dbo].[WP0127] 
(
	@DivisionID VARCHAR(50),				
	@UserID AS VARCHAR(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Mode TINYINT -- 0: chi phí nhập, 1: chi phí xuất, 2: tất cả, 3: Chi phí khác

)	
AS
DECLARE @sSQL NVARCHAR(MAX) = ''

SET @sSQL = N'
SELECT W97.DivisionID, W97.VoucherTypeID, W97.VoucherID, W97.VoucherDate, W97.VoucherNo, W97.Description, A12.ObjectName, A33.Inventoryname AS WareHouseName,
A13.UserName AS CreateUserName, A12.ObjectID,
CASE WHEN ISNULL(W97.IsFinalCost,0) = 0 THEN N''Chưa quyết toán''
	 WHEN ISNULL(W97.IsFinalCost,0) = 1 THEN N''Đã quyết toán'' END AS IsFinalCost
FROM WT0097 W97 WITH (NOLOCK)
LEFT JOIN AT1202 A12 WITH (NOLOCK) ON A12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND W97.ObjectID = A12.ObjectID
LEFT JOIN AT1405 A13 WITH (NOLOCK) ON W97.DivisionID = A13.DivisionID AND W97.CreateUserID = A13.UserID
LEFT JOIN AT1302 A33 WITH (NOLOCK) ON W97.WareHouseID = A33.InventoryID
WHERE W97.DivisionID = '''+@DivisionID+'''
AND CONVERT(VARCHAR(10),W97.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR(10), @FromDate,120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate,120)+'''
'+CASE WHEN STR(@Mode) = 0 THEN 'AND W97.IsImportVoucher = 1 AND W97.IsOtherCosts = 0'
	   WHEN STR(@Mode) = 1 THEN 'AND W97.IsImportVoucher = 0 AND W97.IsOtherCosts = 0' 
	   WHEN STR(@Mode) = 3 THEN 'AND W97.IsOtherCosts = 1'
	   ELSE '' END+'
ORDER BY W97.VoucherDate, W97.VoucherNo
'

--PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
