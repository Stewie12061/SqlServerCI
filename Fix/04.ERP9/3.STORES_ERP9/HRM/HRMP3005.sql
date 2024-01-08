IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP3005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP3005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo kế hoạch đào tạo
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
	EXEC [HRMP3005] @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@FromDate='01-01-2016',@ToDate='01-01-2018',@TrainingFieldID='CNTT',@TrainingType='1',@TrainingPlanID='000001',@lstTransactionID='606F9FA8-C610-4FF4-BBAC-06E6B7F8937A'',''B1FF6B1A-8572-4F56-9149-E7F3FA9B0884'
----*/

CREATE PROCEDURE [HRMP3005]
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),	 
	 @FromDate DATETIME,
	 @ToDate DATETIME, 
	 @TrainingFieldID NVARCHAR(4000), 	 
	 @TrainingType NVARCHAR(4000),
	 @TrainingPlanID NVARCHAR(4000),
	 @lstTransactionID NVARCHAR(4000)	 
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N''

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'HRMT2100.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + 'HRMT2100.DivisionID = '''+@DivisionID+''''

IF ISNULL(@TrainingFieldID, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT1050.TrainingFieldID IN (''' + @TrainingFieldID + ''')'
	
IF ISNULL(@TrainingType, '') <> ''
	SET @sWhere = @sWhere + ' AND HRMT1050.TrainingType IN (''' + @TrainingType + ''')'	
	
SET @sSQL = '
SELECT HRMT2070.TrainingPlanID, HRMT2070.Description AS TrainingPlanName, HRMT2070.AssignedToUserID, HRMT2070.CreateDate,
HRMT2100.TrainingScheduleID, HRMT2100.Description2 AS TrainingScheduleName, HRMT1050.TrainingCourseID, HRMT1050.Description AS TrainingCourseName,    
HRMT1040.TrainingFieldName, HT0099.Description AS TrainingTypeName, SUM(HRMT2100.ScheduleAmount) AS ScheduleAmount,
COUNT(HRMT2101.TransactionID) AS ScheduleNumber, SUM(HRMT2130.CostAmount) AS RealityAmount, 
COUNT(HRMT2121.TransactionID) AS RealityNumber
FROM HRMT2070 WITH (NOLOCK) 
LEFT JOIN HRMT2071 WITH (NOLOCK) ON HRMT2071.DivisionID = HRMT2070.DivisionID AND HRMT2071.TrainingPlanID = HRMT2070.TrainingPlanID
LEFT JOIN HRMT2091 WITH (NOLOCK) ON HRMT2091.DivisionID = HRMT2071.DivisionID AND HRMT2091.InheritID = HRMT2071.TransactionID AND HRMT2091.InheritTableID = ''HRMT2071''
LEFT JOIN HRMT2101 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2091.DivisionID AND HRMT2101.InheritTransactionID = HRMT2091.TransactionID
LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID	= HRMT2101.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2101.TrainingScheduleID
LEFT JOIN HRMT2121 WITH (NOLOCK) ON HRMT2121.DivisionID = HRMT2100.DivisionID AND HRMT2121.InheritID = HRMT2100.TrainingScheduleID AND HRMT2121.StatusTypeID = ''1''
LEFT JOIN HRMT2130 WITH (NOLOCK) ON HRMT2130.DivisionID = HRMT2100.DivisionID AND HRMT2130.TrainingScheduleID = HRMT2100.TrainingScheduleID
LEFT JOIN HRMT2131 WITH (NOLOCK) ON HRMT2130.DivisionID = HRMT2131.DivisionID AND HRMT2130.TrainingCostID = HRMT2131.TrainingCostID
LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID
LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
WHERE ' + @sWhere + '
AND HRMT2070.TrainingPlanID = ''' + @TrainingPlanID + '''
AND HRMT2071.TransactionID IN ('''+@lstTransactionID+''')
AND 
(
	HRMT2100.FromDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
	OR 
	HRMT2100.ToDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + '''
)	
GROUP BY HRMT2070.TrainingPlanID, HRMT2070.Description, HRMT2070.AssignedToUserID, HRMT2070.CreateDate, HRMT2100.TrainingScheduleID, HRMT2100.Description2,
HRMT1050.TrainingCourseID, HRMT1050.Description, HRMT1040.TrainingFieldName, HT0099.Description
ORDER BY HRMT2070.CreateDate'

PRINT (@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




