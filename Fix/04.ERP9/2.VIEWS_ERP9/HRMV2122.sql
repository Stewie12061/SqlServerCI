IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMV2122]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HRMV2122]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- Đổ nguồn combo kết quả
---- Created on 26/09/2017 Hải Long
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

CREATE VIEW [dbo].[HRMV2122] 
AS 

SELECT '1' AS ResultID, N'Đạt' AS ResultName
UNION ALL
SELECT '2' AS ResultID, N'Không đạt' AS ResultName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
