IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3006]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo dự trù kế hoạch và chi phí bồi dưỡng ngắn hạn
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
	EXEC [HRMP3006] @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@TranYear=2017,@TrainingFieldID='CNTT',@TrainingType='1',@DepartmentID='ACC'
----*/

CREATE PROCEDURE [HRMP3006]
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),
	 @TranYear INT,
	 @TrainingFieldID NVARCHAR(4000),
	 @TrainingType NVARCHAR(4000),
	 @DepartmentID NVARCHAR(4000) 	 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N''

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'HRMT2130.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + 'HRMT2130.DivisionID = '''+@DivisionID+''''

IF ISNULL(@TrainingFieldID, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT2100.TrainingFieldID IN (''' + @TrainingFieldID + ''')'	
		
IF ISNULL(@TrainingType, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT1050.TrainingType IN (''' + @TrainingType + ''')'	
	
IF ISNULL(@DepartmentID, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT2101.DepartmentID IN (''' + @DepartmentID + ''')'		
			
SET @sSQL = '	
SELECT ISNULL(TB1.TrainingFieldID, TB2.TrainingFieldID) AS TrainingFieldID, HRMT1040.TrainingFieldName, ISNULL(TB1.TrainingCourseName, TB2.TrainingCourseName) AS TrainingCourseName, TB1.Amount1, TB1.Number1, TB2.Amount2, TB2.Number2  
FROM 
(	
	SELECT HRMT2130.DivisionID, HRMT2100.TrainingFieldID, COUNT(HRMT2121.TransactionID) AS Number1, HRMT1050.TrainingCourseID, HRMT1050.[Description] AS TrainingCourseName,
	SUM(HRMT2130.CostAmount)/(CASE WHEN COUNT(HRMT2121.TransactionID) = 0 THEN COUNT(HRMT2101.TransactionID) ELSE COUNT(HRMT2121.TransactionID) END) AS Amount1
	FROM HRMT2130 WITH (NOLOCK)
	LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2130.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2130.TrainingScheduleID
	LEFT JOIN HRMT2101 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2100.DivisionID AND HRMT2101.TrainingScheduleID = HRMT2100.TrainingScheduleID
	LEFT JOIN HRMT2121 WITH (NOLOCK) ON HRMT2121.DivisionID = HRMT2130.DivisionID AND HRMT2121.InheritID = HRMT2101.TrainingScheduleID AND HRMT2121.InheritTransactionID = HRMT2101.TransactionID AND StatusTypeID = ''1''
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID
	WHERE ' + @sWhere + '
	AND DATEPART(YEAR, HRMT2130.FromDate) = ' + CONVERT(NVARCHAR(10), @TranYear) + '
	GROUP BY HRMT2130.DivisionID, HRMT2100.TrainingFieldID, HRMT1050.TrainingCourseID, HRMT1050.[Description]
) TB1 
FULL JOIN 
(	
	SELECT HRMT2130.DivisionID, HRMT2100.TrainingFieldID, COUNT(HRMT2121.TransactionID) AS Number2, HRMT1050.TrainingCourseID, HRMT1050.[Description] AS TrainingCourseName,
	SUM(HRMT2130.CostAmount)/(CASE WHEN COUNT(HRMT2121.TransactionID) = 0 THEN COUNT(HRMT2101.TransactionID) ELSE COUNT(HRMT2121.TransactionID) END) AS Amount2
	FROM HRMT2130 WITH (NOLOCK)
	LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2130.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2130.TrainingScheduleID
	LEFT JOIN HRMT2101 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2100.DivisionID AND HRMT2101.TrainingScheduleID = HRMT2100.TrainingScheduleID	
	LEFT JOIN HRMT2121 WITH (NOLOCK) ON HRMT2121.DivisionID = HRMT2130.DivisionID AND HRMT2121.InheritID = HRMT2101.TrainingScheduleID AND HRMT2121.InheritTransactionID = HRMT2101.TransactionID AND StatusTypeID = ''1''
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID
	WHERE ' + @sWhere + '	
	AND DATEPART(YEAR, HRMT2130.FromDate) = ' + CONVERT(NVARCHAR(10), @TranYear - 1) + '	
	GROUP BY HRMT2130.DivisionID, HRMT2100.TrainingFieldID, HRMT1050.TrainingCourseID, HRMT1050.[Description]
) TB2 ON TB2.DivisionID = TB1.DivisionID AND TB2.TrainingFieldID = TB1.TrainingFieldID AND TB2.TrainingCourseID = TB1.TrainingCourseID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = ISNULL(TB1.TrainingFieldID, TB2.TrainingFieldID)'	

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




