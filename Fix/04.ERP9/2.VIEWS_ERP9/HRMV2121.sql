IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMV2121]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HRMV2121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- Đổ nguồn combo trạng thái
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

CREATE VIEW [dbo].[HRMV2121] 
AS 

SELECT '1' AS StatusTypeID, N'Tham gia' AS StatusTypeName
UNION ALL
SELECT '0' AS StatusTypeID, N'Không tham gia' AS StatusTypeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
