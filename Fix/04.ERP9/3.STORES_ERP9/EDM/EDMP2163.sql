IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2163]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2163]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load tab Chọn biểu phí
----
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 17/10/2018
-- <Example>
/*
		EDMP2163 @DivisionID = 'BE', @UserID = '', @CurGradeID='',@CurFeeID = 'BP003',  @PageNumber = '1',@PageSize = '25',@txtSearch = '',@DateFee = '2019-05-14 00:00:00'
		select * from  edmt1090
		EDMP2163 @DivisionID, @UserID,@GradeID,@CurFeeID,@PageNumber,@PageSize,@txtSearch,@DateFee 

*/
CREATE PROCEDURE EDMP2163
( 
        @DivisionID VARCHAR(50),
		@UserID VARCHAR(50),
		@SchoolYearID VARCHAR(50),
		@GradeID VARCHAR (50),
		@FeeID  VARCHAR(50)=N'',
		@PageNumber INT,
		@PageSize INT,
		@txtSearch NVARCHAR(100),
		@DateFee DATETIME


) 
AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
		@OrderBy NVARCHAR(500) = N'',
		@OrderBy1 NVARCHAR(500) = N'',
		@sWhere NVARCHAR(1500) = N'' 

SET @OrderBy = 'FeeID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


IF ISNULL(@txtSearch, '') <> '' SET @sWhere = @sWhere + N'
	AND (T1.FeeID LIKE N''%'+@txtSearch+'%'' 
	OR T1.FeeName LIKE N''%'+@txtSearch+'%'')'

IF ISNULL(@SchoolYearID,'') != ''
	SET @sWhere = @sWhere + N' AND T1.SchoolYearID LIKE N''%'+@SchoolYearID+'%'' '

IF ISNULL(@GradeID,'') != ''
	SET @sWhere = @sWhere + N' AND T1.GradeID LIKE N''%'+@GradeID+'%'' '

IF ISNULL(@FeeID,'')<>''
	SET @sWhere = @sWhere + N' AND T1.FeeID LIKE N''%'+@FeeID+'%'' '

IF ISNULL(@DateFee,'')<>''
	SET @sWhere = @sWhere + N' AND '''+CONVERT(VARCHAR(10),@DateFee,126)+''' BETWEEN T2.DateFrom AND T2.DateTo '

BEGIN 
	SET @sSQL = @sSQL + N'
	SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy1+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
	iif(T1.FeeID='''+@FeeID+''',1,0) as CurOrder,
	T1.APK,	T1.DivisionID,	T1.FeeID,	T1.FeeName,	T1.GradeID
	FROM EDMT1090 T1 WITH (NOLOCK) 
	INNER JOIN EDMT1040 T2 WITH (NOLOCK)  ON T2.SchoolYearID = T1.SchoolYearID
	WHERE T1.DivisionID IN ('''+@DivisionID+''',''@@@'') 
	

	'+@sWhere+' 
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
