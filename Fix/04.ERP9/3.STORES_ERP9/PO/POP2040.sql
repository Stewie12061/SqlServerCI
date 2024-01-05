IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2040]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2040]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid Form POF2040 Danh sách yêu cầu báo giá
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 15/03/2019 by Như Hàn
----Modify  on 07/08/2019 by Bảo Toàn - Cập nhật phân quyền
----Modify  on 08/03/2023 by Hoài Bảo - Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
----Modify  on 21/03/2023 by Anh Đô: Fix lỗi trùng lặp các dòng trên lưới Master
----Modify  on 31/03/2023 by Anh Đô: Select thêm cột VoucherTypeName
----Modify on ... by ...

-- <Example>
/*  
 EXEC POP2040 @DivisionID, @DivisionList, @FromDate, @ToDate, @IsDate, @PeriodList, @VoucherNo, @VoucherTypeID, @ObjectID, @EmployeeID, @PageNumber, @PageSize, @IsExcel, @APKList
*/
----
CREATE PROCEDURE POP2040 ( 
        @DivisionID VARCHAR(50) = '',
		@DivisionList NVARCHAR(MAX) = '',  --Chọn
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@IsDate INT = 1,
		@PeriodList NVARCHAR(4000) = '',
		@VoucherNo VARCHAR(50) = '',
		@VoucherTypeID VARCHAR(50) = '',
		@ObjectID NVARCHAR(50) = '',
		@EmployeeID NVARCHAR(50) = '',
		@PageNumber INT = 1,
        @PageSize INT = 25,
		@IsExcel BIT = 0, --1: Thực hiện xuất file Excel; 0: Thực hiện load danh sách
		@APKList XML = '',
		@InventoryName NVARCHAR(MAX) = '',
		@ConditionOpportunityID NVARCHAR(MAX) ='',
		@UserID VARCHAR(50) = '',
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sJoin VARCHAR(MAX),
		@TotalRow VARCHAR(50)

IF @APKList IS NOT NULL
BEGIN
	CREATE TABLE #TAM (APK VARCHAR(50))
	INSERT INTO #TAM (APK)
	SELECT X.Data.query('APK').value('.', 'VARCHAR(50)') AS APK 
	FROM @APKList.nodes('//Data') AS X (Data)
END	
		
SET @TotalRow = ''
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
    
SET @sWhere = ''
SET @sJoin = ''

IF ISNULL(@DivisionList, '') <> '' 
	SET @sWhere = @sWhere + ' AND F10.DivisionID IN ('''+@DivisionList+''')'
ELSE 
	SET @sWhere = @sWhere + ' AND F10.DivisionID = '''+@DivisionID+''''

IF @IsDate = 1 
	BEGIN
		IF ISNULL(@FromDate,'') <> '' AND ISNULL(@ToDate,'') <> ''
		SET @sWhere = @sWhere + ' AND (Convert(varchar(20),F10.VoucherDate,112) Between ''' + Convert(varchar(20),@FromDate,112) + ''' AND ''' + Convert(varchar(20),Isnull(@ToDate,'12/31/9999'),112) + ''')'
	END
IF @IsDate = 0 
	BEGIN
		IF ISNULL(@PeriodList,'')<>''
		SET @sWhere = @sWhere + ' AND (CASE WHEN F10.TranMonth <10 THEN ''0''+rtrim(ltrim(str(F10.TranMonth)))+''/''+ltrim(Rtrim(str(F10.TranYear))) 
						ELSE rtrim(ltrim(str(F10.TranMonth)))+''/''+ltrim(Rtrim(str(F10.TranYear))) END) in ('''+@PeriodList +''')'
	END


IF ISNULL(@VoucherTypeID,'') <> ''
	SET @sWhere = @sWhere + ' AND F10.VoucherTypeID like ''%' + @VoucherTypeID + '%'''

IF ISNULL(@VoucherNo,'') <> ''
	SET @sWhere = @sWhere + ' AND F10.VoucherNo like ''%' + @VoucherNo + '%'''

IF ISNULL(@ObjectID,'') <> ''
	SET @sWhere = @sWhere + ' AND (F10.ObjectID like ''%' + @ObjectID + '%'' OR T12.ObjectName like N''%' + @ObjectID + '%'')'

IF ISNULL(@EmployeeID,'') <> ''
	SET @sWhere = @sWhere + ' AND (F10.EmployeeID like ''%' + @EmployeeID + '%'' OR T13.FullName like N''%' + @EmployeeID + '%'')'

IF ISNULL(@InventoryName,'') <> ''
	SET @sWhere = @sWhere + ' AND (F11.InventoryID like ''%' + @InventoryName + '%'' OR A13.InventoryName like N''%' + @InventoryName + '%'')'

IF Isnull(@ConditionOpportunityID, '') != ''
			SET @sWhere = @sWhere + ' AND ISNULL(F10.CreateUserID,'''') in (N'''+@ConditionOpportunityID+''' )'

IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
BEGIN
	SET @sJoin = 
	CASE
		WHEN @RelTable = 'OT3101' THEN @sJoin + ' INNER JOIN OT3102 B WITH (NOLOCK) ON F11.InheritAPKDetail = B.APK AND F11.InheritTableID = ''OT3101'' 
												  INNER JOIN ' +@RelTable+ ' C WITH (NOLOCK) ON B.ROrderID = C.ROrderID'
		ELSE @sJoin
	END

	SET @sWhere = 
	CASE
		WHEN @RelTable = 'OT3101' THEN @sWhere + ' AND C.APK = ''' +@RelAPK+ ''' AND F10.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
		ELSE @sWhere
	END
END
ELSE
	SET @sWhere = @sWhere

SET @sSQL = N'
	SELECT 
		   ROW_NUMBER() OVER (ORDER BY P.VoucherDate DESC
		 , P.VoucherNo DESC) AS RowNum
		 , '+@TotalRow+' AS TotalRow
		 , P.*
	FROM (
		SELECT
		DISTINCT F10.APK, F10.DivisionID, F10.TranMonth, F10.TranYear, F10.VoucherTypeID, F10.VoucherNo, F10.VoucherDate, F10.OverDate, F10.ObjectID, 
		F10.CurrencyID, F10.ExchangeRate, F10.EmployeeID, F10.Description, F10.CreateDate, F10.CreateUserID, F10.LastModifyUserID, F10.LastModifyDate ,
		T12.ObjectName, T13.FullName As EmployeeName, A.Description as Status, A10.VoucherTypeName
		FROM POT2021 F10 WITH (NOLOCK) 
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON F10.ObjectID = T12.ObjectID
		LEFT JOIN AT1103 T13 WITH (NOLOCK) ON F10.EmployeeID = T13.EmployeeID
		LEFT JOIN OOT0099  A WITH (NOLOCK) ON ISNULL(F10.Status,0) = A.ID AND A.CodeMaster = ''Status'' AND A.Disabled = 0
		LEFT JOIN POT2022  F11 WITH (NOLOCK) ON F10.APK = F11.APKMaster
		LEFT JOIN AT1302  A13 WITH (NOLOCK) ON F11.InventoryID = A13.InventoryID
		LEFT JOIN AT1007 A10 WITH (NOLOCK) ON A10.VoucherTypeID = F10.VoucherTypeID'
		+ @sJoin + ' WHERE ISNULL(F10.DeleteFlag,0) = 0 ' + @sWhere 
	+ ') P'

IF @IsExcel = 1
	SET @sSQL = @sSQL + N'
	INNER JOIN #TAM ON P.APK = #TAM.APK'

SET @sSQL = @sSQL + N'
	
	ORDER BY P.VoucherDate DESC, P.VoucherNo DESC'

IF @IsExcel = 0
	SET @sSQL = @sSQL+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
