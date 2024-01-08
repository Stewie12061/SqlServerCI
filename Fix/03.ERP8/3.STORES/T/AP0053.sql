IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0053
-- <Summary>
---- Stored đổ nguồn combo phương pháp phân bổ (PACIFIC)
---- Created on 12/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0053 @DivisionID = 'PCF', @UserID = 'ASOFTADMIN', @AllocationLevelID = 2

CREATE PROCEDURE [DBO].[AP0053]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@AllocationLevelID AS TINYINT
) 
AS

DECLARE @sSQL NVARCHAR(MAX)	
	
SET @sSQL = N'	
SELECT AllocationID, Description, AllocationType, 
(CASE WHEN AllocationType = 1 THEN N''Tỉ lệ''
      WHEN AllocationType = 2 THEN N''Số lượng nhân viên''
      ELSE N''Giá trị ấn định'' END) as AllocationTypeName  
FROM AT1610 WITH (NOLOCK)
WHERE DivisionID = ''' + @DivisionID + '''
AND AllocationLevelID = ' + CONVERT(NVARCHAR(5), @AllocationLevelID) + '
ORDER BY CreateDate DESC
'
	  
PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
