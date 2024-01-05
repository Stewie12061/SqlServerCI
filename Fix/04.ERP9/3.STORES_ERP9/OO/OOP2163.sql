IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2163]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2163]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load màn hình chọn vấn đề
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Tấn Lộc Date 21/12/2019
-- Modify by: Tấn Lộc Date 19/01/2021 - Bổ sung lọc dữ liệu cho màn hình chọn vấn đề, những vấn đề đã được gán cho 1 milestone và được lưu tại bảng OOT0098 sẽ không được load lên.
-- Modify by: Tấn Lộc Date 21/07/2021 - Bổ sung trường hợp mở màn hình Chọn vấn đề từ màn hình chi tiết Release thì lấy thêm điều kiện vấn đề là những vấn đề có trạng thái hoàn thành
-- <Example>
/*
	EXEC OOP2163 @DivisionID=N'KY',@TxtSearch=N'',@UserID=N'DANH',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2163] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @IsOpportunity TINYINT = 0,
	 @UserID VARCHAR(50),
	 @ProjectID NVARCHAR(250),
	 @issuesID NVARCHAR(MAX),
	 @TableID NVARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR (MAX),
	 @sWhere NVARCHAR(MAX),
	 @OrderBy NVARCHAR(500),
	 @TotalRow NVARCHAR(50)

SET @sWhere = '1 = 1'
SET @OrderBy = 'M.CreateDate DESC'

IF ISNULL(@ProjectID, '') != ''
	SET @sWhere = @sWhere + ' AND M.ProjectID LIKE N''%'+@ProjectID+'%''  '

IF ISNULL(@issuesID, '') != ''
	SET @sWhere = @sWhere + ' AND M.IssuesID NOT IN (' + @issuesID +')'

-- Trường hợp mở màn hình Chọn vấn đề từ màn hình chi tiết Release thì lấy thêm điều kiện là những vấn đề có trạng thái hoàn thành
IF ISNULL(@TableID, '') != '' AND @TableID = 'OOT2210'
	SET @sWhere = @sWhere + 'AND M.StatusID = ''TTIS0004'' '

IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.IssuesID LIKE N''%' + @TxtSearch + '%'' 
				OR M.IssuesName LIKE N''%' + @TxtSearch + '%'' 
				OR O1.Description LIKE N''%' + @TxtSearch + '%''  
				OR O2.StatusName LIKE N''%' + @TxtSearch + '%''
				OR O3.ProjectName LIKE N''%' + @TxtSearch + '%''
				OR M.TimeRequest LIKE N''%' + @TxtSearch + '%'' 
				OR M.DeadlineRequest LIKE N''%' + @TxtSearch + '%''
				OR A1.FullName LIKE N''%' + @TxtSearch + '%'')'

IF @IsOpportunity = 1
	SET @sWhere = @sWhere + ' AND ISNULL(M.OpportunityID, '''') != '''''

SET @sSQL = '
		SELECT M.APK, M.DivisionID
			, M.IssuesID
			, M.IssuesName
			, M.StatusID
			, O2.StatusName AS StatusName
			, O1.Description AS TypeOfIssues
			, M.TimeRequest
			, M.DeadlineRequest
			, M.ProjectID
			, O3.ProjectName AS ProjectName
			, M.CreateDate
			, M.CreateUserID
			, A1.FullName AS CreateUserID2
		INTO #TemOOT2160
		FROM OOT2160 M WITH (NOLOCK)
			LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = M.TypeOfIssues AND O1.CodeMaster = ''OOF2160.TypeOfIssues''
			LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON M.StatusID = O2.StatusID
			LEFT JOIN OOT2100 O3 WITH (NOLOCK) ON O3.ProjectID = M.ProjectID
			LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = M.CreateUserID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '

			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2160 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID
			, M.IssuesID
			, M.IssuesName
			, M.StatusID
			, M.StatusName
			, M.TypeOfIssues
			, M.TimeRequest
			, M.DeadlineRequest
			, M.ProjectName
			, M.CreateDate
			, M.CreateUserID
			, M.CreateUserID2
		FROM #TemOOT2160 M
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
EXEC (@sSQL)
PRINT(@sSQL)







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
