IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MV1004]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[MV1004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- View load combo phân loại sản phẩm (Bê Tông Long An)
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

CREATE VIEW [dbo].[MV1004] 
AS 

SELECT '1' AS ProductTypeID, N'Loại A' AS ProductTypeName
UNION ALL
SELECT '2' AS ProductTypeID, N'Loại B' AS ProductTypeName
UNION ALL
SELECT '3' AS ProductTypeID, N'Loại C' AS ProductTypeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
