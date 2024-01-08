IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Grid Form HRF2100: Danh mục lịch đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 21/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 19/07/2023 by Anh Đô: Cập nhật điều kiện lọc; Select thêm cột AssignedToUserName
----Modified on 23/08/2023 by Thu Hà: Bổ sung điều kiện lọc theo mã lịch đào tạo, mã khóa đào tạo, tên lĩnh vực đào tạo, đối tác đào tạo
----Modified on 06/09/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo mã lịch đào tạo
--- Modified on 13/10/2023 by Minh Trí: Cập nhật thêm điều kiện cho cột ScheduleAmount nếu null thì thay bằng 0
-- <Example>
---- 
/*-- <Example>
	HRMP2100 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@SearchTxt=NULL,@TrainingFieldID=NULL,@TrainingType=NULL,@StatusID='0',@FromDate='2016-01-01',@ToDate='2018-01-01'
----*/

CREATE PROCEDURE [dbo].[HRMP2100]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	-- @SearchTxt NVARCHAR(500),
	 @TrainingFieldID NVARCHAR(50),
	 @TrainingType NVARCHAR(50),
	 @TrainingScheduleID NVARCHAR(50),
	 @TrainingCourseID NVARCHAR(50),
	 @TrainingFieldName NVARCHAR(50),
	 @ObjectName NVARCHAR(50),
	 @StatusID NVARCHAR(1),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ConditionTrainingScheduleID VARCHAR(MAX),
	 @IsPeriod TINYINT,
	 @PeriodList VARCHAR(MAX),
	 @AssignedToUserName NVARCHAR(250)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'TrainingScheduleID DESC,CreateDate',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	
       
    
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = '
	DivisionID = '''+@DivisionID+''''

IF  @IsSearch = 1
BEGIN
	--IF ISNULL(@SearchTxt,'') <> ''
	--BEGIN
	--	SET @sWhere = @sWhere + '
	--	AND (TrainingScheduleID LIKE N''%' + @SearchTxt + '%'' OR TrainingCourseID LIKE N''%' + @SearchTxt + '%'')'	
	--END
	 
	IF ISNULL(@TrainingFieldID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND TrainingFieldID IN (''' + @TrainingFieldID + ''') '
	END
	
	IF ISNULL(@TrainingType,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND TrainingType IN (''' + @TrainingType + ''') '
	END	


	IF ISNULL(@TrainingScheduleID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND TrainingScheduleID LIKE N''%' + @TrainingScheduleID + ''''
	END

	IF ISNULL(@TrainingCourseID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND TrainingCourseID LIKE N''%' + @TrainingCourseID + ''''
	END

	IF ISNULL(@TrainingFieldName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND TrainingFieldName LIKE N''%' + @TrainingFieldName + ''''
	END

	IF ISNULL(@ObjectName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND ObjectName LIKE N''%' + @ObjectName + ''''
	END
		
	IF ISNULL(@StatusID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND StatusID = N''' + @StatusID + ''''
	END		
	
	IF @IsPeriod = 1
	BEGIN
		SET @sWhere = @sWhere + 'AND FORMAT(CreateDate, ''MM/yyyy'') IN ('''+@PeriodList +''') '
	END
	ELSE
	BEGIN
		IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, CreateDate, 112) >= '''+ CONVERT(VARCHAR, @FromDate, 112) +''' '
		ELSE IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, CreateDate, 112) <= '''+ CONVERT(VARCHAR, @ToDate, 112) +''' '
		ELSE IF ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != ''
			SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR, CreateDate, 112) BETWEEN 
			'''+ CONVERT(VARCHAR, @FromDate, 112) +''' AND '''+ CONVERT(VARCHAR, @ToDate, 112) +''' '
	END

	IF ISNULL(@AssignedToUserName, '') != ''
		SET @sWhere = @sWhere + ' AND A.AssignedToUserName LIKE N''%'+ @AssignedToUserName +'%'' '
END

IF Isnull(@ConditionTrainingScheduleID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A.CreateUserID,'''') in (N'''+@ConditionTrainingScheduleID+''' )'


SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
FROM
(
	SELECT HRMT2100.APK, HRMT2100.DivisionID, HRMT2100.TrainingScheduleID, HRMT2100.TrainingCourseID, HRMT2100.TrainingFieldID, HRMT1040.TrainingFieldName, FORMAT(HRMT2100.SpecificHours, ''HH:mm:ss'') AS SpecificHours,
	HRMT1050.TrainingType,HRMT1050.ObjectID, HT0099.Description AS TrainingTypeName, COALESCE(HRMT2100.ScheduleAmount, 0) AS ScheduleAmount, HRMT2100.FromDate, HRMT2100.ToDate, HRMT2100.AssignedToUserID,	
	0 AS StatusID, N''Chưa kết thúc'' AS StatusName,
	HRMT2100.CreateUserID, HRMT2100.CreateDate, HRMT2100.LastModifyUserID, HRMT2100.LastModifyDate
	, A1.FullName AS AssignedToUserName
	, IIF(ISNULL(AT1202.ObjectName, '''') != '''', AT1202.ObjectName, A2.FullName) AS ObjectName
	FROM HRMT2100 WITH (NOLOCK)
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
	LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
	LEFT JOIN AT1103 A1 WITH (NOLOCK) ON A1.EmployeeID = HRMT2100.AssignedToUserID AND A1.DivisionID IN (HRMT2100.DivisionID, ''@@@'')
	LEFT JOIN AT1103 A2 WITH (NOLOCK) ON A2.EmployeeID = HRMT1050.ObjectID AND A1.DivisionID IN (HRMT2100.DivisionID, ''@@@'')
) A 
WHERE '+@sWhere +'	
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

PRINT(@sSQL)
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
