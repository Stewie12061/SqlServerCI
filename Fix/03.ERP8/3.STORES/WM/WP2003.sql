IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP2003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP2003]

SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO

-- <Summary>
---- 
-- <History>
---Kế thừa yêu cầu xuất kho 
---- Create on 21/09/2019 by Khánh Đoan 
---- Modified on 25/15/2019 by Huỳnh Thử: Trừ số lượng nếu chưa kế thừa hết
---- Modified on 19/02/2020 by Huỳnh Thử: Thêm trường hợp Edit, load dl của phiếu yêu cầu xuất kho
---- Modified on 23/07/2020 by Văn Tài: Bổ sung xóa và tạo lại store.
---- Modified on 23/09/2020 by Huỳnh Thử: Trường hợp Manual where theo TransactionID
---- Modified by Huỳnh Thử on 30/09/2020 : Bổ sung danh mục dùng chung
---- <Example>

CREATE PROCEDURE [dbo].[WP2003]
    @DivisionID NVARCHAR(50),
    @VoucherID NVARCHAR(50),
    @TransactionID NVARCHAR(50),
	@Mode TINYINT
AS
DECLARE @sSQL NVARCHAR(MAX);

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[TAMKHO]') AND TYPE IN (N'U'))
DROP TABLE TAMKHO

CREATE TABLE TAMKHO (ActualQuantity DECIMAL(28,8), InheritTransactionID NVARCHAR(50), InheritVoucherID NVARCHAR(50) )
IF ISNULL(@TransactionID,'') <> '' -- Trường hợp Manual
BEGIN
	--- Load yêu cầu xuất kho kế thừa 

	INSERT INTO TAMKHO
	SELECT SUM(T02.ActualQuantity) AS ActualQuantity,InheritTransactionID,InheritVoucherID   FROM WT2002 T02 
	WHERE T02.InheritVoucherID = @VoucherID
	AND T02.InheritTransactionID = @TransactionID
	GROUP BY InheritTransactionID,InheritVoucherID 
END
ELSE
BEGIN
	--- Load yêu cầu xuất kho kế thừa
	INSERT INTO TAMKHO
	SELECT SUM(T02.ActualQuantity) AS ActualQuantity,InheritTransactionID,InheritVoucherID   FROM WT2002 T02 
	WHERE T02.InheritVoucherID = @VoucherID
	GROUP BY InheritTransactionID,InheritVoucherID 

END


IF @Mode = 0
BEGIN
    SET @sSQL
        = '
		SELECT Distinct T96.InventoryID, AT1302.InventoryName, T96.UnitID, T96.LimitDate, T96.SourceNo ,T01.VoucherNo as ReVoucherNo, T96.VoucherID AS InheritVoucherID ,
		T96.TransactionID AS InheritTransactionID, ISNULL(T96.ActualQuantity,0) - ISNULL(TAM.ActualQuantity,0) AS ActualQuantity ,  T96.ReVoucherID, T96.ReTransactionID
		FROM WT0096 T96 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T96.DivisionID) AND AT1302.InventoryID = T96.InventoryID
		LEFT JOIN AT2006 T01 WITH (NOLOCK) ON T01.VoucherID = T96.ReVoucherID
		LEFT JOIN WT0095 T95 WITH (NOLOCK) ON T95.VoucherID = T96.VoucherID
		LEFT JOIN TAMKHO TAM WITH (NOLOCK) ON TAM.InheritVoucherID = T96.VoucherID AND  TAM.InheritTransactionID = T96.TransactionID
		WHERE T96.DivisionID =  ''' + @DivisionID + '''
		 AND ISNULL(T96.ActualQuantity,0) - ISNULL(TAM.ActualQuantity,0)  > 0
		 AND T96.VoucherID = ''' + @VoucherID + ''' -- AND T96.ReVoucherID = T02.ReVoucherID
		 '+CASE WHEN @Mode = 0 AND ISNULL(@TransactionID,'') <> '' THEN ' AND T96.TransactionID = '''+@TransactionID+''' -- Trường hợp Manual' ELSE '' END +' 
		 --ORDER BY InventoryID, CASE WHEN T95.TypeRule = 1 THEN N''T95.VoucherDate'' ELSE ''T95.LimitDate '' END';
END;
ELSE
BEGIN
    SET @sSQL
        = '
SELECT T96.InventoryID, AT1302.InventoryName, T96.UnitID, T96.LimitDate, T96.SourceNo ,T01.VoucherNo as ReVoucherNo, T96.VoucherID AS InheritVoucherID ,
T96.TransactionID AS InheritTransactionID, ISNULL(T96.ActualQuantity,0) AS ActualQuantity ,  T96.ReVoucherID, T96.ReTransactionID
FROM WT0096 T96 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', T96.DivisionID) AND AT1302.InventoryID = T96.InventoryID
LEFT JOIN AT2006 T01 WITH (NOLOCK) ON T01.VoucherID = T96.ReVoucherID
LEFT JOIN WT0095 T95 WITH (NOLOCK) ON T95.VoucherID = T96.VoucherID
WHERE T96.DivisionID =  ''' + @DivisionID + '''
 AND T96.VoucherID = ''' + @VoucherID
 + ''' -- AND T96.ReVoucherID = T02.ReVoucherID

 ORDER BY InventoryID, CASE WHEN T95.TypeRule = 1 THEN N''T95.VoucherDate'' ELSE ''T95.LimitDate '' END';
END
PRINT @sSQL;
EXEC (@sSQL);

GO


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO