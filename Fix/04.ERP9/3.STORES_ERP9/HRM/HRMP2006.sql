IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh sách người duyệt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 21/07/2017
/*-- <Example>
	 EXEC HRMP2006 @DivisionID='CH',@UserID='ASOFTADMIN', @PageNumber=11,@PageSize=25, @TranMonth=7, @Tranyear=2017
----*/

CREATE PROCEDURE HRMP2006
( 
   @DivisionID VARCHAR(50),
   @UserID VARCHAR(50),
   @PageNumber INT,
   @PageSize INT,
   @TranMonth INT,
   @TranYear INT
)
AS 
DECLARE @sSQL VARCHAR(MAX)='',
 		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50) = ''

SET @OrderBy = 'UserID'
IF @PageNumber <> 0 SET @TotalRow = 'COUNT(*) OVER ()'
ELSE SET @TotalRow = ''
	
SET @sSQL=' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, Temp.*
FROM
(
	SELECT DISTINCT AT1405.UserID, AT1405.UserName
	FROM AT1405 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+'''
)Temp
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS	
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY	'
	
	
EXEC(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
