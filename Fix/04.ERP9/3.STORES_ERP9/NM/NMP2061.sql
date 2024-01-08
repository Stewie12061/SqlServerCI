IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load detail n/vu hồ sơ học sinh 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 25/08/2018
----Update by: Lương Mỹ, DAte: 07/09/2019
-- <Example>
---- 
/*-- <Example>

	exec NMP2061 @DivisionID=N'BE',@DivisionList=N'',@APK=N'816e04f3-0d86-460a-a8e9-a661a0981d54',@PageNumber=1,@PageSize=25,@UserID=N'ASOFTSUPPORT',@Mode=1	

----*/

CREATE PROCEDURE NMP2061
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @APK VARCHAR(50),
	 @Mode INT --- 0: Lưới khi Xem chi tiết || 1: Lưới khi Chỉnh sửa
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'',
		@TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'N61.StudentID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND N61.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + 'AND N61.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

			SET @sSQL = @sSQL + N'
					SELECT DISTINCT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
					N61.APK, N61.APKMaster, N61.DivisionID, N61.StudentID, N20.StudentName, N61.Height, N61.Weight, N61.ActualQuantity,
					N61.Content, N61.Notes, N61.DeleteFlg, N61.SchoolYearID, N61.GradeID, E1.GradeName, N61.ClassID, E2.ClassName
				FROM NMT2061 N61 WITH (NOLOCK) 
				LEFT JOIN EDMT2010 N20 WITH (NOLOCK) ON N61.DivisionID=N20.DivisionID AND N61.StudentID=N20.StudentID AND N20.DeleteFlg = N61.DeleteFlg 
				LEFT JOIN EDMT1000 E1 WITH (NOLOCK) ON E1.DivisionID IN ( N61.DivisionID,''@@@'')  AND E1.GradeID = N61.GradeID
				LEFT JOIN EDMT1020 E2 WITH (NOLOCK) ON E2.DivisionID IN ( N61.DivisionID,''@@@'') AND E2.ClassID = N61.ClassID

					WHERE N61.APKMaster='''+@APK+''' AND N61.DeleteFlg  = 0 '+@sWhere +'
					ORDER BY '+@OrderBy+'' 
IF @Mode = 0
BEGIN

	SET	@sSQL = @sSQL + N'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END	
EXEC (@sSQL)
--PRINT(@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
