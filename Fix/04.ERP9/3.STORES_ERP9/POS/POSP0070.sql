IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'POSP0070') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE POSP0070
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Form POSF00161 Chọn hàng khuyến mãi theo hóa đơn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Vũ, Date 08/03/2018
-- <Example>
/* 
EXEC POSP0070 'HCM','50C2101','HH001','20000000','NV01',1,20
*/
----
CREATE PROCEDURE POSP0070 ( 
         @DivisionID varchar(50)
	   , @ShopID varchar(50)
	   , @RefInventoryID varchar(50)
	   , @TotalInventoryAmount varchar(50) NULL
	   , @UserID  VARCHAR(50)
	   , @PageNumber INT
	   , @PageSize INT
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
	SET @OrderBy = 'M.OrderNo'
	
	
	IF  Isnull(@DivisionID,'') != ''
		SET @sWhere = @sWhere + ' P10.DivisionID = N'''+ @DivisionID+''''
	IF  Isnull(@ShopID,'') != ''
		SET @sWhere = @sWhere + ' and P10.ShopID = N'''+ @ShopID+''''
	IF Isnull(@TotalInventoryAmount, '') != '' 
		SET @sWhere = @sWhere + '  and '+STR(@TotalInventoryAmount)+'>=  Isnull(C50.FromValues, 0.0)
								    and '+STR(@TotalInventoryAmount)+' < (Case when C50.ToValues is null or C50.ToValues = 0.0 then 999999999999999.0 else C50.ToValues end)'
	
	SET @sSQL = '	
	Select  Case when '''+ @RefInventoryID +''' = C51.InventoryID then 1 else 0 end as IsCheck, P10.DivisionID, P10.ShopID, C51.InventoryID, C51.InventoryName, C51.UnitID, A04.UnitName
					, 0.0 as InstallmentPrice
					, Case When P10.PriceColumn = 1 then isnull(A02.Saleprice01,0.0)
						When P10.PriceColumn = 2 then isnull(A02.SalePrice02,0.0)
						When P10.PriceColumn = 3 then isnull(A02.SalePrice03,0.0)
						When P10.PriceColumn = 4 then isnull(A02.SalePrice04,0.0)
						When P10.PriceColumn = 5 then isnull(A02.SalePrice05,0.0) 
						End as UnitPrice
					, Cast(C51.Quantity as int) as ActualQuantity
					, 0.0 as Amount
					, 0.0 as DiscountAmount
					, 0.0 as TaxAmount
					, 0.0 as InventoryAmount
					, A02.VATGroupID, ISNULL(A02.VATPercent/100,0) as VATPercent, ISNULL(A02.VATPercent,0) as DepositVATPercent
					, 0.0 as  DiscountRate
					, 0 as IsPromotion
					, (Isnull(C49.Description,'''') + '' (''+CONVERT(varchar(10), C49.Fromdate, 103) +''->'' + CONVERT(varchar(10), C49.Todate, 103) +'')'' ) as PromotionProgram
					, Isnull(C50.FromValues, 0.0) as FromQuantity
					, (Case when C50.ToValues is null or C50.ToValues = 0.0 then 999999999999999.0 else C50.ToValues end) as ToQuantity
					, 0.0 as CA
					, 0.0 as CAAmount
					, cast(0 as Tinyint) as IsPackage, NULL PackageID, NULL PackagePriceID, cast(C51.IsGift as Tinyint) as IsGift, 0 as IsDisplay, P99.Description as IsDisplayName
					, Isnull(P10.IsInvoicePromotionID, 0) as IsInvoicePromotionID, C51.OrderNo
					into #TemPOST0010
	From POST0010 P10 WITH (NOLOCK) inner join CT0149 C49 WITH (NOLOCK) on P10.IsInvoicePromotionID = 1 and P10.InvoicePromotionID = C49.PromoteID and C49.Disabled = 0
			inner join CT0150 C50 WITH (NOLOCK) on C50.PromoteID = C49.PromoteID
			inner join CT0151 C51 WITH (NOLOCK) on C51.PromoteID = C50.PromoteID and C51.VoucherID = C50.VoucherID  and C51.InventoryID is not null 
			inner join POST0030 P30 WITH (NOLOCK) on P10.DivisionID = P30.DivisionID and P10.ShopID = P30.ShopID and C51.InventoryID = P30.InventoryID
			inner join AT1302 A02 With (Nolock) on A02.DivisionID in ('''+ @DivisionID+''', ''@@@'') and A02.InventoryID = P30.InventoryID and A02.Disabled = 0
			Inner join AT1304 A04 With (Nolock) on  A04.UnitID = A02.UnitID and A04.Disabled = 0
			LEFT JOIN POST0099 P99 WITH (NOLOCK) ON P99.ID = ''0'' and P99.CodeMaster = ''POS000015''
	Where '+@sWhere+' and convert(varchar(10), Getdate(), 111) between convert(varchar(10), C49.FromDate, 111) and convert(varchar(10), C49.ToDate, 111)
	
	Declare @Count int
	Select @Count = Count(InventoryID) From  #TemPOST0010

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow
					, M. IsCheck, M.DivisionID, M.ShopID, M.InventoryID, M.InventoryName, M.UnitID, M.UnitName
					, M.InstallmentPrice
					, M.UnitPrice
					, M.ActualQuantity
					, M.Amount
					, M.DiscountAmount
					, M.TaxAmount
					, M.InventoryAmount
					, M.VATGroupID, M.VATPercent, M.DepositVATPercent
					, M.DiscountRate
					, M.IsPromotion
					, M.PromotionProgram
					, M.FromQuantity
					, M.ToQuantity
					, M.CA
					, M.CAAmount
					, M.IsPackage, M.PackageID, M.PackagePriceID, M.IsGift, M.IsDisplay, M.IsDisplayName
					, M.IsInvoicePromotionID, M.OrderNo
	From   #TemPOST0010 M
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	
	EXEC (@sSQL)
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
