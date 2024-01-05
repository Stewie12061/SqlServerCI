IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP20091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP20091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load detail màn hình kế thừa phiếu kiểm tra chất lượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Nhật Thanh on 19/09/2023
---Modified by: Thanh Nguyên on 09/11/2023 - Bổ sung kế thừa Specification 
---Modified by: Thanh Lượng  on 15/12/2023 - [2023/12/TA/0126]: Bổ sung dữ liệu POrderID của DHM kế thừa từ phiếu QC.
---Modified by: Nhật Thanh on 20/12/2023 - Bổ sung tên bảng cụ thể 
-- <Example> EXEC QCP20091 @DivisionID = 'VNP', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE [dbo].[QCP20091]
( 
	
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LstOrderID VARCHAR(4000),  ---- Danh sách OrderID check chọn ở lưới master
	 @APK VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
@sSQL1 NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sSQLSL NVARCHAR (MAX) = '',
			@sWhere  NVARCHAR(max) = '',
			@Level INT,
			@i INT = 1, @s VARCHAR(2)

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'



	SET @sSQL =N'SELECT ROW_NUMBER() OVER (ORDER BY VoucherNo) AS RowNum, '+@TotalRow+N' AS TotalRow, *
	FROM ( SELECT QCT2001.APK, QCT2000.DivisionID, QCT2000.VoucherDate, QCT2000.VoucherNo, QCT2001.InventoryID , InventoryName, A02.UnitID, 
	QuantityInherit - QuantityUnQC - ISNULL((SELECT SUM(ISNULL(ActualQuantity,0)) FROM AT2007 WHERE DivisionID = QCT2000.DivisionID and InheritTableID = ''QCT2001'' and InheritTransactionID = QCT2001.APK and IscheckQuality = 1),0) as QuantityQC, 
		null as QuantityUnQC, QCT2001.PONumber, A02.Specification, OT3003.POrderID
				From QCT2001
				LEFT JOIN QCT2000 ON QCT2001.APKMaster = QCT2000.APK
				LEFT JOIN AT1302 A02 ON A02.DivisionID in (QCT2001.DivisionID, ''@@@'') and A02.InventoryID = QCT2001.InventoryID
				LEFT JOIN OT3002 ON OT3002.TransactionID = QCT2001.InheritTransaction
				LEFT JOIN OT3003 ON OT3003.POrderID = OT3002.POrderID
		 WHERE QCT2000.VoucherNo in ('''+@LstOrderID+N''') 		
		 UNION ALL
		 SELECT QCT2001.APK, QCT2000.DivisionID, QCT2000.VoucherDate, QCT2000.VoucherNo, QCT2001.InventoryID , InventoryName, A02.UnitID,null as QuantityQC, 
		 QuantityUnQC- ISNULL((SELECT SUM(ISNULL(ActualQuantity,0)) FROM AT2007 WHERE DivisionID = QCT2000.DivisionID and InheritTableID = ''QCT2001'' and InheritTransactionID = QCT2001.APK and IscheckQuality = 0),0) as QuantityUnQC, 
		 QCT2001.PONumber, A02.Specification, OT3003.POrderID
				From QCT2001
				LEFT JOIN QCT2000 ON QCT2001.APKMaster = QCT2000.APK
				LEFT JOIN AT1302 A02 ON A02.DivisionID in (QCT2001.DivisionID, ''@@@'') and A02.InventoryID = QCT2001.InventoryID 
				LEFT JOIN OT3002 ON OT3002.TransactionID = QCT2001.InheritTransaction
				LEFT JOIN OT3003 ON OT3003.POrderID = OT3002.POrderID
		 WHERE QCT2000.VoucherNo in ('''+@LstOrderID+''') 
		 ) A
		 WHERE ISNULL(QuantityQC,0)!=0 OR ISNULL(QuantityUnQC,0)!=0
		 ORDER BY VoucherNo, InventoryID
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY		
'
		PRINT (@sSQL)
		EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO