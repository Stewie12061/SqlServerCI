IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab thông tin lịch học cơ sở chi tiết
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
	 EDMP2102 @DivisionID = 'BS', @UserID = 'asoftadmin', @APK = '21808ED8-B313-46C0-8E31-B6C3634CB584',@PageNumber = '1',@PageSize= '25',@Mode= 0
	 
	 EDMP2102 @DivisionID, @UserID, @APK,@PageNumber,@PageSize,@Mode
----*/
CREATE PROCEDURE EDMP2102
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT
)

AS 

DECLARE @sSQL NVARCHAR(MAX),
@TotalRow NVARCHAR(50) = N'',
@OrderBy NVARCHAR(MAX) = N''

SET @OrderBy = N'FromHour ASC'


IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @Mode = 0
BEGIN
SET @sSQL = N'
SELECT APK,DivisionID,APKMaster,FromHour, ToHour,Monday,Tuesday, Wednesday,Thursday,Friday,Saturday,Sunday
FROM EDMT2101  WITH (NOLOCK) 
WHERE APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy+'
'
END 

ELSE IF @Mode = 1
BEGIN
SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
APK,DivisionID,APKMaster,FromHour, ToHour,Monday,Tuesday, Wednesday,Thursday,Friday,Saturday,Sunday
FROM EDMT2101  WITH (NOLOCK) 
WHERE APKMaster = '''+@APK+'''
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

END 



 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


