IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2104]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2104]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Đổ nguồn lưới kế thừa đề xuất đào tạo MASTER (Nghiệp vụ lập lịch đào tạo)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 22/09/2017
----Modified by Trọng Kiên on 28/08/2020: Bổ sung dữ liệu trả về (TrainingFieldID)
---- <Example>
	/* 
	 EXEC [HRMP2104] @DivisionID='AS',@UserID='ASOFTADMIN',@FromDate='2016-01-01',@ToDate='2018-01-01',@TrainingFieldID='CNTT',
	@DepartmentID='PB0001', @IsAll = 1, @PageNumber = 1, @PageSize = 25
	*/
---- 

CREATE PROCEDURE [dbo].[HRMP2104]
( 
  @DivisionID AS NVARCHAR(50),
  @UserID AS NVARCHAR(50),
  @FromDate AS DATETIME,
  @ToDate AS DATETIME,  
  @TrainingFieldID AS NVARCHAR(50),
  @DepartmentID AS NVARCHAR(50),
  @IsAll AS NVARCHAR(50),
  @PageNumber INT,
  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX), 
		@TotalRow NVARCHAR(50) = '',
		@sWhere NVARCHAR(MAX) = N'',
		@sOrderBy NVARCHAR(MAX) = N'',
		@sGroupBy NVARCHAR(MAX) = N''

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	

SET @sWhere = @sWhere + ' HRMT2090.DivisionID = ''' + @DivisionID + ''''

IF @TrainingFieldID <> '' SET @sWhere = @sWhere + '
AND HRMT2071.TrainingFieldID  =  ''' + @TrainingFieldID + ''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2090.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2090.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2090.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	
IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + ' AND HRMT2090.DepartmentID LIKE ''%'+@DepartmentID+'%'''

SET @sOrderBy = @sOrderBy + ' HRMT2090.TrainingProposeID'
SET @sGroupBy = @sGroupBy + ' HRMT2090.DivisionID, HRMT2090.TrainingProposeID, HRMT2090.DepartmentID, AT1102.DepartmentName, HRMT2090.Description3, HRMT2090.AssignedToUserID, HRMT2090.CreateDate, HRMT2071.StartDate, HRMT2071.DurationPlan, HRMT2071.TrainingFieldID'

SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@sOrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow,
HRMT2090.DivisionID, HRMT2090.TrainingProposeID, HRMT2090.DepartmentID, HRMT2071.TrainingFieldID,
CASE WHEN HRMT2090.DepartmentID = ''%'' THEN N''Tất cả'' ELSE AT1102.DepartmentName END DepartmentName, HRMT2090.Description3, HRMT2090.AssignedToUserID, HRMT2090.CreateDate,
HRMT2071.StartDate AS FromDate, DATEADD(DAY, HRMT2071.DurationPlan, HRMT2071.StartDate) AS ToDate
FROM HRMT2090 WITH (NOLOCK)
LEFT JOIN HRMT2071 WITH (NOLOCK) ON HRMT2071.DivisionID = HRMT2090.DivisionID AND HRMT2071.TransactionID = HRMT2090.InheritID2
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2090.DepartmentID
LEFT JOIN HRMT2100 WITH (NOLOCK) ON HRMT2100.DivisionID = HRMT2090.DivisionID AND HRMT2100.TrainingProposeID = HRMT2090.TrainingProposeID
WHERE '+@sWhere+'

GROUP BY '+@sGroupBy+'
ORDER BY '+@sOrderBy+'
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'


PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
