IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP0009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP0009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load combo kế hoạch đào tạo định kỳ
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 03/10/2017
---- <Example>
---- Exec HRMP0009 @DivisionID='AS',@DivisionList='AS',@UserID='ASOFTADMIN',@FromDate='02-10-2017',@ToDate='11-01-2017'   
---- 

CREATE PROCEDURE [dbo].[HRMP0009]
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME
) 
AS 
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX),
        @sWhere NVARCHAR(MAX) = N''
        
        
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = 'TB3.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = 'TB3.DivisionID IN ('''+@DivisionID+''')'        

SET @sSQL1 = '
SELECT TB3.DivisionID, TB3.TransactionID, TB3.TrainingPlanID, HRMT2070.Description AS TrainingPlanName, FromDate, DATEADD(DAY, DurationPlan, FromDate) AS ToDate
INTO #TEMP
FROM 
(
	SELECT CASE WHEN RepeatTypeID = ''0'' AND ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' > StartDateTB THEN DATEADD(quarter, 1, StartDateTB) ELSE StartDateTB END AS FromDate, DivisionID, TransactionID, TrainingPlanID, DurationPlan
	FROM 
	(        
		SELECT CASE WHEN RepeatTypeID IN (''0'', ''1'') AND RepeatTime = 0 THEN CONVERT(NVARCHAR(5),DATEPART(YEAR, ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''')) + ''-'' + CONVERT(NVARCHAR(5),DATEPART(MONTH, StartDateTB)) + ''-'' + CONVERT(NVARCHAR(5),DATEPART(DAY, StartDateTB))
					WHEN RepeatTypeID IN (''0'', ''1'') AND RepeatTime <> 0 AND DATEPART(YEAR, ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''') BETWEEN DATEPART(YEAR, StartDateTB) AND RepeatTime + DATEPART(YEAR, StartDateTB) THEN CONVERT(NVARCHAR(5),DATEPART(YEAR, ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''')) + ''-'' + CONVERT(NVARCHAR(5),DATEPART(MONTH, StartDateTB)) + ''-'' + CONVERT(NVARCHAR(5),DATEPART(DAY, StartDateTB))
					ELSE StartDateTB END AS StartDateTB, DivisionID, TransactionID, TrainingPlanID, DurationPlan, RepeatTypeID
		FROM
		(	
			SELECT 
			(CASE WHEN RepeatTypeID = ''0'' THEN
				DATEADD(quarter, 
				((
					CASE WHEN DATEPART(MONTH, StartDate) BETWEEN 1 AND 3 THEN 1
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 4 AND 6 THEN 2
						 WHEN DATEPART(MONTH, StartDate) BETWEEN 7 AND 9 THEN 3 ELSE 4 END
				)-1)*-1+DATEPART(quarter,''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''')-1, StartDate) ELSE StartDate END) AS StartDateTB, *
			FROM HRMT2071 WITH (NOLOCK) 
		) TB	
	) TB2
)TB3
LEFT JOIN HRMT2070 WITH (NOLOCK) ON HRMT2070.DivisionID = TB3.DivisionID AND HRMT2070.TrainingPlanID = TB3.TrainingPlanID
WHERE ' + @sWhere + ' AND FromDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 101) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 101) + ''''

SET @sSQL2 = '
SELECT TrainingPlanID, TrainingPlanName,
STUFF(( 
		SELECT '','' + [TransactionID]
		FROM #TEMP
		WHERE TransactionID = #TEMP.TransactionID 
		FOR XML PATH(''''),TYPE).value(''(./text())[1]'',''VARCHAR(MAX)''),1,2,''''
	) AS lstTransactionID 				
FROM #TEMP
GROUP BY TrainingPlanID, TrainingPlanName
'

PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL1 + @sSQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
