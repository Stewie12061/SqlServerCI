IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1000]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SHMP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
	--Load danh mục nhóm cổ đông
-- <History>
---- Create on 07/08/2018 by Xuân Minh
---- Edited on 17/10/2018 by Hoàng vũ
---- Edited on 12/06/2019 by Hoàng vũ: Fixbug không search ghi chú
/*<Example>
	--Lọc nâng cao
    EXEC SHMP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere=N' where IsNull(ShareHolderCategoryID,'''') = N''asdas'''

	--Lọc thường
    EXEC SHMP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere = NULL
*/
CREATE PROCEDURE SHMP1000
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @ShareHolderCategoryID VARCHAR(50),
	 @ShareHolderCategaoryName NVARCHAR(250),
	 @Notes NVARCHAR(250),
	 @Disabled NVARCHAR(250),
	 @IsCommon NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @SearchWhere NVARCHAR(MAX) = NULL --Lọc nâng cao
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
	
	SET @OrderBy = ' ShareHolderCategoryID'
	SET @sWhere = ' 1 = 1 '
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	

	If Isnull(@SearchWhere, '') = '' --Lọc thường
	Begin
			IF ISNULL(@DivisionList, '') != ''
				SET @sWhere = @sWhere + ' AND SHMT1000.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
			ELSE
				SET @sWhere = @sWhere + ' AND SHMT1000.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

			IF ISNULL(@ShareHolderCategoryID,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1000.ShareHolderCategoryID LIKE N''%'+@ShareHolderCategoryID+'%'' '	
	
			IF ISNULL(@ShareHolderCategaoryName,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1000.ShareHolderCategoryName LIKE N''%'+@ShareHolderCategaoryName+'%'' '

			IF ISNULL(@Notes,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1000.Notes LIKE N''%'+@Notes+'%'' '
	
			IF ISNULL(@Disabled, '') != '' 
				SET @sWhere = @sWhere + N' AND SHMT1000.Disabled = '+@Disabled+''
	
			IF ISNULL(@IsCommon, '') != '' 
				SET @sWhere = @sWhere + N' AND SHMT1000.IsCommon = '+@IsCommon+''
			--nếu giá trị NULL thì set về rổng 
			SET @SearchWhere = Isnull(@SearchWhere, '')
	End

	SET @sSQL = N'
				SELECT SHMT1000.APK,SHMT1000.DivisionID, SHMT1000.ShareHolderCategoryID, SHMT1000.ShareHolderCategoryName,SHMT1000.Notes
						, SHMT1000.IsCommon, SHMT1000.Disabled
						, SHMT1000.CreateDate, SHMT1000.CreateUserID, SHMT1000.LastModifyDate, SHMT1000.LastModifyUserID
				into #SHMT1000
				FROM SHMT1000 WITH (NOLOCK)
				WHERE '+@sWhere +'
				
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						, APK, DivisionID, ShareHolderCategoryID, ShareHolderCategoryName, Notes
						, IsCommon, Disabled
						, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
				FROM #SHMT1000
				'+@SearchWhere +'
				ORDER BY '+@OrderBy+' 
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
				'
	EXEC (@sSQL)
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
