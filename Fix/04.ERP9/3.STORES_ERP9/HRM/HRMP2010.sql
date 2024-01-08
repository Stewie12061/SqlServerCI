IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form HRF2010: Yêu cầu tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy on 10/08/2017
----Update  by: Thu Hà,  Date: 29/06/2023 - Bổ sung lọc theo thời gian
----Update  by: Thu Hà,  Date: 07/08/2023 - Thay đổi vị trí orderBy để sắp xếp thứ tự theo mã yêu cầu công việc
----Update  by: Thu Hà,  Date: 09/09/2023 - Cập nhật kiểu dữ liệu NVARCHAR cho RecruitRequireName
----Update  by: Phương Thảo, Date: 12/03/2023 -[2023/09/IS/0029] Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
---- 
/*-- <Example>
	HRMP2010 @DivisionID='MK',@DivisionList='MK'',''MK1',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@RecruitRequireID=NULL,@DutyID='LD',@Disabled=0, @TxtSearch=NULL

	EXEC HRMP2010 @DivisionID,@DivisionList, @UserID,@PageNumber,@PageSize,@IsSearch, @RecruitRequireID, @DutyID, @Disabled
----*/

CREATE PROCEDURE HRMP2010
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @RecruitRequireID VARCHAR(50),
	 @RecruitRequireName NVARCHAR(50),
	 @DutyID VARCHAR(50),
	 @Disabled VARCHAR(1),
	 @TxtSearch NVARCHAR(250),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
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

SET @OrderBy = 'HRMT2010.RecruitRequireID DESC,HRMT2010.DutyID '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
BEGIN
	IF @DivisionList <> '%'
	SET @sWhere = @sWhere + ' HRMT2010.DivisionID IN ('''+@DivisionList+''', ''@@@'')'

END
ELSE SET @sWhere = @sWhere + ' HRMT2010.DivisionID = '''+@DivisionID+''''
-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2010.CreateDate >= ''' + @FromDateText + '''
											OR HRMT2010.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2010.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT2010.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2010.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
 IF @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2010.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
	
	IF ISNULL(@RecruitRequireID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2010.RecruitRequireID LIKE ''%'+@RecruitRequireID+'%'' '

	IF ISNULL(@RecruitRequireName,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2010.RecruitRequireName LIKE N''%'+@RecruitRequireName+'%'' '

	IF ISNULL(@DutyID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT2010.DutyID LIKE ''%'+@DutyID+'%'' '

	IF ISNULL(@Disabled,'') <> '' 
	SET @sWhere = @sWhere + N'AND HRMT2010.Disabled = '+@Disabled+''

--Bổ sung điều kiện cờ xóa = 0
SET @sWhere = @sWhere + ' AND ISNULL(HRMT2010.DeleteFlg,0) = 0 '
SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+' ) AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT2010.APK, HRMT2010.DivisionID, HRMT2010.RecruitRequireID, HRMT2010.RecruitRequireName, HRMT2010.DutyID, HT1102.DutyName,
	HRMT2010.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2010.CreateUserID) CreateUserID, HRMT2010.CreateDate, 
	HRMT2010.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2010.LastModifyUserID) LastModifyUserID, HRMT2010.LastModifyDate,
	HRMT2010.Disabled
FROM HRMT2010 WITH (NOLOCK)
LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT2010.DivisionID = HT1102.DivisionID AND HRMT2010.DutyID = HT1102.DutyID
WHERE '+@sWhere +'
AND (ISNULL(HRMT2010.DivisionID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR ISNULL(HRMT2010.RecruitRequireID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR ISNULL(HRMT2010.RecruitRequireName,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%'' 
	OR ISNULL(HRMT2010.DutyID,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	OR ISNULL(HT1102.DutyName,'''') LIKE ''%'+ISNULL(@TxtSearch,'')+'%''
	) 
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
