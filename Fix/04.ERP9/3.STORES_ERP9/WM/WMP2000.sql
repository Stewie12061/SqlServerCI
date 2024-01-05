IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---- Load cac phieu yêu cầu Nhap, xuat len man hinh truy van WF0122 (ERP9 - EIMSKIP)
---- Created by Bảo Thy on 30/12/2016
---- Modified by on
---- Modified by TIểu Mai on 24/05/2017: Bổ sung WITH (NOLOCK) và chỉnh sửa danh mục dùng chung
---- Modified by Hoài Bảo on 17/03/2022: Bổ sung Load trạng thái duyệt phiếu theo cột Ischeck
---- Modified by Hoài Bảo on 13/12/2022: Bổ sung load dữ liệu theo biến phân quyền Condition
-- <Example> 
/*
	exec WMP2000 @DivisionID=N'MK', @UserID=N'ASOFTADMIN', @PageNumber=1,@PageSize=6000,@IsSearch=1, @TranMonth=6, @TranYear=2016,@Mode=1,@VoucherNo=NULL,
	@ContractNo=NULL, @Status = '%', @FromDate='2016-12-01 00:00:00',@ToDate='2016-12-30 00:00:00', @WareHouseID = 'ADM01'
*/

CREATE PROCEDURE [dbo].[WMP2000] 
(
    @DivisionID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),	-- Chọn trong DropdownChecklist DivisionID
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@IsSearch TINYINT,
	@Mode TINYINT,-- 1: YC Nhập, 2: YC Xuất, 3: YC VCNB
	@VoucherNo VARCHAR(50),
	@VoucherTypeID VARCHAR(50),
	@WareHouseID VARCHAR(50) = NULL,
	@ImWareHouseID VARCHAR(50),
	@ExWareHouseID VARCHAR(50),
	@ObjectID  VARCHAR(10),
	@Status VARCHAR(10),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@IsPeriod INT,
	@PeriodList VARCHAR(MAX),
	@Condition NVARCHAR(MAX) = NULL,
	@SearchWhere NVARCHAR(MAX) = null
)
AS
DECLARE @sWhere NVARCHAR(MAX) = '',
		@sSQL NVARCHAR(MAX) = '',
		@TotalRow NVARCHAR(50) = '',
		@OrderBy NVARCHAR(2000) = '',
		@CustomerName INT,
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SELECT @CustomerName = ISNULL(CustomerName,-1) FROM CustomerIndex
----------------->>>>>> Phân quyền xem chứng từ của người dùng khác		
		DECLARE @sSQLPer AS NVARCHAR(MAX),
				@sWHEREPer AS NVARCHAR(MAX),
				@sSelect AS NVARCHAR(MAX)
		SET @sSQLPer = ''
		SET @sWHEREPer = ''		

		IF EXISTS (SELECT TOP 1 1 FROM WT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsPermissionView = 1) -- Nếu check Phân quyền xem dữ liệu tại Thiết lập hệ thống thì mới thực hiện
			BEGIN
				SET @sSQLPer = N' LEFT JOIN AT0010 WITH (NOLOCK) ON AT0010.DivisionID = WT95.DivisionID 
													AND AT0010.AdminUserID = '''+@UserID+''' 
													AND AT0010.UserID = WT95.CreateUserID '
				SET @sWHEREPer = N' 
				AND (WT95.CreateUserID = AT0010.UserID
					OR  WT95.CreateUserID = '''+@UserID+''' '		
			
				IF @CustomerName = 70 ---EIMSKIP
				BEGIN
					SET @sWHEREPer = @sWHEREPer + '
					OR WT95.ObjectID = '''+@UserID+''')'
				END
				ELSE SET @sWHEREPer = @sWHEREPer + ')'
			
			END

-- Load theo biến phân quyền dữ liệu
IF ISNULL(@Condition, '') != ''
BEGIN
	SET @sWHEREPer = @sWHEREPer + ' AND (ISNULL(WT95.EmployeeID, '''') IN (''' + @Condition + ''' ) OR ISNULL(WT95.CreateUserID, '''') IN (''' + @Condition + ''' ))'
END
		
-----------------<<<<<< Phân quyền xem chứng từ của người dùng khác		
IF @PageNumber = 1 SET @TotalRow = 'COUNT(1) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @Mode = 1 SET @sWhere = 'AND WT95.KindVoucherID IN (1,5,7,9)'
IF @Mode = 2 SET @sWhere = 'AND WT95.KindVoucherID IN (2,4,6,8,10)'
IF @Mode = 3 SET @sWhere = 'AND WT95.KindVoucherID IN (3)'

-- YCNK
IF @Mode = 1
BEGIN
	SET @sSelect = '(Case when KindVoucherID in (1,3,5,7,9) then WT95.WareHouseID Else '''' End) as ImWareHouseID,
		(CASE WHEN WT95.KindVoucherID IN (1,3,5,7,9) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,'
END

-- YCXK
IF @Mode = 2
BEGIN
	SET @sSelect = '(Case when KindVoucherID in (2,4,6,8,10) then WT95.WareHouseID Else '''' End) as ExWareHouseID,
		(Case when KindVoucherID in (2,4,6,8,10) THEN A33.WareHouseName ELSE '''' END) ExWareHouseName,'
END

-- YC VCNB
IF @Mode = 3
BEGIN
	SET @sSelect = '(Case when KindVoucherID in (3) then WT95.WareHouseID Else '''' End) as ImWareHouseID,
		(CASE WHEN WT95.KindVoucherID IN (3) THEN A33.WareHouseName ELSE '''' END) ImWareHouseName,
		(Case when KindVoucherID in (3) then WT95.WareHouseID2 Else '''' End) as ExWareHouseID,
		(CASE WHEN WT95.KindVoucherID IN (3) THEN A03.WareHouseName ELSE '''' END) ExWareHouseName,'
END

SET @OrderBy = ' A.VoucherNo DESC'

IF ISNULL(@SearchWhere, '') =''
Begin
	--Check Para DivisionIDList null then get DivisionID 
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' AND WT95.DivisionID IN (''' + @DivisionIDList + ''', ''@@@'')'
	ELSE
		SET @sWhere = @sWhere + ' AND WT95.DivisionID IN (''' + @DivisionID + ''', ''@@@'')'
END

-- Check Para FromDate và ToDate
-- Trường hợp search theo từ ngày đến ngày
IF @IsPeriod = 0
BEGIN
	IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (WT95.VoucherDate >= ''' + @FromDateText + '''
											OR WT95.VoucherDate >= ''' + @FromDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M.VoucherDate <= ''' + @ToDateText + ''' 
											OR M.VoucherDate <= ''' + @ToDateText + ''')'
		END
	ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (WT95.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(WT95.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

IF @IsSearch = 1
BEGIN
	IF ISNULL(@VoucherTypeID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(WT95.VoucherTypeID, '''') IN (''' + @VoucherTypeID + ''') '

	IF ISNULL(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(WT95.VoucherNo, '''') LIKE N''%' + @VoucherNo + '%'' '

	IF ISNULL(@ImWareHouseID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(WT95.WareHouseID, '''') IN (''' + @ImWareHouseID + ''') '

		IF ISNULL(@ExWareHouseID,'') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(WT95.WareHouseID, '''') IN (''' + @ExWareHouseID + ''') '
		
	IF ISNULL(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(WT95.ObjectID, '''') LIKE N''%' + @ObjectID + '%'' '
	
END

SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, A.*
	FROM (
		SELECT WT95.APK, WT95.VoucherTypeID, WT95.VoucherNo, WT95.VoucherDate, WT95.RefNo01, WT95.RefNo02,
		ConvertedAmount = (Select Sum(WT0096.OriginalAmount) from WT0096 Where voucherID = WT95.VoucherID AND DivisionID = WT95.DivisionID),WT95.ObjectID,
		WT95.ObjectID+'' - '' + isnull(AT1202.ObjectName,'''') AS ObjectName, WT95.EmployeeID, A01.FullName AS EmployeeName,
		'+@sSelect+'


		WT95.Description,	WT95.VoucherID, WT95.Status, W01.[Description] as StatusName, W01.[DescriptionE] as StatusNameE,		
		WT95.DivisionID,	WT95.TranMonth, OOT99.Description as ApprovePersonStatus,
		WT95.TranYear, WT95.CreateUserID, A45.UserName AS CreateUserName, WT95.KindVoucherID,	WT95.EVoucherID
		FROM WT0095 WT95 WITH (NOLOCK)
		LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = WT95.ObjectID
		LEFT JOIN WV0001 W01 WITH (NOLOCK) ON WT95.[Status] = W01.[Code] and W01.[TypeID] = ''Status''
		LEFT JOIN AT1303 A33 WITH (NOLOCK) ON A33.WareHouseID = WT95.WareHouseID
		LEFT JOIN AT1303 A03 WITH (NOLOCK) ON A03.WareHouseID = WT95.WareHouseID2
		LEFT JOIN AT1405 A45 WITH (NOLOCK) ON A45.DivisionID = WT95.DivisionID AND A45.UserID = WT95.CreateUserID
		LEFT JOIN OOT0099 OOT99 WITH (NOLOCK) ON OOT99.ID1 = WT95.IsCheck AND OOT99.CodeMaster=''Status''
		LEFT JOIN AT1103 A01 WITH (NOLOCK) ON A01.EmployeeID = WT95.EmployeeID
		'+@sSQLPer+'
		WHERE WT95.DivisionID = ''' + @DivisionID + '''
		--AND WT95.ObjectID = '''+@UserID+'''
		'+@sWhere+@sWHEREPer+'
		) A
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

PRINT (@sSQL)
EXEC (@sSQL)












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
