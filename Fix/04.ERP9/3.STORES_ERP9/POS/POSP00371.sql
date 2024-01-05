IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00371]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00371]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- BÁO CÁO TỔNG HỢP DOANH SỐ NHÂN VIÊN
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ on 31/05/2016
----Modify by: Quang hoàng on 05/12/2016: Bổ sung thêm trường Phương thức thanh toán cho TMQ3 , Phát triển đưa vào chuẩn
----Modify by: Thị Phượng, chỉnh sửa bỏ đều kiện M.PVoucherNo is null and M.CVoucherno is null để lên dữ liệu phiếu
----Modify by: Hoàng Vũ, 28/0//2017: Điều kiện lọc kiểm tra nếu không có nhân viên bán hàng thì lấy nhân viên nhập liệu Isnull(SaleManID, EmployeeID)
----Modify by: Hoàng Vũ, 29/06/2018: Sửa cách lấy dữ liệu sao cho các báo cáo bán hàng có số liệu bằng nhau, sửa điều kiện lọc lấy cả phiếu bán hàng/đổi hàng/ trả hàng+ chênh lệch tiền khuyến mãi
----Modify by: Hoàng Vũ, 17/08/2018: Tách thêm cột tiên chênh lệch khuyến mãi để đối chiếu với báo cáo chi tiết bán hàng
----Modify by: Hoàng Vũ, 27/08/2018: Load lại tiền phiếu đổi hàng có chiết khấu tổng hóa đơn
----Modify by: Hoàng Vũ, 03/01/2019: Fixbug lỗi tính toán công thức thiếu trừ chiết khấu, Phải thu chưa xử lý giá trước thuế/sau thuế
----Modify by: Hoàng Vũ, 03/01/2019: Fixbug 1 đối tượng bị tách ra nhiều dòng khác nhau
----Modify by: Hoàng Vũ, 24/04/2019: Bổ sung trừ thêm phần tiền đặt cọc, tiền phiếu quà tặng
----Modify by: Hoàng Vũ, 07/05/2019: Bổ sung doanh số trừ Phiếu quà tặng
-- <Example> 
/*
	exec sp_executesql N'POSP00371 @DivisionID=N''VS'',@DivisionIDList=null,@ShopID=N''CH001'',@ShopIDList=null,@EmployeeID=null,@IsDate=1,@FromDate=N''2018-10-05 00:00:00'',@ToDate=N''2018-10-05 00:00:00'',@PeriodIDList=null,@UserID=N''AS001'',@PaymentID=null',N'@CreateUserID nvarchar(5),@LastModifyUserID nvarchar(5),@DivisionID nvarchar(2)',@CreateUserID=N'AS001',@LastModifyUserID=N'AS001',@DivisionID=N'VS'
*/
CREATE PROCEDURE POSP00371 
(
	@DivisionID			VARCHAR(50),
	@DivisionIDList		NVARCHAR(MAX),
	@ShopID				VARCHAR(50),
	@ShopIDList			NVARCHAR(MAX),
	@EmployeeID			VARCHAR(50)='',	
	@IsDate				TINYINT,  --1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@UserID				VARCHAR(50),
	@PaymentID			VARCHAR(50),
	@ListEmployeeID		VARCHAR(MAX)=''
)
AS
DECLARE @sSQL01   NVARCHAR(MAX)='',  
		@sSQL02   NVARCHAR(MAX)='',  
		@sSQL03   NVARCHAR(MAX)='',  
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


IF Isnull(@EmployeeID, '')<> ''
	SET @sWhere = @sWhere + ' AND Isnull(M.SaleManID, '''') = '''+@EmployeeID+''''

IF Isnull(@ListEmployeeID, '')<> ''
	SET @sWhere = @sWhere + ' AND Isnull(M.SaleManID, '''') IN ('''+@ListEmployeeID+''')'

IF Isnull(@PaymentID, '')<> ''
	SET @sWhere = @sWhere + ' AND (Isnull(P3.PaymentID01, '''') = '''+@PaymentID+''' or Isnull(P3.PaymentID02, '''') = '''+@PaymentID+''')'


IF @IsDate = 1	
Begin
	SET @Date = @Date + ''''+CONVERT(VARCHAR,@FromDate,103)  +''' as FromDate,'''+CONVERT(VARCHAR,@ToDate,103)+ ''' as ToDate'
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR, M.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
end
ELSE
Begin
	SET @Date = @Date + ' M.TranMonth, M.TranYear, (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) as MonthYear '
	SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
									Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+Isnull(@PeriodIDList, '')+''')'
	SET @GroupDate = @GroupDate + ', M.TranMonth, M.TranYear'
End	

SET @sSQL01 = N' 
				Declare @POST0016temp table (
							APK UNIQUEIDENTIFIER,
							DivisionID nvarchar(250),
							ShopID nvarchar(250),
							TranMonth int,
							TranYear int,
							EmployeeID nvarchar(250),
							PaymentID01  nvarchar(250),
							IsTaxIncluded int,
							TotalInventoryAmount Decimal(28,8),
							BookingAmount Decimal(28,8),
							TotalGiftVoucherAmount Decimal(28,8),
							PromoteChangeAmount Decimal(28,8),
							TotalDiscountAmount Decimal(28,8),
							TotalRedureAmount Decimal(28,8),
							TotalTaxAmount Decimal(28,8))
				Insert into @POST0016temp (APK, DivisionID, TranMonth, TranYear, ShopID, EmployeeID, IsTaxIncluded, TotalInventoryAmount, BookingAmount, TotalGiftVoucherAmount, PromoteChangeAmount, TotalDiscountAmount, TotalRedureAmount, TotalTaxAmount)
				--Lấy Phiếu bán hàng
				SELECT M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, sum(Isnull(D.IsTaxIncluded, 0)) as IsTaxIncluded, M.TotalAmount, BookingAmount, Isnull(TotalGiftVoucherAmount, 0), M.PromoteChangeAmount
					 , M.TotalDiscountAmount, M.TotalRedureAmount, M.TotalTaxAmount
				from POST0016 M Left join POST0006 P3  WITH (NOLOCK) on M.APKPaymentID = P3.APK
								Left join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				WHERE M.DeleteFlg = 0 and M.CVoucherNo is null and M.PVoucherNo is null '+@sWhere+'
				Group by  M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, M.TotalAmount, M.PromoteChangeAmount
					 , M.TotalDiscountAmount, M.TotalRedureAmount, M.TotalTaxAmount, M.BookingAmount, Isnull(TotalGiftVoucherAmount, 0)
				Union all
				--Lấy phiếu trả hàng
				SELECT M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, sum(Isnull(D.IsTaxIncluded, 0)) as IsTaxIncluded, (-1)*M.TotalAmount, 0 as BookingAmount, (-1)*Isnull(TotalGiftVoucherAmount, 0), (-1)*M.PromoteChangeAmount
					, (-1) * M.TotalDiscountAmount, (-1) * M.TotalRedureAmount, (-1) * M.TotalTaxAmount
				from POST0016 M Left join POST0006 P3  WITH (NOLOCK) on M.APKPaymentID = P3.APK
								Left join POST00161 D  WITH (NOLOCK) on M.APK = D.APKMaster and M.DeleteFlg = D.DeleteFlg
				WHERE M.DeleteFlg = 0 and M.PVoucherNo is not null '+@sWhere+'
				Group by M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, (-1)*M.TotalAmount, (-1)*M.PromoteChangeAmount
					, (-1) * M.TotalDiscountAmount, (-1) * M.TotalRedureAmount, (-1) * M.TotalTaxAmount, (-1)*Isnull(TotalGiftVoucherAmount, 0)
				Union all
				--Lấy phiếu đổi hàng (Nhập đổi)
				SELECT M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, Isnull(D.IsTaxIncluded, 0) as IsTaxIncluded, Sum((-1) * Isnull(D.InventoryAmount, 0)), 0, (-1)*Isnull(TotalGiftVoucherAmount, 0), 0
					 , Sum((-1) * Isnull(D.DiscountAllocation, 0)), Sum((-1) * Isnull(D.RedureAllocation, 0)), Sum((-1) * Isnull(D.TaxAmount, 0))
				from POST0016 M Left join POST0006 P3  WITH (NOLOCK) on M.APKPaymentID = P3.APK
								Left join POST00161 D on M.APK = D.APkMaster and M.DeleteFlg = D.DeleteFlg
				WHERE M.DeleteFlg = 0 and M.CVoucherNo is not null and IsKindVoucherID = 1 '+@sWhere+'
				Group by M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, Isnull(D.IsTaxIncluded, 0), (-1)*Isnull(TotalGiftVoucherAmount, 0)'

				Print @sSQL01
 SET @sSQL02 = N' 
				Union all
				--Lấy phiếu đổi hàng (Xuất đổi)
				SELECT M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, Isnull(D.IsTaxIncluded, 0) as IsTaxIncluded, Sum(D.InventoryAmount), 0, 0, 0, M.TotalDiscountAmount, M.TotalRedureAmount, Sum(D.TaxAmount)
				from POST0016 M Left join POST0006 P3  WITH (NOLOCK) on M.APKPaymentID = P3.APK
								Left join POST00161 D on M.APK = D.APkMaster and M.DeleteFlg = D.DeleteFlg
				WHERE M.DeleteFlg = 0 and M.CVoucherNo is not null and IsKindVoucherID = 2'+@sWhere+'
				Group by M.APK, M.DivisionID, M.TranMonth, M.TranYear, M.ShopID, M.SaleManID, Isnull(D.IsTaxIncluded, 0), M.TotalDiscountAmount, M.TotalRedureAmount, M.TotalDiscountAmount
				--Lấy kết quả
				'
 SET @sSQL03 = N' 
				
				Select M.DivisionID, M.TranMonth, M.TranYear 
							, M.ShopID, P10.ShopName, M.ShopID + ''_'' + P10.ShopName as ShopID_ShopName
							, Isnull(M.EmployeeID, '''') as EmployeeID
							, Isnull(A031.FullName, '''') as EmployeeName, Isnull(M.EmployeeID, '''') + ''_'' + Isnull(A031.FullName, '''') as EmployeeID_EmployeeName
							, Isnull(M.TotalInventoryAmount,0) - Isnull(M.TotalGiftVoucherAmount, 0) - Isnull(M.BookingAmount, 0) as InventoryAmount
							, Case when Isnull(IsTaxIncluded, 0) = 0 then 0 else 1 end as IsTaxIncluded
							, Isnull(M.TotalDiscountAmount,0) as DiscountAmount
							, Isnull(M.TotalRedureAmount,0) as RedureAmount
							, Isnull(M.TotalTaxAmount,0) as TaxAmount
							, Isnull(M.PromoteChangeAmount,0) as PromoteChangeAmount
							, Case when Isnull(IsTaxIncluded, 0) = 0 
								   Then Isnull(M.TotalInventoryAmount, 0) - Isnull(M.BookingAmount, 0) - Isnull(M.TotalGiftVoucherAmount, 0) + Isnull(M.PromoteChangeAmount, 0)- Isnull(M.TotalDiscountAmount, 0) - Isnull(M.TotalRedureAmount, 0) + Isnull(M.TotalTaxAmount, 0) 
								   Else Isnull(M.TotalInventoryAmount, 0) - Isnull(M.BookingAmount, 0) - Isnull(M.TotalGiftVoucherAmount, 0) + Isnull(M.PromoteChangeAmount, 0)- Isnull(M.TotalDiscountAmount, 0) - Isnull(M.TotalRedureAmount, 0) 
								   End as RevenueAmount
				into #POST0016temp
				From @POST0016temp M Left join POST0010 P10 on M.DivisionID = P10.DivisionID and M.ShopID = P10.ShopID
									 Left join AT1103 A031 on M.EmployeeID = A031.EmployeeID
				

				Select M.DivisionID, '+@Date+', M.ShopID, M.ShopName, M.ShopID_ShopName
							, M.EmployeeID, M.EmployeeName, M.EmployeeID_EmployeeName
							, M.IsTaxIncluded
							, Sum(M.InventoryAmount) as InventoryAmount
							, Sum(M.DiscountAmount) as DiscountAmount
							, Sum(M.RedureAmount) as RedureAmount
							, Sum(M.TaxAmount) as TaxAmount
							, Sum(M.PromoteChangeAmount) as PromoteChangeAmount
							, Sum(RevenueAmount) as RevenueAmount
				From #POST0016temp M
				Group by M.DivisionID, M.ShopID, M.ShopName, M.ShopID_ShopName, M.EmployeeID, M.EmployeeName, M.EmployeeID_EmployeeName, M.IsTaxIncluded ' +  @GroupDate + '
				'
EXEC (@sSQL01 + @sSQL02 + @sSQL03)
--Print @sSQL01
--Print @sSQL02
--Print @sSQL03


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
