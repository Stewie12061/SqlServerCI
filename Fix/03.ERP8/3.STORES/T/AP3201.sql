IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3201]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3201]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load detail cho man hinh  ke thua  nhieu  don hang ban(AF3116) 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 26/08/2007 by Nguyen Thi Thuy Tuyen
---- 
---- Modified on 11/09/2008 by Thuy Tuyen
---- Modified on 08/10/2009 by Bao Anh : Lay truong IsDiscount
---- Modified on 10/10/2009 by T.Tuyen
---- Modified on 29/11/2011 by Thien Huynh : Tach chuoi SQL truong hop @lstROrderID qua dai
---- Modified on 05/01/2012 by Le Thi Thu Hien : ISNULL
---- Modified on 05/01/2012 by Thien Huynh : Lay them cac truong ĐVT quy doi
---- Modified on 29/11/2011 by Thien Huynh : Tach chuoi SQL truong hop @sSQL qua dai
---- Modified on 04/07/2014 by Tan Phu : them column PriceListID
---- Modified on 15/10/2014 by Lê Thị Hanh: Lấy thêm nvarchar01, nvarchar02, nvarchar03: theo dõi chiết khấu
---- Modified on 07/01/2015 by Quốc Tuấn: Lấy thêm số lượng quy đổi từ AQ2901
---- Modified on 24/06/2015 by Hoàng Vũ: Custom secoin kế thừa đơn hàng trừ thêm phần điều chỉnh giảm/tăng của đơn hàng
---- Modified by Tieu Mai on 16/12/2015: Bo sung truong hop thiet lap quan ly mat hang theo quy cach
---- Modify on 13/01/2016 by Bảo Anh: Bổ sung các trường PaymentTermID, IsProInventoryID, DiscountSalesAmount (Angel)
---- Modified by Tiểu Mai on 18/01/2016: Bổ sung columns DiscountPercentSOrder, DiscountAmountSOrder
---- Modified by Tiểu Mai on 06/04/2016: Bổ sung columns tham số 
---- Modified buy Cao thị Phượng on 14/04/2016 Bổ sung thêm trường VoucherNo
---- Modified by Tiểu Mai on 24/05/2016: Bổ sung trường DiscountSaleAmountDetail
---- Modified by Tiểu Mai on 03/06/2016: Bổ sung WITH(NOLOCK)
---- Modified by Tiểu Mai on 26/07/2016: Bổ sung các trường tham số Đơn hàng bán (master)
---- Modified by Hải Long on 25/08/2016: Bổ sung thêm trường cho ABA
---- Modified by Hải Long on 25/08/2016: Sửa lại thứ thự tham số cho ABA
---- Modified by Bảo Thy on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Hải Long on 27/10/2016: Bổ sung trường IsUsedEInvoice
---- Modified by Khả Vi on 10/11/2016: Bổ sung trường WarehouseID
---- Modified by Kim Thư on 07/11/2018: CustomizeIndex=36 (SGPT): Không kế thừa dòng có Số lượng hoặc Đơn giá = 0
---- Modified by Văn Minh on 02/12/2019: CustomizeIndex=110 (SONGBINH): Cho phép kế thừa các đơn hàng có EndQuatity = 0
---- Modified by Đức Thông on 06/08/2020: Qui đổi số lượng chuẩn đối với đơn vị tính qui đổi
---- Modified by Đức Thông on 07/08/2020: Lấy ID đơn vị tính qui đổi trường hợp sử dụng đơn vị tính qui đổi
---- Modified by Đức Thông on 01/10/2020: Lấy UnitID là đơn vị tính chuẩn + Kiểm tra số lượng đã kế thừa từ đơn hàng trong hóa đơn theo đơn vị tính
---- Modified by Đức Thông on 02/10/2020: Chỉnh sửa Lấy UnitID là đơn vị tính chuẩn
---- Modified by Đức Thông on 03/10/2020: Bổ sung customize SAVI: Lấy đơn giá trước thuế
---- Modified by Đức Thông on 05/10/2020: Customize SAVI: Bổ sung rẽ nhánh kiểm tra số lượng hàng trên đơn hàng và hóa đơn khi đvt khác nhau
---- Modified by Đức Thông on 13/10/2020: Customize SAVI: Bổ sung lấy qui đổi để thực hiện kiểm tra số lượng ở hóa đơn so với đơn hàng
---- Modified by Văn Tài   on 23/12/2021: Cập nhật fix lỗi cột ExchangeRate.
---- Modified by Văn Tài   on 08/09/2022: Xử lý lấy thông tin Chiết khấu của Đơn hàng bán
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified by Nhật Thanh on 29/05/2023: Bổ sung kiểm tra có dùng chương trình khuyến mãi hay không
---- Modified by Xuân Nguyên on 29/09/2023: CustomizeIndex=110 (SONGBINH): chỉ load đơn hàng bán không cần load hóa đơn bán hàng
---- Modified by Xuân Nguyên on 23/11/2023: Sửa ENĐ thành END
-- <Example>
----

CREATE PROCEDURE [dbo].[AP3201] 
		@DivisionID nvarchar(50),
		@VATGroupID nvarchar(50),
		@lstROrderID nvarchar(4000),
		@VoucherID nvarchar(50), --- Addnew   truyen ''; Load Edit :  so chung tu vua duoc chon sua
		@ConnID nvarchar(100) ='',
		@InheritDHSX int -- kế thừa dhsx:1 Không kế thừa đơn hàng sx:0. Chỉ sử dụng cho khách hàng Minh phương
				
AS
Declare @sSQL  nvarchar(Max),
		@sSQLUnion  nvarchar(Max),
		@sSQL1  nvarchar(4000),
		@sSQL2  nvarchar(4000),
		@VATRate decimal(28,8),
		@Parameters NVARCHAR(MAX) = '',
		@Parameters2 NVARCHAR(MAX) = '',
		@sWhere  nvarchar(4000)='',
		@CustomerName INT	
			
		SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)
SET @lstROrderID = 	REPLACE(@lstROrderID, ',', ''',''')

IF(@CustomerName = 36)
	SET @sWhere= ' AND T00.OrderQuantity <> 0 AND T00.SalePrice <> 0 '

IF(@CustomerName = 45)
BEGIN
	SET @Parameters = ', T00.nvarchar04 as CParameter01, T00.nvarchar05 as CParameter02, T00.nvarchar06 as CParameter03, T00.nvarchar07 as CParameter04'
	SET @Parameters2 = ', T00.ABParameter01 as CParameter01, T00.ABParameter02 as CParameter02, T00.ABParameter03 as CParameter03, T00.ABParameter04 as CParameter04'
END

SELECT	@VATRate  = ISNULL(VATRate,0)   
FROM	AT1010 
WHERE	VATGroupID = @VATGroupID AND DivisionID IN (@DivisionID,'@@@')
--- Print @lstROrderID



IF(@CustomerName = 1 AND @InheritDHSX = 1) --Customername = 1 khách hàng minh phuong
	BEGIN
		IF isNULL (@VoucherID,'') <> '' 
		BEGIN
			SET @sSQL =N'
		SELECT 
				T00.ObjectID,  T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
				T00.OrderID,T00.VoucherNo,T00.OTransactionID AS TransactionID ,
				T00.InventoryID,T01.InventoryName, T01.UnitID,  0 AS IsEditInventoryName,
				T00.Quantity, T00.UnitPrice,  T00.CommissionPercent,
				T00.OriginalAmount, T00.ConvertedAmount, 
				NULL AS DiscountPercent, 
				NULL AS SODiscountAmount,
				NULL AS DiscountConvertedAmount,				
				T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
				T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
				'''' AS PaymentID, '''' AS PaymenttermID,
				1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
				(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  AND TransactionTypeID = ''T14'')as VATOriginalAMount,
				(SELECT ConvertedAmount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  AND TransactionTypeID = ''T14'')as VATConvertedAmount,
				T00.BDescription, T01.IsDiscount, T00.DivisionID,
				T00.MOrderID,
				T00.SOrderID,
				T00.MTransactionID,
				T00.STransactionID,
				T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
				T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
				, T00.StandardAmount, T00.PriceListID
		FROM	AT9000  T00  WITH(NOLOCK)
		LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		INNER JOIN AT1302  T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		WHERE	T00.DivisionID = ''' + @DivisionID + '''  
				AND T00.VoucherID =  N'''+@VoucherID+'''  
				AND TransactionTypeID in (''T04'',''T64'')
		'
			SET @sSQLUnion = N'
					UNION

					SELECT	T02.ObjectID, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
							OT3.SOrderID AS OrderID,OT4.VoucherNo,
							T00.TransactionID,
							T00.InventoryID,		
							ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
							T01.UnitID, 
							CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
							V00.EndQuantity AS Quantity,	
							T00.SalePrice AS UnitPrice, T00.CommissionPercent,
							CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
							V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
							CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
							V00.EndQuantity*T00.SalePrice*T02.Exchangerate*(100- ISNULL(T00.DiscountPercent, 0))/100 END as ConvertedAmount,
							T00.DiscountPercent, 
							T00.DiscountAmount AS SODiscountAmount,
							T00.DiscountConvertedAmount,
							T01.IsSource, 
							T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
							T01.AccountID, T01.MethodID, T01.IsStocked,
							T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
							T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
							T00.Orders ,V00.DueDate,
							V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymenttermID,
							0 AS IsCheck,  T00.VATPercent,	 T00.VatGroupID,T00.VATOriginalAmount ,
							T00.VATConvertedAmount ,T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
							OT3.SOrderID AS MOrderID,
							OT3.RefSOrderID AS SOrderID,
							OT3.TransactionID AS MTransactionID,
							OT3.RefSTransactionID AS STransactionID,
							OT3.UnitID As ConvertedUnitID, OT3.ConvertedQuantity, OT3.ConvertedSalePrice As ConvertedPrice, 
							OT3.Parameter01 As UParameter01, OT3.Parameter02 As UParameter02, OT3.Parameter03 As UParameter03, 
							OT3.Parameter04 As UParameter04, OT3.Parameter05 As UParameter05, OT3.StandardPrice
							, OT3.StandardAmount, OT4.PriceListID

						FROM	OT2002 OT3 WITH(NOLOCK)  
						INNER JOIN OT2001 OT4 WITH(NOLOCK) on OT3.SOrderID =  OT4.SOrderID AND OT3.DivisionID = OT4.DivisionID
						INNER JOIN AQ2901 V00 on V00.SOrderID = OT3.SOrderID AND V00.TransactionID = OT3.TransactionID  AND V00.DivisionID = OT3.DivisionID 
						INNER JOIN AT1302 T01 WITH(NOLOCK) on OT3.InventoryID = T01.InventoryID
						LEFT JOIN OT2002 T00 WITH(NOLOCK) On T00.SOrderID = OT3.RefSOrderID AND T00.InventoryID = OT3.InventoryID
						LEFT JOIN OT2001 T02 WITH(NOLOCK) on OT3.RefSOrderID =  T02.SOrderID AND OT3.DivisionID = T02.DivisionID 
		
						WHERE  OT4.DivisionID = ''' + @DivisionID + ''' AND '		
			SET @sSQL1 = N'
							OT3.SOrderID in (N''' + @lstROrderID + ''') 
							AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
							 ' + 
							CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 
		END
		ELSE -- Nếu Load New
		BEGIN
			SET @sSQL =N'
			SELECT	T02.ObjectID, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
					OT3.SOrderID AS OrderID,OT4.VoucherNo,
					T00.TransactionID,
					T00.InventoryID,		
					ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
					T01.UnitID, 
					CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
					V00.EndQuantity AS Quantity,	
					T00.SalePrice AS UnitPrice, T00.CommissionPercent,
					CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
					V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
					CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
					V00.EndQuantity * T00.SalePrice * T02.Exchangerate * (100- ISNULL(T00.DiscountPercent, 0))/100 END as ConvertedAmount,
					T00.DiscountPercent, 
					T00.DiscountAmount AS SODiscountAmount,
					T00.DiscountConvertedAmount,
					T01.IsSource, 
					T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
					T01.AccountID, T01.MethodID, T01.IsStocked,
					T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
					T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
					T00.Orders ,V00.DueDate,
					V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymenttermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
					T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
					OT3.SOrderID AS MOrderID,
					OT3.RefSOrderID AS SOrderID,
					OT3.TransactionID AS MTransactionID,
					OT3.RefSTransactionID AS STransactionID,
					OT3.UnitID As ConvertedUnitID, OT3.ConvertedQuantity, OT3.ConvertedSalePrice As ConvertedPrice, 
					OT3.Parameter01 As UParameter01, OT3.Parameter02 As UParameter02, OT3.Parameter03 As UParameter03, 
					OT3.Parameter04 As UParameter04, OT3.Parameter05 As UParameter05, OT3.StandardPrice
					, OT3.StandardAmount, OT4.PriceListID

			FROM	OT2002 OT3  WITH(NOLOCK) 
			INNER JOIN OT2001 OT4 WITH(NOLOCK) on OT3.SOrderID =  OT4.SOrderID AND OT3.DivisionID = OT4.DivisionID
			INNER JOIN AQ2901 V00 on V00.SOrderID = OT3.SOrderID AND V00.TransactionID = OT3.TransactionID  AND V00.DivisionID = OT3.DivisionID 
			INNER JOIN AT1302 T01 WITH(NOLOCK) on OT3.InventoryID = T01.InventoryID
			LEFT JOIN OT2002 T00 WITH(NOLOCK) On T00.SOrderID = OT3.RefSOrderID AND T00.InventoryID = OT3.InventoryID
			LEFT JOIN OT2001 T02 WITH(NOLOCK) on OT3.RefSOrderID =  T02.SOrderID AND OT3.DivisionID = T02.DivisionID 
			
			WHERE  OT4.DivisionID = ''' + @DivisionID + ''' AND '
			SET @sSQL1 = N'
					OT3.SOrderID in (N''' + @lstROrderID + ''')
					AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
					 ' + 
					CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 
		END
	END
	
ELSE IF (@Customername = 43) --Customername = 43 khách hàng Secoin
	BEGIN
		IF isNULL (@VoucherID,'') <> '' 
		BEGIN
			SET @sSQL =N'
			SELECT 
					T00.ObjectID,  T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
					T00.OrderID,T00.OTransactionID AS TransactionID ,
					T00.InventoryID,T01.InventoryName, T01.UnitID,  0 AS IsEditInventoryName,
					T00.Quantity, T00.UnitPrice,  T00.CommissionPercent,
					T00.OriginalAmount, T00.ConvertedAmount, 
					NULL AS DiscountPercent,
					NULL AS SODiscountAmount,
					NULL AS DiscountConvertedAmount,
					T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
					T01.AccountID, T01.MethodID, T01.IsStocked,
					T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
					T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
					T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
					'''' AS PaymentID, '''' AS PaymenttermID,
					1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
					(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  AND TransactionTypeID = ''T14'')as VATOriginalAMount,
					(SELECT ConvertedAmount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  AND TransactionTypeID = ''T14'')as VATConvertedAmount,
					T00.BDescription, T01.IsDiscount, T00.DivisionID,
					T00.MOrderID,
					T00.SOrderID,
					T00.MTransactionID,
					T00.STransactionID,
					T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
					T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
					, T00.StandardAmount, T00.PriceListID
			FROM	AT9000  T00 WITH(NOLOCK) 
			LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
			INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
			WHERE	T00.DivisionID = ''' + @DivisionID + '''  
					AND T00.VoucherID =  '''+@VoucherID+'''  
					AND TransactionTypeID in (''T04'',''T64'')
			'
			SET @sSQLUnion = N'
						UNION

						SELECT	OT4.ObjectID, OT4.VATObjectID, OT4.CurrencyID, OT4.Exchangerate,
								OT3.SOrderID AS OrderID,
								OT3.TransactionID,
								OT3.InventoryID,		
								ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
								OT3.UnitID, 
								CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
								Isnull(V00.EndQuantity,0) AS Quantity,	
								isnull(T00.SalePrice, OT3.SalePrice) AS UnitPrice, isnull(T00.CommissionPercent, 0) as CommissionPercent ,
								CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
								isnull(V00.EndQuantity,0) * Isnull(T00.SalePrice, OT3.SalePrice)*(100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
								CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
								isnull(V00.EndQuantity,0) * Isnull(T00.SalePrice, OT3.SalePrice)*Isnull(OT4.Exchangerate,0)*(100- ISNULL(T00.DiscountPercent, 0))/100 END as ConvertedAmount,
								isnull(T00.DiscountPercent, 0) AS DiscountPercent, 
								Isnull(T00.DiscountAmount, 0) AS SODiscountAmount,
								Isnull(T00.DiscountConvertedAmount,0) AS DiscountConvertedAmount, 
								T01.IsSource,
								T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
								T01.AccountID, T01.MethodID, T01.IsStocked,
								T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
								T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
								T00.Orders ,V00.DueDate,
								V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymenttermID,
								0 AS IsCheck,  T00.VATPercent,	 T00.VatGroupID,T00.VATOriginalAmount ,
								T00.VATConvertedAmount ,T02.notes AS BDescription, T01.IsDiscount, OT3.DivisionID,
								OT3.SOrderID AS MOrderID,
								OT3.RefSOrderID AS SOrderID,
								OT3.TransactionID AS MTransactionID,
				
								OT3.RefSTransactionID AS STransactionID,
								OT3.UnitID As ConvertedUnitID, OT3.ConvertedQuantity, OT3.ConvertedSalePrice As ConvertedPrice, 
								OT3.Parameter01 As UParameter01, OT3.Parameter02 As UParameter02, OT3.Parameter03 As UParameter03, 
								OT3.Parameter04 As UParameter04, OT3.Parameter05 As UParameter05, OT3.StandardPrice
								, OT3.StandardAmount, OT4.PriceListID

							FROM	OT2002 OT3 WITH(NOLOCK)  
							INNER JOIN OT2001 OT4 WITH(NOLOCK) on OT3.SOrderID =  OT4.SOrderID AND OT3.DivisionID = OT4.DivisionID
							INNER JOIN     (--Begin View Cu AQ2901
											Select OT2001.DivisionID, OT2001.TranMonth, OT2001.TranYear, OT2002.SOrderID,  OT2001.OrderStatus, 
													OT2002.TransactionID, OT2001.Duedate, OT2001.Shipdate, OT2002.InventoryID, 
													Isnull(OT2002.OrderQuantity,0) as OrderQuantity  ,Isnull( G.ActualQuantity,0) as ActualQuantity, 
													OT2001.PaymentTermID,AT1208.Duedays,
													case when OT2002.Finish = 1 
														then NULL else isnull(OT2002.OrderQuantity, 0)
															- isnull(G.ActualQuantity, 0) 
															+ isnull(T.OrderQuantity,0) 
															end as EndQuantity, 
													G.OrderID as T9OrderID,
													case when OT2002.Finish = 1 
														then NULL else isnull(OT2002.ConvertedQuantity, 0)
																		- isnull(G.ActualConvertedQuantity, 0) 
																		+ Isnull(T.ConvertedQuantity,0)
													end as EndConvertedQuantity,
													( isnull(OT2002.OriginalAmount,0) - isnull(G.ActualOriginalAmount,0 ) + isnull(T.OriginalAmount,0))  
													as EndOriginalAmount'
			SET @sSQL2 =N'
						From OT2002 WITH(NOLOCK) inner join OT2001 WITH(NOLOCK) ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
									left join AT1208 WITH(NOLOCK) ON AT1208.PaymentTermID = OT2001.PaymentTermID 	
									left join 	(
													Select AT9000.DivisionID, AT9000.OrderID, OTransactionID,
															InventoryID, CASE WHEN EXISTS (SELECT TOP 1 1 FROM OT2002 INNER JOIN AT1302 ON OT2002.UnitID = AT1302.UnitID AND OT2002.InventoryID = AT1302.InventoryID WHERE AT9000.OrderID = OT2002.SOrderID AND AT9000.UnitID = OT2002.UnitID) THEN sum(Quantity) WHEN NOT EXISTS (SELECT TOP 1 1 FROM OT2002 WHERE AT9000.OrderID = OT2002.SOrderID AND AT9000.InventoryID = OT2002.InventoryID AND AT9000.UnitID = OT2002.UnitID) THEN CASE AT1309.Operator WHEN 1 THEN SUM(ConvertedQuantity * AT1309.ConversionFactor) ELSE SUM(ConvertedQuantity / AT1309.ConversionFactor) END  ELSE SUM(ConvertedQuantity) END As ActualQuantity, sum(isnull(OriginalAmount,0)) 
															as ActualOriginalAmount,
															SUM(isnull(ConvertedQuantity,Quantity)) As ActualConvertedQuantity
														From AT9000  WITH(NOLOCK)
															LEFT JOIN AT1309 ON AT9000.InventoryID = AT1309.InventoryID
														WHERE TransactionTypeID in (''T04'', ''T06'') and IsStock = 0 AND isnull(AT9000.OrderID,'''') <>''''
														Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID, AT9000.InventoryID, AT1309.ConversionFactor, AT1309.Operator
													) as G  --- (co nghia la Giao  hang)
													on 	OT2001.DivisionID = G.DivisionID AND OT2002.SOrderID = G.OrderID 
														and OT2002.InventoryID = G.InventoryID AND OT2002.TransactionID = G.OTransactionID
						--End View Cu AQ2901
									Left join (
												Select D.DivisionID, D.InventoryID, 
														Sum(D.OrderQuantity) as OrderQuantity, 
														Sum(D.ConvertedQuantity) as ConvertedQuantity, 
														Sum(D.OriginalAmount) as OriginalAmount,
														D.InheritVoucherID, D.InheritTransactionID 
												From OT2001 M  WITH(NOLOCK) Inner join OT2002 D WITH(NOLOCK) on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID
												Where M.OrderTypeID = 1
												Group by D.DivisionID, D.InventoryID, D.InheritVoucherID, D.InheritTransactionID
												) as T on T.DivisionID = OT2002.DivisionID and T.InheritVoucherID = OT2002.SOrderID 
																							and T.InheritTransactionID = OT2002.TransactionID
						Where OT2001.OrderTypeID = 0 or OT2001.OrderTypeID is null
										) V00 on V00.SOrderID = OT3.SOrderID AND V00.TransactionID = OT3.TransactionID  AND V00.DivisionID = OT3.DivisionID 
						INNER JOIN AT1302 T01 WITH(NOLOCK) on OT3.InventoryID = T01.InventoryID
						LEFT JOIN OT2002 T00 WITH(NOLOCK) On T00.SOrderID = OT3.RefSOrderID AND T00.InventoryID = OT3.InventoryID
						LEFT JOIN OT2001 T02 WITH(NOLOCK) on OT3.RefSOrderID =  T02.SOrderID AND OT3.DivisionID = T02.DivisionID 
		
						WHERE  OT4.OrderTypeID = 0 and OT4.DivisionID = ''' + @DivisionID + ''' AND '
			SET @sSQL1 = N'
								OT3.SOrderID in (''' + @lstROrderID + ''') 
								AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
									' + 
								CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 
		END
	ELSE -- Nếu Load New
	BEGIN
		SET @sSQL =N'
		SELECT	OT4.ObjectID, OT4.VATObjectID, OT4.CurrencyID, OT4.Exchangerate,
				OT3.SOrderID AS OrderID,
				OT3.TransactionID,
				OT3.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				OT3.UnitID, 
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				Isnull(V00.EndQuantity,0) AS Quantity,	
				Isnull(T00.SalePrice, OT3.SalePrice) AS UnitPrice, Isnull(T00.CommissionPercent,0) as CommissionPercent,
				CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				isnull(V00.EndQuantity,0) * Isnull(T00.SalePrice, OT3.SalePrice) * (100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				isnull(V00.EndQuantity,0) * Isnull(T00.SalePrice, OT3.SalePrice) * Isnull(OT4.Exchangerate,0) * (100- ISNULL(T00.DiscountPercent, 0))/100 END as ConvertedAmount,
				Isnull(T00.DiscountPercent,0) as DiscountPercent,
				isnull(T00.DiscountAmount, 0) as SODiscountAmount,
				isnull(T00.DiscountConvertedAmount, 0) as DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymenttermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, OT3.DivisionID,
				OT3.SOrderID AS MOrderID,
				OT3.RefSOrderID AS SOrderID,
				OT3.TransactionID AS MTransactionID,
				OT3.RefSTransactionID AS STransactionID,
				OT3.UnitID As ConvertedUnitID, Isnull(V00.EndConvertedQuantity,0) as ConvertedQuantity, OT3.ConvertedSalePrice As ConvertedPrice, 
				OT3.Parameter01 As UParameter01, OT3.Parameter02 As UParameter02, OT3.Parameter03 As UParameter03, 
				OT3.Parameter04 As UParameter04, OT3.Parameter05 As UParameter05, OT3.StandardPrice
				, OT3.StandardAmount, OT4.PriceListID

		FROM	OT2002 OT3  
		INNER JOIN OT2001 OT4 on OT3.SOrderID =  OT4.SOrderID AND OT3.DivisionID = OT4.DivisionID
		INNER JOIN					(--Begin View Cu AQ2901
										Select OT2001.DivisionID, OT2001.TranMonth, OT2001.TranYear, OT2002.SOrderID,  OT2001.OrderStatus, 
												OT2002.TransactionID, OT2001.Duedate, OT2001.Shipdate, OT2002.InventoryID, 
												Isnull(OT2002.OrderQuantity,0) as OrderQuantity  ,Isnull( G.ActualQuantity,0) as ActualQuantity, '
		SET @sSQL2 =N'								OT2001.PaymentTermID,AT1208.Duedays,
												case when OT2002.Finish = 1 
													then NULL else isnull(OT2002.OrderQuantity, 0)
														- isnull(G.ActualQuantity, 0) 
														+ isnull(T.OrderQuantity,0) 
														end as EndQuantity, 
												G.OrderID as T9OrderID,
												case when OT2002.Finish = 1 
													then NULL else isnull(OT2002.ConvertedQuantity,0)
																	- isnull(G.ActualConvertedQuantity, 0) 
																	+ Isnull(T.ConvertedQuantity,0)
												end as EndConvertedQuantity,
												( isnull(OT2002.OriginalAmount,0) - isnull(G.ActualOriginalAmount,0 ) + isnull(T.OriginalAmount,0))  
												as EndOriginalAmount
										From OT2002 inner join OT2001 ON OT2001.DivisionID = OT2002.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
													left join AT1208 ON AT1208.PaymentTermID = OT2001.PaymentTermID 	
													left join 	(
																	Select AT9000.DivisionID, AT9000.OrderID, OTransactionID,
																			InventoryID, CASE WHEN EXISTS (SELECT TOP 1 1 FROM OT2002 INNER JOIN AT1302 ON OT2002.UnitID = AT1302.UnitID AND OT2002.InventoryID = AT1302.InventoryID WHERE AT9000.OrderID = OT2002.SOrderID AND AT9000.UnitID = OT2002.UnitID) THEN sum(Quantity) WHEN NOT EXISTS (SELECT TOP 1 1 FROM OT2002 WHERE AT9000.OrderID = OT2002.SOrderID AND AT9000.InventoryID = OT2002.InventoryID AND AT9000.UnitID = OT2002.UnitID) THEN CASE AT1309.Operator WHEN 1 THEN SUM(ConvertedQuantity * AT1309.ConversionFactor) ELSE SUM(ConvertedQuantity / AT1309.ConversionFactor) END  ELSE SUM(ConvertedQuantity) END As ActualQuantity, sum(isnull(OriginalAmount,0)) 
															as ActualOriginalAmount,
																			SUM(isnull(ConvertedQuantity,Quantity)) As ActualConvertedQuantity
																		From AT9000 
																		WHERE TransactionTypeID in (''T04'', ''T06'') and IsStock = 0 AND isnull(AT9000.OrderID,'''') <>''''
																		Group by AT9000.DivisionID, AT9000.OrderID, InventoryID, OTransactionID, AT9000.InventoryID, AT1309.ConversionFactor, AT1309.Operator
																	) as G  --- (co nghia la Giao  hang)
																	on 	OT2001.DivisionID = G.DivisionID AND OT2002.SOrderID = G.OrderID 
																		and OT2002.InventoryID = G.InventoryID AND OT2002.TransactionID = G.OTransactionID
										--End View Cu AQ2901
													Left join (
																Select D.DivisionID, D.InventoryID, 
																		Sum(D.OrderQuantity) as OrderQuantity, 
																		Sum(D.ConvertedQuantity) as ConvertedQuantity, 
																		Sum(D.OriginalAmount) as OriginalAmount,
																		D.InheritVoucherID, D.InheritTransactionID 
																From OT2001 M Inner join OT2002 D on M.DivisionID = D.DivisionID and M.SOrderID = D.SOrderID
																Where M.OrderTypeID = 1
																Group by D.DivisionID, D.InventoryID, D.InheritVoucherID, D.InheritTransactionID
																) as T on T.DivisionID = OT2002.DivisionID and T.InheritVoucherID = OT2002.SOrderID 
																											and T.InheritTransactionID = OT2002.TransactionID
										Where OT2001.OrderTypeID = 0 or OT2001.OrderTypeID is null
										) V00 on V00.SOrderID = OT3.SOrderID AND V00.TransactionID = OT3.TransactionID  AND V00.DivisionID = OT3.DivisionID 
		INNER JOIN AT1302 T01 on OT3.InventoryID = T01.InventoryID
		LEFT JOIN OT2002 T00 On T00.SOrderID = OT3.RefSOrderID AND T00.InventoryID = OT3.InventoryID
		LEFT JOIN OT2001 T02 on OT3.RefSOrderID =  T02.SOrderID AND OT3.DivisionID = T02.DivisionID 
			
		WHERE  OT4.OrderTypeID = 0 and OT4.DivisionID = ''' + @DivisionID + ''' AND '
		SET @sSQL1 = N'
				OT3.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + 
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 
	END
	END
ELSE IF (@CustomerName = 44) --Customername = 44 khách hàng SAVI: Lấy đơn giá trước thuế
	BEGIN
	If isNULL (@VoucherID,'') <> '' 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		BEGIN
				SET @sSQL =N'
		SELECT 
			T00.ObjectID, T12.IsUsedEInvoice, T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
			T00.OrderID,T00.VoucherNo,T00.TDescription,T00.OTransactionID AS TransactionID ,
			T00.InventoryID,T01.InventoryName,
			T01.UnitID AS UnitID,
			0 AS IsEditInventoryName,
			T00.Quantity, T00.UnitPrice,  T00.CommissionPercent,
			T00.OriginalAmount, T00.ConvertedAmount, 
			NULL AS DiscountPercent,
			NULL AS SODiscountAmount,
			NULL AS DiscountConvertedAmount,
			T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
			T01.AccountID, T01.MethodID, T01.IsStocked,
			T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
			T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
			T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
			'''' AS PaymentID, T00.PaymentTermID,
			1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
			(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATOriginalAMount,
			(SELECT  ConvertedAmount  FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATConvertedAmount,

			T00.BDescription, T01.IsDiscount, T00.DivisionID,
			T00.MOrderID,
			T00.SOrderID,
			T00.MTransactionID,
			T00.STransactionID,
			T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
			T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
			, T00.StandardAmount, T00.PriceListID, T00.DParameter01,
			T00.DParameter02, T00.DParameter03,T00.DParameter04,
			T00.DParameter05, T00.DParameter06, T00.DParameter07,
			T00.DParameter08, T00.DParameter09, T00.DParameter10,
			NULL S01ID, NULL S02ID, NULL S03ID, NULL S04ID, NULL S05ID, NULL S06ID, NULL S07ID, NULL S08ID, NULL S09ID, NULL S10ID,
			NULL S11ID, NULL S12ID, NULL S13ID, NULL S14ID, NULL S15ID, NULL S16ID, NULL S17ID, NULL S18ID, NULL S19ID, NULL S20ID,
			T00.IsProInventoryID, T00.DiscountSalesAmount,
			T00.DiscountPercentSOrder, 
			T00.DiscountAmountSOrder, NULL AS WarehouseID, 
			T00.DiscountSaleAmountDetail' + @Parameters2 +
			'
			, '''' AS PriceListID,
			A09.Operator,
			A09.ConversionFactor
		FROM AT9000  T00 WITH(NOLOCK)
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T12.ObjectID
		WHERE	T00.DivisionID = ''' + @DivisionID + '''  AND 
				T00.VoucherID =  '''+@VoucherID+'''  
				AND TransactionTypeID in (''T04'',''T64'')
		'
				SET @sSQLUnion = N'
		UNION

		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID, 
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100 AS OriginalAmount , 	  
				V00.EndQuantity*T00.SalePrice*T02.ExchangeRate*(100- ISNULL(T00.DiscountPercent,0))/100	 	as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate, V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,
				0 AS IsCheck,  
				T00.VATPercent,	 
				T00.VatGroupID,
				T00.VATOriginalAmount ,
				T00.VATConvertedAmount,
				T02.notes AS BDescription, 
				T01.IsDiscount, 
				T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID, V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10,
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder, T00.WarehouseID,
				T00.DiscountSaleAmountDetail' + @Parameters + '

				, OT2001.PriceListID
				, A09.Operator
				, A09.ConversionFactor
		FROM	OT2002 T00 WITH(NOLOCK)
		LEFT JOIN OT2001 WITH (NOLOCK) ON T00.SOrderID = OT2001.SOrderID
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID  AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		left join OT8899 O99 WITH(NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.SOrderID and O99.TransactionID = T00.TransactionID and O99.TableID = ''OT2002''
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END			
		END
		ELSE
			BEGIN
				SET @sSQL =N'
		SELECT 
			T00.ObjectID, T12.IsUsedEInvoice, T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
			T00.OrderID,T00.VoucherNo,T00.TDescription,T00.OTransactionID AS TransactionID ,
			T00.InventoryID,T01.InventoryName, T01.UnitID AS UnitID,  0 AS IsEditInventoryName,
			T00.Quantity, T00.UnitPrice,  T00.CommissionPercent,
			T00.OriginalAmount, T00.ConvertedAmount, 
			NULL AS DiscountPercent,
			NULL AS SODiscountAmount,
			NULL AS DiscountConvertedAmount,
			T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
			T01.AccountID, T01.MethodID, T01.IsStocked,
			T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
			T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
			T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
			'''' AS PaymentID, T00.PaymentTermID,
			1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
			(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATOriginalAMount,
			(SELECT  ConvertedAmount  FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATConvertedAmount,

			T00.BDescription, T01.IsDiscount, T00.DivisionID,
			T00.MOrderID,
			T00.SOrderID,
			T00.MTransactionID,
			T00.STransactionID,
			T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
			T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
			, T00.StandardAmount, T00.PriceListID, T00.DParameter01,
			T00.DParameter02, T00.DParameter03, T00.DParameter04,
			T00.DParameter05, T00.DParameter06, T00.DParameter07,
			T00.DParameter08, T00.DParameter09, T00.DParameter10, T00.IsProInventoryID, T00.DiscountSalesAmount,
			T00.DiscountPercentSOrder, 
			T00.DiscountAmountSOrder,
			T00.DiscountSaleAmountDetail,
			T00.Parameter01,
			T00.Parameter02,
			T00.Parameter03,
			T00.Parameter04,
			T00.Parameter05,
			T00.Parameter06,
			T00.Parameter07,
			T00.Parameter08,
			T00.Parameter09,
			T00.Parameter10, NULL AS WarehouseID, 
			T00.RefInfor' + @Parameters2 + '
		FROM AT9000  T00 WITH(NOLOCK)		
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T12.ObjectID		
		WHERE	T00.DivisionID = ''' + @DivisionID + '''  AND 
				T00.VoucherID =  '''+@VoucherID+'''  
				AND TransactionTypeID in (''T04'',''T64'')
		'
				SET @sSQLUnion = N'
		UNION

		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100 AS OriginalAmount , 	  				
				V00.EndQuantity*T00.SalePrice*T02.ExchangeRate*(100- ISNULL(T00.DiscountPercent,0))/100	as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource,
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate,
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate, V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,
				0 AS IsCheck,  
				T00.VATPercent,	 
				T00.VatGroupID,
				T00.VATOriginalAmount ,
				T00.VATConvertedAmount,
				T02.notes AS BDescription, 
				T01.IsDiscount, 
				T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID, V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10, T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder,
				T00.DiscountSaleAmountDetail,
				T02.Varchar01 as Parameter01,
				T02.Varchar02 as Parameter02,
				T02.Varchar03 as Parameter03,
				T02.Varchar04 as Parameter04,
				T02.Varchar05 as Parameter05,
				T02.Varchar06 as Parameter06,
				T02.Varchar07 as Parameter07,
				T02.Varchar08 as Parameter08,
				T02.Varchar09 as Parameter09,
				T02.Varchar10 as Parameter10, T00.WarehouseID, 
				T00.RefInfor' + @Parameters + '

		FROM	OT2002 T00 WITH(NOLOCK)
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID  AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 		

			END

	END
	ELSE -- Load New
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		BEGIN
				SET @sSQL =N'
		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName,
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.InventoryID ELSE V00.EndQuantity * A09.InventoryID END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent,0))/100 AS OriginalAmount , 	  
				V00.EndQuantity * T00.SalePrice * T02.ExchangeRate * (100- ISNULL(T00.DiscountPercent,0))/100 as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID,V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10,			
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder, NULL AS WarehouseID, 
				T00.DiscountSaleAmountDetail' + @Parameters + '	

		FROM OT2002 T00 WITH(NOLOCK)  INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID 
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		left join OT8899 O99 WITH(NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.SOrderID and O99.TransactionID = T00.TransactionID and O99.TableID = ''OT2002''
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END			
		END
		ELSE
			BEGIN
				SET @sSQL =N'
		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent,0))/100 AS OriginalAmount , 	  
				V00.EndQuantity * T00.SalePrice * T02.ExchangeRate * (100- ISNULL(T00.DiscountPercent,0))/100 as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID,V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10, T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder,
				T00.DiscountSaleAmountDetail,
				T02.Varchar01 as Parameter01,
				T02.Varchar02 as Parameter02,
				T02.Varchar03 as Parameter03,
				T02.Varchar04 as Parameter04,
				T02.Varchar05 as Parameter05,
				T02.Varchar06 as Parameter06,
				T02.Varchar07 as Parameter07,
				T02.Varchar08 as Parameter08,
				T02.Varchar09 as Parameter09,
				T02.Varchar10 as Parameter10, T00.WarehouseID, 
				T00.RefInfor' + @Parameters + '	

		FROM OT2002 T00 WITH(NOLOCK)  INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID 
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID			
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end
				 
			END
	END 
END
ELSE IF (@CustomerName = 110) --Customername =  khách hàng Song Bình: chỉ lấy lên đơn hàng không lấy lên hóa đơn bán hàng
	BEGIN
	If isNULL (@VoucherID,'') <> '' 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		BEGIN
				SET @sSQL =N'
		SELECT 
			T00.ObjectID, T12.IsUsedEInvoice, T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
			T00.OrderID,T00.VoucherNo,T00.TDescription,T00.OTransactionID AS TransactionID ,
			T00.InventoryID,T01.InventoryName,
			T01.UnitID AS UnitID,
			0 AS IsEditInventoryName,
			CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN T00.Quantity / A09.ConversionFactor ELSE T00.Quantity * A09.ConversionFactor END ELSE T00.Quantity END AS Quantity, T00.UnitPrice,  T00.CommissionPercent,
			T00.OriginalAmount, T00.ConvertedAmount, 
			NULL AS DiscountPercent,
			NULL AS SODiscountAmount,
			NULL AS DiscountConvertedAmount,
			T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
			T01.AccountID, T01.MethodID, T01.IsStocked,
			T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
			T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
			T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
			'''' AS PaymentID, T00.PaymentTermID,
			1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
			(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATOriginalAMount,
			(SELECT  ConvertedAmount  FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATConvertedAmount,

			T00.BDescription, T01.IsDiscount, T00.DivisionID,
			T00.MOrderID,
			T00.SOrderID,
			T00.MTransactionID,
			T00.STransactionID,
			T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
			T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
			, T00.StandardAmount, T00.PriceListID, T00.DParameter01,
			T00.DParameter02, T00.DParameter03,T00.DParameter04,
			T00.DParameter05, T00.DParameter06, T00.DParameter07,
			T00.DParameter08, T00.DParameter09, T00.DParameter10,
			NULL S01ID, NULL S02ID, NULL S03ID, NULL S04ID, NULL S05ID, NULL S06ID, NULL S07ID, NULL S08ID, NULL S09ID, NULL S10ID,
			NULL S11ID, NULL S12ID, NULL S13ID, NULL S14ID, NULL S15ID, NULL S16ID, NULL S17ID, NULL S18ID, NULL S19ID, NULL S20ID,
			T00.IsProInventoryID, T00.DiscountSalesAmount,
			T00.DiscountPercentSOrder, 
			T00.DiscountAmountSOrder, NULL AS WarehouseID, 
			T00.DiscountSaleAmountDetail' + @Parameters2 +
			'
			, '''' AS PriceListID
		FROM AT9000  T00 WITH(NOLOCK)
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T12.ObjectID
		WHERE	T00.DivisionID = ''' + @DivisionID + '''  AND 
				T00.VoucherID =  '''+@VoucherID+'''  
				AND TransactionTypeID in (''T04'',''T64'')
		'
				SET @sSQLUnion = N'
		UNION

		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID, 
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity*T00.SalePrice*T02.ExchangeRate*(100- ISNULL(T00.DiscountPercent,0))/100	end 	as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate, V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,
				0 AS IsCheck,  
				T00.VATPercent,	 
				T00.VatGroupID,
				T00.VATOriginalAmount ,
				T00.VATConvertedAmount,
				T02.notes AS BDescription, 
				T01.IsDiscount, 
				T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID, V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10,
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder, T00.WarehouseID,
				T00.DiscountSaleAmountDetail' + @Parameters + '

				, OT2001.PriceListID
		FROM	OT2002 T00 WITH(NOLOCK)
		LEFT JOIN OT2001 WITH (NOLOCK) ON T00.SOrderID = OT2001.SOrderID
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID  AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		left join OT8899 O99 WITH(NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.SOrderID and O99.TransactionID = T00.TransactionID and O99.TableID = ''OT2002''
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END			
		END
		ELSE
			BEGIN
				--SET @sSQL =N'
		--SELECT 
		--	T00.ObjectID, T12.IsUsedEInvoice, T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
		--	T00.OrderID,T00.VoucherNo,T00.TDescription,T00.OTransactionID AS TransactionID ,
		--	T00.InventoryID,T01.InventoryName, T01.UnitID AS UnitID,  0 AS IsEditInventoryName,
		--	CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN T00.Quantity / A09.ConversionFactor ELSE T00.Quantity * A09.ConversionFactor END ELSE T00.Quantity END AS Quantity, T00.UnitPrice,  T00.CommissionPercent,
		--	T00.OriginalAmount, T00.ConvertedAmount, 
		--	NULL AS DiscountPercent, 
		--	NULL AS SODiscountAmount,
		--	NULL AS DiscountConvertedAmount,
		--	T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
		--	T01.AccountID, T01.MethodID, T01.IsStocked,
		--	T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
		--	T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
		--	T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
		--	'''' AS PaymentID, T00.PaymentTermID,
		--	1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
		--	(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
		--	AND AT9000.DivisionID = T00.DivisionID
		--	AND TransactionTypeID = ''T14''
		--	AND AT9000.MTransactionID = T00.MTransactionID
		--	AND AT9000.STransactionID = T00.STransactionID)as VATOriginalAMount,
		--	(SELECT  ConvertedAmount  FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
		--	AND AT9000.DivisionID = T00.DivisionID
		--	AND TransactionTypeID = ''T14''
		--	AND AT9000.MTransactionID = T00.MTransactionID
		--	AND AT9000.STransactionID = T00.STransactionID)as VATConvertedAmount,

		--	T00.BDescription, T01.IsDiscount, T00.DivisionID,
		--	T00.MOrderID,
		--	T00.SOrderID,
		--	T00.MTransactionID,
		--	T00.STransactionID,
		--	T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
		--	T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
		--	, T00.StandardAmount, T00.PriceListID, T00.DParameter01,
		--	T00.DParameter02, T00.DParameter03, T00.DParameter04,
		--	T00.DParameter05, T00.DParameter06, T00.DParameter07,
		--	T00.DParameter08, T00.DParameter09, T00.DParameter10, T00.IsProInventoryID, T00.DiscountSalesAmount,
		--	T00.DiscountPercentSOrder, 
		--	T00.DiscountAmountSOrder,
		--	T00.DiscountSaleAmountDetail,
		--	T00.Parameter01,
		--	T00.Parameter02,
		--	T00.Parameter03,
		--	T00.Parameter04,
		--	T00.Parameter05,
		--	T00.Parameter06,
		--	T00.Parameter07,
		--	T00.Parameter08,
		--	T00.Parameter09,
		--	T00.Parameter10, NULL AS WarehouseID, 
		--	T00.RefInfor' + @Parameters2 + '
		--FROM AT9000  T00 WITH(NOLOCK)		
		--LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		--LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		--INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		--LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T12.ObjectID		
		--WHERE	T00.DivisionID = ''' + @DivisionID + '''  AND 
		--		T00.VoucherID =  '''+@VoucherID+'''  
		--		AND TransactionTypeID in (''T04'',''T64'')
		--'
				SET @sSQLUnion = N'
		--UNION

		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity*T00.SalePrice*T02.ExchangeRate*(100- ISNULL(T00.DiscountPercent,0))/100	end 	as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate, V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,
				1 AS IsCheck,  
				T00.VATPercent,	 
				T00.VatGroupID,
				T00.VATOriginalAmount ,
				T00.VATConvertedAmount,
				T02.notes AS BDescription, 
				T01.IsDiscount, 
				T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID, V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10, T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder,
				T00.DiscountSaleAmountDetail,
				T02.Varchar01 as Parameter01,
				T02.Varchar02 as Parameter02,
				T02.Varchar03 as Parameter03,
				T02.Varchar04 as Parameter04,
				T02.Varchar05 as Parameter05,
				T02.Varchar06 as Parameter06,
				T02.Varchar07 as Parameter07,
				T02.Varchar08 as Parameter08,
				T02.Varchar09 as Parameter09,
				T02.Varchar10 as Parameter10, T00.WarehouseID, 
				T00.RefInfor' + @Parameters + '

		FROM	OT2002 T00 WITH(NOLOCK)
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID  AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 		

				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END

			END

	END
	ELSE -- Load New
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		BEGIN
				SET @sSQL =N'
		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.InventoryID ELSE V00.EndQuantity * A09.InventoryID END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity = V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent,0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity * T00.SalePrice * T02.ExchangeRate * (100- ISNULL(T00.DiscountPercent,0))/100	end as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource,
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID,V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10,			
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder, NULL AS WarehouseID, 
				T00.DiscountSaleAmountDetail' + @Parameters + '	

		FROM OT2002 T00 WITH(NOLOCK)  INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID 
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		left join OT8899 O99 WITH(NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.SOrderID and O99.TransactionID = T00.TransactionID and O99.TableID = ''OT2002''
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END			
		END
		ELSE
			BEGIN
				SET @sSQL =N'
		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity = V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent,0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity * T00.SalePrice * T02.ExchangeRate * (100- ISNULL(T00.DiscountPercent,0))/100	end as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource,
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID,V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10, T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder,
				T00.DiscountSaleAmountDetail,
				T02.Varchar01 as Parameter01,
				T02.Varchar02 as Parameter02,
				T02.Varchar03 as Parameter03,
				T02.Varchar04 as Parameter04,
				T02.Varchar05 as Parameter05,
				T02.Varchar06 as Parameter06,
				T02.Varchar07 as Parameter07,
				T02.Varchar08 as Parameter08,
				T02.Varchar09 as Parameter09,
				T02.Varchar10 as Parameter10, T00.WarehouseID, 
				T00.RefInfor
				, CASE WHEN EXISTS (select top 1 1 from sot0088 where TableBusinessChild = ''CIT1220'' AND BusinessParent = T02.VoucherNo) THEN 1 ELSE 0 END AS IsPromotionCalc' + @Parameters + '	

		FROM OT2002 T00 WITH(NOLOCK)  INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID 
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID			
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END	
				 
			END
	END 
END
ELSE ------Bảng chuẩn
	BEGIN
	If isNULL (@VoucherID,'') <> '' 
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		BEGIN
				SET @sSQL =N'
		SELECT 
			T00.ObjectID, T12.IsUsedEInvoice, T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
			T00.OrderID,T00.VoucherNo,T00.TDescription,T00.OTransactionID AS TransactionID ,
			T00.InventoryID,T01.InventoryName,
			T01.UnitID AS UnitID,
			0 AS IsEditInventoryName,
			CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN T00.Quantity / A09.ConversionFactor ELSE T00.Quantity * A09.ConversionFactor END ELSE T00.Quantity END AS Quantity, T00.UnitPrice,  T00.CommissionPercent,
			T00.OriginalAmount, T00.ConvertedAmount, 
			NULL AS DiscountPercent,
			NULL AS SODiscountAmount,
			NULL AS DiscountConvertedAmount,
			T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
			T01.AccountID, T01.MethodID, T01.IsStocked,
			T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
			T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
			T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
			'''' AS PaymentID, T00.PaymentTermID,
			1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
			(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATOriginalAMount,
			(SELECT  ConvertedAmount  FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATConvertedAmount,

			T00.BDescription, T01.IsDiscount, T00.DivisionID,
			T00.MOrderID,
			T00.SOrderID,
			T00.MTransactionID,
			T00.STransactionID,
			T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
			T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
			, T00.StandardAmount, T00.PriceListID, T00.DParameter01,
			T00.DParameter02, T00.DParameter03,T00.DParameter04,
			T00.DParameter05, T00.DParameter06, T00.DParameter07,
			T00.DParameter08, T00.DParameter09, T00.DParameter10,
			NULL S01ID, NULL S02ID, NULL S03ID, NULL S04ID, NULL S05ID, NULL S06ID, NULL S07ID, NULL S08ID, NULL S09ID, NULL S10ID,
			NULL S11ID, NULL S12ID, NULL S13ID, NULL S14ID, NULL S15ID, NULL S16ID, NULL S17ID, NULL S18ID, NULL S19ID, NULL S20ID,
			T00.IsProInventoryID, T00.DiscountSalesAmount,
			T00.DiscountPercentSOrder, 
			T00.DiscountAmountSOrder, NULL AS WarehouseID, 
			T00.DiscountSaleAmountDetail' + @Parameters2 +
			'
			, '''' AS PriceListID
		FROM AT9000  T00 WITH(NOLOCK)
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T12.ObjectID
		WHERE	T00.DivisionID = ''' + @DivisionID + '''  AND 
				T00.VoucherID =  '''+@VoucherID+'''  
				AND TransactionTypeID in (''T04'',''T64'')
		'
				SET @sSQLUnion = N'
		UNION

		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID, 
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity*T00.SalePrice*T02.ExchangeRate*(100- ISNULL(T00.DiscountPercent,0))/100	end 	as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate, V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,
				0 AS IsCheck,  
				T00.VATPercent,	 
				T00.VatGroupID,
				T00.VATOriginalAmount ,
				T00.VATConvertedAmount,
				T02.notes AS BDescription, 
				T01.IsDiscount, 
				T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID, V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10,
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder, T00.WarehouseID,
				T00.DiscountSaleAmountDetail' + @Parameters + '

				, OT2001.PriceListID
		FROM	OT2002 T00 WITH(NOLOCK)
		LEFT JOIN OT2001 WITH (NOLOCK) ON T00.SOrderID = OT2001.SOrderID
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID  AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		left join OT8899 O99 WITH(NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.SOrderID and O99.TransactionID = T00.TransactionID and O99.TableID = ''OT2002''
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END			
		END
		ELSE
			BEGIN
				SET @sSQL =N'
		SELECT 
			T00.ObjectID, T12.IsUsedEInvoice, T00.VATObjectID , T00.CurrencyID,T00.Exchangerate,
			T00.OrderID,T00.VoucherNo,T00.TDescription,T00.OTransactionID AS TransactionID ,
			T00.InventoryID,T01.InventoryName, T01.UnitID AS UnitID,  0 AS IsEditInventoryName,
			CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN T00.Quantity / A09.ConversionFactor ELSE T00.Quantity * A09.ConversionFactor END ELSE T00.Quantity END AS Quantity, T00.UnitPrice,  T00.CommissionPercent,
			T00.OriginalAmount, T00.ConvertedAmount, 
			NULL AS DiscountPercent, 
			NULL AS SODiscountAmount,
			NULL AS DiscountConvertedAmount,
			T01.IsSource, T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
			T01.AccountID, T01.MethodID, T01.IsStocked,
			T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID,  T00.Ana05ID, 
			T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID,  T00.Ana10ID, 
			T00.Orders, NULL  AS DueDate,NULL AS ShipDate, NULL AS DueDays,'''' AS VATNo,
			'''' AS PaymentID, T00.PaymentTermID,
			1 AS IsCheck, AT1010.VATRate AS VATPercent, T00.VatGroupID,
			(SELECT OriginalAMount FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATOriginalAMount,
			(SELECT  ConvertedAmount  FROM AT9000 WHERE AT9000.VoucherID = T00.VoucherID  
			AND AT9000.DivisionID = T00.DivisionID
			AND TransactionTypeID = ''T14''
			AND AT9000.MTransactionID = T00.MTransactionID
			AND AT9000.STransactionID = T00.STransactionID)as VATConvertedAmount,

			T00.BDescription, T01.IsDiscount, T00.DivisionID,
			T00.MOrderID,
			T00.SOrderID,
			T00.MTransactionID,
			T00.STransactionID,
			T00.ConvertedUnitID, T00.ConvertedQuantity, T00.ConvertedPrice, 
			T00.UParameter01, T00.UParameter02, T00.UParameter03, T00.UParameter04, T00.UParameter05, T00.StandardPrice
			, T00.StandardAmount, T00.PriceListID, T00.DParameter01,
			T00.DParameter02, T00.DParameter03, T00.DParameter04,
			T00.DParameter05, T00.DParameter06, T00.DParameter07,
			T00.DParameter08, T00.DParameter09, T00.DParameter10, T00.IsProInventoryID, T00.DiscountSalesAmount,
			T00.DiscountPercentSOrder, 
			T00.DiscountAmountSOrder,
			T00.DiscountSaleAmountDetail,
			T00.Parameter01,
			T00.Parameter02,
			T00.Parameter03,
			T00.Parameter04,
			T00.Parameter05,
			T00.Parameter06,
			T00.Parameter07,
			T00.Parameter08,
			T00.Parameter09,
			T00.Parameter10, NULL AS WarehouseID, 
			T00.RefInfor' + @Parameters2 + '
		FROM AT9000  T00 WITH(NOLOCK)		
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		LEFT JOIN  AT1010 WITH(NOLOCK) on AT1010.VATGroupID= T00.VATGroupID
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T00.ObjectID = T12.ObjectID		
		WHERE	T00.DivisionID = ''' + @DivisionID + '''  AND 
				T00.VoucherID =  '''+@VoucherID+'''  
				AND TransactionTypeID in (''T04'',''T64'')
		'
				SET @sSQLUnion = N'
		UNION

		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity= V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity*T00.SalePrice*(100- ISNULL(T00.DiscountPercent, 0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity*T00.SalePrice*T02.ExchangeRate*(100- ISNULL(T00.DiscountPercent,0))/100	end 	as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource, 
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate, V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,
				0 AS IsCheck,  
				T00.VATPercent,	 
				T00.VatGroupID,
				T00.VATOriginalAmount ,
				T00.VATConvertedAmount,
				T02.notes AS BDescription, 
				T01.IsDiscount, 
				T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID, V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10, T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder,
				T00.DiscountSaleAmountDetail,
				T02.Varchar01 as Parameter01,
				T02.Varchar02 as Parameter02,
				T02.Varchar03 as Parameter03,
				T02.Varchar04 as Parameter04,
				T02.Varchar05 as Parameter05,
				T02.Varchar06 as Parameter06,
				T02.Varchar07 as Parameter07,
				T02.Varchar08 as Parameter08,
				T02.Varchar09 as Parameter09,
				T02.Varchar10 as Parameter10, T00.WarehouseID, 
				T00.RefInfor' + @Parameters + '

		FROM	OT2002 T00 WITH(NOLOCK)
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID  AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 		

				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END

			END

	END
	ELSE -- Load New
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH(NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
		BEGIN
				SET @sSQL =N'
		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.InventoryID ELSE V00.EndQuantity * A09.InventoryID END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity = V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent,0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity * T00.SalePrice * T02.ExchangeRate * (100- ISNULL(T00.DiscountPercent,0))/100	end as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource,
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID,V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10,			
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
				T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder, NULL AS WarehouseID, 
				T00.DiscountSaleAmountDetail' + @Parameters + '	

		FROM OT2002 T00 WITH(NOLOCK)  INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID 
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		left join OT8899 O99 WITH(NOLOCK) on O99.DivisionID = T00.DivisionID and O99.VoucherID = T00.SOrderID and O99.TransactionID = T00.TransactionID and O99.TableID = ''OT2002''
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID		
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END			
		END
		ELSE
			BEGIN
				SET @sSQL =N'
		SELECT	T02.ObjectID, T12.IsUsedEInvoice, T02.VATObjectID, T02.CurrencyID, T02.Exchangerate,
				T00.SorderID AS OrderID,T02.VoucherNo,T00.Description,
				T00.TransactionID,
				T00.InventoryID,		
				ISNULL(T00.InventoryCommonName, T01.InventoryName)  AS InventoryName, 
				T01.UnitID AS UnitID,
				CASE WHEN ISNULL(T00.InventoryCommonName, '''') = '''' then 0 else 1 end  AS  IsEditInventoryName, 
				CASE WHEN ISNULL(A09.UnitID, '''') <> '''' THEN CASE WHEN A09.Operator = 1 THEN V00.EndQuantity / A09.ConversionFactor ELSE V00.EndQuantity * A09.ConversionFactor END ELSE V00.EndQuantity END AS Quantity,	
				T00.SalePrice AS UnitPrice, T00.CommissionPercent,
				CASE WHEN V00.EndQuantity = V00.OrderQuantity then ISNULL(T00.OriginalAmount,0) - ISNULL(T00.DiscountOriginalAmount, 0)  else
				V00.EndQuantity * T00.SalePrice * (100- ISNULL(T00.DiscountPercent,0))/100	end AS OriginalAmount , 	  
				CASE WHEN  V00.EndQuantity= V00.OrderQuantity then  ISNULL(T00.ConvertedAmount,0) - ISNULL(T00.DiscountConvertedAmount, 0) else 
				V00.EndQuantity * T00.SalePrice * T02.ExchangeRate * (100- ISNULL(T00.DiscountPercent,0))/100	end as ConvertedAmount,
				T00.DiscountPercent, 
				T00.DiscountAmount AS SODiscountAmount,
				T00.DiscountConvertedAmount,
				T01.IsSource,
				T01.IsLocation, T01.SalesAccountID, T01.IsLimitDate, 
				T01.AccountID, T01.MethodID, T01.IsStocked,
				T00.Ana01ID, T00.Ana02ID, T00.Ana03ID, T00.Ana04ID, T00.Ana05ID, 
				T00.Ana06ID, T00.Ana07ID, T00.Ana08ID, T00.Ana09ID, T00.Ana10ID, 
				T00.Orders ,V00.DueDate,
				V00.ShipDate, V00.DueDays, T02.VATNo,T02.PaymentID, T02.PaymentTermID,  T00.VATPercent,  T00.VatGroupID,T00.VATOriginalAmount, T00.VATConvertedAmount,
				T02.notes AS BDescription, T01.IsDiscount, T00.DivisionID,
				T00.SOrderID AS MOrderID,
				T00.RefSOrderID AS SOrderID,
				T00.TransactionID AS MTransactionID,
				T00.RefSTransactionID AS STransactionID,
				T00.UnitID As ConvertedUnitID,V00.EndConvertedQuantity ConvertedQuantity, T00.ConvertedSalePrice As ConvertedPrice, 
				T00.Parameter01 As UParameter01, T00.Parameter02 As UParameter02, T00.Parameter03 As UParameter03, 
				T00.Parameter04 As UParameter04, T00.Parameter05 As UParameter05, T00.StandardPrice
				, T00.StandardAmount, T02.PriceListID, T00.nvarchar01,
				T00.nvarchar02, T00.nvarchar03, T00.nvarchar04,
				T00.nvarchar05, T00.nvarchar06,	T00.nvarchar07,
				T00.nvarchar08, T00.nvarchar09,	T00.nvarchar10, T00.IsProInventoryID, T02.DiscountSalesAmount,
				T02.DiscountPercentSOrder, 
				T02.DiscountAmountSOrder,
				T00.DiscountSaleAmountDetail,
				T02.Varchar01 as Parameter01,
				T02.Varchar02 as Parameter02,
				T02.Varchar03 as Parameter03,
				T02.Varchar04 as Parameter04,
				T02.Varchar05 as Parameter05,
				T02.Varchar06 as Parameter06,
				T02.Varchar07 as Parameter07,
				T02.Varchar08 as Parameter08,
				T02.Varchar09 as Parameter09,
				T02.Varchar10 as Parameter10, T00.WarehouseID, 
				T00.RefInfor
				, CASE WHEN EXISTS (select top 1 1 from sot0088 where TableBusinessChild = ''CIT1220'' AND BusinessParent = T02.VoucherNo) THEN 1 ELSE 0 END AS IsPromotionCalc' + @Parameters + '	

		FROM OT2002 T00 WITH(NOLOCK)  INNER JOIN OT2001 T02 WITH(NOLOCK) on T00.SOrderID =  T02.SOrderID AND T00.DivisionID = T02.DivisionID 
		LEFT JOIN AT1309 A09 WITH (NOLOCK) ON T00.InventoryID = A09.InventoryID AND T00.UnitID = A09.UnitID
		INNER JOIN AQ2901 V00 on V00.SOrderID = T00.SOrderID AND V00.TransactionID = T00.TransactionID AND V00.DivisionID = T00.DivisionID 
		INNER JOIN AT1302 T01 WITH(NOLOCK) on T00.InventoryID = T01.InventoryID
		LEFT JOIN AT1202 T12 WITH (NOLOCK) ON T12.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND T02.ObjectID = T12.ObjectID			
		WHERE  T02.DivisionID = ''' + @DivisionID + ''' AND '
		
				SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''')
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) > 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end
				
				IF(@CustomerName = 110) -- KH SONG BÌNH
				BEGIN
									SET @sSQL1 = N'
				T00.SOrderID in (N''' + @lstROrderID + ''') 
				AND (CASE WHEN T01.IsDiscount = 1 then V00.EndOriginalAmount else V00.EndQuantity  end ) >= 0
				 ' + @sWhere +
				CASE WHEN ISNULL(@VATGroupID , '') <> ''  AND ISNULL(@VATGroupID , '') <> '%' then ' AND T00.VATPercent = ' + cast(@VATRate AS nvarchar(50))  else '' end 	
				END	
				 
			END
	END 
END

Print @sSQL
Print @sSQLUnion
Print @sSQL2
Print @sSQL1
IF NOT EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'AV3201' + @CONNID)
	EXEC('CREATE VIEW AV3201' + @ConnID + ' ----tao boi AP3201
			as ' + @sSQL + @sSQLUnion + @sSQL2 +  @sSQL1)
ELSE	
	EXEC('ALTER VIEW AV3201' + @ConnID + ' ----tao boi AP3201
			as ' + @sSQL + @sSQLUnion + @sSQL2 +  @sSQL1)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
