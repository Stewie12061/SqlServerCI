IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2190]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2190]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách đóng gói thành phẩm
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Minh Phúc : 01/06/2021
---- Modified by: Kiều Nga on: 05/12/2023 Bổ sung phân quyền dữ liệu @ConditionPackagingShipping

-- <Example>
/*
	MP2190 'HD','', 1, 2015, 6, 2015
*/
CREATE PROCEDURE MP2190
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ  
	@VoucherNo NVARCHAR(4000) ='',	
	@SearchWhere NVARCHAR(Max) = null,
	@PageNumber INT,
	@PageSize INT,
	@ConditionPackagingShipping NVARCHAR(Max) = null
)
AS
DECLARE @sSQL0 VARCHAR (MAX)='',
		@sSQL NVARCHAR (MAX)='',
		@sSQL1 NVARCHAR (MAX)='',
		@sWhere NVARCHAR(MAX)='',
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
        @SQLPermission NVARCHAR(MAX)=''
        
SET @sWhere = '  1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'MT01.VoucherNo, MT01.VoucherDate'

IF ISNULL(@SearchWhere,'') =''
BEGIN
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),MT01.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,20)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	ELSE IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND (CASE WHEN Month(MT01.VoucherDate) <10 THEN ''0''+rtrim(ltrim(str(Month(MT01.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(MT01.VoucherDate)))) 
										ELSE rtrim(ltrim(str(Month(MT01.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(MT01.VoucherDate)))) END) in ('''+@Period +''')'

	IF @DivisionIDList IS NULL OR @DivisionIDList = ''
		SET @sWhere = @sWhere + ' AND MT01.DivisionID = '''+ @DivisionID+''''
	ELSE 
		SET @sWhere = @sWhere + ' AND MT01.DivisionID IN ('''+@DivisionIDList+''')'
    
	IF ISNULL(@VoucherNo,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(MT01.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'''
END

IF ISNULL(@SearchWhere,'') !=''
BEGIN
	SET  @sWhere='  1 = 1'
END

IF ISNULL(@ConditionPackagingShipping, '') != '' AND ISNULL(@ConditionPackagingShipping, '') != 'UNASSIGNED'
SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMT2190 T1 ON MT01.CreateUserID = T1.Value  '

SET @sSQL0 ='
	SELECT Value
	INTO #PermissionMT2190
	FROM STRINGSPLIT(''' + ISNULL(@ConditionPackagingShipping, '') + ''', '','')
	'

SET @sSQL =N'SELECT MT01.APK
			      , MT01.DivisionID
			      , MT01.VoucherNo
				  , MT01.CreateDate
				  , MT01.LastModifyDate
				  , MT01.VoucherDate
				  , MT01.LastModifyUserID
				  , MT01.Notes
				  , MT01.CreateUserID INTO #TemMT2190
			FROM MT2190 MT01 WITH (NOLOCK)
			'+@SQLPermission+'
			WHERE  '+@sWhere+''+ISNULL(@SearchWhere,'') +'
			GROUP BY MT01.APK, MT01.DivisionID, MT01.VoucherNo, MT01.VoucherDate,MT01.CreateUserID,MT01.CreateDate,MT01.LastModifyDate,MT01.LastModifyUserID, MT01.Notes
			'

SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
		    , COUNT(*) OVER () AS TotalRow, MT01.*
			FROM #TemMT2190 MT01'+ISNULL(@SearchWhere,'')+'
			Order BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL0 + @sSQL + @sSQL1)

PRINT (@sSQL)
PRINT (@sSQL1)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
