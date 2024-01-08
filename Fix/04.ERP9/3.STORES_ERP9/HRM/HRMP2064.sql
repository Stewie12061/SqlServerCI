IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn combo người tạo
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
---- Exec HRMP2064 @DivisionID='AS',@UserID='ASOFTADMIN',@DivisionList='AS'',''GC'
---- 

CREATE PROCEDURE [dbo].[HRMP2064]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @DivisionList NVARCHAR(MAX)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX) = N''
        
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = N'DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = N'DivisionID = ('''+@DivisionID+''')' 

SET @sSQL = ' 		
SELECT UserID AS EmployeeID, UserName AS EmployeeName
FROM AT1405 WITH (NOLOCK)
WHERE ' + @sWhere + '
GROUP BY UserID, UserName'

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
