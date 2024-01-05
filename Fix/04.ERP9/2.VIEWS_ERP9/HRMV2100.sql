IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMV2100]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HRMV2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- Đổ nguồn combo tình trạng
---- Created on 20/09/2017 Hải Long
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

CREATE VIEW [dbo].[HRMV2100] 
AS 

SELECT '0' AS StatusID, N'Chưa kết thúc' AS StatusName
UNION ALL
SELECT '1' AS StatusID, N'Đã kết thúc' AS StatusName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
