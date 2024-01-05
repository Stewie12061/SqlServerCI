IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Form HRF1040: Danh mục lĩnh vực đào tạo
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Hải Long,  Date: 07/09/2017
----Update  by: Thu Hà,    Date: 05/07/2023 - Bổ sung lọc theo kỳ
----Update  by: Thu Hà,    Date: 22/08/2023 - Bổ sung dữ liệu lọc (TrainingFieldName,CreateUserID,IsCommon)
----Update  by: Thu Hà,    Date: 06/09/2023 - Cập nhật sắp xếp giảm dần theo mã lĩnh vực đào tạo
----Update  by: Võ Dương,  Date: 08/09/2023 - Cập nhật lọc theo "Tên lĩnh vực đào tạo"
-- <Example>
/*-- <Example>
	HRMP1040 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@TrainingFieldID=NULL,@Disabled=0
----*/

CREATE PROCEDURE [dbo].[HRMP1040]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @TrainingFieldID NVARCHAR(500),
	 @TrainingFieldName NVARCHAR(500),
	 @CreateUserID NVARCHAR(500),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @FromDate DATETIME ,
	 @ToDate DATETIME ,
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500) = 'TrainingFieldID DESC',
        @TotalRow NVARCHAR(50) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

--SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
--SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + '23:59:59'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111)

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + 'AND
	HRMT1040.DivisionID IN ('''+@DivisionList+''',''@@@'')'
ELSE 
	SET @sWhere =@sWhere + 'AND
	HRMT1040.DivisionID IN ('''+@DivisionID+''', ''@@@'')'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1040.CreateDate >= ''' + @FromDateText + '''
											OR HRMT1040.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1040.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT1040.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1040.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END


IF  @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT1040.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
END

	
	IF ISNULL(@TrainingFieldID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND (HRMT1040.TrainingFieldID LIKE N''%' + @TrainingFieldID + '%'' OR HRMT1040.TrainingFieldName LIKE N''%' + @TrainingFieldID + '%'')'
	END

	 IF ISNULL(@TrainingFieldName,'') <> ''
	SET @sWhere = @sWhere + 'AND HRMT1040.TrainingFieldName LIKE N''%'+@TrainingFieldName+'%'' '

	 IF ISNULL(@CreateUserID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT1040.CreateUserID LIKE ''%'+@CreateUserID+'%'' '

	--IF @Disabled IS NOT NULL
	--BEGIN
	--	SET @sWhere = @sWhere + N'
	--	AND HRMT1040.Disabled = ' + @Disabled
	--END 

	IF ISNULL(@Disabled,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT1040.Disabled = ' + @Disabled
	END
		IF ISNULL(@IsCommon,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT1040.IsCommon = ' + @IsCommon
	END

SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT HRMT1040.APK, HRMT1040.DivisionID, HRMT1040.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT1040.Description,
	HRMT1040.Disabled, HRMT1040.IsCommon, AT1405.UserName AS CreateUserID, HRMT1040.CreateDate, HRMT1040.LastModifyUserID, HRMT1040.LastModifyDate
	FROM HRMT1040 WITH (NOLOCK)
	LEFT JOIN AT1405 WITH (NOLOCK) ON HRMT1040.CreateUserID = AT1405.UserID AND AT1405.DivisionID IN ('''+@DivisionID+''', ''@@@'')
	WHERE ISNULL(HRMT1040.DeleteFlg,0) = 0  '+@sWhere +' 
) A 
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO