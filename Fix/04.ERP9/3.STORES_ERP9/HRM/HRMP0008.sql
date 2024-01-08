IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP0008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP0008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load combo năm (màn hình HRMF3006)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 29/09/2017
---- <Example>
---- Exec HRMP0008 @DivisionID='AS',@DivisionList='AS',@UserID='ASOFTADMIN' 
---- 

CREATE PROCEDURE [dbo].[HRMP0008]
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX) = N''

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = N'DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = N'DivisionID = '''+@DivisionID+''''   
	
SET @sSQL = '	
SELECT DISTINCT TranYear
FROM HT9999 WITH (NOLOCK)
WHERE ' + @sWhere + '
ORDER BY TranYear'

PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
