IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP1020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP1020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục mức độ ưu tiên (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - FN \ Danh mục \Danh mục định mức chi phí 
-- <History>
----Created by: Hồng Thảo  on 02/11/2018 
-- <Example>
---- 
/*-- <Example>
EXEC FNP1020 @DivisionID='BS' , @DivisionList='', @UserID='',@PageNumber ='1',@PageSize =25,@PriorityID ='',@PriorityName ='',@Disabled ='',
@IsCommon ='',@PlanTypeID ='',@SearchWhere=N' where IsNull(PriorityID,'''') = N''asdas'''


FNP1020 @DivisionID, @DivisionList, @UserID,@PageNumber,@PageSize,@PriorityID,@PriorityName,@Disabled,@IsCommon,@PlanTypeID,@SearchWhere
----*/

CREATE PROCEDURE FNP1020
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @PriorityID VARCHAR(50),
	 @PriorityName NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @PlanTypeID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'PriorityID'

SET @TotalRow = 'COUNT(*) OVER ()'
SET @sWhere = ' 1 = 1 '

    If Isnull(@SearchWhere, '') = '' --Lọc thường
	Begin
		IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
		ELSE
		SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

		IF ISNULL(@PriorityID,'') <> '' SET @sWhere = @sWhere + '
		AND T1.PriorityID LIKE N''%'+@PriorityID+'%'' '	
		IF ISNULL(@PriorityName,'') <> '' SET @sWhere = @sWhere + '
		AND T1.PriorityName LIKE N''%'+@PriorityName+'%'' '
		IF ISNULL(@PlanTypeID,'') <> '' SET @sWhere = @sWhere + '
		AND T1.PlanTypeID LIKE N''%'+@PlanTypeID+'%'' '
		IF ISNULL(@Disabled,'') <> '' SET @sWhere = @sWhere + N'
		AND T1.Disabled = '+@Disabled+''
		IF ISNULL(@IsCommon,'') <> '' SET @sWhere = @sWhere + N'
		AND T1.IsCommon = '+@IsCommon+''
		

		--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
	END

	

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK,T1.DivisionID,T1.PriorityID,T1.PriorityName,T1.PlanTypeID,T2.AnaName AS PlanTypeName,T1.Notes,T1.IsCommon,T1.Disabled,T1.CreateUserID,
T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate
INTO #FNP1000
FROM FNT1020 T1 WITH (NOLOCK)
LEFT JOIN AT1011 T2 ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T2.AnaID = T1.PlanTypeID AND T2.AnaTypeID = ''A06''
WHERE '+@sWhere +'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,*
						FROM #FNP1000 AS Temp
						'+@SearchWhere +'

ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)


  
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
