IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2074]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2074]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo kế hoạch đào tạo 
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Khả Vi on 13/12/2017
---- <Example>
/* HRMP2074 @DivisionID = 'AS', @DivisionList = '', @TrainingPlanID = 'KDT/000006/2017/05', @FromDate = '', @ToDate = '', @IsAll = '', @TrainingPlanList = '', @IsSearch = ''

   HRMP2074 @DivisionID, @DivisionList, @TrainingPlanID, @FromDate, @ToDate, @IsSearch, @IsAll, @TrainingPlanList


*/
CREATE PROCEDURE HRMP2074
( 
  @DivisionID VARCHAR(50),
  @DivisionList VARCHAR(MAX),
  @TrainingPlanID NVARCHAR(50),
  @FromDate DATETIME, 
  @ToDate DATETIME,
  @IsAll TINYINT, 
  @TrainingPlanList VARCHAR(MAX), 
  @IsSearch TINYINT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX) = N''


SET @sSQL = N' 
SELECT HRMT2071.TrainingFieldID, HRMT1040.TrainingFieldName AS Description, HRMT2071.DepartmentID, AT1102.DepartmentName, 
HRMT2071.StartDate AS FromDate, DATEADD(DAY, HRMT2071.DurationPlan, HRMT2071.StartDate) AS ToDate, HRMT2071.DurationPlan AS CountDate, 
HRMT2071.Notes AS TrainingTypeName, DATEPART(YEAR, HRMT2071.StartDate) AS Year
FROM HRMT2070 WITH (NOLOCK) 
INNER JOIN HRMT2071 WITH (NOLOCK) ON HRMT2070.DivisionID = HRMT2071.DivisionID AND HRMT2070.TrainingPlanID = HRMT2071.TrainingPlanID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT2071.DivisionID = HRMT1040.DivisionID AND HRMT2071.TrainingFieldID = HRMT1040.TrainingFieldID
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN ('''+@DivisionID+''',''@@@'') AND HRMT2071.DepartmentID = AT1102.DepartmentID AND AT1102.Disabled = 0
WHERE HRMT2070.TrainingPlanID = '''+@TrainingPlanID+'''
'
--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
