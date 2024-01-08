IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2065]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2065]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn combo phòng ban
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 08/09/2017
---- <Example>
---- Exec HRMP2065 @DivisionID='AS',@UserID='ASOFTADMIN',@DivisionList='AS'',''GC'
---- 

CREATE PROCEDURE [dbo].[HRMP2065]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @DivisionList NVARCHAR(MAX)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX) = N''
        
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = N'DivisionID IN ('''+@DivisionList+''', ''@@@'')'
ELSE 
	SET @sWhere = N'DivisionID IN ('''+@DivisionID+''', ''@@@'')'     

SET @sSQL = ' 		
SELECT DepartmentID, DepartmentName
FROM AT1102 WITH (NOLOCK)
WHERE ' + @sWhere + '
and [Disabled] = 0
ORDER BY DepartmentID'

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
