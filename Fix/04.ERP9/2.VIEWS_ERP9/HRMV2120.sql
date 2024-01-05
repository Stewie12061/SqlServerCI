IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMV2120]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HRMV2120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- Đổ nguồn combo đánh giá chung
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

CREATE VIEW [dbo].[HRMV2120] 
AS 

SELECT '1' AS ResultTypeID, N'Trung bình' AS ResultTypeName
UNION ALL
SELECT '2' AS ResultTypeID, N'Khá' AS ResultTypeName
UNION ALL
SELECT '3' AS ResultTypeID, N'Tốt' AS ResultTypeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
