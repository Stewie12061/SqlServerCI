IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2089]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2089]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tra Giang on 19/12/2019: đẩy dữ liệu bị xóa vào table lịch sử xóa
---- Updated by Văn Tài	  on 20/04/2020: Cập nhật xử lý check trùng để xóa dữ liệu.
---- Modified by Lê Hoàng on 26/04/2020: Bổ sung Nhóm thuế nhập khẩu ImTaxConvertedGroupID cho AT9000_DEL, nhà cung cấp Supplier cho OT2001_DEL.
---- Đình Hòa on 13/01/2020 : Chuyển fix từ dự án sang STD 

CREATE PROCEDURE [dbo].[AP2089] 	
						
					@DivisionID as nvarchar(50),
					@VoucherID as nvarchar(50),
					@TypeID INT --1: Phiếu nhập/xuất/VCNB kho ; 2: Đơn hàng bán ; 3: Đơn hàng mua
 AS
 IF @TypeID = 1	
 BEGIN  					
			IF(EXISTS(SELECT * FROM AT2006_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID))
			BEGIN
				DELETE AT2006_Del WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID
			END

			IF(EXISTS(SELECT * FROM AT2007_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID))
			BEGIN
				DELETE AT2007_Del WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID
			END

			IF(EXISTS(SELECT * FROM WT8899_Del WITH (NOLOCK) WHERE VoucherID = @VoucherID))
			BEGIN
				DELETE WT8899_Del WHERE VoucherID = @VoucherID
			END

			IF(EXISTS(SELECT * FROM AT9000_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID))
			BEGIN
				DELETE AT9000_Del WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID
			END

			--Đẩy dữ liệu maser phiếu nhâp/ xuât/ VCNB
					INSERT INTO AT2006_Del
									( APK, DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, ProjectID, OrderID, BatchID, WareHouseID, ReDeTypeID
									, KindVoucherID, WareHouseID2, Status, EmployeeID, Description, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, RefNo01, RefNo02, RDAddress, ContactPerson
									, VATObjectName, InventoryTypeID, IsGoodsFirstVoucher, MOrderID, ApportionID, IsInheritWarranty, EVoucherID, IsGoodsRecycled, IsVoucher, ImVoucherID, ReVoucherID
									, SParameter01, SParameter02, SParameter03, SParameter04, SParameter05, SParameter06, SParameter07, SParameter08, SParameter09, SParameter10, SParameter11, SParameter12
									, SParameter13, SParameter14, SParameter15, SParameter16, SParameter17, SParameter18, SParameter19, SParameter20, RouteID, InTime, OutTime, DeliveryEmployeeID, DeliveryStatus
									, IsWeb, CashierID, CashierTime, IsDeposit, IsProduct, ObjectShipID, ContractID, ContractNo, IsCalCost, IsReturn, IsDelivery, IsInTime, IsOutTime, IsPayment, IsTransferMoney
									, IsReceiptMoney, PaymentTime, TransferMoneyTime, DeliveryDate, IsAutoVoucherID )

					 SELECT  APK, DivisionID, VoucherID, TableID, TranMonth, TranYear, VoucherTypeID, VoucherDate, VoucherNo, ObjectID, ProjectID, OrderID, BatchID, WareHouseID, ReDeTypeID
									, KindVoucherID, WareHouseID2, Status, EmployeeID, Description, CreateDate, CreateUserID, LastModifyUserID, LastModifyDate, RefNo01, RefNo02, RDAddress, ContactPerson
									, VATObjectName, InventoryTypeID, IsGoodsFirstVoucher, MOrderID, ApportionID, IsInheritWarranty, EVoucherID, IsGoodsRecycled, IsVoucher, ImVoucherID, ReVoucherID
									, SParameter01, SParameter02, SParameter03, SParameter04, SParameter05, SParameter06, SParameter07, SParameter08, SParameter09, SParameter10, SParameter11, SParameter12
									, SParameter13, SParameter14, SParameter15, SParameter16, SParameter17, SParameter18, SParameter19, SParameter20, RouteID, InTime, OutTime, DeliveryEmployeeID, DeliveryStatus
									, IsWeb, CashierID, CashierTime, IsDeposit, IsProduct, ObjectShipID, ContractID, ContractNo, IsCalCost, IsReturn, IsDelivery, IsInTime, IsOutTime, IsPayment, IsTransferMoney
									, IsReceiptMoney, PaymentTime, TransferMoneyTime, DeliveryDate, IsAutoVoucherID  
					FROM AT2006 WITH (NOLOCK) WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID


			--Đẩy dữ liệu detail phiếu nhâp/ xuât/ VCNB		
					INSERT INTO AT2007_Del (
								   APK,DivisionID,TransactionID,VoucherID,BatchID,InventoryID,UnitID,ActualQuantity,UnitPrice,OriginalAmount,ConvertedAmount,Notes,TranMonth,TranYear,CurrencyID,ExchangeRate,SaleUnitPrice,SaleAmount
								, DiscountAmount,SourceNo,DebitAccountID,CreditAccountID,LocationID,ImLocationID,LimitDate,Orders,ConversionFactor,ReTransactionID,ReVoucherID,Ana01ID,Ana02ID,Ana03ID,PeriodID
								, ProductID,OrderID,InventoryName1,Ana04ID,Ana05ID,OTransactionID,ReSPVoucherID,ReSPTransactionID,ETransactionID,MTransactionID,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05
								, ConvertedQuantity,ConvertedPrice,ConvertedUnitID,MOrderID,SOrderID,STransactionID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,LocationCode,Location01ID,Location02ID,Location03ID,Location04ID,Location05ID
								, MarkQuantity,OExpenseConvertedAmount,WVoucherID,Notes01,Notes02,Notes03,Notes04,Notes05,Notes06,Notes07,Notes08,Notes09,Notes10,Notes11,Notes12,Notes13,Notes14,Notes15,StandardPrice
								, StandardAmount,RefInfor,InheritTableID,InheritVoucherID,InheritTransactionID,KITID,KITQuantity,TVoucherID,TTransactionID,SOrderIDRecognition,SerialNo,WarrantyCard,PS01ID
								, PS02ID,PS03ID,PS04ID,PS05ID,PS06ID,PS07ID,PS08ID,PS09ID,PS10ID,PS11ID,PS12ID,PS13ID,PS14ID,PS15ID,PS16ID,PS17ID,PS18ID,PS19ID,PS20ID,InheritPO,IsRepairItem )

					SELECT    APK,DivisionID,TransactionID,VoucherID,BatchID,InventoryID,UnitID,ActualQuantity,UnitPrice,OriginalAmount,ConvertedAmount,Notes,TranMonth,TranYear,CurrencyID,ExchangeRate,SaleUnitPrice,SaleAmount
								, DiscountAmount,SourceNo,DebitAccountID,CreditAccountID,LocationID,ImLocationID,LimitDate,Orders,ConversionFactor,ReTransactionID,ReVoucherID,Ana01ID,Ana02ID,Ana03ID,PeriodID
								, ProductID,OrderID,InventoryName1,Ana04ID,Ana05ID,OTransactionID,ReSPVoucherID,ReSPTransactionID,ETransactionID,MTransactionID,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05
								, ConvertedQuantity,ConvertedPrice,ConvertedUnitID,MOrderID,SOrderID,STransactionID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,LocationCode,Location01ID,Location02ID,Location03ID,Location04ID,Location05ID
								, MarkQuantity,OExpenseConvertedAmount,WVoucherID,Notes01,Notes02,Notes03,Notes04,Notes05,Notes06,Notes07,Notes08,Notes09,Notes10,Notes11,Notes12,Notes13,Notes14,Notes15,StandardPrice
								, StandardAmount,RefInfor,InheritTableID,InheritVoucherID,InheritTransactionID,KITID,KITQuantity,TVoucherID,TTransactionID,SOrderIDRecognition,SerialNo,WarrantyCard,PS01ID
								, PS02ID,PS03ID,PS04ID,PS05ID,PS06ID,PS07ID,PS08ID,PS09ID,PS10ID,PS11ID,PS12ID,PS13ID,PS14ID,PS15ID,PS16ID,PS17ID,PS18ID,PS19ID,PS20ID,InheritPO,IsRepairItem
								 FROM AT2007 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID

		INSERT INTO AT9000_Del (APK,DivisionID,VoucherID,BatchID,TransactionID,TableID,TranMonth,TranYear,TransactionTypeID,CurrencyID,ObjectID,CreditObjectID,VATNo
								,VATObjectID,VATObjectName,VATObjectAddress,DebitAccountID,CreditAccountID,ExchangeRate,UnitPrice,OriginalAmount,ConvertedAmount,ImTaxOriginalAmount,ImTaxConvertedAmount
								,ExpenseOriginalAmount,ExpenseConvertedAmount,IsStock,VoucherDate,InvoiceDate,VoucherTypeID,VATTypeID,VATGroupID,VoucherNo,Serial,InvoiceNo,Orders,EmployeeID,SenderReceiver,SRDivisionName,SRAddress
								,RefNo01,RefNo02,VDescription,BDescription,TDescription,Quantity,InventoryID,UnitID,Status,IsAudit,IsCost,Ana01ID,Ana02ID,Ana03ID,PeriodID,ExpenseID,MaterialTypeID
								,ProductID,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,OriginalAmountCN,ExchangeRateCN,CurrencyIDCN,DueDays,PaymentID,DueDate,DiscountRate,OrderID,CreditBankAccountID
								,DebitBankAccountID,CommissionPercent,InventoryName1,Ana04ID,Ana05ID,PaymentTermID,DiscountAmount,OTransactionID,IsMultiTax,VATOriginalAmount,VATConvertedAmount,ReVoucherID
								,ReBatchID,ReTransactionID,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,ConvertedQuantity,ConvertedPrice
								,ConvertedUnitID,ConversionFactor,UParameter01,UParameter02,UParameter03,UParameter04,UParameter05,IsLateInvoice,MOrderID,SOrderID,MTransactionID,STransactionID
								,RefVoucherNo,TBatchID,DParameter01,DParameter02,DParameter03,DParameter04,DParameter05,DParameter06,DParameter07,DParameter08,DParameter09,DParameter10
								,InheritTableID,InheritVoucherID,InheritTransactionID,ETaxVoucherID,ETaxID,ETaxConvertedUnit,ETaxConvertedAmount,ETaxTransactionID,AssignedSET,SETID,SETUnitID
								,SETTaxRate,SETConvertedUnit,SETQuantity,SETOriginalAmount,SETConvertedAmount,SETConsistID,SETTransactionID,AssignedNRT,NRTTaxAmount,NRTClassifyID,NRTUnitID
								,NRTTaxRate,NRTConvertedUnit,NRTQuantity,NRTOriginalAmount,NRTConvertedAmount,NRTConsistID,NRTTransactionID,InvoiceCode,InvoiceSign,ReTableID,TVoucherID,OldCounter,NewCounter,OtherCounter
								,WOrderID,WTransactionID,MarkQuantity,RefInfor,StandardPrice,StandardAmount,IsCom,PriceListID,ContractDetailID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,CreditObjectName
								,CreditVATNo,IsPOCost,TaxBaseAmount,WTCExchangeRate,WTCOperator,IsFACost,IsInheritFA,InheritedFAVoucherID,AVRExchangeRate,PaymentExchangeRate,IsMultiExR,ExchangeRateDate
								,DiscountSalesAmount,IsProInventoryID,InheritQuantity,DiscountPercentSOrder,DiscountAmountSOrder,IsWithhodingTax,IsSaleInvoice,VirtualPrice,VirtualAmount,WTTransID,DiscountSaleAmountDetail
								,ABParameter01,ABParameter02,ABParameter03,ABParameter04,ABParameter05,ABParameter06,ABParameter07,ABParameter08,ABParameter09,ABParameter10,SOAna01ID,SOAna02ID,SOAna03ID,SOAna04ID,SOAna05ID
								,IsVATWithhodingTax,VATWithhodingRate,IsEInvoice,EInvoiceStatus,IsAdvancePayment,Fkey,InheritFkey,EInvoiceType,TypeOfAdjust,IsInheritInvoicePOS,InheritInvoicePOS,IsInheritPayPOS,InheritPayPOS
								,IsInvoiceSuggest,RefVoucherDate,IsDeposit,ReTransactionTypeID,ImVoucherID,ImTransactionID,SourceNo,LimitDate,IsPromotionItem,IsReceived,ObjectName1,InvoiceGuid,DiscountedUnitPrice,ConvertedDiscountedUnitPrice
								,IsInheritContract,VoucherOrder,PlanID,PS01ID,PS02ID,PS03ID,PS04ID,PS05ID,PS06ID,PS07ID,PS08ID,PS09ID,PS10ID,PS11ID,PS12ID,PS13ID,PS14ID,PS15ID,PS16ID,PS17ID,PS18ID,PS19ID,PS20ID,ReVoucherID3386,IsAuto3386,ImTaxConvertedGroupID)

		SELECT APK,DivisionID,VoucherID,BatchID,TransactionID,TableID,TranMonth,TranYear,TransactionTypeID,CurrencyID,ObjectID,CreditObjectID,VATNo
				,VATObjectID,VATObjectName,VATObjectAddress,DebitAccountID,CreditAccountID,ExchangeRate,UnitPrice,OriginalAmount,ConvertedAmount,ImTaxOriginalAmount,ImTaxConvertedAmount
				,ExpenseOriginalAmount,ExpenseConvertedAmount,IsStock,VoucherDate,InvoiceDate,VoucherTypeID,VATTypeID,VATGroupID,VoucherNo,Serial,InvoiceNo,Orders,EmployeeID,SenderReceiver,SRDivisionName,SRAddress
				,RefNo01,RefNo02,VDescription,BDescription,TDescription,Quantity,InventoryID,UnitID,Status,IsAudit,IsCost,Ana01ID,Ana02ID,Ana03ID,PeriodID,ExpenseID,MaterialTypeID
				,ProductID,CreateDate,CreateUserID,LastModifyDate,LastModifyUserID,OriginalAmountCN,ExchangeRateCN,CurrencyIDCN,DueDays,PaymentID,DueDate,DiscountRate,OrderID,CreditBankAccountID
				,DebitBankAccountID,CommissionPercent,InventoryName1,Ana04ID,Ana05ID,PaymentTermID,DiscountAmount,OTransactionID,IsMultiTax,VATOriginalAmount,VATConvertedAmount,ReVoucherID
				,ReBatchID,ReTransactionID,Parameter01,Parameter02,Parameter03,Parameter04,Parameter05,Parameter06,Parameter07,Parameter08,Parameter09,Parameter10,ConvertedQuantity,ConvertedPrice
				,ConvertedUnitID,ConversionFactor,UParameter01,UParameter02,UParameter03,UParameter04,UParameter05,IsLateInvoice,MOrderID,SOrderID,MTransactionID,STransactionID
				,RefVoucherNo,TBatchID,DParameter01,DParameter02,DParameter03,DParameter04,DParameter05,DParameter06,DParameter07,DParameter08,DParameter09,DParameter10
				,InheritTableID,InheritVoucherID,InheritTransactionID,ETaxVoucherID,ETaxID,ETaxConvertedUnit,ETaxConvertedAmount,ETaxTransactionID,AssignedSET,SETID,SETUnitID
				,SETTaxRate,SETConvertedUnit,SETQuantity,SETOriginalAmount,SETConvertedAmount,SETConsistID,SETTransactionID,AssignedNRT,NRTTaxAmount,NRTClassifyID,NRTUnitID
				,NRTTaxRate,NRTConvertedUnit,NRTQuantity,NRTOriginalAmount,NRTConvertedAmount,NRTConsistID,NRTTransactionID,InvoiceCode,InvoiceSign,ReTableID,TVoucherID,OldCounter,NewCounter,OtherCounter
				,WOrderID,WTransactionID,MarkQuantity,RefInfor,StandardPrice,StandardAmount,IsCom,PriceListID,ContractDetailID,Ana06ID,Ana07ID,Ana08ID,Ana09ID,Ana10ID,CreditObjectName
				,CreditVATNo,IsPOCost,TaxBaseAmount,WTCExchangeRate,WTCOperator,IsFACost,IsInheritFA,InheritedFAVoucherID,AVRExchangeRate,PaymentExchangeRate,IsMultiExR,ExchangeRateDate
				,DiscountSalesAmount,IsProInventoryID,InheritQuantity,DiscountPercentSOrder,DiscountAmountSOrder,IsWithhodingTax,IsSaleInvoice,VirtualPrice,VirtualAmount,WTTransID,DiscountSaleAmountDetail
				,ABParameter01,ABParameter02,ABParameter03,ABParameter04,ABParameter05,ABParameter06,ABParameter07,ABParameter08,ABParameter09,ABParameter10,SOAna01ID,SOAna02ID,SOAna03ID,SOAna04ID,SOAna05ID
				,IsVATWithhodingTax,VATWithhodingRate,IsEInvoice,EInvoiceStatus,IsAdvancePayment,Fkey,InheritFkey,EInvoiceType,TypeOfAdjust,IsInheritInvoicePOS,InheritInvoicePOS,IsInheritPayPOS,InheritPayPOS
				,IsInvoiceSuggest,RefVoucherDate,IsDeposit,ReTransactionTypeID,ImVoucherID,ImTransactionID,SourceNo,LimitDate,IsPromotionItem,IsReceived,ObjectName1,InvoiceGuid,DiscountedUnitPrice,ConvertedDiscountedUnitPrice
				,IsInheritContract,VoucherOrder,PlanID,PS01ID,PS02ID,PS03ID,PS04ID,PS05ID,PS06ID,PS07ID,PS08ID,PS09ID,PS10ID,PS11ID,PS12ID,PS13ID,PS14ID,PS15ID,PS16ID,PS17ID,PS18ID,PS19ID,PS20ID,ReVoucherID3386,IsAuto3386,ImTaxConvertedGroupID
			FROM AT9000 WITH (NOLOCK) WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID 

			-- Thông tin quy cách
			IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1 )
			BEGIN
					INSERT INTO WT8899_Del (
						TableID, VoucherID, TransactionID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID
						, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, UnitPrice01, UnitPrice02, UnitPrice03, UnitPrice04, UnitPrice05
						, UnitPrice06, UnitPrice07, UnitPrice08, UnitPrice09, UnitPrice10, UnitPrice11, UnitPrice12, UnitPrice13, UnitPrice14
						, UnitPrice15, UnitPrice16, UnitPrice17, UnitPrice18, UnitPrice19, UnitPrice20, UnitPriceStandard, DivisionID
						, QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount	)
					SELECT 	TableID, VoucherID, TransactionID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID
						, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID, UnitPrice01, UnitPrice02, UnitPrice03, UnitPrice04, UnitPrice05
						, UnitPrice06, UnitPrice07, UnitPrice08, UnitPrice09, UnitPrice10, UnitPrice11, UnitPrice12, UnitPrice13, UnitPrice14
						, UnitPrice15, UnitPrice16, UnitPrice17, UnitPrice18, UnitPrice19, UnitPrice20, UnitPriceStandard, DivisionID
						, QC_OriginalQuantity, QC_OriginalAmount, QC_ConvertedQuantity, QC_ConvertedAmount	
					FROM WT8899  WITH (NOLOCK) WHERE VoucherID = @VoucherID
					
			END
END 
ELSE IF @TypeID = 2 
BEGIN

		IF(EXISTS(SELECT * FROM OT2001_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = @VoucherID))
		BEGIN
			DELETE OT2001_Del WHERE DivisionID = @DivisionID AND SOrderID = @VoucherID 
		END

		IF(EXISTS(SELECT * FROM OT2002_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND SOrderID = @VoucherID))
		BEGIN
			DELETE OT2002_Del WHERE DivisionID= @DivisionID AND SOrderID = @VoucherID 
		END

		IF(EXISTS(SELECT * FROM OT8899_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID))
		BEGIN
			DELETE OT8899_Del WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID
		END

		INSERT INTO OT2001_Del (APK, DivisionID, SOrderID, VoucherTypeID, VoucherNo, OrderDate, ContractNo, ContractDate, ClassifyID, OrderType
								, ObjectID, DeliveryAddress, Notes, Disabled, OrderStatus, QuotationID, CreateDate, CreateUserID, LastModifyUserID
								, LastModifyDate, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, CurrencyID, ExchangeRate, InventoryTypeID, TranMonth
								, TranYear, EmployeeID, Transport, PaymentID, ObjectName, VatNo, Address, IsPeriod, IsPlan, DepartmentID, SalesManID
								, ShipDate, InheritSOrderID, DueDate, PaymentTermID, FileType, Contact, VATObjectID, VATObjectName, IsInherit, IsConfirm
								, DescriptionConfirm, PeriodID, SalesMan2ID, PriceListID, IsPrinted, IsSalesCommission, Ana06ID, Ana07ID, Ana08ID, Ana09ID
								, Ana10ID, OrderTypeID, ImpactLevel, IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02, ConfirmDate
								, ConfirmUserID, RouteID, IsInvoice, InheritApportionID, DiscountSalesAmount, DiscountPercentSOrder, DiscountAmountSOrder
								, ShipAmount, IsAllocation, AdjustSOrderID, RelatedToTypeID, IsWholeSale, IsObjectConfirm, NoteConfirm, DateConfirm
								, ProductDate, APKMaster_9000, Status, IsShipDate,TaskID,SupplierID)

		SELECT APK, DivisionID, SOrderID, VoucherTypeID, VoucherNo, OrderDate, ContractNo, ContractDate, ClassifyID, OrderType
								, ObjectID, DeliveryAddress, Notes, Disabled, OrderStatus, QuotationID, CreateDate, CreateUserID, LastModifyUserID
								, LastModifyDate, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, CurrencyID, ExchangeRate, InventoryTypeID, TranMonth
								, TranYear, EmployeeID, Transport, PaymentID, ObjectName, VatNo, Address, IsPeriod, IsPlan, DepartmentID, SalesManID
								, ShipDate, InheritSOrderID, DueDate, PaymentTermID, FileType, Contact, VATObjectID, VATObjectName, IsInherit, IsConfirm
								, DescriptionConfirm, PeriodID, SalesMan2ID, PriceListID, IsPrinted, IsSalesCommission, Ana06ID, Ana07ID, Ana08ID, Ana09ID
								, Ana10ID, OrderTypeID, ImpactLevel, IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02, ConfirmDate
								, ConfirmUserID, RouteID, IsInvoice, InheritApportionID, DiscountSalesAmount, DiscountPercentSOrder, DiscountAmountSOrder
								, ShipAmount, IsAllocation, AdjustSOrderID, RelatedToTypeID, IsWholeSale, IsObjectConfirm, NoteConfirm, DateConfirm
								, ProductDate, APKMaster_9000, Status, IsShipDate,TaskID,SupplierID
		 FROM OT2001  WITH (NOLOCK) WHERE DivisionID= @DivisionID AND SOrderID = @VoucherID 

		INSERT INTO OT2002_Del
					(APK, DivisionID, TransactionID, SOrderID, InventoryID, MethodID, OrderQuantity, SalePrice, ConvertedAmount, OriginalAmount
					, VATOriginalAmount, VATConvertedAmount, VATPercent, DiscountConvertedAmount, DiscountPercent, IsPicking, Quantity01
					, Quantity02, Quantity03, Quantity04, Quantity05, Quantity06, Quantity07, Quantity08, Quantity09, Quantity10, Quantity11
					, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20, Quantity21
					, Quantity22, Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30, WareHouseID
					, DiscountOriginalAmount, LinkNo, EndDate, Orders, Description, RefInfor, CommissionPercent, CommissionCAmount, CommissionOAmount
					, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, InventoryCommonName, UnitID, Finish, AdjustQuantity, FileID, RefOrderID
					, SourceNo, Cal01, Cal02, Cal03, Cal04, Cal05, Cal06, Cal07, Cal08, Cal09, Cal10, Notes, Notes01, Notes02, QuotationID
					, VATGroupID, QuoTransactionID, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02, SaleOffAmount02, SaleOffPercent03
					, SaleOffAmount03, SaleOffPercent04, SaleOffAmount04, SaleOffPercent05, SaleOffAmount05, PriceList, Varchar01, Varchar02
					, Varchar03, Varchar04, Varchar05, Varchar06, Varchar07, Varchar08, Varchar09, Varchar10, ConvertedQuantity, SOKitTransactionID
					, ConvertedSalePrice, nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05, nvarchar06, nvarchar07, nvarchar08, nvarchar09
					, nvarchar10, Allowance, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, StandardPrice, YDQuantity, StandardAmount
					, StandardVoucherID, Markup, OriginalAmountOutput, DeliveryDate, ConvertedSalepriceInput, RefSOrderID, RefSTransactionID
					, ShipDate, InheritTableID, InheritVoucherID, InheritTransactionID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
					, ExtraID, ReadyQuantity, PlanPercent, PlanQuantity, IsProInventoryID, SOActualQuantity, ParentInventoryID, AppInheritOrderID
					, ReAPK, DiscountSaleAmountDetail, KmNumber, Varchar11, Varchar12, Varchar13, Varchar14, Varchar15, Varchar16, Varchar17, Varchar18
					, Varchar19, Varchar20, Varchar21, Varchar22, Varchar23, Varchar24, Varchar25, Varchar26, Varchar27
					, Varchar28, Varchar29, Varchar30, EstimateQuantity, BeginQuantity, MinQuantity, InventoryEndDate, PlanDate, SOrderIDRecognition, Ana02IDAP
					, ExportType, NotesAP, AdjustSOrderID, AdjustTransactionID, IsBorrow, RequireDate, ScheduleDate, ObjectID_NNP
					, InventoryQuantity, PickingQuantity, IsInvenBorrow, APKMaster_9000, ApproveLevel, ApprovingLevel, Status ) 
		SELECT APK, DivisionID, TransactionID, SOrderID, InventoryID, MethodID, OrderQuantity, SalePrice, ConvertedAmount, OriginalAmount
					, VATOriginalAmount, VATConvertedAmount, VATPercent, DiscountConvertedAmount, DiscountPercent, IsPicking, Quantity01
					, Quantity02, Quantity03, Quantity04, Quantity05, Quantity06, Quantity07, Quantity08, Quantity09, Quantity10, Quantity11
					, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20, Quantity21
					, Quantity22, Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30, WareHouseID
					, DiscountOriginalAmount, LinkNo, EndDate, Orders, Description, RefInfor, CommissionPercent, CommissionCAmount, CommissionOAmount
					, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, InventoryCommonName, UnitID, Finish, AdjustQuantity, FileID, RefOrderID
					, SourceNo, Cal01, Cal02, Cal03, Cal04, Cal05, Cal06, Cal07, Cal08, Cal09, Cal10, Notes, Notes01, Notes02, QuotationID
					, VATGroupID, QuoTransactionID, SaleOffPercent01, SaleOffAmount01, SaleOffPercent02, SaleOffAmount02, SaleOffPercent03
					, SaleOffAmount03, SaleOffPercent04, SaleOffAmount04, SaleOffPercent05, SaleOffAmount05, PriceList, Varchar01, Varchar02
					, Varchar03, Varchar04, Varchar05, Varchar06, Varchar07, Varchar08, Varchar09, Varchar10, ConvertedQuantity, SOKitTransactionID
					, ConvertedSalePrice, nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05, nvarchar06, nvarchar07, nvarchar08, nvarchar09
					, nvarchar10, Allowance, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, StandardPrice, YDQuantity, StandardAmount
					, StandardVoucherID, Markup, OriginalAmountOutput, DeliveryDate, ConvertedSalepriceInput, RefSOrderID, RefSTransactionID
					, ShipDate, InheritTableID, InheritVoucherID, InheritTransactionID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID
					, ExtraID, ReadyQuantity, PlanPercent, PlanQuantity, IsProInventoryID, SOActualQuantity, ParentInventoryID, AppInheritOrderID
					, ReAPK, DiscountSaleAmountDetail, KmNumber, Varchar11, Varchar12, Varchar13, Varchar14, Varchar15, Varchar16, Varchar17, Varchar18
					, Varchar19, Varchar20, Varchar21, Varchar22, Varchar23, Varchar24, Varchar25, Varchar26, Varchar27
					, Varchar28, Varchar29, Varchar30, EstimateQuantity, BeginQuantity, MinQuantity, InventoryEndDate, PlanDate, SOrderIDRecognition, Ana02IDAP
					, ExportType, NotesAP, AdjustSOrderID, AdjustTransactionID, IsBorrow, RequireDate, ScheduleDate, ObjectID_NNP
					, InventoryQuantity, PickingQuantity, IsInvenBorrow, APKMaster_9000, ApproveLevel, ApprovingLevel, Status
		 FROM OT2002 WITH (NOLOCK) WHERE DivisionID= @DivisionID AND SOrderID = @VoucherID 


		INSERT INTO OT8899_Del
					( DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID
					, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID
					, S19ID, S20ID, SUnitPrice01, SUnitPrice02, SUnitPrice03, SUnitPrice04, SUnitPrice05, SUnitPrice06
					, SUnitPrice07, SUnitPrice08, SUnitPrice09, SUnitPrice10, SUnitPrice11, SUnitPrice12, SUnitPrice13
					, SUnitPrice14, SUnitPrice15, SUnitPrice16, SUnitPrice17, SUnitPrice18, SUnitPrice19, SUnitPrice20
					, UnitPriceStandard ) 
		SELECT DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID
					, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID
					, S19ID, S20ID, SUnitPrice01, SUnitPrice02, SUnitPrice03, SUnitPrice04, SUnitPrice05, SUnitPrice06
					, SUnitPrice07, SUnitPrice08, SUnitPrice09, SUnitPrice10, SUnitPrice11, SUnitPrice12, SUnitPrice13
					, SUnitPrice14, SUnitPrice15, SUnitPrice16, SUnitPrice17, SUnitPrice18, SUnitPrice19, SUnitPrice20
					, UnitPriceStandard 
		FROM OT8899  WITH (NOLOCK) WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID 
		
END 	
ELSE
BEGIN 
		IF(EXISTS(SELECT * FROM OT3001_Del WITH (NOLOCK) WHERE DivisionID= @DivisionID AND POrderID = @VoucherID ))
		BEGIN
			DELETE OT3001_Del WHERE DivisionID = @DivisionID AND POrderID = @VoucherID 
		END

		IF(EXISTS(SELECT * FROM OT3002_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND POrderID = @VoucherID ))
		BEGIN
			DELETE OT3002_Del WHERE DivisionID = @DivisionID AND POrderID = @VoucherID 
		END

		IF(EXISTS(SELECT * FROM OT8899_Del WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID ))
		BEGIN
			DELETE OT8899_Del WHERE DivisionID = @DivisionID AND VoucherID = @VoucherID 
		END
		
		INSERT INTO OT3001_Del
				( APK, DivisionID, POrderID, VoucherTypeID, VoucherNo, ClassifyID, InventoryTypeID, CurrencyID, ExchangeRate, OrderType
				, ObjectID, ReceivedAddress, Notes, Description, Disabled, OrderStatus, Ana01ID, Ana02ID, Ana03ID, Ana04ID
				, Ana05ID, TranMonth, TranYear, EmployeeID, OrderDate, Transport, PaymentID, ObjectName, VATNo, Address, ShipDate
				, ContractNo, ContractDate, CreateUserID, Createdate, LastModifyUserID, LastModifyDate, DueDate, RequestID, Varchar01
				, Varchar02, Varchar03, Varchar04, Varchar05, Varchar06, Varchar07, Varchar08, Varchar09, Varchar10, Varchar11, Varchar12
				, Varchar13, Varchar14, Varchar15, Varchar16, Varchar17, Varchar18, Varchar19, Varchar20, PaymentTermID, IsConfirm
				, DescriptionConfirm, DeliveryDate, SOrderID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, PriceListID, IsPrinted
				, KindVoucherID, IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02, PurchaseManID, RelatedToTypeID
				, ReceivingStatus, APKMaster_9000, Status ) 
		SELECT  APK, DivisionID, POrderID, VoucherTypeID, VoucherNo, ClassifyID, InventoryTypeID, CurrencyID, ExchangeRate, OrderType
				, ObjectID, ReceivedAddress, Notes, Description, Disabled, OrderStatus, Ana01ID, Ana02ID, Ana03ID, Ana04ID
				, Ana05ID, TranMonth, TranYear, EmployeeID, OrderDate, Transport, PaymentID, ObjectName, VATNo, Address, ShipDate
				, ContractNo, ContractDate, CreateUserID, Createdate, LastModifyUserID, LastModifyDate, DueDate, RequestID, Varchar01
				, Varchar02, Varchar03, Varchar04, Varchar05, Varchar06, Varchar07, Varchar08, Varchar09, Varchar10, Varchar11, Varchar12
				, Varchar13, Varchar14, Varchar15, Varchar16, Varchar17, Varchar18, Varchar19, Varchar20, PaymentTermID, IsConfirm
				, DescriptionConfirm, DeliveryDate, SOrderID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, PriceListID, ISNULL(IsPrinted,0)
				, KindVoucherID, IsConfirm01, ConfDescription01, IsConfirm02, ConfDescription02, PurchaseManID, RelatedToTypeID
				, ReceivingStatus, APKMaster_9000, Status
		FROM OT3001 WITH (NOLOCK) WHERE DivisionID= @DivisionID AND POrderID = @VoucherID 

		INSERT INTO OT3002_Del
				( APK, DivisionID, TransactionID, POrderID, InventoryID, MethodID, OrderQuantity, OriginalAmount, ConvertedAmount
				, PurchasePrice, VATPercent, VATConvertedAmount, DiscountPercent, DiscountConvertedAmount, IsPicking, Quantity01
				, Quantity02, Quantity03, Quantity04, Quantity05, Quantity06, Quantity07, Quantity08, Quantity09, Quantity10
				, Quantity11, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20
				, Quantity21, Quantity22, Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30
				, WareHouseID, DiscountOriginalAmount, VATOriginalAmount, Orders, Description, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID
				, AdjustQuantity, InventoryCommonName, UnitID, Finish, Notes, Notes01, Notes02, RefTransactionID, ROrderID, ConvertedQuantity
				, ImTaxPercent, ImTaxOriginalAmount, ImTaxConvertedAmount, ConvertedSalePrice, ShipDate, ReceiveDate, Ana06ID, Ana07ID, Ana08ID
				, Ana09ID, Ana10ID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Notes03, Notes04, Notes05, Notes06, Notes07
				, Notes08, Notes09, StrParameter01, StrParameter02, StrParameter03, StrParameter04, StrParameter05, StrParameter06, StrParameter07
				, StrParameter08, StrParameter09, StrParameter10, StrParameter11, StrParameter12, StrParameter13, StrParameter14, StrParameter15
				, StrParameter16, StrParameter17, StrParameter18, StrParameter19, StrParameter20, nvarchar01, nvarchar02, nvarchar03, nvarchar04
				, nvarchar05, nvarchar06, nvarchar07, nvarchar08, nvarchar09, nvarchar10, nvarchar11, nvarchar12, nvarchar13, nvarchar14
				, nvarchar15, nvarchar16, nvarchar17, nvarchar18, nvarchar19, nvarchar20, InheritTableID, InheritVoucherID, InheritTransactionID
				, Specification, ApproveLevel, ApprovingLevel, APKMaster_9000, Status ) 
		SELECT APK, DivisionID, TransactionID, POrderID, InventoryID, MethodID, OrderQuantity, OriginalAmount, ConvertedAmount
				, PurchasePrice, VATPercent, VATConvertedAmount, DiscountPercent, DiscountConvertedAmount, IsPicking, Quantity01
				, Quantity02, Quantity03, Quantity04, Quantity05, Quantity06, Quantity07, Quantity08, Quantity09, Quantity10
				, Quantity11, Quantity12, Quantity13, Quantity14, Quantity15, Quantity16, Quantity17, Quantity18, Quantity19, Quantity20
				, Quantity21, Quantity22, Quantity23, Quantity24, Quantity25, Quantity26, Quantity27, Quantity28, Quantity29, Quantity30
				, WareHouseID, DiscountOriginalAmount, VATOriginalAmount, Orders, Description, Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID
				, AdjustQuantity, InventoryCommonName, UnitID, Finish, Notes, Notes01, Notes02, RefTransactionID, ROrderID, ConvertedQuantity
				, ImTaxPercent, ImTaxOriginalAmount, ImTaxConvertedAmount, ConvertedSalePrice, ShipDate, ReceiveDate, Ana06ID, Ana07ID, Ana08ID
				, Ana09ID, Ana10ID, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05, Notes03, Notes04, Notes05, Notes06, Notes07
				, Notes08, Notes09, StrParameter01, StrParameter02, StrParameter03, StrParameter04, StrParameter05, StrParameter06, StrParameter07
				, StrParameter08, StrParameter09, StrParameter10, StrParameter11, StrParameter12, StrParameter13, StrParameter14, StrParameter15
				, StrParameter16, StrParameter17, StrParameter18, StrParameter19, StrParameter20, nvarchar01, nvarchar02, nvarchar03, nvarchar04
				, nvarchar05, nvarchar06, nvarchar07, nvarchar08, nvarchar09, nvarchar10, nvarchar11, nvarchar12, nvarchar13, nvarchar14
				, nvarchar15, nvarchar16, nvarchar17, nvarchar18, nvarchar19, nvarchar20, InheritTableID, InheritVoucherID, InheritTransactionID
				, Specification, ApproveLevel, ApprovingLevel, APKMaster_9000, Status
		FROM OT3002   WITH (NOLOCK) WHERE DivisionID= @DivisionID AND POrderID = @VoucherID 
		
		INSERT INTO OT8899_Del
					( DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID
					, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID
					, S19ID, S20ID, SUnitPrice01, SUnitPrice02, SUnitPrice03, SUnitPrice04, SUnitPrice05, SUnitPrice06
					, SUnitPrice07, SUnitPrice08, SUnitPrice09, SUnitPrice10, SUnitPrice11, SUnitPrice12, SUnitPrice13
					, SUnitPrice14, SUnitPrice15, SUnitPrice16, SUnitPrice17, SUnitPrice18, SUnitPrice19, SUnitPrice20
					, UnitPriceStandard ) 
		SELECT DivisionID, VoucherID, TransactionID, TableID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID
					, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID
					, S19ID, S20ID, SUnitPrice01, SUnitPrice02, SUnitPrice03, SUnitPrice04, SUnitPrice05, SUnitPrice06
					, SUnitPrice07, SUnitPrice08, SUnitPrice09, SUnitPrice10, SUnitPrice11, SUnitPrice12, SUnitPrice13
					, SUnitPrice14, SUnitPrice15, SUnitPrice16, SUnitPrice17, SUnitPrice18, SUnitPrice19, SUnitPrice20
					, UnitPriceStandard 
		FROM OT8899  WITH (NOLOCK) WHERE DivisionID= @DivisionID AND VoucherID = @VoucherID 

END 		

		



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

