IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0027]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created By Hải Long, 17/08/2017
---- Purpose View load thông tin tình trạng hóa đơn điện tử
---- Modified by ...
CREATE VIEW [dbo].[AV0027] as 
	
SELECT 1 AS EInvoiceStatus, N'Đã bị điều chỉnh' AS EInvoiceStatusName
UNION ALL	
SELECT 2 AS EInvoiceStatus, N'Đã bị thay thế' AS EInvoiceStatusName
UNION ALL	
SELECT 3 AS EInvoiceStatus, N'Đã bị hủy bỏ' AS EInvoiceStatusName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

