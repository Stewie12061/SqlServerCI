IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2293]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2293]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
--- Load màn hình chọn Chỉ tiêu/công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Thu Hà Date 27/10/2023
-- Modify by: Thu Hà  Date 31/10/2023 - Bổ sung lọc dữ liệu cho màn hình chọn chỉ tiêu/công việc, những vấn đề đã được gán cho 1 milestone và được lưu tại bảng OOT0088 sẽ không được load lên.
-- <Example>
/*
	EXEC OOP2293 @DivisionID=N'BBA-SI',@TxtSearch=N'',@UserID=N'ADMIN',@RequestUserID=N'',@targetTaskID=N'',@TableID=N'OOT2290',@PageNumber=N'1',@PageSize=N'10'
*/

 CREATE PROCEDURE [dbo].[OOP2293] (
	 @DivisionID NVARCHAR(2000),
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @RequestUserID NVARCHAR(250),
	 @targetTaskID NVARCHAR(MAX),
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

IF ISNULL(@RequestUserID, '') != ''
	SET @sWhere = @sWhere + ' AND M.RequestUserID LIKE N''%'+@RequestUserID+'%''  '

IF ISNULL(@targetTaskID, '') != ''
	SET @sWhere = @sWhere + ' AND M.TargetTaskID NOT IN (' + @targetTaskID +')'

IF ISNULL(@TxtSearch,'') != ''

	SET @sWhere = @sWhere + '
				 AND (M.TargetTaskID LIKE N''%' + @TxtSearch + '%'' 
				OR M.TargetTaskName LIKE N''%' + @TxtSearch + '%'' 
				OR O1.Description LIKE N''%' + @TxtSearch + '%''  
				OR O2.StatusName LIKE N''%' + @TxtSearch + '%''
				OR A3.FullName LIKE N''%' + @TxtSearch + '%''
				OR M.BeginDate LIKE N''%' + @TxtSearch + '%'' 
				OR M.EndDate LIKE N''%' + @TxtSearch + '%''
				OR A2.FullName LIKE N''%' + @TxtSearch + '%'')'


SET @sSQL = '
		SELECT M.APK, M.DivisionID
			, M.TargetTaskID
			, M.TargetTaskName
			, M.StatusID
			, O2.StatusName 
			, M.TypeID
			, O1.Description AS TypeName
			, M.PriorityID
			, C1.Description AS PriorityName
			, M.BeginDate
			, M.EndDate
			, M.RequestUserID
			, A3.FullName AS RequestUserName
			, M.AssignedUserID
			, A2.FullName AS AssignedUserName
			, M.Description
			, M.CreateDate
			, M.CreateUserID
			, O2.Color

		INTO #TemOOT2290
		FROM OOT2290 M WITH (NOLOCK)
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = M.AssignedUserID AND A2.DivisionID IN (M.DivisionID, ''@@@'')
			LEFT JOIN AT1103 A3 WITH (NOLOCK) ON A3.EmployeeID = M.RequestUserID AND A3.DivisionID IN (M.DivisionID, ''@@@'')
			LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON C1.CodeMaster = ''CRMT00000006'' AND C1.ID = M.PriorityID
			LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.CodeMaster = ''OOF2290.Type'' AND O1.ID = M.TypeID
			LEFT JOIN OOT1040 O2 WITH (NOLOCK) ON O2.StatusID = M.StatusID
		WHERE M.DivisionID = ''' + @DivisionID + ''' AND ISNULL(M.DeleteFlg, 0) = 0 AND ' + @sWhere + '
		
			
		DECLARE @count INT
		SELECT @count = COUNT(*) FROM #TemOOT2290 
		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID
			, M.TargetTaskID
			, M.TargetTaskName
			, M.StatusID
			, M.TypeID
			, M.StatusName
			, M.TypeName
			, M.PriorityID
			, M.PriorityName
			,M.RequestUserName
			, M.BeginDate
			, M.EndDate
			, M.RequestUserID
			, M.AssignedUserID
			,M.AssignedUserName
			, M.CreateDate
			, M.CreateUserID
			, M.Description
			, M.Color
			
		FROM #TemOOT2290 M
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
