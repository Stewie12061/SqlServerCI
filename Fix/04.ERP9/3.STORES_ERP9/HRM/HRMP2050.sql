IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRMF2050: Quyết định tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 28/08/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 22/10/2020 by Huỳnh Thử: Cập nhật phân quyền
----Modified on 11/11/2020 by Huỳnh Thử: Hiển thị trạng thái duyệt
----Modified on 30/06/2023 by Thu Hà: Bổ sung lọc theo kỳ
----Modified on 07/09/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo số quyết định
----Modified on 17/10/2023 by Thu Hà: Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
---- 
/*-- <Example>
	HRMP2050 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@InterviewScheduleID=NULL,@DutyID='LD',@Disabled=0

	EXEC HRMP2050 @DivisionID='CH',@DivisionList='CH'',''CH1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1, @RecDecisionNo = 'abc',
	@RecruitID = 'aaa', @DepartmentID = 'SOF', @DutyID = 'BA', @RecruitPeriodID='bbb', @FromDate = '2017-08-01', 
	@ToDate = NULL, @Status = 0

	EXEC HRMP2050 @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @RecDecisionNo, @RecruitID, @RecruitPeriodID, @DepartmentID,
	 @DutyID, @CreateUserID, @FromDate, @ToDate, @Status
----*/

CREATE PROCEDURE HRMP2050
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @RecDecisionNo VARCHAR(50),
	 @RecruitID VARCHAR(50),
	 @RecruitPeriodID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @Status VARCHAR(1),
	 @ConditionRecDecisionNo VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SET @OrderBy = '#Temp_HRMP2050.RecDecisionNo DESC,#Temp_HRMP2050.RecDecisionID, #Temp_HRMP2050.DecisionDate'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2050.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2050.DivisionID = '''+@DivisionID+''' '

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2050.DecisionDate >= ''' + @FromDateText + '''
											OR HRMT2050.DecisionDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2050.DecisionDate <= ''' + @ToDateText + ''' 
											OR HRMT2050.DecisionDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2050.DecisionDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2050.DecisionDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	
	IF ISNULL(@RecDecisionNo,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2050.RecDecisionNo LIKE ''%'+@RecDecisionNo+'%'' '
	IF ISNULL(@RecruitID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2051.RecruitID LIKE ''%'+@RecruitID+'%'' '

	IF ISNULL(@RecruitPeriodID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2051.RecruitPeriodID LIKE ''%'+@RecruitPeriodID+'%'' '

	IF ISNULL(@DepartmentID,'') <> ''
	SET @sWhere = @sWhere + 'AND HRMT2020.DepartmentID LIKE ''%'+@DepartmentID+'%'' '

	IF ISNULL(@DutyID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2020.DutyID LIKE ''%'+@DutyID+'%'' '

	IF ISNULL(@Status,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2051.Status LIKE ''%'+@Status+'%'' '

	--IF (@FromDate IS NOT NULL AND @ToDate IS NULL) 
	--SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '

	--IF (@FromDate IS NULL AND @ToDate IS NOT NULL) 
	--SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '

	--IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) 
	--SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2050.DecisionDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	


IF Isnull(@ConditionRecDecisionNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2050.CreateUserID,'''') in (N'''+@ConditionRecDecisionNo+''','''+@UserID+''' )'
	--Bổ sung điều kiện cờ xóa = 0
	SET @sWhere = @sWhere + ' AND ISNULL(HRMT2050.DeleteFlg,0) = 0 '

SET @sSQL = N'
SELECT DISTINCT HRMT2050.APK, HRMT2050.DivisionID, HRMT2050.RecDecisionID, HRMT2050.RecDecisionNo, HRMT2050.Description, 
	HRMT2050.DecisionDate, H09.Description AS [Status],
	HRMT2050.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE DivisionID = HRMT2050.DivisionID AND UserID = HRMT2050.CreateUserID) CreateUserID, 
	HRMT2050.CreateDate, 
	HRMT2050.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE DivisionID = HRMT2050.DivisionID AND UserID = HRMT2050.LastModifyUserID) LastModifyUserID, 
	HRMT2050.LastModifyDate
INTO #Temp_HRMP2050
FROM HRMT2050 WITH (NOLOCK)
LEFT JOIN HRMT2051 WITH (NOLOCK) ON HRMT2050.DivisionID = HRMT2051.DivisionID AND HRMT2050.RecDecisionID = HRMT2051.RecDecisionID
LEFT JOIN HRMT2020 WITH (NOLOCK) ON HRMT2051.DivisionID = HRMT2020.DivisionID AND HRMT2051.RecruitPeriodID = HRMT2020.RecruitPeriodID
LEFT JOIN OOT9000 O09 WITH (NOLOCK) ON O09.DivisionID = HRMT2050.DivisionID AND O09.APK = HRMT2050.APKMaster 
LEFT JOIN HT0099 H09 WITH (NOLOCK) ON HRMT2051.Status = H09.ID AND H09.CodeMaster = ''Status''
WHERE '+@sWhere +'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, #Temp_HRMP2050.*
FROM #Temp_HRMP2050
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY

DROP TABLE #Temp_HRMP2050'

PRINT(@sSQL)
EXEC (@sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
