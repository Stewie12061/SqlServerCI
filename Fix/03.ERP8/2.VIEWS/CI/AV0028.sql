IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0028]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created By Hải Long, 171808/2017
---- Purpose View Load thông tin loại hóa đơn điện tử
---- Modified by ...
CREATE VIEW [dbo].[AV0028] as 

SELECT 0 AS EInvoiceType, N'Hóa đơn gốc' AS EInvoiceTypeName
UNION ALL	
SELECT 1 AS EInvoiceType, N'Hóa đơn điều chỉnh' AS EInvoiceTypeName
UNION ALL	
SELECT 2 AS EInvoiceType, N'Hóa đơn thay thế' AS EInvoiceTypeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

