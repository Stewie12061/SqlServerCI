IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMV2090]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HRMV2090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- Đổ nguồn combo nguồn dữ liệu (Màn hình kế thừa - HRMF2093)
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

CREATE VIEW [dbo].[HRMV2090] 
AS 

SELECT '0' AS ModeID, N'Tất cả' AS ModeName
UNION ALL
SELECT '1' AS ModeID, N'Yêu cầu đào tạo' AS ModeName
UNION ALL
SELECT '2' AS ModeID, N'Kế hoạch đào tạo định kỳ' AS ModeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
