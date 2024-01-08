IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV2006]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created by Nguyen Van Nhan, Date 07/01/2004
---- Purpose: Dung de truy van so chung tu
---- Edit by Nguyen Quoc Huy, Date 12/05/2005
---- Modified by Phương Thảo on 18/05/2016 : Bổ sung with(nolock)
---- Modified by Bảo Thy on 19/05/2017: Sửa danh mục dùng chung
---- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

CREATE VIEW [dbo].[AV2006] as

SELECT 	
AT2017.DivisionID,
AT2016.VoucherID, 
AT2016.VoucherDate,
AT2016.VoucherNo,
AT2017.TransactionID,
AT2017.InventoryID
FROM AT2017 WITH (NOLOCK)
INNER JOIN AT2016 WITH (NOLOCK) ON AT2016.VoucherID = AT2017.VoucherID AND AT2016.DivisionID = AT2017.DivisionID
INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT2017.DivisionID,'@@@') AND AT1302.InventoryID = AT2017.InventoryID
WHERE (AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1 OR AT1302.MethodID = 3)

UNION ALL

SELECT 	
AT2007.DivisionID,
AT2006.VoucherID, 
AT2006.VoucherDate,
AT2006.VoucherNo,
AT2007.TransactionID,
AT2007.InventoryID
FROM AT2007 WITH (NOLOCK)
INNER JOIN AT2006  WITH (NOLOCK) ON AT2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
INNER JOIN AT1302  WITH (NOLOCK) ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
WHERE (AT1302.IsSource = 1 OR AT1302.IsLimitDate = 1 OR AT1302.MethodID = 3) 
AND AT2006.KindVoucherID in (1, 3, 5, 7, 9)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

