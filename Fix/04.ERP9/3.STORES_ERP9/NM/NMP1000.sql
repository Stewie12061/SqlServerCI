IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục nhóm thực phẩm (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 20/08/2018
-- <Example>
---- 
/*-- <Example>
--Lọc thường
	NMP1000 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @MaterialsTypeID = '', 
	@MaterialsTypeName = '', @IsCommon = 0, @Disabled = 0, @SearchWhere=NULL
--Lọc nâng cao
NMP1000 @DivisionID = 'BS', @DivisionList = 'BS', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @MaterialsTypeID = '', 
	@MaterialsTypeName = '', @IsCommon = 0, @Disabled = 0, @SearchWhere=N' where IsNull(MaterialsTypeID,'''') = N''asdas'''
----*/

CREATE PROCEDURE NMP1000
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @MaterialsTypeID VARCHAR(50),
	 @MaterialsTypeName NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sWhere = ' 1 = 1 '
	SET @OrderBy = 'MaterialsTypeID'
If Isnull(@SearchWhere, '') = '' --Lọc thường
		Begin
		IF ISNULL(@DivisionList, '') != ''
			SET @sWhere = @sWhere + 'AND NMT1000.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
		ELSE 
			SET @sWhere = @sWhere + 'AND NMT1000.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

		IF ISNULL(@MaterialsTypeID,'') != '' SET @sWhere = @sWhere + '
			AND NMT1000.MaterialsTypeID LIKE N''%'+@MaterialsTypeID+'%'' '	
		IF ISNULL(@MaterialsTypeName,'') != '' SET @sWhere = @sWhere + '
			AND NMT1000.MaterialsTypeName LIKE N''%'+@MaterialsTypeName+'%'' '
		IF @Disabled IS NOT NULL SET @sWhere = @sWhere + N'
			AND NMT1000.Disabled = '+@Disabled+''
		IF @IsCommon IS NOT NULL SET @sWhere = @sWhere + N'
			AND NMT1000.IsCommon = '+@IsCommon+''
	--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
End	
SET @sSQL = @sSQL + N'
	    SELECT 	NMT1000.APK, DivisionID, MaterialsTypeID, MaterialsTypeName, Description, IsCommon, [Disabled], CreateUserID,
		 CreateDate, LastModifyUserID, LastModifyDate
		 INTO #NMP1000
		 FROM NMT1000 WITH (NOLOCK)
		 WHERE '+@sWhere +'

		Select  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow	
				,APK, DivisionID, MaterialsTypeID, MaterialsTypeName, Description, IsCommon, [Disabled], CreateUserID,
				CreateDate, LastModifyUserID, LastModifyDate
			FROM #NMP1000 AS N
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
