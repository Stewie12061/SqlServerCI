IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In Yêu cầu tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 10/08/2017
----Update  by: Thu Hà,  Date: 29/06/2023 - Bổ sung lọc (để in) theo tên đơn vị
-- <Example>
---- 
/*-- <Example>
	HRMP2012 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@IsSearch=1,
	@RecruitRequireID=NULL,@DutyID='LD',@Disabled=0, @IsCheckAll=0,@RecruitRequireList = NULL

	EXEC HRMP2012 @DivisionID,@DivisionList, @UserID,@PageNumber,@PageSize,@IsSearch, @RecruitRequireID, @DutyID, @Disabled
----*/
CREATE PROCEDURE HRMP2012
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @IsSearch TINYINT,
	 @RecruitRequireID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @Disabled VARCHAR(1),
	 @IsCheckAll TINYINT,
	 @RecruitRequireList XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=''

SET @OrderBy = 'HRMT2010.DutyID, HRMT2010.RecruitRequireID'

IF Isnull(@DivisionList, '') <> ''
BEGIN
	IF @DivisionList <> '%'
	SET @sWhere = @sWhere + ' HRMT2010.DivisionID IN ('''+@DivisionList+''', ''@@@'')'

END
ELSE SET @sWhere = @sWhere + ' HRMT2010.DivisionID LIKE '''+@DivisionID+''' OR HRMT2010.DivisionID = ''@@@'' '

IF  @IsSearch = 1
BEGIN
	
	IF ISNULL(@RecruitRequireID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2010.RecruitRequireID LIKE ''%'+@RecruitRequireID+'%'' '
	IF ISNULL(@DutyID,'') <> '' SET @sWhere = @sWhere + '
	AND HRMT2010.DutyID LIKE ''%'+@DutyID+'%'' '
	IF @Disabled IS NOT NULL SET @sWhere = @sWhere + N'
	AND HRMT2010.Disabled = ''' + @Disabled + ''''
END

IF ISNULL(@IsCheckAll,0) = 0
BEGIN
	CREATE TABLE #RecruitRequireList (RecruitRequireID VARCHAR(50), DivisionID VARCHAR(50))
	INSERT INTO #RecruitRequireList (RecruitRequireID, DivisionID)
	SELECT X.Data.query('RecruitRequireID').value('.', 'NVARCHAR(50)') AS RecruitRequireID,
		   X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID
	FROM	@RecruitRequireList.nodes('//Data') AS X (Data)
	ORDER BY RecruitRequireID

	SET @sJoin = @sJoin + '
	INNER JOIN #RecruitRequireList T1 ON HRMT2010.DivisionID = T1.DivisionID AND HRMT2010.RecruitRequireID = T1.RecruitRequireID'
END
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum,
	HRMT2010.APK, HRMT2010.DivisionID,AT1101.DivisionName, HRMT2010.RecruitRequireID, HRMT2010.RecruitRequireName, HRMT2010.DutyID, HT1102.DutyName,
	HT99.Description AS Gender, HRMT2010.FromAge, HRMT2010.ToAge, HRMT2010.Experience, HT1005.EducationLevelName AS EducationLevelID, HRMT2010.Appearance,
	HRMT2010.FromSalary, HRMT2010.ToSalary, HRMT2010.WorkDescription, HT16A.LanguageName Language1ID, HT16B.LanguageName Language2ID, HT16C.LanguageName Language3ID, 
	HT17A.LanguageLevelName LanguageLevel1ID, HT17B.LanguageLevelName LanguageLevel2ID, HT17C.LanguageLevelName LanguageLevel3ID, HRMT2010.IsInformatics, 
	HRMT2010.InformaticsLevel, HRMT2010.IsCreativeness, HRMT2010.Creativeness, HRMT2010.IsProblemSolving, HRMT2010.ProblemSolving, HRMT2010.IsPrsentation,
	HRMT2010.Prsentation, HRMT2010.IsCommunication, HRMT2010.Communication, HRMT2010.Height, HRMT2010.Weight, HRMT2010.HealthStatus, HRMT2010.Notes,
	HRMT2010.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2010.CreateUserID) CreateUserID, HRMT2010.CreateDate, 
	HRMT2010.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2010.LastModifyUserID) LastModifyUserID, HRMT2010.LastModifyDate,
	HT0099.Description AS Disabled   
FROM HRMT2010 WITH (NOLOCK)
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2010.DivisionID = HT1102.DivisionID AND HRMT2010.DutyID = HT1102.DutyID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT2010.Disabled = HT0099.ID AND HT0099.CodeMaster = ''Disabled''
LEFT JOIN HT0099 HT99 WITH (NOLOCK) ON HRMT2010.Gender = HT99.ID AND HT99.CodeMaster = ''Gender''
LEFT JOIN HT1005 WITH (NOLOCK) ON HRMT2010.DivisionID = HT1005.DivisionID AND HRMT2010.EducationLevelID = HT1005.EducationLevelID
LEFT JOIN HT1006 HT16A WITH (NOLOCK) ON HRMT2010.DivisionID = HT16A.DivisionID AND HRMT2010.Language1ID = HT16A.LanguageID
LEFT JOIN HT1006 HT16B WITH (NOLOCK) ON HRMT2010.DivisionID = HT16B.DivisionID AND HRMT2010.Language2ID = HT16B.LanguageID
LEFT JOIN HT1006 HT16C WITH (NOLOCK) ON HRMT2010.DivisionID = HT16C.DivisionID AND HRMT2010.Language3ID = HT16C.LanguageID
LEFT JOIN HT1007 HT17A WITH (NOLOCK) ON HRMT2010.DivisionID = HT17A.DivisionID AND HRMT2010.LanguageLevel1ID = HT17A.LanguageLevelID
LEFT JOIN HT1007 HT17B WITH (NOLOCK) ON HRMT2010.DivisionID = HT17B.DivisionID AND HRMT2010.LanguageLevel2ID = HT17B.LanguageLevelID
LEFT JOIN AT1101 WITH (NOLOCK) ON HRMT2010.DivisionID = AT1101.DivisionID
LEFT JOIN HT1007 HT17C WITH (NOLOCK) ON HRMT2010.DivisionID = HT17C.DivisionID AND HRMT2010.LanguageLevel3ID = HT17C.LanguageLevelID'+@sJoin+'
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+'
'

PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

