IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2115]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2115]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load màn hình chọn công việc
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Hoàng vũ
----Editted by: Kiều Nga , Date: 26/03/2020: Bổ xung điều kiện lọc khi gọi từ màn hình có nghiệp vụ xét duyệt
----Editted by: Bảo Toàn , Date: 18/04/2020: Bổ sung điều kiện lọc theo người theo dõi
----Editted by: Bảo Toàn , Date: 26/04/2020: Bổ sung điều kiện lọc theo người theo dõi bỏ quan người hỗ trợ và người giám sát.
----Editted by: Văn Tài	 , Date: 08/06/2021: Bổ sung điều kiện loc theo bảng theo dõi mới do thay đổi Core: Module + 'T9020'
----Editted by: Hoài Bảo , Date: 16/07/2021: Load thêm cột APK công việc.
----Editted by: Nhật Quang , Date: 04/08/2022: Bổ sung thêm số lượng người theo dõi từ 20 lên 50.
----<Example> exec OOP2115 @DivisionID=N'KY', @TxtSearch=N'',@UserID=N'',@PageNumber=N'1',@PageSize=N'10'

 CREATE PROCEDURE [dbo].[OOP2115] (
     @DivisionID NVARCHAR(2000),		--Biến môi trường
	 @TxtSearch NVARCHAR(250),
	 @UserID VARCHAR(50),				--Biến môi trường
	 @ProjectID NVARCHAR(250),
	 @TaskID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,
	 @IsApproval INT = 0 -- 1: Gọi từ màn hình có nghiệp vụ xét duyệt
)
AS
BEGIN
	DECLARE @sSQL VARCHAR (MAX),
			@sSQL01 VARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@sJoin NVARCHAR(MAX) = ''

	DECLARE @CustomerName INT

	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#CustomerName'))
	DROP TABLE #CustomerName
	CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
	INSERT #CustomerName EXEC AP4444
	SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

	SET @sWhere = ''
	SET @OrderBy = '  M.PlanStartDate DESC'

	IF ISNULL(@ProjectID, '') != ''
			SET @sWhere = @sWhere + ' AND M.ProjectID LIKE N''%'+@ProjectID+'%''  '

	IF ISNULL(@TaskID, '') != ''
			SET @sWhere = @sWhere + ' AND M.TaskID NOT LIKE N''%'+@TaskID+'%''  '

	IF ISNULL(@IsApproval, 0) != 0
	BEGIN
		SET @sWhere = @sWhere + ' AND (M.StatusID = ''TTCV0001'' OR M.StatusID = ''TTCV0008'') '
		SET @sWhere = @sWhere + ' AND M.TaskID NOT IN (SELECT TaskID FROM CRMT20501 WITH(NOLOCK) WHERE TaskID IS NOT NULL AND DivisionID =''' + @DivisionID + ''')
		AND M.TaskID NOT IN (SELECT TaskID FROM OT3101 WITH(NOLOCK) WHERE TaskID IS NOT NULL AND DivisionID = ''' + @DivisionID + ''' AND ISNULL(DeleteFlag, 0) = 0)
		AND M.TaskID NOT IN (SELECT TaskID FROM OT2001 WITH(NOLOCK) WHERE TaskID IS NOT NULL AND DivisionID = ''' + @DivisionID + ''' )
		AND M.TaskID NOT IN (SELECT TaskID FROM OT2101 WITH(NOLOCK) WHERE TaskID IS NOT NULL AND DivisionID = ''' + @DivisionID + ''' AND ISNULL(DeleteFlg, 0) = 0 ) '

		SET @sJoin = @sJoin +' LEFT JOIN CMNT0020 CMNT20 WITH (NOLOCK) ON M.APK = CMNT20.APKMaster 
																			AND CMNT20.TableID = ''OOT2110'' 
																			AND CMNT20.FollowerID = '''+@UserID+''' 
																			AND CMNT20.FollowerID <> ISNULL(M.SupportUserID,'''') 
																			AND CMNT20.FollowerID <> ISNULL(M.ReviewerUserID,'''') 
							   LEFT JOIN OOT9020 OT90 WITH (NOLOCK) ON OT90.TableID = ''OOT2110''
																				AND M.APK = OT90.APKMaster 
																				AND ''' + @UserID + ''' IN (OT90.FollowerID01, OT90.FollowerID02, OT90.FollowerID03, OT90.FollowerID04, OT90.FollowerID05
																											 , OT90.FollowerID06, OT90.FollowerID07, OT90.FollowerID08, OT90.FollowerID09, OT90.FollowerID10
																											 , OT90.FollowerID11, OT90.FollowerID12, OT90.FollowerID13, OT90.FollowerID14, OT90.FollowerID15
																											 , OT90.FollowerID16, OT90.FollowerID17, OT90.FollowerID18, OT90.FollowerID19, OT90.FollowerID20, OT90.FollowerID21, OT90.FollowerID22, OT90.FollowerID23, OT90.FollowerID24, OT90.FollowerID25, OT90.FollowerID26, OT90.FollowerID27, OT90.FollowerID28, OT90.FollowerID29, OT90.FollowerID30, OT90.FollowerID31, OT90.FollowerID32, OT90.FollowerID33, OT90.FollowerID34, OT90.FollowerID35, OT90.FollowerID36, OT90.FollowerID37, OT90.FollowerID38, OT90.FollowerID39, OT90.FollowerID40, OT90.FollowerID41, OT90.FollowerID42, OT90.FollowerID43, OT90.FollowerID44, OT90.FollowerID45, OT90.FollowerID46, OT90.FollowerID47, OT90.FollowerID48, OT90.FollowerID49, OT90.FollowerID50)
																				AND ''' + @UserID + ''' NOT IN (ISNULL(M.SupportUserID, ''''), ISNULL(M.ReviewerUserID, ''''))'
		SET @sWhere = @sWhere + '
		AND (CMNT20.APKMaster IS NOT NULL OR OT90.APKMaster IS NOT NULL) '
	END

	IF @TxtSearch IS NOT NULL SET @sWhere = @sWhere +'
		AND (M.ProjectID + '' '' + TM21.ProjectSampleID LIKE N''%'+@TxtSearch+'%'' 
				OR M.ProcessID + '' '' +  TM11.ProcessName LIKE N''%'+@TxtSearch+'%'' 
				OR M.StepID + '' '' +  TM12.StepName LIKE N''%'+@TxtSearch+'%'' 
				OR M.TaskID LIKE N''%'+@TxtSearch+'%'' 
				OR M.TaskName LIKE N''%'+ @TxtSearch+'%''
				OR M.PlanStartDate LIKE N''%'+ @TxtSearch+'%''
				OR M.PlanEndDate LIKE N''%'+ @TxtSearch+'%''
				OR M.AssignedToUserID + '' '' + A1.EmployeeID LIKE N''%'+@TxtSearch + '%'' 
				OR M.StatusID + '' '' +  TM13.StatusName LIKE N''%'+@TxtSearch+'%'' 
				)'

	SET @sSQL = '
	Select  M.APK, M.DivisionID, M.TaskID, M.TaskName
			, M.AssignedToUserID, A1.FullName as AssignedToUserName
			, M.ProjectID, TM21.ProjectSampleID
			, TM21.ProjectSampleName as ProjectName
			, IIF (M.ProjectID != '''' AND M.ProjectID IS NOT NULL, TM11.ProcessName, O4.ProcessName) AS ProcessName
			, IIF (M.ProjectID != '''' AND M.ProjectID IS NOT NULL AND M.ProcessID != '''' AND M.ProcessID IS NOT NULL, TM12.StepName, O5.StepName) AS StepName
			, M.ProcessID
			, M.StepID
			, ISNULL(M.StatusID, 0) as StatusID, TM13.StatusName as StatusName
			, M.PlanStartDate, M.PlanEndDate, M.PlanTime
			, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
			into #TempOOT2110
	FROM OOT2110 M WITH (NOLOCK)	LEFT JOIN OOT1050 TM21 WITH(NOLOCK) on M.ProjectID = TM21.ProjectSampleID
									LEFT JOIN OOT1051 TM11 WITH (NOLOCK) on M.ProcessID = TM11.ProcessID
									LEFT JOIN OOT1051 TM12 WITH (NOLOCK) on M.StepID = TM12.StepID
									LEFT JOIN OOT1020 O4 WITH (NOLOCK) on M.ProcessID = O4.ProcessID
									LEFT JOIN OOT1021 O5 WITH (NOLOCK) on M.StepID = O5.StepID
									LEFT JOIN AT1103 A1 WITH (NOLOCK) on M.AssignedToUserID = A1.EmployeeID
									LEFT JOIN OOT1040 TM13 WITH (NOLOCK) on M.StatusID = TM13.StatusID
									'
	SET @sSQL01 = @sJoin + '
	WHERE M.DivisionID = N''' + @DivisionID + ''' and ISNULL(M.DeleteFlg, 0) = 0  '  + @sWhere + '

	DECLARE @count int
	Select @count = Count(TaskID) FROM #TempOOT2110

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @count AS TotalRow
			, M.APK, M.DivisionID, M.TaskID, M.TaskName
			, M.AssignedToUserID, M.AssignedToUserName
			, M.ProjectID, M.ProjectName
			, M.ProcessID , M.ProcessName
			, M.StepID, M.StepName
			, M.StatusID, M.StatusName
			, M.PlanStartDate, M.PlanEndDate, M.PlanTime
			, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate
	FROM #TempOOT2110 M
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	--SET @sSQL = 'SELECT * FROM OOT1020'

	PRINT (@sSQL + @sSQL01)
	EXEC (@sSQL + @sSQL01)
	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
