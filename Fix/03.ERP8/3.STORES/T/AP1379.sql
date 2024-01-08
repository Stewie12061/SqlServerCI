IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'AP1379') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE AP1379
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form AF0379 Kế thừa phiếu bán hàng từ POS
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 11/12/2017
----Modify by Thị Phượng Date 28/02/2018: Lấy thêm địa chỉ và Tên người nhận để đưa vào màn hình chi và chi qua ngân hàng
----Modify by Thị Phượng Date 13/03/2018: Fix bug dữ liệu số tiền còn lại
-- <Example>
/* 
exec AP1379 @DivisionID='HCM',@ObjectID=N'',@VoucherNo=N'',@IsDate=1,@FromDate='2017-12-13 00:00:00',@ToDate='2018-02-28 00:00:00',@FromMonth=2,@FromYear=2018,@ToMonth=2,@ToYear=2018,@UserID='PHUONG'
*/
----
CREATE PROCEDURE AP1379 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ObjectID  NVARCHAR(250),--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@FromMonth Int,
		@FromYear  Int,
		@ToMonth Int,
		@ToYear Int,
		@UserID  VARCHAR(50)
		
) 
AS 
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere=''
SET @OrderBy = 'M.VoucherNo'
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),M.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 0 
	SET @sWhere = @sWhere + 'M.TranYear * 100 + M.TranMonth BETWEEN '+STR(@FromYear * 100 + @FromMonth)+' AND '+STR(@ToYear * 100 + @ToMonth)+' '
	--Check Para DivisionIDList null then get DivisionID 
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'and M.DivisionID = '''+ @DivisionID+''''
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@ObjectID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID, '''') = '''+@ObjectID+''''
	


SET @sSQL = '
	SELECT M.APK, M.DivisionID, M.ShopID, D.ShopName , M.VoucherTypeID, M.VoucherNo,  M.VoucherDate
	, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
	, M.TotalInventoryAmount, Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount
                   when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
                   end), 0) - Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(Sum(ERP.OriginalAmount), 0)
				    as SumAmount, M.SaleManID, B.FullName SaleManName
	, D.Address, D.Tel, M.Notes
	Into #TemPOST0016
	FROM POST0016 M With (NOLOCK) 
	Left join (
                    Select D.APKMInherited as APKBanDoi, Sum(Amount) as ThuTien
                    from POST00801 M WITH (NOLOCK) inner join POST00802 D WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg 
                    Where Isnull(M.IsDeposit, 0) = 0 and  isnull(IsPayInvoice, 0) in (0, 2,3) and D.APKMInherited is not null and M.DeleteFlg = 0
                    Group by D.APKMInherited
          ) THU on M.APK = THU.APKBanDoi
        --Lấy phiếu thu dưới ERP kế thừa từ phiếu bán hàng
    Left join AT9000 ERP WITH (NOLOCK) on ERP.InheritInvoicePOS = Cast(M.APK as nvarchar(50)) and ERP.IsInheritInvoicePOS = 1 
	LEFT JOIN POST0010 D With (NOLOCK) ON D.DivisionID = M.DivisionID and D.ShopID = M.ShopID
	LEFT JOIN AT1103 B With (NOLOCK) ON B.EmployeeID = M.SaleManID
	WHERE '+@sWhere+' and M.DeleteFlg =0 
	Group by M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo, M.VoucherDate, D.ShopName
	, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
	 , M.SaleManID, B.FullName, M.TotalInventoryAmount, D.Address, D.Tel, M.Notes, M.BookingAmount, M.PvoucherNo, M.CVoucherNo, THU.ThuTien,  M.ChangeAmount
	Having  Isnull((Case when M.PvoucherNo is null and M.CVoucherNo is null then M.TotalInventoryAmount
                   when M.CVoucherNo is not null and ChangeAmount > 0 then M.ChangeAmount
                   end), 0) - Isnull(THU.ThuTien, 0) - Isnull(M.BookingAmount, 0)- Isnull(Sum(ERP.OriginalAmount), 0) >0
	Declare @Count int
	Select @Count = Count(VoucherNo) From  #TemPOST0016

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo
	, M.VoucherDate, M.MemberID, M.MemberName , M.ShopName, M.SaleManID, M.SaleManName
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.TotalInventoryAmount as TotalAmount, M.SumAmount
	, M.Address, M.Tel, M.Notes
	From  #TemPOST0016 M
	ORDER BY '+@OrderBy+''

EXEC (@sSQL)
--Print @sSQL
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
