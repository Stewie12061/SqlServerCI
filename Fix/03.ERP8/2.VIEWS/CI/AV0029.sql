IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV0029]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV0029]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created By Hải Long, 28/09/2017
---- Purpose View Load thông tin loại hóa đơn điện tử điều chỉnh
---- Modified by ...
CREATE VIEW [dbo].[AV0029] as 

SELECT 1 AS TypeOfAdjust, N'Điều chỉnh tăng giá trị' AS TypeOfAdjustName
UNION ALL	
SELECT 2 AS TypeOfAdjust, N'Điều chỉnh tăng số lượng' AS TypeOfAdjustName
UNION ALL	
SELECT 3 AS TypeOfAdjust, N'Điều chỉnh giảm giá trị' AS TypeOfAdjustName
UNION ALL	
SELECT 4 AS TypeOfAdjust, N'Điều chỉnh giảm số lượng' AS TypeOfAdjustName
UNION ALL	
SELECT 5 AS TypeOfAdjust, N'Điều chỉnh thông tin' AS TypeOfAdjustName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

