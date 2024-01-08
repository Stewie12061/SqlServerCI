IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WV0002]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[WV0002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- 
-- <Summary>
---- View load combo loại phiếu vận chuyển nội bộ (Bê Tông Long An)
---- Created on 08/08/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- 

CREATE VIEW [dbo].[WV0002] 
AS 

SELECT '1' AS TypeID, N'Phiếu VCNB trả về' AS TypeName
UNION ALL
SELECT '2' AS TypeID, N'Phiếu VCNB giao hàng' AS TypeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
