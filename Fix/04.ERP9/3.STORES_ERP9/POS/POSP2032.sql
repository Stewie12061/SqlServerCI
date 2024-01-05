IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'POSP2032') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE POSP2032
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid master Form POSF2033 (Phiếu đề nghị xuất hóa đơn) Kế thừa phiếu bán hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date 07/08/2017
----Edit by: hoàng vũ, 02/05/2018: lấy thêm 4 trường: DeliveryAddress, DeliveryContact, DeliveryMobile, DeliveryReceiver
----Edit by: hoàng vũ, 25/01/2019: Chặn những phiếu đã kết chuyển/đã lập đề nghị 
-- <Example>
/* 
EXEC POSP2032 'HCM','CH-HCM001','','', 1, '2015-01-01', '2017-12-30', '11/2017'',''12/2017' ,'NV01',1,50
*/
----
CREATE PROCEDURE POSP2032 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ShopID  NVARCHAR(250),--Biến môi trường
        @VoucherNo  NVARCHAR(250),
		@MemberID  NVARCHAR(250),
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
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
	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),M.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  (CASE WHEN M.TranMonth <10 THEN ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
				ELSE rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) END) in ('''+@Period +''')'
	--Check Para DivisionIDList null then get DivisionID 
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + 'and M.DivisionID = '''+ @DivisionID+''''
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@MemberID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.MemberID, '''') LIKE N''%'+@MemberID+'%''  or ISNULL(M.MemberName, '''') LIKE N''%'+@MemberID+'%'')'
	IF Isnull(@ShopID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID, '''') = '''+@ShopID+''''
	
	SET @sSQL = '
		SELECT Distinct M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID
				, Case when M.CVoucherNo is null then M.VoucherNo
					   when M.CVoucherNo is not null then M.CVoucherNo
					   else NULL end as VoucherNo
				, M.VoucherDate, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID
				, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear
				, Case when M.CVoucherNo is null then M.TotalInventoryAmount 
					   when M.CVoucherNo is not null then M.ChangeAmount
					   Else 0 end as TotalAmount
				, M.SaleManID, P06.PaymentID01 as PaymentID, P10.ShopName
				, M.PVoucherNo, M.CVoucherNo, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
		Into #TemPOST0016
		FROM POST0016 M With (NOLOCK) 
					Left join POST00161 D WITH (NOLOCK) On M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
					LEFT JOIN POST0006 P06 With (NOLOCK) On P06.APK = M.APKPaymentID
					LEFT JOIN POST0010 P10 With (NOLOCK) On P10.DivisionID = M.DivisionID and P10.ShopID = M.ShopID
					Left join POST2031 P31  WITH (NOLOCK) On P31.DivisionID = D.DivisionID and P31.APKMInherited = D.APKMaster and P31.APKDInherited = D.APK and P31.DeleteFlg = 0
					Left join AT9000 A90  WITH (NOLOCK) On A90.DivisionID = D.DivisionID and A90.InheritVoucherID = M.APK and A90.InheritTransactionID = D.APK and A90.InheritTableID = ''POST0016'' and A90.OrderID is not null and a90.TransactionTypeID = ''T04''
		WHERE '+@sWhere+' and M.DeleteFlg =0 and M.PVoucherNo is null and M.CVoucherNo is null and P31.APKMInherited is null
						  and (Case when Isnull(Cast(P31.APK as nvarchar(50)), '''') = '''' and Isnull(A90.VoucherID, '''') = '''' then 1 else 0 end) = 1
							
		Declare @Count int
		Select @Count = Count(VoucherNo) From  #TemPOST0016

		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow, M.APK, M.DivisionID, M.ShopID, M.VoucherTypeID, M.VoucherNo
				, convert(varchar(20), M.VoucherDate, 103) as VoucherDate, M.MemberID, M.MemberName , M.CreateDate, M.CreateUserID, M.LastModifyUserID
				, M.LastModifyDate, M.TranMonth, M.TranYear, M.TotalAmount, M.SaleManID, M.PaymentID, M.ShopName, M.PVoucherNo, M.CVoucherNo
				, M.DeliveryAddress, M.DeliveryContact, M.DeliveryMobile, M.DeliveryReceiver
		From  #TemPOST0016 M
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	EXEC (@sSQL)
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
