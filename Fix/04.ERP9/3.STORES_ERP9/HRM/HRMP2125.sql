IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2125]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2125]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In dữ liệu ghi nhận kết quả
-- <Param>
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thu Hà, Date: 27/09/2023
-- <Example>
----

CREATE PROCEDURE [dbo].[HRMP2125]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @TrainingResultID VARCHAR(50),
	 @TrainingScheduleID  VARCHAR(50),	
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList VARCHAR(MAX),
	 @IsPeriod TINYINT,
	 @IsCheckAll TINYINT,
	 @TrainingResultList NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'A.TrainingResultID,A.TrainingScheduleID,HRMT2121.EmployeeID ',
        @TotalRow NVARCHAR(50) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@TrainingResultListConvert NVARCHAR(MAX)=N''

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111)      

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	A.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = '
	A.DivisionID = '''+@DivisionID+''''
		

IF @TrainingResultList IS NOT NULL
SET @sWhere = @sWhere + ' AND A.TrainingResultID IN (''' + @TrainingResultList +''') '

IF @IsSearch = 1
BEGIN
	IF ISNULL(@TrainingResultID,'') <> '' SET @sWhere = @sWhere + '
	AND A.TrainingResultID LIKE ''%'+@TrainingResultID+'%'' '

	IF ISNULL(@TrainingScheduleID,'') <> '' SET @sWhere = @sWhere + N'
	AND A.TrainingScheduleID LIKE ''%'+@TrainingScheduleID+'%'' '

--Lọc theo ngày
	IF @IsPeriod =0
	BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (A.CreateDate >= ''' + @FromDateText + '''
											OR A.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (A.CreateDate <= ''' + @ToDateText + ''' 
											OR A.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (A.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	END	
	-- Lọc theo kỳ
	ELSE
	BEGIN
		IF(@PeriodList IS NOT NULL)
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(A.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

END

SET @sSQL = N'
	SELECT  DISTINCT 
	ROW_NUMBER() OVER (ORDER BY A.TrainingResultID) AS RowNum,
	A.APK,
	A.DivisionID,
	AT1101.DivisionName,
	A.TrainingResultID,
	A.TrainingScheduleID,
	HRMT2100.TrainingCourseID,
	HT0099.Description AS TrainingTypeName,
	HRMT1040.TrainingFieldName,
	HRMT1050.ObjectID, 
	CASE
        WHEN HRMT1050.ObjectID = AT1103.EmployeeID THEN AT1103.FullName
        WHEN HRMT1050.ObjectID = AT1202.ObjectID THEN AT1202.ObjectName
	END AS ObjectName,
	HRMT1050.Address,
	A.AssignedToUserID,
	AT1103.FullName AS AssignedToUserName,
	HRMV2120.ResultTypeName,
	A.Description1,
	A.Description2,

	HRMT2121.EmployeeID, 
	 AT1405.UserName AS EmployeeName,
	AT1102.DepartmentName,
	HT1102.DutyName,
	HRMV2121.StatusTypeName,
	HRMV2122.ResultName,
	HRMT2121.Notes

	FROM HRMT2120 A WITH (NOLOCK)
	LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = A.DivisionID AND HRMT2100.TrainingScheduleID = A.TrainingScheduleID
	LEFT JOIN HRMT2121 WITH (NOLOCK) ON  A.APK =  TRY_CAST(HRMT2121.TrainingResultID AS UNIQUEIDENTIFIER)
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID	
	LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
	LEFT JOIN HRMV2120 ON HRMV2120.ResultTypeID = A.ResultTypeID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
	LEFT JOIN AT1103  WITH (NOLOCK) ON AT1103.EmployeeID = A.AssignedToUserID
	LEFT JOIN HRMV2121 ON HRMV2121.StatusTypeID = HRMT2121.StatusTypeID
	LEFT JOIN HRMV2122 ON HRMV2122.ResultID = HRMT2121.ResultID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.EmployeeID = HRMT2121.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = HT1400.DivisionID AND HT1403.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DutyID = AT1103.DutyID AND HT1102.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = HRMT2121.EmployeeID AND AT1405.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2121.DepartmentID 
	LEFT JOIN AT1101 WITH (NOLOCK) ON A.DivisionID = AT1101.DivisionID
	WHERE '+@sWhere +'
	Group by
	A.APK,
	A.DivisionID,
	AT1101.DivisionName,
	A.TrainingResultID,
	A.TrainingScheduleID,
	HRMT2100.TrainingCourseID,
	HRMT1040.TrainingFieldName,
	HRMT1050.ObjectID, 
	A.AssignedToUserID,
	HRMV2120.ResultTypeName,
	A.Description1,
	A.Description2,
	HRMT2121.EmployeeID,
	AT1102.DepartmentName,
	HT1102.DutyName,
	HRMV2121.StatusTypeName,
	HRMV2122.ResultName,
	HRMT2121.Notes,
	HT0099.Description,
	AT1103.EmployeeID,
	AT1103.FullName,
	AT1202.ObjectID,
	AT1202.ObjectName,
	HRMT1050.Address,
	AT1405.UserName
	ORDER BY '+@OrderBy+''

PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
