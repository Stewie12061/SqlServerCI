IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2125]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2125]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load kế thừa chương trình học tháng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Khánh Đoan on 18/11/2019
-- <Example>
---- 
/*-- <Example>
EXEC EDMP2125 @DivisionID=N'BE',@UserID=N'HONGTHAO',@APK=N'9B889E8C-3B2D-49C7-8130-08AA1A72A940',@Mode=N'1',
@PageNumber=1,@PageSize=25, @ProgrammonthID = '',@VoucherDate='',
@TermID='', @TranMonth='',@TranYear ='',@GradeID='',@ClassID=''
----*/


CREATE PROCEDURE [dbo].[EDMP2125]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Mode VARCHAR(1) , -- 0: kế thừa thì có phân trang; 1 load detail
	 @PageNumber INT = 1,
	 @PageSize INT = 25,
	 @ProgrammonthID VARCHAR(50),
	 @VoucherDate DateTime ,
	 @TermID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT ,
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50)

)
AS 

DECLARE @sSQL NVARCHAR (MAX), 
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N''


	SET @TotalRow = 'COUNT(*) OVER ()' 
	SET @OrderBy = '[E2120].ProgrammonthID'
	


	IF ISNULL(@ProgrammonthID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2120].ProgrammonthID LIKE N''%'+@ProgrammonthID+'%'''
	IF ISNULL(@VoucherDate, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2120].VoucherDate =  '''+ CONVERT(VARCHAR, @VoucherDate,111)+''''
	IF ISNULL(@TermID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2120].TermID LIKE N''%'+@TermID+'%'''
	IF ISNULL(cast(@TranMonth + @TranYear*100 as nvarchar(50)), '') <> '' 
		SET @sWhere = @sWhere + N' AND ([E2120].TranMonth + [E2120].TranYear*100) = '+(cast(@TranMonth + @TranYear*100 as nvarchar(50)))+''
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2120].GradeID  LIKE N''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND [E2120].ClassID  LIKE N''%'+@ClassID +'%'''

IF @Mode = '0' -- LỌC CHƯƠNG TRÌNH HỌC THÁNG
	BEGIN
	SET @sSQL ='
				 SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
						[E2120].APK,[E2120].ProgrammonthID,[E2120].VoucherDate,[E2120].TermID, 
						[E2120].TranMonth,[E2120].GradeID, [E2120].ClassID, [E2120].Description
				 FROM EDMT2120 [E2120]
				 WHERE [E2120].DivisionID = '''+@DivisionID+'''
				'+@sWhere+'

				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

	END
IF @Mode = '1'
-----LOAD DEATIL
	SET @sSQL ='SELECT [E2121].Topic ,[E2121].Description , [E2121].[Week]
				FROM EDMT2121 [E2121]
				WHERE [E2121].APKMaster ='''+@APK+'''
	'
PRINT @sSQL
EXEC (@sSQL )





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
