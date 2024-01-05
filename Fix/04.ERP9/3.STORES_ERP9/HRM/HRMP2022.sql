IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2022]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2022]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In phiếu yêu cầu tuyển dụng 
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

	HRMP2022 @DivisionID = 'AS', @DivisionList='AS'',''CH', @RecruitPeriodID = 'REC/05/2017/144', @DepartmentID = '', @DutyID = '', 
	@FromDate = '', @ToDate = '', @IsAll = '', @RecruitPeriodList = '', @IsSearch = 0

	HRMP2022 @DivisionID, @DivisionList, @RecruitPeriodID, @DepartmentID, @DutyID, @FromDate, @ToDate, @IsAll, @RecruitPeriodList, @IsSearch

----*/

CREATE PROCEDURE HRMP2022
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX), 
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50), 
	 @DutyID VARCHAR(50), 
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @IsAll TINYINT, 
	 @RecruitPeriodList NVARCHAR(MAX),
	 @IsSearch TINYINT

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''

IF @IsSearch = 0 
BEGIN
SET @sSQL = N'
SELECT HRMT2020.DivisionID, HRMT2020.RecruitPeriodID, HRMT2020.DepartmentID, AT1102.DepartmentName, HRMT2020.PeriodFromDate, HRMT2020.PeriodToDate, HRMT2020.DutyID, 
HT1102.DutyName, HRMT2020.RecruitQuantity, HRMT2024.WorkDescription, HRMT2024.EducationLevelID, HT1005.EducationLevelName, HT09.[Description] AS Gender, 
HRMT2024.FromAge, HRMT2024.ToAge, HRMT2020.Note AS VoucherType, HRMT2020.RequireDate, HRMT2024.Notes
FROM HRMT2020 WITH (NOLOCK) 
INNER JOIN HRMT2024 WITH (NOLOCK) ON HRMT2020.DivisionID = HRMT2024.DivisionID AND HRMT2020.RecruitPeriodID = HRMT2024.RecruitPeriodID
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HT0099 HT09 WITH (NOLOCK) ON HRMT2024.Gender = HT09.ID AND HT09.CodeMaster = ''Gender''
LEFT JOIN HT1005 WITH (NOLOCK) ON HRMT2024.DivisionID = HT1005.DivisionID AND HRMT2024.EducationLevelID = HT1005.EducationLevelID
WHERE HRMT2020.RecruitPeriodID = '''+@RecruitPeriodID+''' 
'
END 

--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
