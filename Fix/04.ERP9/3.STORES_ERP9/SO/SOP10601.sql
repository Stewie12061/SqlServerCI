IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP10601]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP10601]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form SOF1060 Danh mục chỉ tiêu doanh số nhân viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 11/07/2022
--- Modify by Hoài Bảo Date: 15/07/2022 - Cập nhật các cột load lên Grid
-- <Example>
----    EXEC SOP10601 @DivisionID=N'DTI',@DivisionIDList=N'',@FromDate=NULL,@ToDate=NULL,@IsPeriod=0,@PeriodList=N'',@TargetsID=N'',@Description=N'',@UserID=N'ASOFTADMIN',@PageNumber=1,@PageSize=25

CREATE PROCEDURE [dbo].[SOP10601] ( 
  @DivisionID VARCHAR(50),
  @DivisionIDList NVARCHAR(2000),  
  @TargetsID  NVARCHAR(250),
  @CreateUser  NVARCHAR(250),
  @Description  NVARCHAR(250),
  @IsPeriod INT,--0: theo ngày, 1: Theo kỳ
  @FromDate Datetime,
  @ToDate Datetime,
  @PeriodList VARCHAR(MAX),
  @UserID  VARCHAR(50),
  @PageNumber INT,
  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sSQL1 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
        
SET @sWhere = ' 1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'x.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '') = ''
		SET @sWhere = @sWhere + 'AND A01.DivisionID = '''+ @DivisionID+''''
	ELSE 
		SET @sWhere = @sWhere + 'AND A01.DivisionID IN ('''+@DivisionIDList+''')'

	IF @IsPeriod = 0 
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (A01.FromDate >= ''' + @FromDateText + '''
										   OR A01.ToDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (A01.FromDate <= ''' + @ToDateText + '''
										   OR A01.ToDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (A01.FromDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										   OR A01.ToDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END

	IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(A01.FromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') 
								  OR (SELECT FORMAT(A01.ToDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''')) '
	END

	IF ISNULL(@TargetsID,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(A01.TargetsID, '''') LIKE N''%'+@TargetsID+'%'' '

	IF ISNULL(@CreateUser, '') != ''
		SET @sWhere = @sWhere + ' AND (A03.FullName LIKE N''%' + @CreateUser + '%'' OR A03.EmployeeID LIKE N''%' + @CreateUser + '%'') '
	IF ISNULL(@Description,'') !='' 
		SET @sWhere = @sWhere + ' AND ISNULL(A01.Description, '''') LIKE N''%'+@Description+'%'' '

SET @sSQL = '
		SELECT DISTINCT A01.DivisionID, A01.TargetsID, A01.FromDate, A01.ToDate, A01.[Description]
		INTO #TempAT0161
		From AT1103 A03
		INNER JOIN AT0161 A01 WITH(NOLOCK)
		ON '+@sWhere+'

		DECLARE @Count INT
		SELECT @Count = COUNT(TargetsID) FROM #TempAT0161

		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
			, x.APK, AT01.DivisionID, AT01.FromDate, AT01.TargetsID, AT01.ToDate, AT01.[Description]
			, x.CreateDate, x.CreateUserID, x.LastModifyDate, x.LastModifyUserID
		FROM #TempAT0161 AT01
			CROSS APPLY (SELECT TOP 1 A01.APK, A01.CreateDate, A03.FullName AS CreateUserID, A01.LastModifyDate, A01.LastModifyUserID 
						 FROM AT0161 A01 WITH (NOLOCK)
						 LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A01.CreateUserID = A03.EmployeeID
						 WHERE TargetsID = AT01.TargetsID) x
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL )
PRINT (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
