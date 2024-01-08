IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMV2071]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HRMV2071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- MP0047
-- <Summary>
---- View load thông tin hiệu lực (Màn hình cập nhật kế hoạch đào tạo định kỳ)
---- Created on 18/09/2017 Hải Long
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

CREATE VIEW [dbo].[HRMV2071] 
AS 

SELECT 0 AS RepeatTime, N'Không giới hạn' AS RepeatTimeName
UNION ALL
SELECT 1 AS RepeatTime, N'1 năm' AS RepeatTimeName
UNION ALL				  
SELECT 2 AS RepeatTime, N'2 năm' AS RepeatTimeName
UNION ALL				  
SELECT 3 AS RepeatTime, N'3 năm' AS RepeatTimeName
UNION ALL				  
SELECT 4 AS RepeatTime, N'4 năm' AS RepeatTimeName
UNION ALL				  
SELECT 5 AS RepeatTime, N'5 năm' AS RepeatTimeName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
