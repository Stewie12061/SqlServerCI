IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load Grid danh sách thực đơn ngày
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trà Giang
---- Create date: 07/09/2018
---- Modify on 16/01/2019 by Tra Giang: Bỏ lọc điều kiện trường 
---- Modify on 04/09/2019 by Lương MỸ: Chỉnh sửa store load, thay đổi màn hình
/*
----Lọc thường

----Lọc nâng cao

*/
 CREATE PROCEDURE NMP2010
(
 	 @DivisionID VARCHAR(50),
     @DivisionIDList NVARCHAR(2000),
     @PageNumber INT,
     @PageSize INT,
     @MenuDate DATETIME,
	 @GradeID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS
DECLARE @sSQL01 NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = N''

		IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
      	SET @sWhere = ' 1 = 1 '
	   	SET @OrderBy = ' CreateDate Desc'
If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != '' 
		SET @sWhere = @sWhere + 'AND N1.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + 'AND N1.DivisionID IN ('''+@DivisionID+''')'

	IF Isnull(@GradeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(N1.GradeID,'''') LIKE N''%'+@GradeID+'%'' '


	IF ISNULL(@MenuDate, '') !=  '' 
			SET @sWhere = @sWhere + '
				AND '''+CONVERT(VARCHAR(10),@MenuDate,126)+''' BETWEEN  CONVERT(VARCHAR(10), CONVERT(DATE, N1.FromDate,120), 126) AND  CONVERT(VARCHAR(10), CONVERT(DATE, N1.ToDate,120), 126)'
	-- Nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End
	-- Lấy Distinct thưc đơn ngày
		SET @sSQL01 = '
		Select	N1.APK, N1.DivisionID, N1.GradeID, E1.GradeName, N1.FromDate, N1.ToDate, 
		N1.CreateUserID, N1.CreateDate, N1.LastModifyUserID, N1.LastModifyDate
			INTO #NMP2010
			FROM NMT2010 N1 WITH (NOLOCK)
			LEFT JOIN EDMT1000 E1 WITH (NOLOCK) ON E1.DivisionID IN (N1.DivisionID, ''@@@'') AND N1.GradeID = E1.GradeID
			WHERE ' +@sWhere + ' AND N1.DeleteFlg = 0 


		Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
		,* FROM #NMP2010 AS Temp
			'+@SearchWhere +'
			ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
			'


EXEC (@sSQL01)
--print (@sSQL01)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
