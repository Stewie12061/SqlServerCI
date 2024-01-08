IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2158]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2158]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
--- Load form MF2150 - Load Danh sách dự trù chi phí
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên ON 23/03/2021
----Update by: Kiều Nga ON 01/06/2021 : Bổ sung điều kiện DeleteFlg = 0
----Modified by :  Đình Hòa, Date: 17/06/2021 : Bổ sung lọc theo kỳ
----Modified by: Kiều Nga on: 05/12/2023 Bổ sung phân quyền dữ liệu @ConditionManufactureOrder

-- <Example>
/*
	EXEC MP2158 'KY', '', '', '',N'', N'', 1, 10
*/

CREATE PROCEDURE [dbo].[MP2158]
(
	@DivisionID NVARCHAR(250),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
	@VoucherNo NVARCHAR(250),
	@ObjectID NVARCHAR(250),
	@DepartmentID NVARCHAR(250),
	@UserID NVARCHAR(250),
	@PageNumber INT,
	@PageSize INT,
	@ConditionEstimateCosts NVARCHAR(MAX) =''
)
AS
BEGIN
	DECLARE @sSQL0 VARCHAR (MAX)='',
			@sSQL NVARCHAR(MAX),
			@sSQL2 NVARCHAR(MAX),
			@sSQLPermission NVARCHAR(MAX),
			@sWhere NVARCHAR(MAX),
			@OrderBy NVARCHAR(500),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@SQLPermission NVARCHAR(MAX)=''

	SET @sWhere = '' 
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'

	
	IF @IsDate = 1 
	BEGIN
	-- Check Para FromDate và ToDate
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.VoucherDate <= ''' + @ToDateText + '''
											OR M.SuppliesDate <= ''' + @ToDateText + ''') '
		END
		ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') = '')
			 BEGIN
				SET @sWhere = @sWhere + ' AND (M.VoucherDate >= ''' + @FromDateText + '''
											OR M.SuppliesDate >= ''' + @FromDateText + ''') '
			 END
		ELSE IF (ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (M.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR M.SuppliesDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE 
	IF @IsDate = 0 
	BEGIN
		SET @sWhere = @sWhere + ' AND (CONCAT(FORMAT(Month(M.VoucherDate),''00''),''/'',Year(M.VoucherDate)) in ('''+@Period +''')
										OR CONCAT(FORMAT(Month(M.SuppliesDate),''00''),''/'',Year(M.SuppliesDate)) in ('''+@Period +'''))'
	END

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND M.VoucherNo LIKE N''%' + @VoucherNo + '%'' '
	
	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND (M.ObjectID LIKE N''%' + @ObjectID + '%'' OR M.ObjectName LIKE N''%' + @ObjectID + '%'') '
	
	IF ISNULL(@DepartmentID, '') != ''
		SET @sWhere = @sWhere + ' AND M.DepartmentID = ''' + @DepartmentID + ''''
	

	SET @OrderBy = N' M.VoucherDate DESC, M.VoucherNo DESC'

	IF ISNULL(@ConditionEstimateCosts, '') != '' AND ISNULL(@ConditionEstimateCosts, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionOT2201 T1 ON M.CreateUserID = T1.Value  '

	SET @sSQL0 ='
		SELECT Value
		INTO #PermissionOT2201
		FROM STRINGSPLIT(''' + ISNULL(@ConditionEstimateCosts, '') + ''', '','')
		'

	SET @sSQL = N' SELECT M.APK, M.DivisionID, M.VoucherNo, M.VoucherDate
						, M.SuppliesDate
						, M.ObjectID
						, A1.ObjectName
						, A2.DepartmentName AS DepartmentID
						, M.EmployeeID
						, A3.FullName AS EmployeeName
						, S1.Description AS OrderStatus
						, O1.Description AS StatusID
						, M.Description
				INTO #TempOT2201		
				FROM OT2201 M WITH (NOLOCK)
							
						LEFT JOIN AT1202 A1 WITH (NOLOCK) ON M.ObjectID = A1.ObjectID
						LEFT JOIN AT1102 A2 WITH (NOLOCK) ON M.DepartmentID = A2.DepartmentID AND ISNULL(A2.Disabled, 0) = 0
						LEFT JOIN AT1103 A3 WITH (NOLOCK) ON M.EmployeeID = A3.EmployeeID AND ISNULL(A3.Disabled, 0) = 0
						LEFT JOIN SOT0099 S1 WITH (NOLOCK) ON M.OrderStatus = S1.ID AND S1.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(S1.Disabled, 0)= 0
						LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON M.StatusID = O1.ID AND O1.CodeMaster =''Status'' AND ISNULL(O1.Disabled, 0)= 0
						'+@SQLPermission+'	
				WHERE M.DivisionID IN (''@@@'', ''' + @DivisionID + ''')  AND M.DeleteFlg = 0 ' + @sWhere + '
				
				DECLARE @count INT
				SELECT @count = COUNT(VoucherNo) FROM #TempOT2201
				SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
						, M.APK, M.DivisionID
						, M.VoucherNo
						, M.VoucherDate
						, M.SuppliesDate
						, M.ObjectID
						, M.ObjectName
						, M.DepartmentID
						, M.EmployeeID
						, M.EmployeeName
						, M.OrderStatus
						, M.StatusID
						, M.Description					
				FROM #TempOT2201 M
				ORDER BY ' + @OrderBy + '
				OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
				FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY ' 


	EXEC (@sSQL0 + @sSQL)
	PRINT (@sSQL0 + @sSQL)
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
