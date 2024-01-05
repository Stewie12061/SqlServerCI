IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRF2080: Danh mục yêu cầu đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 18/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 13/07/2023 by Tiến Sỹ:  Cập nhật lọc và lấy ra phòng ban theo chuổi
----Modified on 23/08/2023 by Võ Dương: Cập nhật lọc theo người phụ trách
----Modified on 06/09/2023 by Thu Hà:   Cập nhật sắp xếp giảm dần theo mã yêu cầu đào tạo
----Update  by: Minh Trí, Date: 17/10/2023 -[2023/10/IS/0014] Cập nhật bổ sung điều kiện lọc ( DeleteFlg = 0 )
-- <Example>
---- 
/*-- <Example>
	HRMP2080 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@TrainingRequestID=NULL,@DepartmentID=NULL,@TrainingFieldID=NULL
----*/
CREATE PROCEDURE [dbo].[HRMP2080]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @TrainingRequestID NVARCHAR(500),
	 @DepartmentID NVARCHAR(50),
	 @TrainingFieldID NVARCHAR(50),
	 @ConditionTrainingRequestID VARCHAR(MAX),
	 @FromDate DATETIME = NULL,
	 @ToDate DATETIME = NULL,
	 @IsPeriod INT = 0,
	 @AssignedToUser NVARCHAR(MAX),
	 @PeriodList VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'TrainingRequestID DESC,CreateDate',
        @TotalRow NVARCHAR(50) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'


IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	
       
    
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	HRMT2080.DivisionID IN ('''+@DivisionList+''', ''@@@'')'
ELSE 
	SET @sWhere = '
	HRMT2080.DivisionID  IN ('''+@DivisionID+''', ''@@@'')'

IF  @IsSearch = 1
BEGIN
	IF ISNULL(@TrainingRequestID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2080.TrainingRequestID LIKE N''%' + @TrainingRequestID + '%'''		
	END
	 
	IF ISNULL(@DepartmentID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2080.DepartmentID LIKE (''%' + @DepartmentID + '%'')'		
	END
	
	IF ISNULL(@TrainingFieldID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2080.TrainingFieldID = N''' + @TrainingFieldID + ''''		
	END	

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
		BEGIN
			IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
				BEGIN
					SET @sWhere = @sWhere + ' AND (HRMT2080.CreateDate >= ''' + @FromDateText + '''
													OR M.CreateDate >= ''' + @FromDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (HRMT2080.CreateDate <= ''' + @ToDateText + ''' 
													OR M.CreateDate <= ''' + @ToDateText + ''')'
				END
			ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (HRMT2080.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				END
		END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2080.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		END
	IF Isnull(@AssignedToUser, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(AT1103.fullname,'''') LIKE N''%'+@AssignedToUser+'%'' '
END

IF Isnull(@ConditionTrainingRequestID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2080.CreateUserID,'''') in (N'''+@ConditionTrainingRequestID+''' )'
--Bổ sung điều kiện cờ xóa = 0
SET @sWhere = @sWhere + ' AND ISNULL(HRMT2080.DeleteFlg,0) = 0 '
SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
FROM
(
	SELECT HRMT2080.APK, HRMT2080.DivisionID, 
	HRMT2080.TrainingRequestID, HRMT2080.DepartmentID,AT1103.fullname AS AssignedToUserName,
	STUFF(( SELECT '','' + AT1102.DepartmentName
								FROM   AT1102 WITH (NOLOCK) 
								WHERE   AT1102.DepartmentID IN (SELECT Value FROM dbo.StringSplit(HRMT2080.DepartmentID,'',''))
								ORDER BY AT1102.DepartmentID
								FOR XML PATH('''')), 1, 1, '''') AS DepartmentName,
								HRMT2080.TrainingFieldID, HRMT1040.TrainingFieldName,
	NumberEmployee, TrainingFromDate, TrainingToDate, Description1, Description2, AssignedToUserID, N''Đã duyệt'' AS IsConfirmName, 
	CASE WHEN EXISTS (SELECT TOP 1 1 FROM HRMT2091 WITH (NOLOCK) WHERE HRMT2091.DivisionID = HRMT2080.DivisionID AND HRMT2091.ID = HRMT2080.TrainingRequestID 
	AND HRMT2091.InheritTableID = ''HRMT2080'') THEN N''Đã được lập đề xuất'' ELSE NULL END StatusName,
	HRMT2080.CreateUserID, HRMT2080.CreateDate, HRMT2080.LastModifyUserID, HRMT2080.LastModifyDate
	FROM HRMT2080 WITH (NOLOCK)
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2080.DepartmentID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2080.TrainingFieldID
	LEFT JOIN AT1103 ON AT1103.employeeID = HRMT2080.AssignedToUserID
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
