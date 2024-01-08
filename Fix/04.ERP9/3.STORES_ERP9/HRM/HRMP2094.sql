IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2094]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2094]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Đổ nguồn lưới kế thừa (Nghiệp vụ đề xuất đào tạo)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 19/09/2017
---- <Example>
/*
  EXEC [HRMP2094] @DivisionID='AS',@UserID='ASOFTADMIN',@FromDate='2016-01-01',@ToDate='2018-01-01',@TrainingFieldID='%',@DepartmentID='PB001',@ModeID=1, 
  @PageNumber = 1, @PageSize = 25
*/
---- 

CREATE PROCEDURE [dbo].[HRMP2094]
( 
  @DivisionID AS NVARCHAR(50),
  @UserID AS NVARCHAR(50),
  @FromDate AS DATETIME,
  @ToDate AS DATETIME,  
  @TrainingFieldID AS NVARCHAR(50),
  @DepartmentID AS NVARCHAR(50),
  @ModeID AS NVARCHAR(1), 
  @PageNumber INT,
  @PageSize INT
) 
AS 
DECLARE @sSQL1 NVARCHAR(MAX),
		@sSQL2 NVARCHAR(MAX), 
		@sSQL3 NVARCHAR(MAX), 
		@TotalRow NVARCHAR(50)=N'',
		@sWhere NVARCHAR(MAX) = ''

SET @TotalRow = 'COUNT(*) OVER ()'
SET @sSQL3 = N'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--Lấy dữ liệu kế hoạch đào tạo định kỳ	
EXEC [HRMP2098] @DivisionID,@UserID		
-- Kế thừa yêu cầu đào tạo	
SET @sWhere = 'HRMT2080.DivisionID = ''' + @DivisionID + ''''

IF ISNULL(@TrainingFieldID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT2080.TrainingFieldID LIKE ''%'+@TrainingFieldID+'%'' '
IF ISNULL(@DepartmentID,'') <> '' SET @sWhere = @sWhere + '
AND HRMT2080.DepartmentID LIKE ''%'+@DepartmentID+'%'' '
IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2080.TrainingFromDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2080.TrainingToDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2080.TrainingFromDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' 
AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2080.TrainingToDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '	


SET @sSQL1 = N' 
SELECT ROW_NUMBER() OVER (ORDER BY HRMT2080.DepartmentID) AS RowNum, '+@TotalRow+N' AS TotalRow, 
TrainingRequestID AS InheritID1, NULL AS InheritID2, ''1'' AS TypeID, N''Yêu cầu đào tạo'' AS TypeName, TrainingRequestID AS ID, 0 AS IsAll, HRMT2080.DepartmentID, 
AT1102.DepartmentName, HRMT2080.TrainingFieldID, HRMT1040.TrainingFieldName, Description2 AS Description, TrainingFromDate AS FromDate, TrainingToDate AS ToDate
FROM HRMT2080 WITH (NOLOCK) 
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2080.DepartmentID  
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2080.TrainingFieldID
WHERE '+@sWhere+'
'
-- Kế thừa kế hoạch đào tạo định kỳ
SET @sSQL2 = N'
SELECT ROW_NUMBER() OVER (ORDER BY TB.DepartmentID) AS RowNum, '+@TotalRow+N' AS TotalRow, 
NULL AS InheritID1, TB.TransactionID AS InheritID2, ''2'' AS TypeID, N''Kế hoạch đào tạo định kỳ'' AS TypeName, TrainingPlanID AS ID, IsAll, TB.DepartmentID, AT1102.DepartmentName, 
TB.TrainingFieldID, HRMT1040.TrainingFieldName, TB.Description, TB.FromDate, TB.ToDate
FROM HRMT2071_Temp TB
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = TB.DepartmentID  
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = TB.TrainingFieldID
LEFT JOIN 
(
	SELECT DISTINCT InheritID, ID, TranQuarter, TranYear
	FROM HRMT2091 WITH (NOLOCK)
	WHERE InheritTableID = ''HRMT2071''
) HRMT2091 ON HRMT2091.InheritID = TB.TransactionID AND HRMT2091.ID = TB.TrainingPlanID 
AND 1 = (CASE WHEN TB.RepeatTypeID = 1 AND HRMT2091.TranQuarter = DATEPART(QUARTER, TB.FromDate) AND HRMT2091.TranYear = DATEPART(YEAR, TB.FromDate) THEN 1
			  WHEN TB.RepeatTypeID = 2 AND HRMT2091.TranYear = DATEPART(YEAR, TB.FromDate) THEN 1 ELSE 0 END) 
WHERE TB.TrainingFieldID LIKE ''' + @TrainingFieldID + '''
AND TB.DepartmentID = ''' + @DepartmentID + '''
AND DATEPART(YEAR, GETDATE())*100 + DATEPART(QUARTER, GETDATE()) = DATEPART(YEAR, TB.FromDate)*100 + DATEPART(QUARTER, TB.FromDate)
AND HRMT2091.InheritID IS NULL
'     
        
IF @ModeID = '0' OR @ModeID = ''
BEGIN
	--PRINT @sSQL1 
	--PRINT 'UNION ALL'
	--PRINT @sSQL2
	EXEC (@sSQL1 + 'UNION ALL' + @sSQL2 +   ' ORDER BY DepartmentID' + ' ' + @sSQL3) 	
END       
ELSE
IF @ModeID = '1'	
BEGIN
	--PRINT @sSQL1 
	EXEC (@sSQL1 +' ORDER BY HRMT2080.DepartmentID' + ' ' + @sSQL3)
END	 
ELSE
BEGIN
	--PRINT @sSQL2
	EXEC (@sSQL2 +' ORDER BY TB.DepartmentID' + ' ' + @sSQL3)	
END	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
