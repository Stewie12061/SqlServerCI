IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2134]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2134]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load đổ nguồn kế thừa lịch đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 25/09/2017
---Modified by Đình Ly on 02/06/2021: Load thêm trường dữ liệu cho màn hình chọn Lịch đào tạo.
---Modified by Tiến Sỹ on 18/07/2023: Hiển thị duy nhất
----Võ Dương Updated on 25/07/2023 - Bổ sung điều kiện lọc lấy ra lịch đào tạo chưa có kết quả
---Modified by Thu Hà on 28/09/2023:Fix lỗi không hiển thị tên đối tác đào tạo đối với "hình thức đào tạo nội bộ" 
---- <Example>
---- exec HRMP2134 @DivisionID=N'BBA-SI',@UserID=N'ADMIN',@PageNumber=1,@PageSize=25,@SearchTxt=N''
---- 

CREATE PROCEDURE [dbo].[HRMP2134]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@SearchTxt NVARCHAR(500)
)
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = '',
        @TotalRow NVARCHAR(50) = '',
		@OrderBy NVARCHAR(500) = 'CreateDate'       
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 

IF ISNULL(@SearchTxt,'') <> ''
BEGIN
	SET @sWhere = '
	AND (HRMT2100.TrainingScheduleID LIKE N''%' + @SearchTxt + '%'' OR HRMT2100.TrainingCourseID LIKE N''%' + @SearchTxt + '%'')'	
END
        
SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow, *
FROM
(
	SELECT DISTINCT HRMT2100.TrainingScheduleID
		, HRMT2100.TrainingCourseID
		, HRMT2100.TrainingFieldID
		, HRMT1040.TrainingFieldName
		, HRMT1050.TrainingType AS TrainingTypeID 
		, HT0099.Description AS TrainingTypeName
		, HRMT2100.AssignedToUserID
		, AT1103.FullName AS AssignedToUserName
		, AT1202.ObjectID
		--, AT1202.ObjectName
		,CASE
        WHEN HRMT1050.ObjectID = AT1103.EmployeeID THEN AT1103.FullName
        WHEN HRMT1050.ObjectID = AT1202.ObjectID THEN AT1202.ObjectName
		END AS ObjectName
		, HRMT2100.Address
		, HRMT2100.FromDate
		, HRMT2100.ToDate
		, HRMT2100.ScheduleAmount
		, HRMT2100.Description3 AS Description
		, HRMT2100.CreateDate
	FROM HRMT2100 WITH (NOLOCK)
	LEFT JOIN HRMT2120 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2120.DivisionID AND HRMT2100.TrainingScheduleID = HRMT2120.TrainingScheduleID
		LEFT JOIN HRMT1050 WITH (NOLOCK) ON HRMT1050.TrainingCourseID = HRMT2100.TrainingCourseID 
		LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND HT0099.CodeMaster = ''TrainingType''
		LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2100.TrainingFieldID
		LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2100.AssignedToUserID 
		LEFT JOIN AT1405 WITH (NOLOCK) ON HRMT1050.CreateUserID = AT1405.UserID AND AT1405.DivisionID IN ('''+@DivisionID+''', ''@@@'')
		--LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2100.AssignedToUserID AND   AT1103.EmployeeID =HRMT1050.ObjectID
		LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID
		LEFT JOIN HRMT2130 WITH (NOLOCK) ON HRMT2130.DivisionID = HRMT2100.DivisionID AND HRMT2130.TrainingScheduleID = HRMT2100.TrainingScheduleID
	WHERE 
	HRMT2100.DivisionID = ''' + @DivisionID + ''' AND 
	HRMT2120.TrainingScheduleID IS NULL OR HRMT2130.DivisionID IS NULL '+ @sWhere +'
) A
ORDER BY ' + @OrderBy + '
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'

print (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
