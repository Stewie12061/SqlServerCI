IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0025]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- OP0025
-- <Summary>
---- Store load lưới màn hình danh sách mặt hàng sắp hết hạn sử dụng (ANGEL)
---- Created on 25/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- <Example>
---- EXEC [OP0025] @DivisionID = 'ANG', @UserID = 'ASOFTADMIN', '58122F11-7A86-4A3D-A3CE-AE7C7CC361CB, BB20170000000273, BB20170000000804, BB20170000000120, TTd97e3b8e-5112-4602-8e8d-605b57af9c03, BB20170000000805'

CREATE PROCEDURE [DBO].[OP0025]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),		
	@lstTransactionID NVARCHAR(MAX)
) 
AS

DECLARE @sSQL NVARCHAR(MAX)

SET @lstTransactionID = REPLACE(@lstTransactionID, ', ', ''',''')

SET @sSQL = '
SELECT AT2006.DivisionID, AT2006.VoucherID, AT2006.VoucherNo, AT2006.VoucherDate, AT2006.KindVoucherID, AT2006.ObjectID, AT2006.WareHouseID, 
AT2007.InventoryID, AT1302.InventoryName, AT2007.LimitDate, AT2007.SourceNo
FROM AT2006 WITH (NOLOCK)
INNER JOIN AT2007 WITH (NOLOCK) ON AT2007.DivisionID = AT2006.DivisionID AND AT2007.VoucherID = AT2006.VoucherID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', AT2007.DivisionID) AND AT1302.InventoryID = AT2007.InventoryID
WHERE AT2006.DivisionID = ''' + @DivisionID + '''
AND AT2007.TransactionID in (''' + @lstTransactionID + ''') 
'

PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
