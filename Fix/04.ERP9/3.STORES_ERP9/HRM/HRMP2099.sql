IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2099]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2099]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In báo cáo đề xuất huấn luyện
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi on 13/12/2017
-- <Example>
---- 
/*-- <Example>
	HRMP2099 @DivisionID = 'AS', @DivisionIDList = '', @TrainingProposeID = 'DXDT/00006/2017/05', @DepartmentID = 'PB0001', @FromDate = '', @ToDate = '', 
	@IsAll = '', @TrainingProposeList = '', @IsSearch = 0 

	HRMP2099 @DivisionID, @DivisionIDList, @TrainingProposeID, @DepartmentID, @FromDate, @ToDate, @IsAll, @TrainingProposeList, @IsSearch

----*/

CREATE PROCEDURE HRMP2099
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList VARCHAR(50), 
	 @TrainingProposeID VARCHAR(50), 
	 @DepartmentID VARCHAR(50), 
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @IsAll TINYINT, 
	 @TrainingProposeList VARCHAR(MAX), 
	 @IsSearch TINYINT
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''

IF @IsSearch = 0 
BEGIN 
	IF @DepartmentID = '%'
	BEGIN 
	SET @sSQL = N'
	SELECT HRMT2090.DivisionID, HRMT2090.TrainingProposeID, N''Tất cả'' AS EmployeeID, N''Tất cả'' AS EmployeeName, 
	N''Tất cả'' AS Birthday, N''Tất cả'' AS DutyID,  N''Tất cả'' AS DutyName, HRMT2090.DepartmentID, N''Tất cả'' AS DepartmentName, HRMT2090.Description3
	FROM HRMT2090 WITH (NOLOCK) 
	WHERE HRMT2090.TrainingProposeID = '''+@TrainingProposeID+'''
	'
	END

	ELSE
	BEGIN
	SET @sSQL = N'
	SELECT HRMT2090.DivisionID, HRMT2090.TrainingProposeID, HRMT2091.EmployeeID, CASE 
	WHEN ISNULL(HT1400.MiddleName,'''') = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
	WHEN ISNULL(HT1400.MiddleName,'''') <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  
	LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) END AS EmployeeName, HT1400.Birthday, HT1403.DutyID, HT1102.DutyName, HRMT2091.DepartmentID, AT1102.DepartmentName, 
	HRMT2091.Notes
	FROM HRMT2090 WITH (NOLOCK) 
	INNER JOIN HRMT2091 WITH (NOLOCK) ON HRMT2090.DivisionID = HRMT2091.DivisionID AND HRMT2090.TrainingProposeID = HRMT2091.TrainingProposeID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HRMT2091.DivisionID = HT1400.DivisionID AND HRMT2091.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HRMT2091.DivisionID = HT1403.DivisionID AND HRMT2091.EmployeeID = HT1403.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1403.DivisionID = HT1102.DivisionID AND HT1403.DutyID = HT1102.DutyID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND HRMT2091.DepartmentID = AT1102.DepartmentID
	WHERE HRMT2090.TrainingProposeID = '''+@TrainingProposeID+'''
	ORDER BY HRMT2090.TrainingProposeID, HRMT2091.EmployeeID
	'
	END
END 


--PRINT(@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
