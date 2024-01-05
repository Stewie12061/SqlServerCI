IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2112]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2112]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load tab thông tin tổng khung chương trình (tổng quan) 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 13/09/2018
-- <Example>
---- 
/*-- <Example>
	 EDMP2112 @DivisionID = 'BE', @UserID = '', @APK = '3484C4BF-A340-45F5-AAC1-58CB4D326B8F',@LanguageID= 'vi-VN', @PageNumber = '1',@PageSize = '25',@Mode = 1

	 EDMP2112 @DivisionID, @UserID, @APK,@LanguageID,@PageNumber,@PageSize,@Mode
----*/
CREATE PROCEDURE EDMP2112
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Mode TINYINT ---0: Cập nhật, 1 Xem chi tiết 
)

AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N''


SET @OrderBy = 'T1.TranMonth'

IF @Mode = 0 
BEGIN 
SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.APKMaster,T1.TranMonth,T1.TranYear, 
CASE WHEN T1.TranMonth < 10 THEN ''0''+CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) Else CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) END AS MonthID,
T1.[Description]
FROM EDMT2111 T1 WITH (NOLOCK) 
WHERE T1.DivisionID = '''+@DivisionID+''' AND  T1.APKMaster = '''+@APK+''''
END 


ELSE IF @Mode = 1 
BEGIN 

DECLARE @TotalRow NVARCHAR(50) = N''

SET @TotalRow = 'COUNT(*) OVER ()'

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK,T1.DivisionID,T1.APKMaster,T1.TranMonth,T1.TranYear, 
CASE WHEN T1.TranMonth < 10 THEN ''0''+CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) Else CAST (T1.TranMonth AS nvarchar)+''/''+CAST (T1.TranYear AS nvarchar) END AS MonthID,
T1.[Description]
FROM EDMT2111 T1 WITH (NOLOCK) 
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.APKMaster = '''+@APK+'''
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
