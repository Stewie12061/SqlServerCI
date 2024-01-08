IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRF1050: Danh mục khóa đào tạo
-- <Param>
-- <Return>
-- <Reference>
-- <History>
----Created by: Hải Long, Date: 07/09/2017.
----Update  by: Thu  Hà,  Date: 04/07/2023 - Bổ sung lọc theo kỳ
--						  Date: 19/07/2023 -Select tên nhân viên  để load Grid Form HRF1050
----Update  by: Võ Dương, Date: 04/07/2023
----Update  by: Võ Dương, Date: 22/08/2023
----Update  by: Thu Hà,   Date: 06/09/2023 - Cập nhật sắp xếp giảm dần theo mã khóa đào tạo
----Update  by: Thu Hà,   Date: 16/10/2023 - Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
/*-- <Example>
	HRMP1050 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@TrainingCourseID=NULL,@Disabled=0,@TrainingFieldID=NULL,@TrainingType=NULL
----*/

CREATE PROCEDURE [dbo].[HRMP1050]
( 
	 @DivisionID NVARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID NVARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @TrainingCourseID NVARCHAR(500),
	 @Disabled NVARCHAR(1),
	 @TrainingFieldID NVARCHAR(50),
	 @TrainingType NVARCHAR(50),
	 @FromDate DATETIME ,
	 @ToDate DATETIME ,
	 @PeriodList VARCHAR(MAX) = '',
	 @ObjectName NVARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'TrainingCourseID DESC',
        @TotalRow NVARCHAR(50) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

    SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
    
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	HRMT1050.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
ELSE 
	SET @sWhere = '
	HRMT1050.DivisionID IN ('''+@DivisionID+''', ''@@@'')'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
IF @IsSearch = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1050.CreateDate >= ''' + @FromDateText + '''
											OR HRMT1050.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1050.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT1050.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT1050.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END

IF  @IsSearch = 1 AND ISNULL(@PeriodList, '') != ''
BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT1050.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
END

	IF ISNULL(@TrainingCourseID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1050.TrainingCourseID LIKE N''%' + @TrainingCourseID + '%'''
	END
	
	IF ISNULL(@Disabled,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT1050.Disabled = ' + @Disabled
	END
	
	IF ISNULL(@TrainingFieldID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1050.TrainingFieldID = ''' + @TrainingFieldID + ''''
	END
	IF ISNULL(@TrainingType,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1050.TrainingType = ''' + @TrainingType + ''''
	END
	IF ISNULL(@ObjectName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND (
        (TrainingType = 1 AND AT1202.ObjectName LIKE N''%'+@ObjectName+'%'')
        OR
        (TrainingType = 2 AND EXISTS (SELECT 1 FROM AT1405 WHERE HRMT1050.ObjectID = AT1405.UserID AND UserName LIKE N''%'+@ObjectName+'%''))
		) '
	END
	--Bổ sung điều kiện cờ xóa = 0
	SET @sWhere = @sWhere + ' AND ISNULL(HRMT1050.DeleteFlg,0) = 0 '
SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT
    HRMT1050.APK,
    HRMT1050.DivisionID,
    TrainingCourseID,
    HRMT1050.TrainingFieldID,
    HRMT1040.TrainingFieldName,
    TrainingType,
    HT0099.Description AS TrainingTypeName,
    HRMT1050.ObjectID,
    CASE
        WHEN TrainingType = 1 THEN AT1202.ObjectName
        ELSE (SELECT TOP(1) UserName FROM AT1405 where HRMT1050.ObjectID = AT1405.UserID)
    END AS ObjectName,
    HRMT1050.Address,
    HRMT1050.Description,
    HRMT1050.Disabled,
    HRMT1050.IsCommon,
    AT1405.UserName AS CreateUserID,
    HRMT1050.CreateDate,
    HRMT1050.LastModifyUserID,
    HRMT1050.LastModifyDate

	FROM HRMT1050 WITH (NOLOCK)
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT1050.TrainingFieldID
	LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND CodeMaster = ''TrainingType''
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID

	LEFT JOIN AT1405 WITH (NOLOCK) ON HRMT1050.CreateUserID = AT1405.UserID AND AT1405.DivisionID IN ('''+@DivisionID+''', ''@@@'')
	WHERE '+@sWhere +'
) A
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
