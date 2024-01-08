IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form HRF2090: Danh mục đề xuất đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 18/09/2017
----Modified on 04/10/2019 by Bảo Toàn: Cập nhật phân quyền
-- <Example>
---- 
/*-- <Example>
	HRMP2090 @DivisionID='AS',@DivisionList='',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,@TrainingProposeID=NULL,@DepartmentID='ACC',@FromDate='2016-01-01',@ToDate='2018-01-01'
----*/

CREATE PROCEDURE [dbo].[HRMP2090]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @IsSearch TINYINT,
	 @TrainingProposeID NVARCHAR(500),
	 @DepartmentID NVARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ConditionTrainingProposeID VARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500) = 'CreateDate',
        @TotalRow NVARCHAR(50) = ''
        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	
       
    
IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = '
	HRMT2090.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = '
	HRMT2090.DivisionID = '''+@DivisionID+''''

IF  @IsSearch = 1
BEGIN
	IF ISNULL(@TrainingProposeID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2090.TrainingProposeID LIKE N''%' + @TrainingProposeID + '%'''		
	END
	 
	IF ISNULL(@DepartmentID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + '
		AND HRMT2090.DepartmentID = N''' + @DepartmentID + ''''		
	END
	
	IF (@FromDate IS NOT NULL AND @ToDate IS NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2090.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromDate,126)+''' '
	IF (@FromDate IS NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2090.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToDate,126)+''' '
	IF (@FromDate IS NOT NULL AND @ToDate IS NOT NULL) SET @sWhere = @sWhere + '
	AND CONVERT(VARCHAR(10), CONVERT(DATE,HRMT2090.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,126)+'''' 
	
	

END

IF Isnull(@TrainingProposeID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(HRMT2090.CreateUserID,'''') in (N'''+@TrainingProposeID+''' )'


SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+N' AS TotalRow, *
FROM
(
	SELECT HRMT2090.APK, HRMT2090.DivisionID, 
	HRMT2090.TrainingProposeID, HRMT2090.DepartmentID, 
	CASE WHEN HRMT2090.DepartmentID = ''%'' THEN N''Toàn công ty'' ELSE AT1102.DepartmentName END DepartmentName, 
	HRMT2090.ProposeAmount, HRMT2090.Description3, AssignedToUserID, AT1103.FullName AS AssignedToUserName,
	HRMT2090.CreateUserID, HRMT2090.CreateDate, HRMT2090.LastModifyUserID, HRMT2090.LastModifyDate
	FROM HRMT2090 WITH (NOLOCK)
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2090.DepartmentID
	LEFT JOIN AT1103 WITH (NOLOCK) ON HRMT2090.AssignedToUserID = AT1103.EmployeeID AND AT1103.DivisionID IN ('''+@DivisionID+''', ''@@@'')
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
