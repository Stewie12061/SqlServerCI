IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form HRF2000: Kế hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 20/07/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 15/10/2020 by Huỳnh Thử: Cập nhật phân quyền
----Modified on 27/06/2023 by Võ Dương: Cập nhật lọc theo ngày và kì
----Modified on 27/06/2023 by Võ Dương: Cập nhật lọc theo ngày
----Modified on 28/08/2023 by Phương Thảo: Cập nhật load với điều kiện HRMT2000.DeleteFlg = 0
----Modified on 06/09/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo mã kế hoạch tuyển dụng
-- <Example>
---- 
/*-- <Example>
exec HRMP2000 @DivisionID=N'BBA-SI',@DivisionList=N'',
@CheckListPeriodControl=N'06/2023'',''05/2023'',''04/2023'',''03/2023'',''02/2023'',''01/2023',
@IsPeriod=1,@RecruitPlanID=N'',@DepartmentID=N'',@DutyID=N'',@IsSearch=1,@Status=N'',@FromDate=NULL,
@ToDate=NULL,@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,
@ConditionRecruitPlanID=N'ADMIN'',''ANGI-SS001'',''BBA-SELLIN'',''BRVT-SS001'',''HCQ12-SS001'',''MTA1-ASM001'',''NM-NV01'',''NM-NV02'',''NM-NV03'',
''NMT-ASM001'',''QUNG-SS001'',''UNASSIGNED'',''VP-ADMIN'',''VP-KT04'',''VP-KT05'',''VP-KT06'',''VP-SO01'',''VP-SO02'',''VP-SO03'',''VP-SO04'',''VP-SO05'',''VP-SO06'',''VP-SO07'',''VP-SO08'',''VP-SO09'',''VP-SO10'',''VP-TGD'
----*/

CREATE PROCEDURE HRMP2000
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @CheckListPeriodControl VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @RecruitPlanID VARCHAR(50),
	 @DepartmentID VARCHAR(50),
	 @DutyID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @Status VARCHAR(1),
	 --@IsPeriod TINYINT,
	 @ConditionRecruitPlanID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)=N'',
        @sWhere NVARCHAR(MAX)=N'',
		@sJoin NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@RecruitPlanListConvert NVARCHAR(MAX)=N'',
        @TotalRow NVARCHAR(50)=N''


SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111)

SET @OrderBy = 'HRMT2000.RecruitPlanID DESC,HRMT2000.DepartmentID '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' HRMT2000.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' HRMT2000.DivisionID = '''+@DivisionID+''' '
	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF (@IsSearch = 0)
	BEGIN
			IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (''' + @FromDateText + '''BETWEEN HRMT2000.FromDate   AND HRMT2000.ToDate )'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (''' + @ToDateText + '''BETWEEN HRMT2000.FromDate   AND HRMT2000.ToDate ) '
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND ((''' + @FromDateText + ''' BETWEEN HRMT2000.FromDate AND HRMT2000.ToDate ) OR 
			(''' + @ToDateText + ''' BETWEEN HRMT2000.FromDate   AND HRMT2000.ToDate ) OR 
			( HRMT2000.FromDate BETWEEN'' ' + @FromDateText + '''  AND '' ' +@ToDateText + ''' ) OR 
			( HRMT2000.ToDate BETWEEN'' ' + @FromDateText + '''  AND '' ' +@ToDateText + '''  )) '
		END
	END
ELSE
IF  @IsSearch = 1 AND ISNULL(@CheckListPeriodControl, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2000.FromDate, ''MM/yyyy'')) IN ( ''' + @CheckListPeriodControl + ''') '
	END

	
	IF ISNULL(@RecruitPlanID,'') <> ''
	SET @sWhere = @sWhere + 'AND HRMT2000.RecruitPlanID LIKE ''%'+@RecruitPlanID+'%'' '
	
	IF ISNULL(@DepartmentID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2000.DepartmentID LIKE N''%'+@DepartmentID+'%'' '

	IF ISNULL(@DutyID,'') <> '' 
	BEGIN
		SET @sWhere = @sWhere + 'AND HRMT2001.DutyID LIKE ''%'+@DutyID+'%'' '
		SET @sJoin = ''
	END

	IF ISNULL(@Status,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2000.Status LIKE ''%'+@Status+'%'' '

	IF Isnull(@ConditionRecruitPlanID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2000.CreateUserID,'''') in (N'''+@ConditionRecruitPlanID+''','''+@UserID+''' )'
		

SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT2000.APK, HRMT2000.DivisionID, HRMT2000.RecruitPlanID, HRMT2000.Description,HRMT2000.DepartmentID, AT1102.DepartmentName AS DepartmentID,
	HRMT2000.FromDate, HRMT2000.ToDate,
	HRMT2000.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2000.CreateUserID) CreateUserID,
	HRMT2000.CreateDate, 
	HRMT2000.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2000.LastModifyUserID) LastModifyUserID, 
	HRMT2000.LastModifyDate,
	HRMT2000.Status, HT0099.Description AS StatusName   

FROM HRMT2000 WITH (NOLOCK)
LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND HRMT2000.RecruitPlanID = HRMT2001.RecruitPlanID
LEFT JOIN AT1102 WITH (NOLOCK) ON HRMT2000.DepartmentID = AT1102.DepartmentID
LEFT JOIN HT0099 WITH (NOLOCK) ON HRMT2000.Status = HT0099.ID AND HT0099.CodeMaster = ''Status'' '+@sJoin+'
    WHERE ISNULL(HRMT2000.DeleteFlg,0) = 0 AND '+@sWhere+'
	GROUP BY HRMT2000.APK,HRMT2000.DepartmentID,HRMT2000.RecruitPlanID,HRMT2000.DivisionID,HRMT2000.Description,AT1102.DepartmentName,HRMT2000.FromDate,HRMT2000.ToDate,HRMT2000.CreateDate,HRMT2000.CreateUserID,HRMT2000.LastModifyDate,HRMT2000.LastModifyUserID,HRMT2000.Status,HT0099.Description
	ORDER BY '+@OrderBy+'

	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
