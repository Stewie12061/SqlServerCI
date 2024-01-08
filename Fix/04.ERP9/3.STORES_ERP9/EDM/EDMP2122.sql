IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2122]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2122]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load tab thông tin chi tiết chương trình học theo tháng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 06/10/2018
-- <Example>
---- 
/*-- <Example>
	 EDMP2122 @DivisionID = 'BE', @UserID = '', @APK = 'F7583E2C-3D2E-4C65-83C0-ACC295EA45EF', @LanguageID='vi-VN',@PageNumber = '1',@PageSize = '25',@Mode = '1'
	SELECT * FROM EDMT2120
	 EDMP2122 @DivisionID, @UserID, @APK,@PageNumber,@PageSize,@Mode
----*/
CREATE PROCEDURE EDMP2122
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT 
)

AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N''


SET @OrderBy = 'T1.APK'

IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.APKMaster,T1.Topic,T1.Description, T1.Week, T1.FromDate, T1.ToDate
FROM EDMT2121 T1 WITH (NOLOCK) 
WHERE T1.APKMaster = '''+@APK+''''
END

ELSE IF @Mode = 1 
BEGIN 

DECLARE @TotalRow NVARCHAR(50) = N''

SET @TotalRow = 'COUNT(*) OVER ()'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK,T1.DivisionID,T1.APKMaster,T1.Topic, T1.Description, T1.Week, T1.FromDate, T1.ToDate
FROM EDMT2121 T1 WITH (NOLOCK) 
WHERE T1.APKMaster = '''+@APK+'''
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
