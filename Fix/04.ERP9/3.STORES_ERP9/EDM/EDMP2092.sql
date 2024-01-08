IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2092]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2092]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load tab thông tin lịch học năm chi tiết
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 10/09/2018
-- <Example>
---- 
/*-- <Example>
	 EDMP2092 @DivisionID = 'BS', @UserID = 'ASOFTADMIN', @APK = '5DA80878-B1E6-4E46-8E53-EA703DE45FDD',@PageNumber = '1',@PageSize = '25',@Mode = '1'
	 EDMP2092 @DivisionID, @UserID, @APK, @PageNumber,@PageSize,@Mode
----*/
CREATE PROCEDURE EDMP2092
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT
)

AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.FromDate'

IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.APKMaster,T1.ActivityTypeID, T2.ActivityTypeName,
T1.ActivityID,T3.ActivityName, T1.FromDate,T1.ToDate,T1.Contents
FROM EDMT2091 T1 WITH (NOLOCK) 
LEFT JOIN EDMT1060 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ActivityTypeID = T2.ActivityTypeID
LEFT JOIN EDMT1061 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'')AND T2.APK = T3.APKMaster AND T3.ActivityID = T1.ActivityID
WHERE T1.APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy+''
END 

ELSE IF @Mode = 1 
BEGIN 
DECLARE @TotalRow NVARCHAR(50) = N''

SET @TotalRow = 'COUNT(*) OVER ()'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK,T1.DivisionID,T1.APKMaster,T1.ActivityTypeID,
T2.ActivityTypeName,T1.ActivityID,T3.ActivityName, T1.Contents,
T1.FromDate,T1.ToDate 
FROM EDMT2091 T1 WITH (NOLOCK) 
LEFT JOIN EDMT1060 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ActivityTypeID = T2.ActivityTypeID
LEFT JOIN EDMT1061 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'') AND T2.APK = T3.APKMaster AND T3.ActivityID = T1.ActivityID
WHERE T1.APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy+' 

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

END 

 PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
