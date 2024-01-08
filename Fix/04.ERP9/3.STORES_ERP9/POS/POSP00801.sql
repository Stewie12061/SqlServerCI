IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00801]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form POSF0080 Danh mục phiếu thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 04/08/2017
----Modified by Thị Phượng on 08/12/2017 Load thêm tổng tiền và Phiếu đặt cọc
----Modified by Hoàng vũ on 18/01/2018 Bổ sung điều kiện search trạng thái hủy
----Modified by Thị Phượng on 31/01/2018 Chỉnh sửa trường hợp phiếu thu có nhiều dòng không bị double dữ liệu
----Modified by Hoàng vũ on 31/01/2018: Sắp xếp giảm dần
----Modified by Thị Phượng on 01/03/2018 Bổ sung lấy thêm trường chứng từ tham chiếu InheritVoucher
----Modified by Hoàng vũ on 05/07/2019: Fixbug search bị lỗi hội viên
-- Modified by Tuấn Anh on 27/12/2019: Bổ sung điều kiện lọc theo số tham chiếu
-- <Example>
/* 
EXEC POSP00801 'MS','','MS','','','','','', 0, '2015-01-01', '2018-12-30', '04/2017'',''08/2017' ,'', '',1,20
*/
----
CREATE PROCEDURE POSP00801 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@DivisionIDList NVARCHAR(2000),  --Chọn trong DropdownChecklist DivisionID
		@ShopID  NVARCHAR(250),
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@VoucherTypeID  NVARCHAR(250),
		@CashierID  NVARCHAR(250),
		@EmployeeID  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@DeleteFlg NVARCHAR(50) = NULL,
		@PageNumber INT,
		@PageSize INT,
		@ShopIDPermission NVARCHAR(MAX) = NULL
) 
AS 
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@sWhere1 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere=''
SET @sWhere1=''
SET @OrderBy = ' M.VoucherDate desc, M.VoucherNo'
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),POST00801.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  (CASE WHEN POST00801.TranMonth <10 THEN ''0''+rtrim(ltrim(str(POST00801.TranMonth)))+''/''+ltrim(Rtrim(str(POST00801.TranYear))) 
				ELSE rtrim(ltrim(str(POST00801.TranMonth)))+''/''+ltrim(Rtrim(str(POST00801.TranYear))) END) in ('''+@Period +''')'

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '')!=''
		SET @sWhere = @sWhere + ' AND POST00801.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' AND POST00801.DivisionID IN ('''+@DivisionID+''')'

	IF Isnull(@ShopID, '')!=''
	BEGIN
		SET @sWhere = @sWhere + ' AND ISNULL(POST00801.ShopID,'''') LIKE N''%'+@ShopID+'%'' '
	END
	SET @sWhere = @sWhere + ' AND POST00801.ShopID IN ('''+@ShopIDPermission+''')'

	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere1 = @sWhere1 + ' AND (ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' or ISNULL(M.InheritVoucherA, '''') LIKE N''%'+@VoucherNo+'%'' or ISNULL(M.InheritVoucherB, '''') LIKE N''%'+@VoucherNo+'%'' )'
	IF Isnull(@MemberID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(D.MemberID, '''') LIKE N''%'+@MemberID+'%''  or ISNULL(A103.MemberName, '''') LIKE N''%'+@MemberID+'%'')'
	IF Isnull(@VoucherTypeID, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(POST00801.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
	IF Isnull(@EmployeeID, '') != '' 
		SET @sWhere = @sWhere + ' AND (ISNULL(POST00801.EmployeeID, '''') LIKE N''%'+@EmployeeID+'%''  or ISNULL(A03.FullName, '''') LIKE N''%'+@EmployeeID+'%'')' 
	IF Isnull(@CashierID, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(POST00801.CashierID, '''') LIKE N''%'+@CashierID+'%'''
	IF Isnull(@DeleteFlg, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(POST00801.DeleteFlg,'''') LIKE N''%'+@DeleteFlg+'%'''


SET @sSQL = '
SELECT POST00801.APK, POST00801.DivisionID
, POST00801.ShopID, POST00801.VoucherTypeID, POST00801.VoucherNo
, POST00801.VoucherDate
, Stuff(isnull((	Select  '', '' + C.MemberID From  POST00802 C WITH (NOLOCK)
					Where C.MemberID = D.MemberID 
					Group By C.MemberID
					FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as MemberID
, Stuff(isnull((	Select  '', '' + x.MemberName From  POST00802 C WITH (NOLOCK)
					LEFT JOIN POST0011 x With (NOLOCK) on C.MemberID = x.MemberID
					Where C.MemberID = D.MemberID 
					Group By C.MemberID, x.MemberName
					FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as MemberName
, POST00801.CurrencyID, POST00801.CreateDate, POST00801.CreateUserID, POST00801.LastModifyUserID, POST00801.LastModifyDate
, POST00801.TranMonth, POST00801.TranYear, A03.FullName EmployeeID, POST00801.DeleteFlg
, POST00801.CashierID, POST00801.RelatedToTypeID, Case WHEN POST00801.IsPayInvoice = 1 then 1 else POST00801.IsDeposit end  as IsDeposit
, Sum(D.Amount) as Amount
, Stuff(isnull((	Select  '', '' + C.VoucherNoInherited From  POST00802 C WITH (NOLOCK)
					Where C.APKMaster = D.APKMaster and C.VoucherNoInherited = D.VoucherNoInherited
					Group By C.VoucherNoInherited, C.APKMaster
					FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InheritVoucherA
, Stuff(isnull((	Select  '', '' + C.DepositVoucherNo From  POST00802 C WITH (NOLOCK)
					Where C.APKMaster = D.APKMaster and C.DepositVoucherNo = D.DepositVoucherNo
					Group By C.DepositVoucherNo, C.APKMaster
					FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InheritVoucherB
, Stuff(isnull((	Select  '', '' + C.ServiceRequestVoucherNo From  POST00802 C WITH (NOLOCK)
					Where C.APKMaster = D.APKMaster and C.ServiceRequestVoucherNo = D.ServiceRequestVoucherNo
					Group By C.ServiceRequestVoucherNo, C.APKMaster
					FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as InheritVoucherC

Into #TemPOST00801
FROM POST00801 With (NOLOCK) 
Inner join POST00802 D With (NOLOCK) On D.APKMaster =POST00801.APK and D.DeleteFlg = POST00801.DeleteFlg
			Left join AT1103 A03 With (NOLOCK) on POST00801.EmployeeID = A03.EmployeeID
			Left join POST0011 A103 With (Nolock) on D.MemberID = A103.MemberID
			
	WHERE '+@sWhere+' 
Group by POST00801.APK, POST00801.DivisionID, POST00801.ShopID, POST00801.VoucherTypeID, POST00801.VoucherNo, 
POST00801.VoucherDate, D.MemberID,POST00801.IsPayInvoice , POST00801.CurrencyID, POST00801.CreateDate, POST00801.CreateUserID, POST00801.LastModifyUserID, POST00801.LastModifyDate
, POST00801.TranMonth, POST00801.TranYear, A03.FullName, POST00801.DeleteFlg
, POST00801.CashierID, POST00801.RelatedToTypeID, POST00801.IsDeposit, D.DepositVoucherNo, D.VoucherNoInherited,D.ServiceRequestVoucherNo, D.APKMaster
	Declare @Count int
	Select @Count = Count(VoucherNo) From  #TemPOST00801

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo
	, M.VoucherDate, M.DeleteFlg, M.MemberID
	, M.MemberName , M.CurrencyID
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.EmployeeID
	, M.CashierID, M.RelatedToTypeID, M.IsDeposit, M.Amount, Isnull(InheritVoucherB,'''')+ Isnull(InheritVoucherA,'''') + Isnull(InheritVoucherC,'''') as InheritVoucher
	From  #TemPOST00801 M
	Where 1=1'+@sWhere1+' 
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL)

print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

