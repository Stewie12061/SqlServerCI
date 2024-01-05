IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2160]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2160]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách cấu trúc sản phẩm
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 13/05/2021
---- Modified by: Kiều Nga on: 05/12/2023 Bổ sung phân quyền dữ liệu @ConditionManufactureOrder

-- <Example>
/*
	MP2160 'HD','', 1, 2015, 6, 2015
*/
CREATE PROCEDURE MP2160
(
	@DivisionID VARCHAR(50),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ  
	@VoucherNo NVARCHAR(250) ='',
	@ObjectID NVARCHAR(250) ='',
	@ProductID NVARCHAR(250) ='',
	@MachineID NVARCHAR(250) ='',
	@UserID VARCHAR(50),
	@SearchWhere NVARCHAR(MAX) = null,
	@PageNumber INT,
	@PageSize INT,
	@ConditionManufactureOrder NVARCHAR(MAX) =''
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sSQL1 NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
        @FromDateText NVARCHAR(20),
        @ToDateText NVARCHAR(20),
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex),
		@SQLPermission NVARCHAR(MAX)=''

IF (@CustomerIndex IN (117)) -- Khách hàng MAITHU
BEGIN
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'M1.CreateDate DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	IF ISNULL(@SearchWhere,'') =''
	BEGIN
		IF ISNULL(@DivisionID,'') != ''
			SET @sWhere = @sWhere + ' M1.DivisionID = '''+ @DivisionID+''''

		IF @IsDate = 1 
		BEGIN
		-- Check Para FromDate và ToDate
			IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (M1.VoucherDate <= ''' + @ToDateText + ''')'
			END
			ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = '')
				 BEGIN
					SET @sWhere = @sWhere + ' AND (M1.VoucherDatee >= ''' + @FromDateText + ''')'
				 END
			ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (M1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')'
				END
		END
		ELSE 
		IF @IsDate = 0 
		BEGIN
			SET @sWhere = @sWhere + ' AND (CONCAT(FORMAT(Month(M1.VoucherDate),''00''),''/'',Year(M1.VoucherDate)) in ('''+@Period +'''))'
		END

		IF ISNULL(@VoucherNo,'') !=''
			SET @sWhere = @sWhere + ' AND ISNULL(M1.VoucherNo, '''') = N'''+@VoucherNo+''''

		IF ISNULL(@ObjectID,'') !=''
			SET @sWhere = @sWhere + ' AND (ISNULL(M1.ObjectName, '''') LIKE N''%'+@ObjectID+'%'' OR ISNULL(M1.ObjectID, '''') = N'''+@ObjectID+''')'

		IF ISNULL(@ProductID,'') !=''
			SET @sWhere = @sWhere + ' AND (ISNULL(M1.ProductID, '''') = N'''+@ProductID+''' OR ISNULL(M1.ProductName, '''') LIKE N''%'+@ProductID+'%'')'

		IF ISNULL(@MachineID,'') !=''
			SET @sWhere = @sWhere + ' AND (ISNULL(M1.MachineID, '''') = N'''+@MachineID+''' OR ISNULL(M1.MachineName, '''') LIKE N''%'+@MachineID+'%'')'
	END

	IF ISNULL(@SearchWhere,'') !=''
	BEGIN
		SET  @sWhere='1 = 1'
	END

	IF ISNULL(@ConditionManufactureOrder, '') != '' AND ISNULL(@ConditionManufactureOrder, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMT2160 T1 ON M1.CreateUserID = T1.Value  '

	SET @sSQL = N'
				SELECT Value
				INTO #PermissionMT2160
				FROM STRINGSPLIT(''' + ISNULL(@ConditionManufactureOrder, '') + ''', '','')

				SELECT M1.*
						, AT26.PhaseName
				INTO #TempMT2160
				FROM MT2160 M1 WITH(NOLOCK)
				'+@SQLPermission+'
				LEFT JOIN AT0126 AT26 WITH (NOLOCK) ON AT26.DivisionID = M1.DivisionID 
													AND AT26.PhaseID = M1.PhaseID
				WHERE M1.DeleteFlg <> 1 AND ' + @sWhere + '' + ISNULL(@SearchWhere,'''')

	SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
					   , COUNT(*) OVER () AS TotalRow, M1.*
				  FROM #TempMT2160 M1
				  Order BY '+@OrderBy+'
				  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	EXEC (@sSQL + @sSQL1)

	PRINT (@sSQL)
	PRINT (@sSQL1)
END
ELSE
BEGIN
	SET @sWhere = ''
	SET @TotalRow = ''
	SET @OrderBy = 'M1.CreateDate DESC'
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	IF ISNULL(@SearchWhere,'') =''
	BEGIN
		IF ISNULL(@DivisionID,'') != ''
			SET @sWhere = @sWhere + ' M1.DivisionID = '''+ @DivisionID+''''

		IF @IsDate = 1 
		BEGIN
		-- Check Para FromDate và ToDate
			IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (M1.VoucherDate <= ''' + @ToDateText + ''')'
			END
			ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = '')
				 BEGIN
					SET @sWhere = @sWhere + ' AND (M1.VoucherDatee >= ''' + @FromDateText + ''')'
				 END
			ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
				BEGIN
					SET @sWhere = @sWhere + ' AND (M1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''')'
				END
		END
		ELSE 
		IF @IsDate = 0 
		BEGIN
			SET @sWhere = @sWhere + ' AND (CONCAT(FORMAT(Month(M1.VoucherDate),''00''),''/'',Year(M1.VoucherDate)) in ('''+@Period +'''))'
		END

		IF ISNULL(@VoucherNo,'') !=''
			SET @sWhere = @sWhere + ' AND ISNULL(M1.VoucherNo, '''') = N'''+@VoucherNo+''''

		IF ISNULL(@ObjectID,'') !=''
			SET @sWhere = @sWhere + ' AND (ISNULL(M1.ObjectName, '''') LIKE N''%'+@ObjectID+'%'' OR ISNULL(M1.ObjectID, '''') = N'''+@ObjectID+''')'

		IF ISNULL(@ProductID,'') !=''
			SET @sWhere = @sWhere + ' AND (ISNULL(M1.ProductID, '''') = N'''+@ProductID+''' OR ISNULL(M1.ProductName, '''') LIKE N''%'+@ProductID+'%'')'

		IF ISNULL(@MachineID,'') !=''
			SET @sWhere = @sWhere + ' AND (ISNULL(M1.MachineID, '''') = N'''+@MachineID+''' OR ISNULL(M1.MachineName, '''') LIKE N''%'+@MachineID+'%'')'
	END

	IF ISNULL(@SearchWhere,'') !=''
	BEGIN
		SET  @sWhere='1 = 1'
	END

	IF ISNULL(@ConditionManufactureOrder, '') != '' AND ISNULL(@ConditionManufactureOrder, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMT2160 T1 ON M1.CreateUserID = T1.Value  '

	SET @sSQL = N'
				SELECT Value
				INTO #PermissionMT2160
				FROM STRINGSPLIT(''' + ISNULL(@ConditionManufactureOrder, '') + ''', '','')

				SELECT M1.*
				INTO #TempMT2160
				FROM MT2160 M1 WITH(NOLOCK)
				'+@SQLPermission+'
				WHERE M1.DeleteFlg <> 1 AND ' + @sWhere + '' + ISNULL(@SearchWhere,'''')

	SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
					   , COUNT(*) OVER () AS TotalRow, M1.*
				  FROM #TempMT2160 M1
				  Order BY '+@OrderBy+'
				  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	EXEC (@sSQL + @sSQL1)

	PRINT (@sSQL)
	PRINT (@sSQL1)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
