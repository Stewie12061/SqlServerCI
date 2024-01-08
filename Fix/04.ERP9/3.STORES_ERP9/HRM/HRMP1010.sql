IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form HRF1010: Danh mục hình thức phỏng vấn
-- <Param> 
-- <Return>
-- <Reference>
-- <History>
----Created by: Bảo Thy, Date: 19/07/2017
----Modified on 26/6/2023 by Thu Hà: Bổ dung lọc theo thời gian
----Modified on 06/9/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo mã hình thức phỏng vấn
----Modified on 17/10/2023 by Thu Hà: - Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
/*-- <Example>
	HRMP1010 @DivisionID = 'AS', @DivisionList = NULL, @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsSearch = 1,
	@InterviewTypeID = 'HT0001', @InterviewTypeName = NULL, @DutyID = 'CV001', @Disabled = 0, @IsCommon = 0
	HRMP1010 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @InterviewTypeID, @InterviewTypeName, @DutyID, @Disabled, @IsCommon
----*/

CREATE PROCEDURE HRMP1010
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @InterviewTypeID VARCHAR(50),
	 @InterviewTypeName NVARCHAR(1000),
	 @DutyID VARCHAR(50),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@AllDuty NVARCHAR(20) = N'Tất cả'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SET @OrderBy = 'HRMT1010.InterviewTypeID DESC, HRMT1010.DutyID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

	IF Isnull(@DivisionList, '') <> ''
		BEGIN
			IF @DivisionList <> '%'
			SET @sWhere = @sWhere + ' HRMT1010.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
		END
	ELSE SET @sWhere = @sWhere + ' HRMT1010.DivisionID IN ('''+@DivisionID+''', ''@@@'') '
	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1010.CreateDate >= ''' + @FromDateText + '''
											OR HRMT1010.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1010.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT1010.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1010.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT1010.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

	IF ISNULL(@InterviewTypeID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT1010.InterviewTypeID LIKE ''%'+@InterviewTypeID+'%'' '

	IF ISNULL(@InterviewTypeName,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT1010.InterviewTypeName LIKE N''%'+@InterviewTypeName+'%'' '

	IF ISNULL(@DutyID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT1010.DutyID LIKE ''%'+@DutyID+'%'' '

	IF ISNULL(@Disabled, '') <> '' 
	SET @sWhere = @sWhere + N'AND HRMT1010.Disabled = '+@Disabled+''

	IF ISNULL(@IsCommon,'') <> ''
	SET @sWhere = @sWhere + N'AND HRMT1010.IsCommon = '+@IsCommon+''
	--Bổ sung điều kiện cờ xóa = 0
	SET @sWhere = @sWhere + ' AND ISNULL(HRMT1010.DeleteFlg,0) = 0 '

	SET @sSQL = '
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
		HRMT1010.APK, 
		HRMT1010.DivisionID, 
		HRMT1010.InterviewTypeID, 
		HRMT1010.InterviewTypeName, 
		CASE WHEN HRMT1010.DutyID = ''%'' THEN N'''+@AllDuty+'''
		ELSE HT1102.DutyName
		END AS DutyName, 
		HRMT1010.DutyID, 
		HRMT1010.Note, 
		HRMT1010.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1010.CreateUserID) CreateUserID, 
		HRMT1010.CreateDate, 
		HRMT1010.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1010.LastModifyUserID) LastModifyUserID, 
		HRMT1010.LastModifyDate,
		HRMT1010.Disabled, 
		HRMT1010.IsCommon    
		FROM HRMT1010 WITH (NOLOCK)
		LEFT JOIN HT1102 WITH (NOLOCK) ON HRMT1010.DutyID = HT1102.DutyID AND HRMT1010.DivisionID IN ('''+@DivisionID+''', ''@@@'')
		WHERE '+@sWhere +'
		ORDER BY '+@OrderBy+'

		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
	

EXEC (@sSQL)
PRINT(@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
