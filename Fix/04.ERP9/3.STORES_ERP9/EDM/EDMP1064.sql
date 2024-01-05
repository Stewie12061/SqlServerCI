IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1064]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1064]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load danh mục loại hoạt động chi tiết 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục loại hoạt động \ Xem chi tiết loại hoạt động 
-- <History>
----Created by: Hồng Thảo, Date: 26/08/2018
---- Modified by on 
-- <Example>
---- 
/*-- <Example>
	EDMP1064 @DivisionID = 'VF',@APK = '', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsSearch = 1, @ActivityID = '', 
	@ActivityName = ''
	
	EDMP1064 @DivisionID,@APK, @UserID, @PageNumber, @PageSize, @IsSearch, @ActivityID, @ActivityName
----*/

CREATE PROCEDURE EDMP1064
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'EDMT1061.ActivityID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
EDMT1061.APK, EDMT1061.DivisionID, EDMT1061.APKMaster, EDMT1061.ActivityID, EDMT1061.ActivityName
FROM EDMT1061 WITH (NOLOCK)
WHERE EDMT1061.APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy+' 
	
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)


   

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
