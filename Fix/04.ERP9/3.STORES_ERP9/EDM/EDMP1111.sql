IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1111]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1111]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục đưa đón \ Xem thông tin đưa đón \ Tab chi tiết đưa đón
-- <History>
----Created by: Lương Mỹ, Date: 02/01/2019
---- Modified by on 
-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE EDMP1111 
( 
	 @DivisionID VARCHAR(50),
	 @APK VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''

        
SET @OrderBy = 'T1.StudentID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK, T1.DivisionID, T1.StudentID,  T2.StudentName 
FROM EDMT1111 T1 WITH (NOLOCK)
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID
WHERE T1.APKMaster = '''+@APK+'''
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
