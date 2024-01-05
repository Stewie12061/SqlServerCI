IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2140]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2140]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
--- Load dữ liệu kế hoạch sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Lê Hoàng on: 01/06/2021
---- Modified by Lê Hoàng on 04/06/2021 : thêm điều kiện DeleteFlg
---- Modified by :  Đình Hòa, Date: 17/06/2021 : Bổ sung lọc theo kỳ
---- Modified by: Kiều Nga on: 05/12/2023 Bổ sung phân quyền dữ liệu @ConditionProductionPlan
-- <Example>

CREATE PROCEDURE MP2140
(
	@DivisionIDList NVARCHAR(2000),
	@DivisionID VARCHAR(50),
	@VoucherNo VARCHAR(50)='',
	@DescriptionSearch NVARCHAR(50)='',
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ  
	@UserID VARCHAR(50) = '',
	@PageNumber INT,
	@PageSize INT,
	@ConditionProductionPlan NVARCHAR(MAX) =''
)
AS

DECLARE @sSQL NVARCHAR (MAX)=''
DECLARE @sSQL1 NVARCHAR (MAX)=''
DECLARE @sWhere NVARCHAR(MAX)=''
DECLARE @OrderBy NVARCHAR(500)
DECLARE @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@SQLPermission NVARCHAR(MAX)=''
        
SET @sWhere = ''
SET @TotalRow = ''
SET @OrderBy = 'M.VoucherNo DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

IF ISNULL(@DivisionIDList, '') != ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'') '
ELSE 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN (''' + @DivisionID + ''', ''@@@'') '

IF ISNULL(@VoucherNo, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

IF ISNULL(@DescriptionSearch, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(M.Description, '''') LIKE N''%' + @DescriptionSearch + '%'' '

IF @IsDate = 1 
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.VoucherDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE 
IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + ' AND CONCAT(FORMAT(Month(M.VoucherDate),''00''),''/'',Year(M.VoucherDate)) in ('''+@Period +''')'
END

IF ISNULL(@ConditionProductionPlan, '') != '' AND ISNULL(@ConditionProductionPlan, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMT2140 T1 ON M.CreateUserID = T1.Value  '

SET @sSQL = N'
		SELECT Value
		INTO #PermissionMT2140
		FROM STRINGSPLIT(''' + ISNULL(@ConditionProductionPlan, '') + ''', '','')

		SELECT M.APK
			 , M.DivisionID
			 , M.VoucherNo
			 , M.VoucherDate
			 , M.Description
	    INTO #MT2140
        FROM MT2140 M WITH(NOLOCK)
		'+@SQLPermission+'
		WHERE M.DeleteFlg = 0 ' + @sWhere + ' 

		DECLARE @Count INT
		SELECT @Count = COUNT(VoucherNo)
		FROM #MT2140

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @Count AS TotalRow, M.*
		FROM #MT2140 M WITH (NOLOCK)
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

EXEC (@sSQL)
PRINT (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO