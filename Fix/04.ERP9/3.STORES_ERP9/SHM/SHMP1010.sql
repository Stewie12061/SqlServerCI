IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1010]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SHMP1010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
	--Load danh mục loại cổ phần
-- <History>
----Create on 11/09/2018 by Xuân Minh
----Edited by Hoàng vũ, on 17/10/2018
-- <Example> 
/*
--Lọc nâng cao
EXEC SHMP1010 'BS', 'BS', '', 1, 25, 'q', 'q', 'q', 'q', 'q', '2', '5', '1', N' where IsNull(ShareTypeID,'''') = N''asdas'''

--Lọc thường
EXEC SHMP1010 'BS', 'BS', '', 1, 25, 'q', 'q', 'q', 'q', 'q', '2', '5', '1', ''
*/
CREATE PROCEDURE SHMP1010
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ShareTypeID VARCHAR(50),
	 @ShareTypeName NVARCHAR(250),
     @PreferentialDescription NVARCHAR(250),
     @TransferCondition NVARCHAR(250),
	 @SharedKind VARCHAR(50),
	 @LimitTransferYear INT ,
	 @Disabled VARCHAR(50),
	 @IsCommon VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --Lọc nâng cao
) 
AS
	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500) = N'',
			@TotalRow NVARCHAR(50) = N''
	SET @OrderBy = ' ShareTypeID'
	SET @sWhere = ' 1 = 1 '
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	If Isnull(@SearchWhere, '') = '' --Lọc thường
	Begin
			IF ISNULL(@DivisionList, '') != ''
				SET @sWhere = @sWhere + ' AND SHMT1010.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
			ELSE
				SET @sWhere = @sWhere + ' AND SHMT1010.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 
	
			IF ISNULL(@ShareTypeID,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1010.ShareTypeID LIKE N''%'+@ShareTypeID+'%'' '	
	
			IF ISNULL(@ShareTypeName,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1010.ShareTypeName LIKE N''%'+@ShareTypeName+'%'' '
	
			IF ISNULL(@PreferentialDescription,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1010.PreferentialDescription LIKE N''%'+@PreferentialDescription+'%'' '
	
			IF ISNULL(@TransferCondition,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1010.TransferCondition LIKE N''%'+@TransferCondition+'%'' '
	
			IF ISNULL(@SharedKind,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1010.SharedKind LIKE N''%'+Cast(@SharedKind as nvarchar(50))+'%'' '
	
			IF ISNULL(@LimitTransferYear,'') != '' 
				SET @sWhere = @sWhere + ' AND SHMT1010.LimitTransferYear LIKE N''%'+Cast(@LimitTransferYear as nvarchar(250))+'%'' '
	
			IF ISNULL(@Disabled, '') != '' 
				SET @sWhere = @sWhere + N' AND SHMT1010.Disabled = '+@Disabled+''
	
			IF ISNULL(@IsCommon, '') != '' 
				SET @sWhere = @sWhere + N' AND SHMT1010.IsCommon = '+@IsCommon+''
			--nếu giá trị NULL thì set về rổng 
			SET @SearchWhere = Isnull(@SearchWhere, '')
	End
	SET @sSQL = N'
			SELECT SHMT1010.APK,SHMT1010.DivisionID, SHMT1010.ShareTypeID, SHMT1010.ShareTypeName,SHMT1010.PreferentialDescription,
					SHMT1010.TransferCondition,SHMT1010.LimitTransferYear,SHMT1010.SharedKind, A91.Description as SharedKindName, SHMT1010.IsCommon, SHMT1010.Disabled
			into #SHMT1010
			FROM SHMT1010 WITH (NOLOCK) Left join AT0099 A91 WITH (NOLOCK) on SHMT1010.SharedKind = A91.ID and A91.CodeMaster = ''AT00000053''
			WHERE '+@sWhere +'
						
			
			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
				, APK, DivisionID, ShareTypeID, ShareTypeName, PreferentialDescription
				, TransferCondition, LimitTransferYear, SharedKind, SharedKindName, IsCommon, Disabled
			FROM #SHMT1010
			'+@SearchWhere +'
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
