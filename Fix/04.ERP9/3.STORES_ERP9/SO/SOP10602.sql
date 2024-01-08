IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP10602]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP10602]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Grid Master Form SOF1063 Kế thừa chỉ tiêu doanh số nhân viên bán sỉ (Sale In)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 15/07/2022
-- <Example>
/*
	EXEC SOP10602 @DealerDivisionID=N''1B'',@TargetsID=N'''',@CreateUserID=N'''',@Description=N'''',@IsPeriod=N'''',@FromDate=N'''',@ToDate=N'''',@PeriodList=N'''',@UserID=N''ASOFTADMIN'',@PageNumber=N''1'',@PageSize=N''25''
*/
CREATE PROCEDURE SOP10602 ( 
	@DealerDivisionID VARCHAR(50),  --Biến môi trường
	@TargetsID  NVARCHAR(250),
	@CreateUserID  NVARCHAR(250),
	@Description  NVARCHAR(250),
	@IsPeriod TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@PeriodList NVARCHAR(MAX), --Chọn trong DropdownChecklist Chọn kỳ
	@UserID  VARCHAR(50),
	@PageNumber INT,
	@PageSize INT
) 
AS 
BEGIN
DECLARE @sSQL VARCHAR (MAX),
		@sSQL1 VARCHAR(MAX) = '',
		@sSQL2 VARCHAR(MAX) = '',
		@sWhere VARCHAR(MAX),
		@OrderBy VARCHAR(500),
		@sJoin VARCHAR(MAX) = '',
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)
		
	SET @sWhere = '1 = 1'
	SET @OrderBy = ' x.CreateDate DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	
	IF Isnull(@DealerDivisionID, '') != ''
		SET @sWhere = @sWhere + ' AND A01.DivisionID <> N'''+ @DealerDivisionID+''' '
	
IF @IsPeriod = 0
BEGIN
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
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(A01.FromDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') 
								  OR (SELECT FORMAT(A01.ToDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''')) '
	END
	
	IF ISNULL(@TargetsID,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(A01.TargetsID, '''') LIKE N''%'+@TargetsID+'%'' '

	IF ISNULL(@CreateUserID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A01.CreateUserID, '''') LIKE N''%'+@CreateUserID+'%'' '

	IF ISNULL(@Description,'') !='' 
		SET @sWhere = @sWhere + ' AND ISNULL(A01.Description, '''') LIKE N''%'+@Description+'%'' '

SET @sSQL = '
		SELECT DISTINCT DivisionID, TargetsID, FromDate, ToDate, [Description]
		INTO #TempAT0161
		FROM AT0161 A01 WITH (NOLOCK)
		WHERE '+@sWhere+'

		DECLARE @Count INT
		SELECT @Count = COUNT(TargetsID) FROM #TempAT0161

		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
			, x.APK, AT01.DivisionID, AT01.FromDate, AT01.TargetsID, AT01.ToDate, AT01.[Description]
			, x.CreateDate, x.CreateUserID, x.LastModifyDate, x.LastModifyUserID
		FROM #TempAT0161 AT01
			CROSS APPLY (SELECT TOP 1 A01.APK, A01.CreateDate, A03.FullName AS CreateUserID, A01.LastModifyDate, A01.LastModifyUserID 
						 FROM AT0161 A01 WITH (NOLOCK)
						 LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A01.CreateUserID = A03.EmployeeID
						 WHERE A01.TargetsID = AT01.TargetsID) x
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT @sSQL
EXEC (@sSQL)

END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

