IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load kế thừa thời khóa biểu năm học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Khánh Đoan on 15/11/2019
-- <Example>
---- 
/*-- <Example>
exec EDMP2105 @DivisionID=N'BE',@UserID=N'HONGTHAO',@APK=N'52C2A309-4142-447F-AC08-296C733E3968',@Mode=N'1',
@PageNumber=1,@PageSize=25, @DailyScheduleID = '',@TermID='',@GradeID='',@ClassID=''		
----*/


CREATE PROCEDURE [dbo].[EDMP2105]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Mode VARCHAR(1) , -- 0: kế thừa thì có phân trang; 1 load detail
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @DailyScheduleID VARCHAR(50),
	 @TermID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50)

)
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N''


	SET @TotalRow = 'COUNT(*) OVER ()' 
	SET @OrderBy = '[E2100].DailyScheduleID'
	


	IF ISNULL(@DailyScheduleID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2100].DailyScheduleID LIKE N''%'+@DailyScheduleID+'%'''
	IF ISNULL(@TermID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2100].TermID LIKE N''%'+@TermID+'%'''
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2100].GradeID  LIKE N''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2100].ClassID  LIKE N''%'+@ClassID +'%'''

IF @Mode = '0' -- LỌC THỜI KHÓA BIỂU NĂM HỌC
	BEGIN
	SET @sSQL ='SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
						[E2100].DivisionID,[E2100].APK,
						[E2100].DailyScheduleID, [E2100].DateSchedule, [E2100].TermID,
						[E2100].GradeID,[E2100].ClassID, [E2100].Description
		
				FROM EDMT2100 [E2100]
				WHERE [E2100].DivisionID = '''+@DivisionID+'''
				'+@sWhere+'

				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

	END
IF @Mode = '1'
-----LOAD DEATIL
	SET @sSQL ='SELECT 
						[E2101].FromHour,[E2101].ToHour, [E2101].Monday,[E2101].Tuesday, 
						[E2101].Wednesday,[E2101].Thursday,[E2101].Friday, [E2101].Saturday
				FROM EDMT2101 [E2101] WITH (NOLOCK) 
				WHERE [E2101].APKMaster ='''+@APK+'''
	'
--PRINT @sSQL
EXEC (@sSQL )




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
