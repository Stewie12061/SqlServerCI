IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo phiếu theo dõi đào tạo cá nhân
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 29/09/2017
-- <Example>
---- 
/*-- <Example>
	EXEC [HRMP3003] @DivisionID='AS',@DivisionList='',@FromDate='01-01-2016',@ToDate='01-01-2018',@TrainingFieldID='CNTT',@EmployeeID='NV0001'
----*/

CREATE PROCEDURE [HRMP3003]
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),	 
	 @FromDate DATETIME,
	 @ToDate DATETIME, 
	 @TrainingFieldID NVARCHAR(4000), 	 
	 @EmployeeID NVARCHAR(50)	 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N''

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'HRMT2121.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + 'HRMT2121.DivisionID = '''+@DivisionID+''''
IF ISNULL(@TrainingFieldID, '') <> '' SET @sWhere = @sWhere + ' 
AND HRMT1050.TrainingFieldID IN (''' + @TrainingFieldID + ''')'
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2120.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2120.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2120.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''  '


SET @sSQL = '
SELECT HRMT2121.EmployeeID, HT1400.LastName + '' '' + HT1400.MiddleName + '' '' + HT1400.FirstName AS EmployeeName, 
AT1102.DepartmentName, HT1102.DutyName, HRMT1050.TrainingCourseID, HRMT1050.Description AS TrainingCourseName, 
HRMT1040.TrainingFieldName, HT0099.Description AS TrainingTypeName,
AT1202.ObjectName, HRMT2130.FromDate AS StartDate, HRMT2130.ToDate AS EndDate, 
CASE WHEN HRMV2121.StatusTypeID = 0 THEN HRMV2121.StatusTypeName ELSE HRMV2122.ResultName END AS ResultName   
FROM HRMT2121 WITH (NOLOCK)
INNER JOIN HRMT2120 WITH (NOLOCK) ON HRMT2121.DivisionID = HRMT2120.DivisionID AND HRMT2121.TrainingResultID = HRMT2120.TrainingResultID
LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2120.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2120.TrainingScheduleID
LEFT JOIN HRMT2130 WITH (NOLOCK) ON HRMT2130.DivisionID = HRMT2120.DivisionID AND HRMT2130.TrainingScheduleID = HRMT2120.TrainingScheduleID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID	
LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.EmployeeID = HRMT2121.EmployeeID
LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = HT1400.DivisionID AND HT1403.EmployeeID = HT1400.EmployeeID
LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID 
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2121.DepartmentID
LEFT JOIN HRMV2121 ON HRMV2121.StatusTypeID = HRMT2121.StatusTypeID
LEFT JOIN HRMV2122 ON HRMV2122.ResultID = HRMT2121.ResultID
WHERE ' + @sWhere + '
AND HRMT2121.EmployeeID = ''' + @EmployeeID + '''
ORDER BY HRMT2130.FromDate'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




