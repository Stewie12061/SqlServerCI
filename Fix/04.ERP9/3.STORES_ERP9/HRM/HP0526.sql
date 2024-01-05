IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0526]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0526]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load grid ứng viên trúng tuyển (HF0502)
-- <History>
---- Created by Bảo Thy on 27/07/2017
---- Modified by on
-- <Example>
/* 
 EXEC HP0526 @DivisionID = 'CH', @UserID = 'ASOFTADMIN', @RecDecisionList = NULL
 */
 
CREATE PROCEDURE HP0526
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@RecDecisionList AS XML

) 
AS
CREATE TABLE #RecDecisionList (RecDecisionID VARCHAR(50))
INSERT INTO #RecDecisionList (RecDecisionID)
SELECT X.Data.query('RecDecisionID').value('.', 'NVARCHAR(50)') AS RecDecisionID
FROM	@RecDecisionList.nodes('//Data') AS X (Data)
ORDER BY RecDecisionID

SELECT HRMT2051.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2020.DepartmentID, AT1102.DepartmentName, HRMT2020.DutyID, HT1102.DutyName, 
CONVERT(VARCHAR(50),'') AS EmployeeID,HRMT2051.CandidateID,
LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HRMT1030.LastName,'')))+ ' ' + LTRIM(RTRIM(ISNULL(HRMT1030.MiddleName,''))) + ' ' + LTRIM(RTRIM(ISNULL(HRMT1030.FirstName,''))),'  ',' '))) AS CandidateName,
HRMT1030.Gender, H10.Description AS GenderName, HRMT1030.Birthday, HRMT1030.BornPlace, IsSingle, 
CASE WHEN ISNULL(IsSingle,0) = 0 THEN N'Đã kết hôn' ELSE N'Độc thân' END AS MaterialStatus, HRMT1031.WorkType, H11.Description AS WorkTypeName
INTO #HP0526
FROM HRMT2051 WITH (NOLOCK)
LEFT JOIN HRMT2050 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2050.DivisionID AND HRMT2051.RecDecisionID = HRMT2050.RecDecisionID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HT0099 H09 WITH (NOLOCK) ON HRMT2051.Status = H09.ID AND H09.CodeMaster = 'Status'
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2020.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2020.DivisionID = HT1102.DivisionID AND HRMT2020.DutyID = HT1102.DutyID
LEFT JOIN HRMT1030 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT1030.DivisionID AND HRMT2051.CandidateID = HRMT1030.CandidateID
LEFT JOIN HT0099 H10 WITH (NOLOCK) ON HRMT1030.Gender = H10.ID AND H10.CodeMaster = 'Gender'
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1030.DivisionID AND HRMT1031.CandidateID = HRMT1030.CandidateID
LEFT JOIN HT0099 H11 WITH (NOLOCK) ON HRMT1031.WorkType = H11.ID AND H11.CodeMaster = 'WorkType'
WHERE  HRMT2051.DivisionID = @DivisionID
AND HRMT1031.RecruitStatus = 5
AND EXISTS (SELECT TOP 1 1 FROM #RecDecisionList WHERE #RecDecisionList.RecDecisionID = HRMT2051.RecDecisionID)
AND NOT EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE HT1400.DivisionID = HRMT2051.DivisionID AND HT1400.RecDecisionID = HRMT2051.RecDecisionID AND HT1400.CandidateID = HRMT2051.CandidateID)

---Sinh mã nhân viên
DECLARE @Cur CURSOR,
		@CandidateID VARCHAR(50),
		@RecDecisionID VARCHAR(50),
		@NewKey NVARCHAR(50),
		@IsAutomatic TINYINT,
		@IsS1 TINYINT,
		@IsS2 TINYINT,
		@IsS3 TINYINT,
		@S1 NVARCHAR(50),
		@S2 NVARCHAR(50),
		@S3 NVARCHAR(50),
		@Length INT,
		@OutputOrder INT, 
		@IsSeparator INT,
		@Separator NVARCHAR(1)

SELECT @IsAutomatic = IsAutomatic,
	   @S1  = S1,
	   @S2  = S2,
	   @S3  = S3,
	   @Length =Length,
	   @OutputOrder = OutputOrder, 
	   @IsSeparator = IsSeparator,
	   @Separator = Separator
FROM AT0002 WITH (NOLOCK)  	
WHERE DivisionID = @DivisionID AND TableID = 'HT1400'

IF ISNULL(@IsAutomatic,0) = 1
BEGIN
	SET @Cur = CURSOR FOR
	SELECT	CandidateID, RecDecisionID
	FROM #HP0526
	WHERE ISNULL(EmployeeID,'') = ''
			
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @CandidateID, @RecDecisionID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC AP0002 @DivisionID, @NewKey OUTPUT, 'HT1400', @S1, @S2, @S3, @Length, @OutputOrder, @IsSeparator, @Separator
	
		UPDATE #HP0526
		SET #HP0526.EmployeeID = @NewKey
		FROM #HP0526
		WHERE #HP0526.CandidateID = @CandidateID AND #HP0526.RecDecisionID = @RecDecisionID
	
	FETCH NEXT FROM @Cur INTO @CandidateID, @RecDecisionID
	END	
	CLOSE @Cur
END

SELECT * FROM #HP0526
ORDER BY RecDecisionNo, CandidateID

DROP TABLE #RecDecisionList
DROP TABLE #HP0526

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
