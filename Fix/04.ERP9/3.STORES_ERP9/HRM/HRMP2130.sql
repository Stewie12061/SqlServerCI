IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2130]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2130]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form HRF2130: Danh mục ghi nhận chi phí
-- <Param>
----
-- <Return>
----
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 25/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Modified on 28/08/2020 by Trọng Kiên: Fix load lịch đào tạo
----Modified on 02/06/2021 by Đình Ly: Load dữ liệu tên lĩnh vực và tên hình thức đào tạo.
----Modified on 22/08/2023 by Anh Phú: fix hiển thị dữ liệu màn hình danh mục -> add parameter: @PeriodList và @IsPeriod.
----Modified on 22/08/2023 by Anh Phú: Cập nhật sắp xếp giảm dần theo mã ghi nhận chi phí
----Modified on 08/09/2023 by Võ Dương: Bổ sung lọc màn hình danh mục
-- <Example>
---- 
/*-- <Example>
	HRMP2130 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@SearchTxt=NULL,@TrainingFieldID=NULL,@TrainingType=NULL,@FromDate='2016-01-01',@ToDate='2018-01-01'
----*/

CREATE PROCEDURE [dbo].[HRMP2130]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @SearchTxt NVARCHAR(500),
	 @TrainingScheduleID NVARCHAR(50),
	 @TrainingCostID NVARCHAR(50),
	 @AssignedToUserID NVARCHAR(50),
	 @TrainingFieldID NVARCHAR(50),
	 @TrainingType NVARCHAR(50),
	 @CostAmount INT,
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ConditionTrainingCostID NVARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @IsPeriod VARCHAR
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'TrainingCostID DESC,CreateDate',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
       
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	HRMT2130.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = '
	HRMT2130.DivisionID = '''+@DivisionID+''''

IF  @IsSearch = 1
BEGIN
	IF ISNULL(@SearchTxt,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND (HRMT2130.TrainingCostID LIKE N''%' + @SearchTxt + '%'' OR HRMT2130.TrainingScheduleID LIKE N''%' + @SearchTxt + '%'')'
	END
	IF ISNULL(@TrainingScheduleID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2130.TrainingScheduleID LIKE N''%' + @TrainingScheduleID + '%'''
	END
	IF ISNULL(@TrainingCostID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2130.TrainingCostID LIKE N''%' + @TrainingCostID + '%'''
	END
	IF ISNULL(@SearchTxt,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND (HRMT2130.TrainingCostID LIKE N''%' + @SearchTxt + '%'' OR HRMT2130.TrainingScheduleID LIKE N''%' + @SearchTxt + '%'')'
	END
	IF ISNULL(@AssignedToUserID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND (HRMT2130.AssignedToUserID LIKE N''%' + @AssignedToUserID + '%'' OR (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2130.AssignedToUserID) LIKE N''%' + @AssignedToUserID + '%'')'
	END
	IF ISNULL(@TrainingFieldID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2100.TrainingFieldID LIKE N''%' + @TrainingFieldID + '%'' OR HRMT1040.TrainingFieldName LIKE N''%' + @TrainingFieldID + '%'''
	END
	IF ISNULL(@TrainingType,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1050.TrainingType = N''' + @TrainingType + ''''
	END
	IF ISNULL(@CostAmount,'') <> 0
	BEGIN
		SET @sWhere = @sWhere + '
		AND cast(ROUND(HRMT2130.CostAmount,0) as int) = '+ CAST(@CostAmount AS NVARCHAR(50)) +' '
	END
END
	
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) 
	SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2130.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '

IF (@FromDate IS NULL AND @ToDate IS NOT NULL) 
	SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2130.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '

IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) 
	SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2130.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '		

IF ISNULL(@ConditionTrainingCostID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(HRMT2130.CreateUserID,'''') in (N'''+@ConditionTrainingCostID+''' )'

SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT HRMT2130.APK
		, HRMT2130.DivisionID
		, HRMT2130.TrainingCostID
		, HRMT2130.TrainingScheduleID AS TrainingSchedule
		, HRMT2130.CostAmount
		--, HRMT2100.TrainingFieldID
		, HRMT1040.TrainingFieldName AS TrainingFieldID
		--, HRMT1050.TrainingType
		, HT0099.Description AS TrainingType
		, HRMT2130.FromDate
		, HRMT2130.ToDate
		, HRMT2130.AssignedToUserID
		, HRMT2130.CreateUserID
		, HRMT2130.CreateDate
		, HRMT2130.LastModifyUserID
		, HRMT2130.LastModifyDate
		, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2130.AssignedToUserID) AS AssignedToUser
	FROM HRMT2130 WITH (NOLOCK)
		LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2130.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2130.TrainingScheduleID
		LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
		LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID	
		LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
	WHERE '+@sWhere +'
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
