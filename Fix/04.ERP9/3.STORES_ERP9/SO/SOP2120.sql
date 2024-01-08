IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2120]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP2120]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách Phiếu báo giá Sale
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 02/08/2021

CREATE PROCEDURE SOP2120
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ  
	@VouCherNo NVARCHAR(250),
	@OrderStatus  VARCHAR(50),
	@ObjectName NVARCHAR(250),
	@EmployeeName NVARCHAR(MAX),
	@IsSO  VARCHAR(50),
	@IsConfirm  VARCHAR(50),
	@SearchWhere NVARCHAR(MAX) = null,
	@PageNumber INT,
	@PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sSQL1 NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = '1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'S1.CreateDate DESC'

IF ISNULL(@SearchWhere,'') =''
BEGIN
	IF @IsDate = 1 
		SET @sWhere = @sWhere + '  AND CONVERT(VARCHAR(10),S1.VouCherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''

	ELSE IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONCAT(FORMAT(S1.TranMonth,''00''),''/'',S1.TranYear) in ('''+@Period +''')'

	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + ' and S1.DivisionID = '''+ @DivisionID+''''
	ELSE 
		SET @sWhere = @sWhere + ' and S1.DivisionID IN ('''+@DivisionIDList+''')'

	IF ISNULL(@VouCherNo,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(S1.VouCherNo, '''') = '''+@VouCherNo+''''

	IF ISNULL(@OrderStatus,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.OrderStatus, '''')) = '''+@OrderStatus+''''

	IF ISNULL(@ObjectName,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.ObjectID, '''') = ''' + @ObjectName +''' OR ISNULL(S3.ObjectName, '''') LIKE N''%' + @ObjectName + '%'')'

	IF ISNULL(@EmployeeName,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.EmployeeID, '''') = ''' + @EmployeeName +''' OR ISNULL(S2.FullName, '''') LIKE N''%' + @EmployeeName + '%'')'

	IF ISNULL(@IsSO,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.IsSO, '''')) = '''+@IsSO+''''

	IF ISNULL(@IsSO,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.IsConfirm, '''')) = '''+@IsConfirm+''''

END

IF ISNULL(@SearchWhere,'') !=''
BEGIN
	SET  @sWhere=' AND 1 = 1'
END

SET @sSQL = N'SELECT S1.APK, S1.DivisionID, S1.VouCherNo, S1.VouCherDate, S2.FullName AS EmployeeName, S3.ObjectName
			,S4.Description AS OrderStatus, S5.Description AS IsConfirm, S6.Description AS IsSO, S1.CreateDate
			INTO #TemSOF2120
			FROM SOT2120 S1 WITH(NOLOCK)
			LEFT JOIN AT1103 S2 WITH(NOLOCK) On S2.DivisionID IN (''@@@'', S1.DivisionID) AND S1.EmployeeID = S2.EmployeeID
			LEFT JOIN AT1202 S3 WITH(NOLOCK) On S3.DivisionID IN (''@@@'', S1.DivisionID) AND S1.ObjectID = S3.ObjectID
			LEFT JOIN AT0099 S4 WITH(NOLOCK) On S1.OrderStatus = S4.ID AND S4.CodeMaster = ''AT00000003'' AND S4.Disabled = 0
			LEFT JOIN OOT0099 S5 WITH(NOLOCK) ON S1.IsConfirm = S5.ID AND S5.CodeMaster = ''Status'' AND S5.Disabled = 0
			LEFT JOIN AT0099 S6 WITH(NOLOCK) On S1.IsSO = S6.ID AND S6.CodeMaster = ''AT00000004'' AND S6.Disabled = 0
			WHERE ' + @sWhere + '' + ISNULL(@SearchWhere,'') + ' AND S1.QuoType = 2'

SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
				   , COUNT(*) OVER () AS TotalRow, S1.*
			  FROM #TemSOF2120 S1
			  '+ISNULL(@SearchWhere,'')+'
			  Order BY '+@OrderBy+'
			  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1)

PRINT (@sSQL)
PRINT (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
