IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2055]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2055]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xác nhận tuyển dụng hàng loạt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 30/08/2017
--- Modified on 18/02/2019 by Bảo Anh: Update trạng thái trong danh mục hồ sơ nhân viên đối với nhân viên tái tuyển dụng (NEWTOYO)
-- <Example>
---- 
/*-- <Example>
	
	EXEC HRMP2055 @DivisionID='CH',@UserID='ASOFTADMIN',@IsSearch=1, @RecDecisionNo = 'abc',
	@CandidateID = 'aaa', @DepartmentID = 'SOF', @DutyID = 'BA', @RecruitPeriodID='bbb', @RecruitStatus = 5, @IsCheckAll=1, @RecruitList=NULL

----*/

CREATE PROCEDURE HRMP2055
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @RecDecisionNo VARCHAR(50),
	 @CandidateID VARCHAR(50),
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @RecruitStatus VARCHAR(1),
	 @IsCheckAll TINYINT,
	 @RecruitList XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
		@sSQL1 NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N''

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@RecDecisionNo,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2050.RecDecisionNo LIKE ''%'+@RecDecisionNo+'%'' '
	IF ISNULL(@CandidateID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2051.CandidateID LIKE ''%'+@CandidateID+'%'' '
	IF ISNULL(@RecruitPeriodID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2051.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'' '
	IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '

END

IF ISNULL(@IsCheckAll,0) = 0
BEGIN
	CREATE TABLE #RecruitList (DivisionID VARCHAR(50), CandidateID VARCHAR(50), ReccruitPeriodID VARCHAR(50))
	INSERT INTO #RecruitList (DivisionID, CandidateID, ReccruitPeriodID)
	SELECT X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		   X.Data.query('CandidateID').value('.', 'NVARCHAR(50)') AS CandidateID,
		   X.Data.query('ReccruitPeriodID').value('.', 'NVARCHAR(50)') AS ReccruitPeriodID
	FROM	@RecruitList.nodes('//Data') AS X (Data)
	ORDER BY DivisionID, ReccruitPeriodID, CandidateID


	SET @sJoin = @sJoin + N'
	INNER JOIN #RecruitList T1 ON HRMT2051.DivisionID = T1.DivisionID AND HRMT2051.CandidateID = T1.CandidateID'
END

SET @sSQL = N'
SELECT HRMT2051.DivisionID, HRMT2051.RecruitPeriodID, HRMT2051.CandidateID
INTO #Temp_HRMP2055
FROM HRMT2051 WITH (NOLOCK)
LEFT JOIN HRMT2050 WITH (NOLOCK) ON HRMT2050.DivisionID = HRMT2051.DivisionID AND HRMT2050.RecDecisionID = HRMT2051.RecDecisionID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT1031.DivisionID AND HRMT2051.CandidateID = HRMT1031.CandidateID
'+@sJoin+' 
WHERE HRMT2051.DivisionID = '''+@DivisionID+''' AND  ( HRMT1031.RecruitStatus = 1 OR HRMT1031.RecruitStatus = 3 OR HRMT1031.RecruitStatus = 4 )
'+@sWhere +'
'



SET @sSQL1 = '
DECLARE @Cur CURSOR,
		@RecruitPeriodID_Cur VARCHAR(50),
		@CandidateID_Cur VARCHAR(50)

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT RecruitPeriodID, CandidateID
FROM #Temp_HRMP2055
ORDER BY CandidateID

OPEN @Cur
FETCH NEXT FROM @Cur INTO @RecruitPeriodID_Cur, @CandidateID_Cur
WHILE @@FETCH_STATUS = 0
BEGIN
	----Update trang thai nhan viec trong HSUV
	UPDATE HRMT1031
	SET RecruitStatus = '''+@RecruitStatus+'''
	WHERE DivisionID = '''+@DivisionID+'''
	AND CandidateID = @CandidateID_Cur

	--- Customize NEWTOYO: Update trang thai trong danh muc ho so nhan vien doi voi nhan vien tai tuyen dung
	IF (SELECT CustomerName FROM CustomerIndex) = 81
	BEGIN
		IF ''' + @RecruitStatus + ''' = ''5''
			UPDATE HT1400
			SET EmployeeStatus = 2
			WHERE DivisionID = ''' + @DivisionID + '''
			AND EmployeeID = @CandidateID_Cur
	END

	
FETCH NEXT FROM @Cur INTO @RecruitPeriodID_Cur, @CandidateID_Cur
END
CLOSE @Cur
'
--PRINT(@sSQL)
--PRINT(@sSQL1)

EXEC (@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
