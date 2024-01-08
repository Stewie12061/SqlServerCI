IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[QCP1000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[QCP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
-- Load danh mục tiêu chuẩn
-- <History>
---- Create on 06/10/2020	by Thanh Thi
---- Modified on 03/07/2023 by Văn Tài - Bổ sung điều kiện lọc thiếu trước đó: Công đoạn, Tên hiển thị, Thông số kỹ thuật.
/*<Example>
	--Lọc nâng cao
    EXEC QCP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere=N' where IsNull(ShareHolderCategoryID,'''') = N''asdas'''

	--Lọc thường
    EXEC QCP1000 @DivisionID = 'BS', @DivisionList = '', @UserID = 'ASOFTADMIN',@Notes='', @PageNumber = 1, @PageSize = 25, @ShareHolderCategoryID = 'a', 
	@ShareHolderCategaoryName = 'd', @IsCommon = '0', @Disabled = '0', @SearchWhere = NULL

	@DivisionID=@@DivisionID,@DivisionList=@@DivisionList,@UserID=@@UserID,@StandardID=@StandardID,@StandardName=@StandardName,@Description=@Description,@Disabled=@Disabled,@IsCommon=@IsCommon,@PageNumber=@requestPage,@PageSize=@requestPageSize
*/
CREATE PROCEDURE [dbo].[QCP1000]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @StandardID VARCHAR(50),
	 @StandardName NVARCHAR(250),
	 @StandardNameE NVARCHAR(250) = NULL,
	 @UnitID VARCHAR(50) = NULL	,
	 @Description NVARCHAR(250),
	 @TypeID VARCHAR(50) = NULL,
	 @ParentID VARCHAR(50) = NULL,
	 @DataType VARCHAR(50) = NULL,
	 @Disabled NVARCHAR(250),
	 @IsCommon NVARCHAR(250),
	 @IsDefault VARCHAR(50) = NULL,
	 @IsVisible VARCHAR(50) = NULL,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @PhaseID VARCHAR(MAX) = NULL,
	 @DisplayName VARCHAR(MAX) = NULL,	-- Tên hiển thị.
	 @Specification VARCHAR(MAX) = NULL,	-- Thông số kỹ thuật.
	 @SearchWhere NVARCHAR(MAX) = NULL --Lọc nâng cao
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
	
	SET @OrderBy = ' StandardID'
	SET @sWhere = ' 1 = 1 '
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
	-- Lọc thường
	IF ISNULL(@SearchWhere, '') = '' 
	Begin
			IF ISNULL(@DivisionList, '') != ''
				SET @sWhere = @sWhere + ' AND QCT1000.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
			ELSE
				SET @sWhere = @sWhere + ' AND QCT1000.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

			IF ISNULL(@StandardID,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.StandardID LIKE N''%'+@StandardID+'%'' '	
	
			IF ISNULL(@StandardName,'') != '' 
				SET @sWhere = @sWhere + ' AND (QCT1000.StandardName LIKE N''%'+@StandardName+'%'' 
										  OR QCT1000.Specification LIKE N''%'+@StandardName+'%''
										  OR M1.Description LIKE N''%'+@StandardName+'%'') '

			IF ISNULL(@StandardNameE,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.StandardNameE LIKE N''%'+@StandardNameE+'%'' '

			IF ISNULL(@UnitID,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.UnitID LIKE N''%'+@UnitID+'%'' '

			IF ISNULL(@Disabled,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.Description LIKE N''%'+@Disabled+'%'' '

			IF ISNULL(@TypeID,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.TypeID LIKE N''%'+@TypeID+'%'' '

			IF ISNULL(@ParentID,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.ParentID LIKE N''%'+@ParentID+'%'' '

			IF ISNULL(@DataType,'') != '' 
				SET @sWhere = @sWhere + ' AND QCT1000.DataType = '''+@DataType+''' '

			IF ISNULL(@PhaseID,'') != '' 
					SET @sWhere = @sWhere + ' AND QCT1000.PhaseID IN ('''+@PhaseID+''') '

			IF ISNULL(@DisplayName,'') != '' 
					SET @sWhere = @sWhere + ' AND QCT1000.DisplayName IN ('''+@DisplayName+''') '

			IF ISNULL(@Specification,'') != '' 
					SET @sWhere = @sWhere + ' AND QCT1000.Specification IN ('''+@Specification+''') '
 
			IF ISNULL(@Disabled, '') != '' 
				SET @sWhere = @sWhere + N' AND QCT1000.Disabled = '+@Disabled+''
	
			IF ISNULL(@IsCommon, '') != '' 
				SET @sWhere = @sWhere + N' AND QCT1000.IsCommon = '+@IsCommon+''

			IF ISNULL(@IsDefault, '') != '' 
				SET @sWhere = @sWhere + N' AND QCT1000.IsDefault = '''+@IsDefault+''' '

			IF ISNULL(@IsVisible, '') != '' 
				SET @sWhere = @sWhere + N' AND QCT1000.IsVisible = '''+@IsVisible+''' '
			-- Nếu giá trị NULL thì set về rổng,
			SET @SearchWhere = Isnull(@SearchWhere, '')
	END

	SET @sSQL = N'
			SELECT 
				QCT1000.APK
				, QCT1000.DivisionID
				, QCT1000.StandardID
				, QCT1000.StandardName
				, QCT1000.StandardNameE
				, QCT1000.UnitID
				, QCT1000.Description
				, QCT1000.TypeID
				, QCT0099.Description AS TypeName
				, STUFF((SELECT '','' + A1.StandardName
						FROM QCT1000 C1 WITH (NOLOCK)
						LEFT JOIN QCT1000 A1 WITH (NOLOCK) ON CONCAT('','',C1.ParentID,'','') LIKE CONCAT(''%,'',A1.StandardID,'',%'')
						WHERE C1.StandardID = QCT1000.StandardID
						FOR XML PATH('''')), 1, 1, ''''
					) AS ParentID
				, QCT1000.IsCommon
				, QCT1000.Disabled
				, QCT1000.IsDefault
				, QCT1000.IsVisible
				, R0.Description CalculateType
				, T4.Description As DataType
				, QCT1000.CreateDate
				, QCT1000.CreateUserID
				, QCT1000.LastModifyDate
				, QCT1000.LastModifyUserID
				, M1.Description AS Specification
				, A1.PhaseName AS PhaseID
				, QCT1000.Recipe
				, QCT1000.DeclareSO
				, M2.Description AS DisplayName
				INTO #QCT1000
				FROM QCT1000 QCT1000 WITH (NOLOCK)
				LEFT JOIN QCT0099 WITH (NOLOCK) ON QCT0099.ID = QCT1000.TypeID AND QCT0099.CodeMaster = ''Standard''
				LEFT JOIN QCT0099 R0 WITH (NOLOCK) ON R0.ID = QCT1000.CalculateType AND R0.CodeMaster = ''CalculateType''
				LEFT JOIN (SELECT * FROM QCT0099 WITH(NOLOCK) WHERE CodeMaster = ''DataType'') T4 ON QCT1000.DataType = T4.ID
				--LEFT JOIN QCT1000 R01 WITH (NOLOCK) ON CONCAT('','',QCT1000.ParentID,'','') LIKE CONCAT(''%,'',R01.StandardID,'',%'') 
				LEFT JOIN AT0126 A1 WITH (NOLOCK) ON A1.PhaseID = QCT1000.PhaseID AND ISNULL(A1.Disabled, 0) = 0
				LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.CodeMaster = ''Specification'' AND ISNULL(M1.Disabled, 0) = 0 AND M1.ID = QCT1000.Specification 
				LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.CodeMaster = ''DisplayName'' AND ISNULL(M2.Disabled, 0)= 0 AND M2.ID = QCT1000.DisplayName
				WHERE ' + @sWhere + '
				
				SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum
						, ' + @TotalRow + ' AS TotalRow
						, APK
						, DivisionID
						, StandardID
						, StandardName
						, StandardNameE
						, UnitID
						, Description
						, TypeID
						, TypeName
						, ParentID
						, IsCommon
						, Disabled
						, IsDefault
						, IsVisible
						, CalculateType
						, DataType
						, CreateDate
						, CreateUserID
						, LastModifyDate
						, LastModifyUserID
						, Specification
						, PhaseID
						, Recipe
						, DisplayName
				FROM #QCT1000
				'+@SearchWhere +'
				ORDER BY '+@OrderBy+' 
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
				'
	EXEC (@sSQL)
	PRINT (@sSQL)
GO


