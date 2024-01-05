IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0401]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0401]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load danh sách tổ nhóm theo phòng ban (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
-- <Example>
---- 
/*-- <Example>
	EXEC HP0401 @DivisionID='ANG',N'%'
----*/

CREATE PROCEDURE HP0401
( 
	 @DivisionID VARCHAR(50),
	 @ListDepartmentID NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)


                
SET @sWhere = ''

IF Isnull(@ListDepartmentID,'%') = '%'  
	SET @sWhere = @sWhere + '
		AND DepartmentID LIKE N''%''	'
ELSE 
	SET @sWhere = @sWhere + '
		AND DepartmentID IN ('''+@ListDepartmentID+''')	'


SET @sSQL = '
SELECT TeamID, TeamName  
FROM HT1101 WITH (NOLOCK)  
WHERE DivisionID = ''' +@DivisionID +'''
AND DISABLED = 0 
' + @sWhere + '
ORDER BY TeamID
'

EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
