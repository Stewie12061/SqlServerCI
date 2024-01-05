IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP20432]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP20432]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh sách mặt hàng của yêu cầu chuyển kho theo VoucherNo
-- <History>
----Created on 27/12/2022 by Anh Đô
-- <Example>

CREATE PROC WMP20432
			 @DivisionID	VARCHAR(50)
			,@ListVoucherNo		VARCHAR(50)
AS
BEGIN
	DECLARE @sSql	NVARCHAR(MAX)
			,@sSql2	NVARCHAR(MAX)
	SET @sSqL = N'
		SELECT
			 W.APK
			,W2.VoucherNo
			,W.InventoryID
			,W.UnitID
			,A5.UnitName
			,A5.UnitID AS ConvertedUnitID
			,W.ActualQuantity
			,W.UnitPrice
			,W.OriginalAmount
			,W.LimitDate
			,W.SourceNo
			,W.Notes
			,A1.InventoryName
			,A2.AccountName AS DebitAccountName
			,A3.AccountName AS CreditAccountName
			,A4.AnaName AS Ana08Name
			,(SELECT AT2008.EndQuantity
					FROM AT2008 WITH (NOLOCK)
					WHERE DivisionID = '''+ @DivisionID +'''
					AND InventoryID = W.InventoryID
					AND InventoryAccountID = A1.AccountID
					AND TranMonth + 100 * AT2008.TranYear = STR(W.TranMonth + 100 * W.TranYear)
					AND WarehouseID = W2.WareHouseID) 
			AS ActEndQty
		INTO #TmpWT0096
		FROM WT0096 W WITH (NOLOCK)
		LEFT JOIN WT0095 W2 WITH (NOLOCK) ON W2.APK = W.VoucherID
		LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = W.InventoryID AND A1.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1005 A2 WITH (NOLOCK) ON A2.AccountID = W.DebitAccountID AND A2.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1005 A3 WITH (NOLOCK) ON A3.AccountID = W.CreditAccountID AND A3.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A4.AnaID = W.Ana08ID AND A4.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		LEFT JOIN AT1304 A5 WITH (NOLOCK) ON A5.UnitID = W.UnitID AND A5.DivisionID IN ('''+ @DivisionID +''', ''@@@'')
		WHERE W.DivisionID IN ('''+ @DivisionID +''', ''@@@'') AND W2.VoucherNo IN ('''+ @ListVoucherNo +''')
	'

	SET @sSql2 = N'
		DECLARE @TotalRow INT
		SELECT @TotalRow = COUNT(*) FROM #TmpWT0096
		SELECT @TotalRow AS TotalRow, T.* FROM #TmpWT0096 T
	'

	EXEC(@sSql + @sSql2)
END

SET QUOTED_IDENTIFIER OFF


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
