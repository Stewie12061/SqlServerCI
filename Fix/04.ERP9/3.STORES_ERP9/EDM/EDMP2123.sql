IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2123]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2123]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Chọn khung chương trình EDMF2123
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 17/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2123 @DivisionID = 'BE', @UserID = 'asoftadmin',@Mode = '1', @TermID = '',@ProgramID = '',
	@XML = '''<Data><APK>3484C4BF-A340-45F5-AAC1-58CB4D326B8F</APK></Data>
             <Data><APK>75A36F06-9C94-4217-997D-70ACEEA36B0B</APK></Data>
             ''',
	@PageNumber = '1', @PageSize = '25'


	EDMP2123 @DivisionID = 'BE', @UserID = 'asoftadmin',@Mode = '0', @TermID = '',@ProgramID = '',
	@XML = 'Null', @PageNumber = '', @PageSize = ''
	
	EDMP2123 @DivisionID, @UserID, @Mode,@TermID,@ProgramID,@XML,@PageNumber, @PageSize
----*/
CREATE PROCEDURE EDMP2123
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @Mode TINYINT,
	 @TermID VARCHAR (50),
	 @ProgramID VARCHAR (50),
	 @XML XML,
	 @PageNumber INT,
	 @PageSize INT
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

 
SET @TotalRow = 'COUNT(*) OVER ()'
SET @OrderBy = 'ProgramID'

IF @Mode =0 ---Load detail 1: Tổng khung chương trình 
BEGIN 

IF ISNULL(@ProgramID,'') <> '' SET @sWhere = @sWhere + '
AND ProgramID LIKE N''%'+@ProgramID+'%'' '

IF ISNULL(@TermID,'') <> '' SET @sWhere = @sWhere + '
AND TermID LIKE N''%'+@TermID+'%'' '	


SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
EDMT2110.APK,EDMT2110.DivisionID,EDMT2110.ProgramID,EDMT2110.FromDate,EDMT2110.ToDate,
EDMT2110.TermID + '' ('' + CONVERT(VARCHAR(10), T2.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T2.DateTo, 103) + '')'' AS TermID
FROM EDMT2110 WITH (NOLOCK) 
LEFT JOIN EDMT1040 T2 WITH(NOLOCK) ON EDMT2110.TermID = T2.SchoolYearID
WHERE EDMT2110.DivisionID = '''+@DivisionID+'''
'+@sWhere+'
'
END 
ELSE IF @Mode = 1 ---Load detail 2: Detail tổng khung chương trình 

BEGIN 
CREATE TABLE #EDMP2123(APK VARCHAR(50))
INSERT INTO #EDMP2123 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)


SELECT ROW_NUMBER() OVER (ORDER BY TranMonth ) AS RowNum, COUNT(*) OVER () AS TotalRow, 
T01.APKMaster,T01.DivisionID,T01.Topic,T03.ActivityName,T01.FromDate,T01.ToDate,T01.TranMonth,T01.TranYear, 
CASE WHEN TranMonth < 10 THEN '0'+CAST (TranMonth AS nvarchar)+'/'+CAST (TranYear AS nvarchar) Else CAST (TranMonth AS nvarchar)+'/'+CAST (TranYear AS nvarchar) END AS MonthIDTopic
FROM EDMT2112 T01 WITH (NOLOCK) 
LEFT JOIN EDMT1060 T02 WITH (NOLOCK) ON T02.DivisionID IN (T01.DivisionID, '@@@') AND T02.ActivityTypeID = T01.ActivityTypeID AND T02.Disabled = 0 
LEFT JOIN EDMT1061 T03 WITH (NOLOCK) ON T03.DivisionID IN (T01.DivisionID, '@@@') AND T02.APK = T03.APKMaster AND T01.ActivityID = T03.ActivityID AND T03.Disabled = 0 
INNER JOIN #EDMP2123 ON T01.APKMaster = #EDMP2123.APK 

END





--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




