IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRF1000: Danh mục nguồn tuyển dụng
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Bảo Thy,   Date: 26/11/2015
----Update  by: Thu Hà,    Date: 28/06/2023 - Bổ dung lọc theo thời gian.
----Update  by: Võ Dương,  Date: 23/08/2023 - Cập nhật chức năng lọc
----Update  by: Thu Hà,    Date: 06/09/2023 - Cập nhật sắp xếp giảm dần theo mã nguồn tuyển dụng
----Update  by: Thu Hà,    Date: 08/09/2023 - Cập nhật bổ sung điều kiện lọc (ResourceName)
----Update  by: Phương Thảo, Date: 12/03/2023 -[2023/09/IS/0029] Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
/*-- <Example>
	HRMP1000 @DivisionID = 'AS', @DivisionList = '', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @IsSearch = 1, @ResourceID = '', 
	@Disabled = NULL, @IsCommon = NULL
	HRMP1000 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @IsSearch, @ResourceID, @Disabled, @IsCommon
----*/

CREATE PROCEDURE HRMP1000
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT, 
	 @ResourceID VARCHAR(50),
	 @ResourceName NVARCHAR(250),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)= N'',
        @OrderBy NVARCHAR(500)=N'',
        @TotalRow NVARCHAR(50)=N'',
		@LanguageID VARCHAR(50),
		@sSQLLanguage VARCHAR(100)='',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111)          
SET @OrderBy = 'HRMT1000.ResourceID DESC'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF Isnull(@DivisionList, '') <> ''
		BEGIN
			IF @DivisionList <> '%' SET @sWhere = @sWhere + ' HRMT1000.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
		END
	ELSE 
		SET @sWhere = @sWhere + ' HRMT1000.DivisionID in ('''+@DivisionID+''', ''@@@'') '
-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1000.CreateDate >= ''' + @FromDateText + '''
											OR HRMT1000.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1000.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT1000.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1000.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END

ELSE IF @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT1000.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
IF ISNULL(@ResourceID,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT1000.ResourceID LIKE ''%'+@ResourceID+'%'' '

IF ISNULL(@ResourceName,'') <> '' 
	SET @sWhere = @sWhere + 'AND HRMT1000.ResourceName LIKE N''%'+@ResourceName+'%'' '

IF ISNULL(@Disabled,'') <> ''
	SET @sWhere = @sWhere + N'AND HRMT1000.Disabled = '+@Disabled+''

IF ISNULL(@IsCommon,'') <> ''
	SET @sWhere = @sWhere + N'AND HRMT1000.IsCommon = '+@IsCommon+''
--Bổ sung điều kiện cờ xóa = 0
SET @sWhere = @sWhere + ' AND ISNULL(HRMT1000.DeleteFlg,0) = 0 '
SET @sSQL = '
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	HRMT1000.APK, 
	CASE WHEN ISNULL(HRMT1000.IsCommon,0) = 1 then '''' ELSE HRMT1000.DivisionID END AS DivisionID,
	HRMT1000.ResourceID, 
	HRMT1000.ResourceName, 
	HRMT1000.Note,
	HRMT1000.CreateUserID,
	HRMT1000.CreateDate, 
	HRMT1000.LastModifyUserID ,
	HRMT1000.LastModifyDate,
	HRMT1000.Disabled, 
	HRMT1000.IsCommon
	FROM HRMT1000 WITH (NOLOCK)
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
