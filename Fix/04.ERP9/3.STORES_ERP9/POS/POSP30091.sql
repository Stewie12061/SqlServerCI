IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP30091]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP30091]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- BÁO CÁO TỔNG HỢP DOANH SỐ MẶT HÀNG (Tổng hợp bán hàng theo mặt hàng)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ on 26/12/2016
----Modify by: Hoàng Vũ: Bổ sung chức năng dùng chung
----Modify by: Hoàng Vũ, 28/08/2017: lấy thêm tiền chênh lệch khuyến mãi vào doanh số
----Modify by: Thị Phượng, 13/03/2018: Fix bug lấy trường hợp mẫu bằng 0 thì không chia dữ liệu tránh lỗi
----Modify by: Hoàng Vũ, 27/08/2018: Load lại tiền phiếu đổi hàng có chiết khấu tổng hóa đơn
----Modify by: Hoàng Vũ, 03/01/2019: Fixbug lỗi tính toán công thức thiếu trừ chiết khấu, Phải thu chưa xử lý giá trước thuế/sau thuế
---- Modify by: Hoàng Vũ, 15/05/2019: Xử lý chuẩn về trường hợp báo cáo MINHSANG, OKIA, NHANNGOC, chuyển qua chuẩn (Bổ sung sử dụng phiếu quà tặng)
-- <Example>
/*
exec sp_executesql N'POSP30091 @DivisionID=N''VS'',@DivisionIDList=null,@ShopID=N''CH001'',@ShopIDList=null,@EmployeeID=null,@IsDate=1,@FromDate=N''2018-10-05 00:00:00'',@ToDate=N''2018-10-05 00:00:00'',@PeriodIDList=null,@FromMemberID=null,@ToMemberID=null,@FromInventoryID=null,@ToInventoryID=null,@UserID=N''AS001''',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(2)',@CreateUserID=N'AS001',@LastModifyUserID=N'AS001',@DivisionID=N'VS'
*/


CREATE PROCEDURE POSP30091 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@EmployeeID			VARCHAR(50),	
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@ToMemberID			VARCHAR(MAX) ='',
	@FromMemberID		VARCHAR(MAX) ='',
	@FromInventoryID	NVARCHAR(MAX) ='',
	@ToInventoryID		VARCHAR(MAX) ='',
	@UserID				VARCHAR(50),
	@ListInventoryID	VARCHAR(MAX) ='',
	@ListMemberID	    VARCHAR(MAX) ='',
	@ListEmployeeID	    VARCHAR(MAX) =''
)
AS
	DECLARE @sSQL01   NVARCHAR(MAX),  
			@sSQL02   NVARCHAR(MAX),  
			@sSQL03   NVARCHAR(MAX),  
			@sSQL04   NVARCHAR(MAX),  
			@sSQL05   NVARCHAR(MAX),  
			@sSQL06   NVARCHAR(MAX),  
			@sWhere NVARCHAR(MAX),
			@Date  NVARCHAR(MAX),
			@GroupDate NVARCHAR(MAX)
	SET @GroupDate = ''
	SET @Date = ''
	SET @sWhere = ''

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList,'') = ''
	SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''')'
	Else 
	SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+@DivisionIDList+''')'

	--Check Para @ShopIDList null then get ShopID 
	IF Isnull(@ShopIDList,'') = ''
	SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopID+''')'
	Else 
	SET @sWhere = @sWhere + ' And M.ShopID IN ('''+@ShopIDList+''')'

	IF Isnull(@EmployeeID, '')!= ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SaleManID, M.EmployeeID) = N'''+@EmployeeID+''''

	IF @IsDate = 1	
	Begin
		SET @Date = @Date + ''''+CONVERT(VARCHAR,@FromDate,103)  +''' as FromDate,'''+CONVERT(VARCHAR,@ToDate,103)+ ''' as ToDate'
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	
	end
	ELSE
	Begin
		SET @Date = @Date + ' M.TranMonth, M.TranYear, (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
										Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) as MonthYear '
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
										Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodIDList+''')'
		SET @GroupDate = @GroupDate + ',M.TranMonth, M.TranYear'
	End	
	--Search theo hội viên  (Dữ liệhội viên nhiều nên dùng control từ hội viên , đến hội viên
	IF Isnull(@FromMemberID, '')!= '' and Isnull(@ToMemberID, '') = ''
		SET @sWhere = @sWhere + ' AND M.MemberID > = N'''+@FromMemberID +''''
	ELSE IF Isnull(@FromMemberID, '') = '' and Isnull(@ToMemberID, '') != ''
		SET @sWhere = @sWhere + ' AND M.MemberID < = N'''+@ToMemberID +''''
	ELSE IF Isnull(@FromMemberID, '') != '' and Isnull(@ToMemberID, '') != ''
		SET @sWhere = @sWhere + ' AND M.MemberID Between N'''+@FromMemberID+''' AND N'''+@ToMemberID+''''

	--Search theo vật tư (Dữ liệu vật tư nhiều nên dùng control từ vật tư , đến vật tư
	IF Isnull(@FromInventoryID, '')!= '' and Isnull(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND D.InventoryID > = N'''+@FromInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') = '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND D.InventoryID < = N'''+@ToInventoryID +''''
	ELSE IF Isnull(@FromInventoryID, '') != '' and Isnull(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND D.InventoryID Between N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	IF Isnull(@ListInventoryID, '')!= ''
		SET @sWhere = @sWhere + ' AND D.InventoryID IN (N'''+@ListInventoryID+''')'

 	IF Isnull(@ListMemberID, '')!= ''
		SET @sWhere = @sWhere + ' AND  M.MemberID IN (N'''+@ListMemberID+''')'

	IF Isnull(@ListEmployeeID, '')!= ''
		SET @sWhere = @sWhere + ' AND Isnull(M.SaleManID, M.EmployeeID) IN (N'''+@ListEmployeeID+''')'
			    
	SET @sSQL01 = N'---------- Phiếu bán hàng
					Select   D.InventoryID, A02.UnitID, D.ActualQuantity, D.UnitPrice
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.Amount
								   Else 0 end Amount
							, D.DiscountRate
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.DiscountAmount
								   Else 0 end DiscountAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.InventoryAmount
								   Else 0 end InventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then Isnull(DiscountAllocation, Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ TotalAmount END) 
								   Else 0 end as DiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then Isnull(RedureAllocation, Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ TotalAmount END  )
								   Else 0 end as RedureInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalGiftVoucherAmount * D.InventoryAmount)/ M.TotalAmount END) 
								   Else 0 end as GiftInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.DiscountAmount 
										+ Isnull(DiscountAllocation, Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ TotalAmount END) 
										+ Isnull(RedureAllocation, Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ TotalAmount END  )
									Else 0 End as TotalDiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.TaxAmount
								   Else 0 end TaxAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then   Case when Isnull(D.IsTaxIncluded, 0) = 0 
											   Then D.Amount  
													- D.DiscountAmount 
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalDiscountAmount * D.InventoryAmount)/ M.TotalAmount END)
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalRedureAmount * D.InventoryAmount)/ M.TotalAmount END)
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalGiftVoucherAmount * D.InventoryAmount)/ M.TotalAmount END) 
													+ D.TaxAmount 
													+ Isnull(D.PromoteChangeUnitPrice, 0) 
											   Else
													 D.Amount  
													- D.DiscountAmount 
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalDiscountAmount * D.InventoryAmount)/ M.TotalAmount END)
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalRedureAmount * D.InventoryAmount)/ M.TotalAmount END)
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalGiftVoucherAmount * D.InventoryAmount)/ M.TotalAmount END) 
													+ Isnull(D.PromoteChangeUnitPrice, 0) 
											   End 
									Else 0 End as ReceiveAmount'
	SET @sSQL02 = N'		, Isnull(D.IsTaxIncluded, 0) as IsTaxIncluded, D.VATGroupID, D.VATPercent, D.IsPromotion, D.EVoucherNo, D.MarkQuantity, D.Ana01ID, D.Ana02ID, D.Ana03ID, D.Ana04ID
							, D.Ana05ID, D.Ana06ID, D.Ana07ID, D.Ana08ID, D.Ana09ID, D.Ana10ID, M.DivisionID, M.ShopID, P10.ShopName, M.VoucherTypeID, M.VoucherNo, M.TranMonth, M.TranYear
							, M.VoucherDate, M.ObjectID, M.ObjectName, Isnull(M.SaleManID, M.EmployeeID) as EmployeeID, Isnull(A03.FullName, M.EmployeeName) as EmployeeName, M.MemberID
							, M.MemberName, M.APKPaymentID, M.CurrencyID, M.CurrencyName, M.ExchangeRate, M.TotalAmount, M.TotalDiscountRate, M.TotalDiscountAmount, M.TotalRedureRate
							, M.TotalRedureAmount, M.TotalTaxAmount, M.TotalInventoryAmount, M.Change, M.Description, D.WareHouseID, D.WareHouseName, D.InventoryName, A04.UnitName
					into #POST0016
					from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									 Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
									 Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
									 Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
									 Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
					Where M.DeleteFlg = 0 and M.CVoucherNo is null and M.PVoucherNo is null'+@sWhere+' 
					---------- Phiếu trả hàng
					Union all 
					Select  D.InventoryID, A02.UnitID, (-1)*D.ActualQuantity, D.UnitPrice
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.Amount
								   Else 0 end Amount
							, D.DiscountRate
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.DiscountAmount
								   Else 0 end DiscountAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.InventoryAmount
								   Else 0 end InventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*Isnull(DiscountAllocation, Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ TotalAmount END) 
								   Else 0 end as DiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*Isnull(RedureAllocation, Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ TotalAmount END)
								   Else 0 end as RedureInventoryAmount					
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*(Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (M.TotalGiftVoucherAmount * D.InventoryAmount)/ M.TotalAmount END) 
								   Else 0 end as GiftInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.DiscountAmount 
											+ (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (-1)*(M.TotalDiscountAmount * D.InventoryAmount)/ M.TotalAmount END)
											+ (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (-1)*(M.TotalRedureAmount * D.InventoryAmount)/ M.TotalAmount END)
									Else 0 End as TotalDiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.TaxAmount
								   Else 0 end TaxAmount'
	SET @sSQL03 = N'		, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then   Case when Isnull(D.IsTaxIncluded, 0) = 0 
											   Then (-1)*D.Amount  
													- (-1)*D.DiscountAmount 
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (-1)*(M.TotalDiscountAmount * D.InventoryAmount)/ M.TotalAmount END)
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (-1)*(M.TotalRedureAmount * D.InventoryAmount)/ M.TotalAmount END)
													+ (-1)*D.TaxAmount 
													+ (-1)*Isnull(D.PromoteChangeUnitPrice, 0) 
											   Else  (-1)*D.Amount  
													- (-1)*D.DiscountAmount 
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (-1)*(M.TotalDiscountAmount * D.InventoryAmount)/ M.TotalAmount END)
													- (Case WHEN isnull(TotalAmount, 0) = 0 THEN 0 ELSE (-1)*(M.TotalRedureAmount * D.InventoryAmount)/ M.TotalAmount END)
													+ (-1)*Isnull(D.PromoteChangeUnitPrice, 0) 
											   End 
									Else 0 End as ReceiveAmount
							, Isnull(D.IsTaxIncluded, 0) as IsTaxIncluded, D.VATGroupID, D.VATPercent, D.IsPromotion, D.EVoucherNo, D.MarkQuantity, D.Ana01ID, D.Ana02ID, D.Ana03ID, D.Ana04ID
							, D.Ana05ID, D.Ana06ID, D.Ana07ID, D.Ana08ID, D.Ana09ID, D.Ana10ID, M.DivisionID, M.ShopID, P10.ShopName, M.VoucherTypeID, M.PVoucherNo, M.TranMonth, M.TranYear
							, M.VoucherDate, M.ObjectID, M.ObjectName, Isnull(M.SaleManID, M.EmployeeID) as EmployeeID, Isnull(A03.FullName, M.EmployeeName) as EmployeeName, M.MemberID
							, M.MemberName, M.APKPaymentID, M.CurrencyID, M.CurrencyName, M.ExchangeRate, (-1)*M.TotalAmount, M.TotalDiscountRate, (-1)*M.TotalDiscountAmount, M.TotalRedureRate
							, (-1)*M.TotalRedureAmount, (-1)*M.TotalTaxAmount, (-1)*M.TotalInventoryAmount, M.Change, M.Description, D.WareHouseID, D.WareHouseName, D.InventoryName, A04.UnitName 
					From POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
									Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
									Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
									Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
					Where M.DeleteFlg = 0 and M.PVoucherNo is not null'+@sWhere+' 
					-------- Phiếu đổi hàng (Xuất: giống phiếu bán hàng mới)
					Union all '
	SET @sSQL04 = N'Select  D.InventoryID, A02.UnitID,  D.ActualQuantity, D.UnitPrice
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.Amount
								   Else 0 end Amount
							, D.DiscountRate
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.DiscountAmount
								   Else 0 end DiscountAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.InventoryAmount
								   Else 0 end InventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then Isnull(DiscountAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ P4.TotalAmount END) 
								   Else 0 end as DiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then Isnull(RedureAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ P4.TotalAmount END)
								   Else 0 end as RedureInventoryAmount
							, 0 as GiftInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.DiscountAmount 
										+ Isnull(DiscountAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ P4.TotalAmount END) 
										+ Isnull(RedureAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ P4.TotalAmount END)
									Else 0 End as TotalDiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then D.TaxAmount
								   Else 0 end TaxAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then   Case when Isnull(D.IsTaxIncluded, 0) = 0
												Then D.Amount  
													- D.DiscountAmount 
													- Isnull(DiscountAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ P4.TotalAmount END) 
													- Isnull(RedureAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ P4.TotalAmount END)
													+ D.TaxAmount 
													+ Isnull(D.PromoteChangeUnitPrice, 0) 
												Else 
													D.Amount  
													- D.DiscountAmount 
													- Isnull(DiscountAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalDiscountAmount * InventoryAmount)/ P4.TotalAmount END) 
													- Isnull(RedureAllocation, Case WHEN isnull(P4.TotalAmount, 0) = 0 THEN 0 ELSE (TotalRedureAmount * InventoryAmount)/ P4.TotalAmount END)
													+ Isnull(D.PromoteChangeUnitPrice, 0) 
												End 
									Else 0 End as ReceiveAmount
							, Isnull(D.IsTaxIncluded, 0) as IsTaxIncluded, D.VATGroupID, D.VATPercent, D.IsPromotion, D.EVoucherNo, D.MarkQuantity, D.Ana01ID, D.Ana02ID, D.Ana03ID, D.Ana04ID
							, D.Ana05ID, D.Ana06ID, D.Ana07ID, D.Ana08ID, D.Ana09ID, D.Ana10ID, M.DivisionID, M.ShopID, P10.ShopName, M.VoucherTypeID, M.CVoucherNo, M.TranMonth, M.TranYear
							, M.VoucherDate, M.ObjectID, M.ObjectName, Isnull(M.SaleManID, M.EmployeeID) as EmployeeID, Isnull(A03.FullName, M.EmployeeName) as EmployeeName, M.MemberID
							, M.MemberName, M.APKPaymentID, M.CurrencyID, M.CurrencyName, M.ExchangeRate, M.TotalAmount, M.TotalDiscountRate, M.TotalDiscountAmount, M.TotalRedureRate
							, M.TotalRedureAmount, M.TotalTaxAmount, M.TotalInventoryAmount, M.Change, M.Description, D.WareHouseID, D.WareHouseName, D.InventoryName, A04.UnitName
					
					from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg	'
	SET @sSQL05 = N'
									Left join ( Select M.APK, M.DivisionID, M.ShopID, Sum(D.InventoryAmount) as TotalAmount
												From POST0016 M inner join POST00161 D on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
												Where M.DeleteFlg = 0 and M.CVoucherNo is not null and IsKindVoucherID = 2'+@sWhere+' 
												Group by M.APK, M.DivisionID, M.ShopID
												) P4 on M.DivisionID = P4.DivisionID and M.APK = P4.APK
									Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
									Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
									Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
									Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
					Where M.DeleteFlg = 0 and M.CVoucherNo is not null and IsKindVoucherID = 2'+@sWhere+' 
					------------ Phiếu đổi hàng (Nhập: giống phiếu trả hàng mới)
					Union all
					Select  D.InventoryID, A02.UnitID, (-1)*D.ActualQuantity as ActualQuantity, D.UnitPrice
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.Amount
								   Else 0 end Amount
							, D.DiscountRate
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*D.DiscountAmount
								   Else 0 end DiscountAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*Isnull(D.InventoryAmount, 0)
								   Else 0 end InventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*Isnull(D.DiscountAllocation, 0)
								   Else 0 end as DiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*Isnull(D.RedureAllocation, 0)
								   Else 0 end as RedureInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then Case when Isnull(M.TotalGiftVoucherAmount, 0) != 0
											 Then  (-1)*(Case when Isnull(PTH.TotalAmount, 0) ! = 0 then (D.InventoryAmount * M.TotalGiftVoucherAmount/PTH.TotalAmount) else 0 end)
											 Else 0 End
								   Else 0 End as GiftInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then	  (-1)*D.DiscountAmount 
										+ (-1)*Isnull(D.DiscountAllocation, 0)
										+ (-1)*Isnull(D.RedureAllocation, 0)
									Else 0 End as TotalDiscountInventoryAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then (-1)*Isnull(D.TaxAmount, 0)
								   Else 0 end TaxAmount
							, Case when Isnull(A02.IsGiftVoucher, 0) = 0 
								   then   Case when Isnull(D.IsTaxIncluded, 0) = 0
											   Then   (-1)*D.Amount  
													- (-1)*Isnull(D.DiscountAmount, 0) 
													- (-1)*Isnull(D.DiscountAllocation, 0) 
													- (-1)*Isnull(D.RedureAllocation, 0) 
													- (-1)*(Case when Isnull(M.TotalGiftVoucherAmount, 0) != 0
															Then  (Case when Isnull(PTH.TotalAmount, 0) ! = 0 then (D.InventoryAmount * M.TotalGiftVoucherAmount/PTH.TotalAmount) else 0 end)
															Else 0 End)
													+ (-1)*Isnull(D.TaxAmount, 0) 
											   Else
													  (-1)*D.Amount  
													- (-1)*Isnull(D.DiscountAmount, 0) 
													- (-1)*Isnull(D.DiscountAllocation, 0) 
													- (-1)*Isnull(D.RedureAllocation, 0) 
													- (-1)*(Case when Isnull(M.TotalGiftVoucherAmount, 0) != 0
															Then  (Case when Isnull(PTH.TotalAmount, 0) ! = 0 then (D.InventoryAmount * M.TotalGiftVoucherAmount/PTH.TotalAmount) else 0 end)
															Else 0 End)
											   End 
									Else 0 End as ReceiveAmount'

	SET @sSQL06 = N'		, Isnull(D.IsTaxIncluded, 0) as IsTaxIncluded, D.VATGroupID, D.VATPercent, D.IsPromotion, D.EVoucherNo, (-1)*D.MarkQuantity, D.Ana01ID, D.Ana02ID, D.Ana03ID, D.Ana04ID
							, D.Ana05ID, D.Ana06ID, D.Ana07ID, D.Ana08ID, D.Ana09ID, D.Ana10ID, M.DivisionID, M.ShopID, P10.ShopName, M.VoucherTypeID, M.CVoucherNo, M.TranMonth, M.TranYear
							, M.VoucherDate, M.ObjectID, M.ObjectName, Isnull(M.SaleManID, M.EmployeeID) as EmployeeID, Isnull(A03.FullName, M.EmployeeName) as EmployeeName, M.MemberID
							, M.MemberName, M.APKPaymentID, M.CurrencyID, M.CurrencyName, M.ExchangeRate, (-1)*M.TotalAmount, M.TotalDiscountRate, 0 as TotalDiscountAmount, M.TotalRedureRate
							, 0 as TotalRedureAmount, (-1)*M.TotalTaxAmount, (-1)*M.TotalInventoryAmount, (-1)*M.Change, M.Description, D.WareHouseID, D.WareHouseName, D.InventoryName, A04.UnitName
					from POST0016 M  WITH (NOLOCK) inner join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
									Left join ( Select M.APK, SUm(((Case when Isnull(D.IsTaxIncluded, 0) = 1 Then Isnull(D.BeforeVATUnitPrice, 0) + Isnull(D.DiscountAmount, 0) 
																				else Isnull(D.UnitPrice, 0) end) * D.ActualQuantity + isnull(D.PromoteChangeUnitPrice, 0) - Isnull(D.DiscountAmount, 0))) as TotalAmount
												From POST0016 M Inner join POST00161 D on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
												WHERE  M.DeleteFlg = 0 AND M.CVoucherNo is not null AND D.IsKindVoucherID = 1 '+@sWhere +'  
												Group by M.APK
											  ) PTH on PTH.APK = D.APKMaster
									Left join POST0010 P10 WITH (NOLOCK) on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
									Left Join AT1302 A02  WITH (NOLOCK) on D.InventoryID = A02.InventoryID
									Left Join AT1304 A04  WITH (NOLOCK) on A02.UnitID = A04.UnitID
									Left Join AT1103 A03  WITH (NOLOCK) on A03.EmployeeID = M.SaleManID
					Where M.DeleteFlg = 0 and M.CVoucherNo is not null and IsKindVoucherID = 1'+@sWhere+' 
					Select M.DivisionID, M.ShopID, M.ShopName,'+ @Date+', M.InventoryID, M.InventoryName, M.UnitName
							, Sum(M.ActualQuantity) as ActualQuantity
							, Isnull(M.IsTaxIncluded, 0) as IsTaxIncluded
							, Case when Sum(M.ActualQuantity) = 0 then 0 else Sum(M.ReceiveAmount)/Sum(M.ActualQuantity) end as UnitPrice
							, Sum(M.Amount) as Amount
							, Sum(Isnull(M.DiscountAmount, 0)) as DiscountAmount
							, Sum(Isnull(M.DiscountInventoryAmount, 0)) as DiscountInventoryAmount
							, Sum(Isnull(M.RedureInventoryAmount, 0)) as RedureInventoryAmount
							, Sum(Isnull(M.TotalDiscountInventoryAmount, 0)) as TotalDiscountInventoryAmount --Tổng chiết khấu cho từng mặt hàng
							, Sum(Isnull(M.GiftInventoryAmount, 0)) as TotalGiftInventoryAmount
							, Sum(Isnull(M.TaxAmount, 0)) as TaxAmount
							, Sum(Isnull(M.ReceiveAmount, 0)) as ReceiveAmount

					from #POST0016 M
					Group by M.DivisionID, Isnull(M.IsTaxIncluded, 0), M.ShopID, M.ShopName, M.InventoryID, M.InventoryName, M.UnitName'+@GroupDate+'
	'
	EXEC (@sSQL01+@sSQL02+@sSQL03+@sSQL04+@sSQL05+@sSQL06)
	PRINT (@sSQL01)
	PRINT (@sSQL02)
	PRINT (@sSQL03)
	PRINT (@sSQL04)
	PRINT (@sSQL05)
	PRINT (@sSQL06)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
