IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2120]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid Form HRF2120: Danh mục ghi nhận kết quả
-- <Param>
---- IsPrint = 0 - Load Grid Form HRF2120: Danh mục ghi nhận kết quả
---- IsPrint = 1 - Load Data phiếu in
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 25/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
----Võ Dương Updated on 25/07/2023 - Bổ sung load data phiếu in
----Modified on 06/09/2023 by Thu Hà: Cập nhật sắp xếp giảm dần theo mã ghi nhận kết quả
----Modified on 26/09/2023 by Thu Hà: Cập nhật bổ sung điều kiện lọc
-- <Example>
---- 
/*-- <Example>
	HRMP2120 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@SearchTxt=NULL,@TrainingFieldID=NULL,@TrainingType=NULL,@FromDate='2016-01-01',@ToDate='2018-01-01'
----*/

CREATE PROCEDURE [dbo].[HRMP2120]
( 
	 @IsPrint VARCHAR,
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @SearchTxt NVARCHAR(500),
	 @TrainingFieldID NVARCHAR(50),
	 @TrainingResultID NVARCHAR(50),
	 @TrainingScheduleID  NVARCHAR(50),
	 @TrainingCourseID NVARCHAR(50),
	 @AssignedToUserName NVARCHAR(50),
	 @ObjectName NVARCHAR(50),
	 @TrainingType NVARCHAR(50),	
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ConditionTrainingResultID VARCHAR(MAX),
	 @PeriodList VARCHAR(MAX),
	 @IsPeriod TINYINT,
	 @ResultType VARCHAR,
	 @IsCheckAll TINYINT,
	 @TrainingResultList NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500) = 'TrainingResultID DESC,CreateDate',
        @TotalRow NVARCHAR(50) = '',
        @DatePeriod NVARCHAR(MAX) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@TrainingResultListConvert NVARCHAR(MAX)=N''
--DIEUKIEN CHUNG
	
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111)      
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + '
	AND HRMT2120.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + '
	AND HRMT2120.DivisionID = '''+@DivisionID+''''
	--Mã ghi nhận kết quả
	IF ISNULL(@TrainingResultID,'') <> ''
		SET @sWhere = @sWhere + '
		AND HRMT2120.TrainingResultID = '''+@TrainingResultID+''' ' 
		---LIKE ''' + @TrainingResultID + ''''		

--IF @TrainingResultList IS NOT NULL
IF Isnull(@TrainingResultList, '') != ''
SET @sWhere = @sWhere + ' AND  ISNULL(HRMT2120.TrainingScheduleID,'''') IN (N''' + @TrainingResultList +''') '
---HRMT2120.TrainingResultID

IF  @IsSearch = 1
BEGIN
	IF ISNULL(@SearchTxt,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND (HRMT2120.TrainingCostID LIKE N''%' + @SearchTxt + '%'' OR HRMT2120.TrainingScheduleID LIKE N''%' + @SearchTxt + '%'')'	
	END
	 
	 --Lịch đào tạo
	IF ISNULL(@TrainingScheduleID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2120.TrainingScheduleID LIKE ''' + @TrainingScheduleID + ''''		
	END
	--Mã ghi nhận kết quả
	IF ISNULL(@TrainingResultID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2120.TrainingResultID LIKE ''' + @TrainingResultID + ''''		
	END
	--Khóa đào tạo
	IF ISNULL(@TrainingCourseID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1050.TrainingCourseID LIKE ''' + @TrainingCourseID + ''''		
	END
	--Lĩnh vực đào tạo
	IF ISNULL(@TrainingFieldID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2100.TrainingFieldID LIKE ''' + @TrainingFieldID + ''''		
	END
	--người phụ trách
	IF ISNULL(@AssignedToUserName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND AT1103.FullName LIKE N''%'+@AssignedToUserName+'%'''
	END

	--Đối tác đào tạo
	IF ISNULL(@ObjectName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND AT1202.ObjectName LIKE N''%'+@ObjectName+'%'''
	END
	--Hình thức đào tạo
	IF ISNULL(@TrainingType,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT1050.TrainingType LIKE N''' + @TrainingType + ''''

	END
	--Lọc theo ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2120.CreateDate >= ''' + @FromDateText + '''
											OR HRMT2120.CreateDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2120.CreateDate <= ''' + @ToDateText + ''' 
											OR HRMT2120.CreateDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (HRMT2120.CreateDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	END	
	-- Lọc theo kỳ
	ELSE
	BEGIN
		--SET @sWhere = @sWhere + ' AND (SELECT FORMAT(ISNULL(HRMT2120.CreateDate,HRMT2120.CreateDate), ''MM/yyyy'')) IN (' + @PeriodList + ') '
		--SET @DatePeriod =N'Theo kỳ: '+ REPLACE(@PeriodList,'''','')
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(HRMT2120.CreateDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END
END

IF Isnull(@ConditionTrainingResultID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2120.CreateUserID,'''') in (N'''+@ConditionTrainingResultID+''' )'

--IF @ResultType IS NOT NULL
--	SET @sWhere = @sWhere + ' AND ISNULL(HRMT2120.ResultTypeID,'''') = '''+ @ResultType+''''

	IF ISNULL(@ResultType,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + N'
		AND HRMT2120.@ResultType = ' + @ResultType
	END
-- XY LY QUERY
IF(@IsPrint = 0)   
BEGIN   
SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT 
	HRMT2120.APK,
	HRMT2120.DivisionID,
	HRMT2120.TrainingResultID,
	--HRMT2120.TrainingScheduleID AS TrainingScheduleName,
	--HRMT2100.TrainingScheduleName AS TrainingScheduleName,
	HRMT2120.TrainingScheduleID,
	HRMT2100.TrainingCourseID ,
	HRMT2100.TrainingFieldID,
	HRMT1040.TrainingFieldName,
	HRMT1050.TrainingType,
	HRMT1050.Address,
	HT0099.Description AS TrainingTypeName,
	HRMT2120.AssignedToUserID,
	A1.FullName AS AssignedToUserName,
	HRMT1050.ObjectID,
	IIF(ISNULL(AT1202.ObjectName, '''') != '''', AT1202.ObjectName, A2.FullName) AS ObjectName,
	HRMT2120.ResultTypeID,
	HRMV2120.ResultTypeName,
	HRMT2120.CreateUserID,
	HRMT2120.CreateDate,
	HRMT2120.Description1,
	HRMT2120.Description2
	FROM HRMT2120 WITH (NOLOCK)
	LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2120.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2120.TrainingScheduleID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON  HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
	LEFT JOIN AT1103 A1  WITH (NOLOCK) ON A1.EmployeeID = HRMT2120.AssignedToUserID 
	LEFT JOIN AT1103 A2  WITH (NOLOCK) ON A2.EmployeeID = HRMT1050.ObjectID 
	LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
	LEFT JOIN HRMV2120 ON HRMV2120.ResultTypeID = HRMT2120.ResultTypeID
	WHERE ISNULL(HRMT2120.DeleteFlg,0) = 0  '+@sWhere +'
) A 	
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'
END
ELSE
BEGIN
--	N'''+@DatePeriod+''' AS DatePeriod, 

SET @sSQL = N'
	SELECT 
	AT1101.DivisionName,
	HRMT2120.TrainingResultID,
	HRMT2120.TrainingScheduleID,
	HRMT2100.TrainingCourseID,
	HT0099.Description AS TrainingTypeName,
	HRMT1040.TrainingFieldName,
	AT1202.ObjectName,
	HRMT1050.Address,
	(SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2120.AssignedToUserID) AS AssignedToUserName,
	HRMV2120.ResultTypeName,
	HRMT2120.Description1,
	HRMT2120.Description2,

	HRMT2121.EmployeeID, 
	HT1400.LastName + '' '' + HT1400.MiddleName + '' '' + HT1400.FirstName AS EmployeeName,
	AT1102.DepartmentName,
	HT1102.DutyName,
	HRMV2121.StatusTypeName,
	HRMV2122.ResultName,
	HRMT2121.Notes

	FROM HRMT2120 WITH (NOLOCK)
	LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2120.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2120.TrainingScheduleID
	LEFT JOIN HRMT2121 WITH (NOLOCK) ON HRMT2120.TrainingResultID = HRMT2121.TrainingResultID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID	
	LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID	
	LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
	LEFT JOIN HRMV2120 ON HRMV2120.ResultTypeID = HRMT2120.ResultTypeID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
	LEFT JOIN HRMV2121 ON HRMV2121.StatusTypeID = HRMT2121.StatusTypeID
	LEFT JOIN HRMV2122 ON HRMV2122.ResultID = HRMT2121.ResultID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.EmployeeID = HRMT2121.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = HT1400.DivisionID AND HT1403.EmployeeID = HT1400.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID 
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2121.DepartmentID 
	LEFT JOIN AT1101 WITH (NOLOCK) ON HRMT2120.DivisionID = AT1101.DivisionID
	WHERE '+@sWhere +'
	GROUP BY 
	HRMT2120.TrainingScheduleID,
	AT1101.DivisionName,
	HRMT2120.TrainingResultID,
	HRMT2100.TrainingCourseID,
	HT0099.Description,
	HRMT1040.TrainingFieldName,
	AT1202.ObjectName,
	HRMT1050.Address,
	HRMT2120.AssignedToUserID,
	HRMV2120.ResultTypeName,
	HRMT2120.Description1,
	HRMT2120.Description2,
	HRMT2121.EmployeeID,
	HT1400.LastName,
	HT1400.MiddleName,
	HT1400.FirstName,
	HT1102.DutyName,
	AT1102.DepartmentName,
	HRMV2121.StatusTypeName,
	HRMV2122.ResultName,
	HRMT2121.Notes,
	HRMT2120.CreateDate
	ORDER BY HRMT2120.CreateDate'
END
PRINT(@sSQL)
EXEC (@sSQL)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
