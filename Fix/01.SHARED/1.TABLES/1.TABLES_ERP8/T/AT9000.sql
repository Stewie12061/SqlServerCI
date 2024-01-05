-- <Summary>
---- 
-- <History>
---- Create on 24/10/2010 by Huỳnh Tấn Phú
---- Modified on 17/02/2012 by Nguyễn Bình Minh
---- Modified on 20/06/2013 by Luu Khanh Van: Them vao TBatchID
---- Modified on 01/10/2014 by Lê Thị Hạnh: Thêm 10 trường tham số trên lưới (theo dõi chiết khấu) [Customize Index: 36 - Sài Gòn Petro]
---- Modified on 27/10/2014 by Quốc Tuấn: bổ sung thêm 3 cột để kế thừa
---- Modified on 20/03/2015 by Lê Thị Hạnh: Bổ sung ETaxVoucherID, ETaxID, ETaxConvertedUnit, ETaxConvertedAmount
---- Modified on 01/01/2014 by Huỳnh Tấn Phú
---- Modified on 23/01/2014 by Thanh Sơn
---- Modified on 15/04/2014 by Luu Khanh Van
---- Modified on 09/03/2012 by Việt Khánh
---- Modified on 04/11/2013 by Bảo Anh
---- Modified on 13/09/2012 by Huỳnh Tấn Phú
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 17/08/2015 by Trần Quốc Tuấn: Bo sung Thêm 2 cột CreditObjectNane, CreditVATNo
---- Modified on 9/11/2015 by Phương Thảo: Bổ sung thêm trường tỷ giá tính thuế nhà thầu (TaxBaseAmount)
---- Modified on 11/11/2015 by Phương Thảo: Bổ sung thêm trường để phân biệt bút toán chi phí hình thành TSCĐ (IsFACost)
---- Modified on 16/11/2015 by Phương Thảo: Bổ sung thêm trường để tập hợp TSCĐ 
---- Modified on 14/01/2016 by Phương Thảo: Bổ sung thêm 2 trường tỷ giá, check nhiều tỷ giá, ngày lấy tỷ giá
---- Modified on 18/01/2016 by Tieu Mai: Bo sung truong DiscountPercentSOrder, DiscountAmountSOrder
---- Modified on 01/02/2016 by Phương Thảo: Bo sung truong IsWithhodingTax
---- Modified on 17/02/2016 by Hoàng Vũ: Bo sung truong IsSaleInvoice (Lưu vết check vào Hóa Đơn bán hàng theo bộ) --> CustomizeIndex = 51 Hoàng trần
---- Modifeid on 18/05/2016 by Tieu Mai: Bo sung truong DiscountSaleAmountDetail (Chiết khấu doanh số lưới - CustomizeIndex = 57 ANGEL)
---- Modified on 18/08/2016 by Hải Long: Bổ sung các trường cho ABA
---- Modified on 09/12/2016 by Hải Long: Bổ sung các 5 trường mã phân tích nhân viên cho ANGEL
---- Modified on 22/12/2017 by Hoàng Vũ: Bổ sung các trường IsInvoiceSuggest 
---- Modified on 29/01/2018 by Hoàng Vũ: Bổ sung các trường RefVoucherDate, RefVoucherNo: lưu ngày đơn hàng và số đơn hàng Metro (Customize = [OKIA])
---- Modified on 20/08/2018 by Kim Thư: Bổ sung cột ObjectName1 lưu tên khách vãng lai
---- Modified on 07/11/2018 by Kim Thư: Bổ sung cột InvoiceGuid lấy mã từ BKAV trả về khi phát hành hóa đơn
---- Modified on 09/11/2018 by Kim Thư: Bổ sung cột DiscountedUnitPrice và ConvertedDiscountedUnitPrice tính đơn giá sau khi đã chiết khấu
---- Modified on 22/11/2019 by Văn Tài: Bổ sung cột BranchID cho trường hợp BKAV dùng nhiều chữ ký số
---- Modified on 13/02/2020 by Huỳnh Thử: Mở rộng ký tự InventoryName1
---- Modified on 13/02/2020 by Huỳnh Thử: Mở rộng ký tự VDescription, BDescription, TDescription
---- Modified on 30/12/2020 by Đức Thông: [KRUGER] 2020/12/IS/0255: Mở rộng kí tự cho param 1 và 10 lên 500
---- Modified on 13/11/2021 by Đình hòa: Merger cột từ fix dự án sang STD
---- Modified on 15/12/2021 by Nhựt Trường: Angel - Điều chỉnh độ dài chuỗi DParameter02 từ 250 lên 500.
---- Modified on 12/04/2022 by Xuân Nguyên: Bổ sung cột ExInvoiceNo
---- Modified on 03/11/2022 by Thanh Lượng:[2022/10/TA/0124] Bổ sung cột BankAccountID tạo combobox số TK ngân hàng (Customize = [THIENNAM])
---- Modified on 29/11/2022 by Thành Sang  Bổ sung cột IsPriceAfterVAT, PriceBeforeVAT cho khách hàng VIMEC
---- Modified on 22/12/2023 by Hương Nhung Bổ sung cột AddressE cho khách hàng PANGLOBE
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT9000]') AND type in (N'U'))
CREATE TABLE [dbo].[AT9000](
	[APK] [uniqueidentifier] NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[BatchID] [nvarchar](50) NOT NULL DEFAULT ('AT9000'),
	[TransactionID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[TransactionTypeID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[CreditObjectID] [nvarchar](50) NULL,
	[VATNo] [nvarchar](50) NULL,
	[VATObjectID] [nvarchar](50) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[VATObjectAddress] [nvarchar](250) NULL,
	[DebitAccountID] [nvarchar](50) NULL,
	[CreditAccountID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[UnitPrice] [decimal](28, 8) NULL,
	[OriginalAmount] [decimal](28, 8) NULL,
	[ConvertedAmount] [decimal](28, 8) NULL,
	[ImTaxOriginalAmount] [decimal](28, 8) NULL,
	[ImTaxConvertedAmount] [decimal](28, 8) NULL,
	[ExpenseOriginalAmount] [decimal](28, 8) NULL,
	[ExpenseConvertedAmount] [decimal](28, 8) NULL,
	[IsStock] [tinyint] NOT NULL DEFAULT ((0)),
	[VoucherDate] [datetime] NULL,
	[InvoiceDate] [datetime] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VATTypeID] [nvarchar](50) NULL,
	[VATGroupID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[Serial] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[Orders] [int] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[SenderReceiver] [nvarchar](250) NULL,
	[SRDivisionName] [nvarchar](250) NULL,
	[SRAddress] [nvarchar](250) NULL,
	[RefNo01] [nvarchar](100) NULL,
	[RefNo02] [nvarchar](100) NULL,
	[VDescription] [nvarchar](250) NULL,
	[BDescription] [nvarchar](250) NULL,
	[TDescription] [nvarchar](250) NULL,
	[Quantity] [decimal](28, 8) NULL,[InventoryID] [nvarchar](50) NULL,
	[UnitID] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NOT NULL DEFAULT ((0)),
	[IsAudit] [tinyint] NOT NULL DEFAULT ((0)),
	[IsCost] [tinyint] NOT NULL DEFAULT ((0)),
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[PeriodID] [nvarchar](50) NULL,
	[ExpenseID] [nvarchar](50) NULL,
	[MaterialTypeID] [nvarchar](50) NULL,
	[ProductID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[OriginalAmountCN] [decimal](28, 8) NULL,
	[ExchangeRateCN] [decimal](28, 8) NULL,
	[CurrencyIDCN] [nvarchar](50) NULL,
	[DueDays] [int] NULL,
	[PaymentID] [nvarchar](50) NULL,
	[DueDate] [datetime] NULL,
	[DiscountRate] [decimal](28, 8) NULL,
	[OrderID] [nvarchar](50) NULL,
	[CreditBankAccountID] [nvarchar](50) NULL,
	[DebitBankAccountID] [nvarchar](50) NULL,
	[CommissionPercent] [decimal](28, 8) NULL,
	[InventoryName1] [nvarchar](250) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[DiscountAmount] [decimal](28, 8) NULL,
	[OTransactionID] [nvarchar](50) NULL,
	[IsMultiTax] [tinyint] NULL,
	[VATOriginalAmount] [decimal](28, 8) NULL,
	[VATConvertedAmount] [decimal](28, 8) NULL,
	[ReVoucherID] [nvarchar](50) NULL,
	[ReBatchID] [nvarchar](50) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[Parameter01] [varchar](500) NULL,
	[Parameter02] [varchar](250) NULL,
	[Parameter03] [varchar](250) NULL,
	[Parameter04] [varchar](250) NULL,
	[Parameter05] [varchar](250) NULL,
	[Parameter06] [varchar](250) NULL,
	[Parameter07] [varchar](250) NULL,
	[Parameter08] [varchar](250) NULL,
	[Parameter09] [varchar](250) NULL,
	[Parameter10] [varchar](500) NULL,
 CONSTRAINT [PK_AT9000] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[TransactionID] ASC,
	[TableID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ConvertedQuantity')
		ALTER TABLE AT9000 ADD ConvertedQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ConvertedPrice')
		ALTER TABLE AT9000 ADD ConvertedPrice DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ConvertedUnitID')
		ALTER TABLE AT9000 ADD ConvertedUnitID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ConversionFactor')
		ALTER TABLE AT9000 ADD ConversionFactor DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='UParameter01')
		ALTER TABLE AT9000 ADD UParameter01 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='UParameter02')
		ALTER TABLE AT9000 ADD UParameter02 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='UParameter03')
		ALTER TABLE AT9000 ADD UParameter03 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='UParameter04')
		ALTER TABLE AT9000 ADD UParameter04 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='UParameter05')
		ALTER TABLE AT9000 ADD UParameter05 DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='IsLateInvoice')
		ALTER TABLE AT9000 ADD IsLateInvoice TINYINT DEFAULT(0) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='MOrderID')
		ALTER TABLE AT9000 ADD MOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SOrderID')
		ALTER TABLE AT9000 ADD SOrderID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='MTransactionID')
		ALTER TABLE AT9000 ADD MTransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='STransactionID')
		ALTER TABLE AT9000 ADD STransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='RefVoucherNo')
		ALTER TABLE AT9000 ADD RefVoucherNo NVARCHAR(50) NULL
	END
If Exists (Select * From sysobjects Where name = 'AT9000' and xtype ='U') 
Begin 
	If not exists (select * from syscolumns col inner join sysobjects tab 
   On col.id = tab.id where tab.name = 'AT9000' and col.name = 'TBatchID') 
   Alter Table  AT9000 Add TBatchID nvarchar(50) Null 
End 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter01')
		ALTER TABLE AT9000 ADD DParameter01 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter02')
		ALTER TABLE AT9000 ADD DParameter02 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter03')
		ALTER TABLE AT9000 ADD DParameter03 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter04')
		ALTER TABLE AT9000 ADD DParameter04 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter05')
		ALTER TABLE AT9000 ADD DParameter05 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter06')
		ALTER TABLE AT9000 ADD DParameter06 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter07')
		ALTER TABLE AT9000 ADD DParameter07 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter08')
		ALTER TABLE AT9000 ADD DParameter08 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter09')
		ALTER TABLE AT9000 ADD DParameter09 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter10')
		ALTER TABLE AT9000 ADD DParameter10 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='InheritTableID')
		ALTER TABLE AT9000 ADD InheritTableID NVARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='InheritVoucherID')
		ALTER TABLE AT9000 ADD InheritVoucherID VARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='InheritTransactionID')
		ALTER TABLE AT9000 ADD InheritTransactionID VARCHAR(50) NULL
	END
-- Thuế bảo vệ môi trường - hỗ trợ 20/03/2015
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ETaxVoucherID')
		ALTER TABLE AT9000 ADD ETaxVoucherID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ETaxID')
		ALTER TABLE AT9000 ADD ETaxID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ETaxConvertedUnit')
		ALTER TABLE AT9000 ADD ETaxConvertedUnit DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ETaxConvertedAmount')
		ALTER TABLE AT9000 ADD ETaxConvertedAmount DECIMAL(28,8) NULL
	END
---- Modified on 25/03/2015 by Lê Thị Hạnh: Thêm trường ETaxTransactionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ETaxTransactionID')
		ALTER TABLE AT9000 ADD ETaxTransactionID NVARCHAR(50) NULL
	END
---- Modified on 27/05/2015 by Lê Thị Hạnh: Thêm trường thuế tiêu thụ đặc biệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='AssignedSET')
		ALTER TABLE AT9000 ADD AssignedSET TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETID')
		ALTER TABLE AT9000 ADD SETID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETUnitID')
		ALTER TABLE AT9000 ADD SETUnitID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETTaxRate')
		ALTER TABLE AT9000 ADD SETTaxRate DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETConvertedUnit')
		ALTER TABLE AT9000 ADD SETConvertedUnit DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETQuantity')
		ALTER TABLE AT9000 ADD SETQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETOriginalAmount')
		ALTER TABLE AT9000 ADD SETOriginalAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETConvertedAmount')
		ALTER TABLE AT9000 ADD SETConvertedAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETConsistID')
		ALTER TABLE AT9000 ADD SETConsistID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SETTransactionID')
		ALTER TABLE AT9000 ADD SETTransactionID NVARCHAR(50) NULL
	END
---- Modified on 01/06/2015 by Lê Thị Hạnh: Thêm trường thuế tiêu tài nguyên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='AssignedNRT')
		ALTER TABLE AT9000 ADD AssignedNRT TINYINT NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTTaxAmount')
		ALTER TABLE AT9000 ADD NRTTaxAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTClassifyID')
		ALTER TABLE AT9000 ADD NRTClassifyID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTUnitID')
		ALTER TABLE AT9000 ADD NRTUnitID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTTaxRate')
		ALTER TABLE AT9000 ADD NRTTaxRate DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTConvertedUnit')
		ALTER TABLE AT9000 ADD NRTConvertedUnit DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTQuantity')
		ALTER TABLE AT9000 ADD NRTQuantity DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTOriginalAmount')
		ALTER TABLE AT9000 ADD NRTOriginalAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTConvertedAmount')
		ALTER TABLE AT9000 ADD NRTConvertedAmount DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTConsistID')
		ALTER TABLE AT9000 ADD NRTConsistID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='NRTTransactionID')
		ALTER TABLE AT9000 ADD NRTTransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='InvoiceCode')
	ALTER TABLE AT9000 ADD InvoiceCode NVARCHAR (50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='InvoiceSign')
	ALTER TABLE AT9000 ADD InvoiceSign NVARCHAR (50) NULL
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ReTableID')
	ALTER TABLE AT9000 ADD ReTableID NVARCHAR (50) NULL		
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'TVoucherID')
	Alter Table  AT9000 Add TVoucherID NVARCHAR(50) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'OldCounter')
	Alter Table  AT9000 Add OldCounter Decimal(28,8) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'NewCounter')
	Alter Table  AT9000 Add NewCounter Decimal(28,8) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'OtherCounter')
	Alter Table  AT9000 Add OtherCounter Decimal(28,8) NULL	
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'WOrderID')
	Alter Table  AT9000 Add WOrderID NVARCHAR(50) NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'WTransactionID')
	Alter Table  AT9000 Add WTransactionID NVARCHAR(50) NULL	
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'MarkQuantity')
	Alter Table  AT9000 Add MarkQuantity DECIMAL(28,8) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='RefInfor')
	ALTER TABLE AT9000 ADD RefInfor NVARCHAR (250) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='StandardPrice')
	ALTER TABLE AT9000 ADD StandardPrice DECIMAL(28,8) DEFAULT (0) NULL
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='StandardAmount')
	ALTER TABLE AT9000 ADD StandardAmount DECIMAL(28,8) DEFAULT (0) NULL
END
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='IsCom')
	ALTER TABLE AT9000 ADD IsCom tinyint DEFAULT (0) NULL
END
If Exists (Select * From sysobjects Where name = 'AT9000' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'PriceListID')
           Alter Table  AT9000 Add PriceListID nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'AT9000' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'WOrderID')
           Alter Table  AT9000 Add WOrderID NVARCHAR(50) NULL
           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'WTransactionID')
           Alter Table  AT9000 Add WTransactionID NVARCHAR(50) NULL
           
           --- Bổ sung trường nhận biết kế thừa hợp đồng (Sinolife)
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'ContractDetailID')
           Alter Table  AT9000 Add ContractDetailID NVARCHAR(50) NULL
End 
If Exists (Select * From sysobjects Where name = 'AT9000' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'MarkQuantity')
           Alter Table  AT9000 Add MarkQuantity DECIMAL(28,8) NULL
END
If Exists (Select * From sysobjects Where name = 'AT9000' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'AT9000'  and col.name = 'Ana06ID')
Alter Table  AT9000 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
END
--Bố sung thêm cột CreditObjectName,
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='CreditObjectName')
		ALTER TABLE AT9000 ADD CreditObjectName NVARCHAR(500) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='CreditVATNo')
		ALTER TABLE AT9000 ADD CreditVATNo NVARCHAR(500) NULL
	END
---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter01')
		ALTER TABLE AT9000 ALTER COLUMN Parameter01 NVARCHAR(500) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter02')
		ALTER TABLE AT9000 ALTER COLUMN Parameter02 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter03')
		ALTER TABLE AT9000 ALTER COLUMN Parameter03 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter04')
		ALTER TABLE AT9000 ALTER COLUMN Parameter04 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter05')
		ALTER TABLE AT9000 ALTER COLUMN Parameter05 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter06')
		ALTER TABLE AT9000 ALTER COLUMN Parameter06 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter07')
		ALTER TABLE AT9000 ALTER COLUMN Parameter07 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter08')
		ALTER TABLE AT9000 ALTER COLUMN Parameter08 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter09')
		ALTER TABLE AT9000 ALTER COLUMN Parameter09 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='Parameter10')
		ALTER TABLE AT9000 ALTER COLUMN Parameter10 NVARCHAR(500) NULL 
	END
 IF((ISNULL(COL_LENGTH('AT9000', 'OrderID'), 0)/2)<=50)
 ALTER TABLE AT9000 ALTER COLUMN OrderID NVARCHAR(500)

 IF((ISNULL(COL_LENGTH('AT9000', 'InheritTransactionID'), 0)/2)<=50)
 ALTER TABLE AT9000 ALTER COLUMN InheritTransactionID NVARCHAR(2000)

--- Thêm check chi phí mua hàng IsPOCost[LAVO]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='IsPOCost')
		ALTER TABLE AT9000 ADD IsPOCost TINYINT NULL
	END

--- Them truong tri gia tinh thue nha thau
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'TaxBaseAmount')
        ALTER TABLE AT9000 ADD TaxBaseAmount DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'WTCExchangeRate')
        ALTER TABLE AT9000 ADD WTCExchangeRate DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'WTCOperator')
        ALTER TABLE AT9000 ADD WTCOperator TINYINT NULL
    END

--- But toan chi phi hinh thanh TSCD
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsFACost')
        ALTER TABLE AT9000 ADD IsFACost TINYINT NULL
    END

--- Phieu tap hop TSCĐ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsInheritFA')
        ALTER TABLE AT9000 ADD IsInheritFA TINYINT NULL
    END

--- Khoa cua phieu tap hop TSCD, luu vao cac but toan hinh thanh
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'InheritedFAVoucherID')
        ALTER TABLE AT9000 ADD InheritedFAVoucherID NVARCHAR(50) NULL
    END

--- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'AVRExchangeRate')
        ALTER TABLE AT9000 ADD AVRExchangeRate DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'PaymentExchangeRate')
    ALTER TABLE AT9000 ADD PaymentExchangeRate DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsMultiExR')
        ALTER TABLE AT9000 ADD IsMultiExR TINYINT NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ExchangeRateDate')
        ALTER TABLE AT9000 ADD ExchangeRateDate DATETIME NULL
    END

--- Modify on 11/01/2016 by Bảo Anh: Bổ sung các trường cho Angel
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
		--- Số tiền được hưởng chiết khấu doanh số
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'DiscountSalesAmount')
        ALTER TABLE AT9000 ADD DiscountSalesAmount Decimal(28,8) NULL
		--- Check là hàng khuyến mãi
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsProInventoryID')
        ALTER TABLE AT9000 ADD IsProInventoryID tinyint NULL
		--- Số lượng yêu cầu
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'InheritQuantity')
        ALTER TABLE AT9000 ADD InheritQuantity Decimal(28,8) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'DiscountPercentSOrder')
        ALTER TABLE AT9000 ADD DiscountPercentSOrder Decimal(28,8) NULL, DiscountAmountSOrder Decimal(28,8) NULL
    END	    

---- Modify by Phương Thảo on 01/02/2016
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsWithhodingTax')
        ALTER TABLE AT9000 ADD IsWithhodingTax TINYINT NULL
    END
---- Modify by Hoàng Vũ on 17/02/2016: CuatomizeIndex = 51 (Hoàng Trần)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsSaleInvoice')
        ALTER TABLE AT9000 ADD IsSaleInvoice TINYINT NULL
    END	
---------------------------Sửa kiểu dữ liệu Decimal -> datetime--> Databsae hoàng trần lỗi
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ExchangeRateDate')
	Alter Table AT9000
		Alter column ExchangeRateDate DateTime NULL
END	
---- Modify by Quốc tuấn thêm 2 cột đủ bảng nâng cáp từ bảng thấp lên thiếu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'VirtualPrice')
        ALTER TABLE AT9000 ADD VirtualPrice Decimal(28,8) NULL
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'VirtualAmount')
        ALTER TABLE AT9000 ADD VirtualAmount Decimal(28,8) NULL
    END	    

--- Bổ sung trường xử lý thuế nhà thầu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'WTTransID')
        ALTER TABLE AT9000 ADD WTTransID NVARCHAR(50) NULL
    END
    
--- Bổ sung trường cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'DiscountSaleAmountDetail')
        ALTER TABLE AT9000 ADD DiscountSaleAmountDetail DECIMAL(28,8) NULL
    END

---- Modified by Hải Long on 18/08/2016: Bổ sung các trường cho ABA
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter01')
		ALTER TABLE AT9000 ADD ABParameter01 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter02')
		ALTER TABLE AT9000 ADD ABParameter02 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter03')
		ALTER TABLE AT9000 ADD ABParameter03 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter04')
		ALTER TABLE AT9000 ADD ABParameter04 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter05')
		ALTER TABLE AT9000 ADD ABParameter05 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter06')
		ALTER TABLE AT9000 ADD ABParameter06 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter07')
		ALTER TABLE AT9000 ADD ABParameter07 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter08')
		ALTER TABLE AT9000 ADD ABParameter08 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter09')
		ALTER TABLE AT9000 ADD ABParameter09 NVARCHAR(100) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='ABParameter10')
		ALTER TABLE AT9000 ADD ABParameter10 NVARCHAR(100) NULL
	END
	
---- Modified by Hải Long on 09/12/2016: Bổ sung các 5 trường mã phân tích nhân viên cho ANGEL
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SOAna01ID')
		ALTER TABLE AT9000 ADD SOAna01ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SOAna02ID')
		ALTER TABLE AT9000 ADD SOAna02ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SOAna03ID')
		ALTER TABLE AT9000 ADD SOAna03ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SOAna04ID')
		ALTER TABLE AT9000 ADD SOAna04ID NVARCHAR(50) NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='SOAna05ID')
		ALTER TABLE AT9000 ADD SOAna05ID NVARCHAR(50) NULL
	END	
	
--- Modified by Hải Long on 09/06/2017: Bổ sung trường IsVATWithhodingTax đánh dấu dòng nào là dòng thuế GTGT (thuế nhà thầu), VATWithhodingRate giá trị nhóm thuế 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsVATWithhodingTax')
        ALTER TABLE AT9000 ADD IsVATWithhodingTax TINYINT NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'VATWithhodingRate')
        ALTER TABLE AT9000 ADD VATWithhodingRate DECIMAL(28,8) NULL        
    END	

--- Modified by Hải Long on 16/08/2017: Bổ sung trường các trường của hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsEInvoice')
        ALTER TABLE AT9000 ADD IsEInvoice TINYINT DEFAULT(0) NULL
         IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'EIsInvoice')
        ALTER TABLE AT9000 ADD EIsInvoice TINYINT DEFAULT(0) NULL
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'EInvoiceStatus')
        ALTER TABLE AT9000 ADD EInvoiceStatus TINYINT DEFAULT(0) NULL            
    END	  
    
--- Modified by Hải Long on 08/09/2017: Bổ sung trường IsAdvancePayment cho Bê Tông Long An
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsAdvancePayment')
        ALTER TABLE AT9000 ADD IsAdvancePayment TINYINT NULL            
    END	
    
--- Modified by Hải Long on 12/10/2017: Bổ sung trường fkey hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'Fkey')
        ALTER TABLE AT9000 ADD Fkey NVARCHAR(50) NULL            
    END	 
    
--- Modified by Hải Long on 19/10/2017: Bổ sung trường InheritFkey (lưu vết hóa đơn cần điều chỉnh, thay thế), trường EInvoiceType, TypeOfAdjust
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'InheritFkey')
        ALTER TABLE AT9000 ADD InheritFkey NVARCHAR(50) NULL            
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'EInvoiceType')
        ALTER TABLE AT9000 ADD EInvoiceType TINYINT DEFAULT(0) NULL        
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'TypeOfAdjust')
        ALTER TABLE AT9000 ADD TypeOfAdjust TINYINT NULL           
    END	
	
--- Modified by Thị Phượng on 11/12/2017: Bổ sung trường Kế thừa phiếu bán hàng POS và kế thừa phiếu đề nghị chi POS
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsInheritInvoicePOS') 
   ALTER TABLE AT9000 ADD IsInheritInvoicePOS TINYINT NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'InheritInvoicePOS') 
   ALTER TABLE AT9000 ADD InheritInvoicePOS VARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsInheritPayPOS') 
   ALTER TABLE AT9000 ADD IsInheritPayPOS TINYINT NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'InheritPayPOS') 
   ALTER TABLE AT9000 ADD InheritPayPOS VARCHAR(50) NULL 
END     

--Đề nghị xuất hóa đơn (POS)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsInvoiceSuggest') 
   ALTER TABLE AT9000 ADD IsInvoiceSuggest TINYINT NULL 
END
/*===============================================END IsInvoiceSuggest===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'RefVoucherNo') 
   ALTER TABLE AT9000 ADD RefVoucherNo VARCHAR(50) NULL 
END

/*===============================================END RefVoucherNo===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'RefVoucherDate') 
   ALTER TABLE AT9000 ADD RefVoucherDate DATETIME NULL 
END

/*===============================================END RefVoucherDate===============================================*/


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsDeposit') 
   ALTER TABLE AT9000 ADD IsDeposit TINYINT NULL 
END

/*===============================================END IsDeposit===============================================*/ 
--- Modified by Thị Phượng on 11/03/2018: Bổ sung trường lưu vết kế thừa loại chứng từ (Loại bút toán kế thừa)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ReTransactionTypeID') 
   ALTER TABLE AT9000 ADD ReTransactionTypeID VARCHAR(50) NULL 
END

---- Modified on 21/03/2018 by Bảo Anh: Bổ sung cột Chứng từ nhập, Lô nhập, Hạn sử dụng, IsPromotionItem
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ImVoucherID') 
   ALTER TABLE AT9000 ADD ImVoucherID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ImTransactionID') 
   ALTER TABLE AT9000 ADD ImTransactionID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'SourceNo') 
   ALTER TABLE AT9000 ADD SourceNo NVARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'LimitDate') 
   ALTER TABLE AT9000 ADD LimitDate DATETIME NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsPromotionItem') 
   ALTER TABLE AT9000 ADD IsPromotionItem TINYINT NULL DEFAULT(0)

END

----Modified on 20/08/2018 by Kim Thư: Bổ sung cột ObjectName1 lưu tên khách vãng lai----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ObjectName1') 
	ALTER TABLE AT9000 ADD ObjectName1 NVARCHAR(250) NULL
END

---- Modified on 07/11/2018 by Kim Thư: Bổ sung cột InvoiceGuid lấy mã từ BKAV trả về khi phát hành hóa đơn----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'InvoiceGuid') 
	ALTER TABLE AT9000 ADD InvoiceGuid VARCHAR(MAX) NULL
END

---- Modified on 09/11/2018 by Kim Thư: Bổ sung cột DiscountedUnitPrice và ConvertedDiscountedUnitPrice tính đơn giá sau khi đã chiết khấu----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'DiscountedUnitPrice') 
	ALTER TABLE AT9000 ADD DiscountedUnitPrice DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ConvertedDiscountedUnitPrice') 
	ALTER TABLE AT9000 ADD ConvertedDiscountedUnitPrice DECIMAL(28,8) NULL

END

----Modified on 13/11/2018 by Kim Thư: Bổ sung cột IsReceived----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsReceived') 
	ALTER TABLE AT9000 ADD IsReceived TINYINT NULL
END

----Modified on 14/11/2019 by Van Minh: Bổ sung cột IsAutoGen----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='IsAutoGen')
		ALTER TABLE AT9000 ADD IsAutoGen TINYINT NULL 
	END

----Modified on 22/11/2019 by Văn Tài: Bổ sung cột BranchID----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='BranchID')
		ALTER TABLE AT9000 ADD BranchID NVARCHAR(50) 
	END

--Huỳnh Thử Date 13/02/2020 Mở rộng ký tự InventoryName1
ALTER TABLE dbo.AT9000 ALTER COLUMN InventoryName1 NVARCHAR(500) NULL;

--Huỳnh Thử Date 11/06/2020 Mở rộng ký tự VDescription
ALTER TABLE dbo.AT9000 ALTER COLUMN VDescription NVARCHAR(500) NULL;

--Huỳnh Thử Date 11/06/2020 Mở rộng ký tự BDescription
ALTER TABLE dbo.AT9000 ALTER COLUMN BDescription NVARCHAR(500) NULL;

--Huỳnh Thử Date 11/06/2020 Mở rộng ký tự TDescription
ALTER TABLE dbo.AT9000 ALTER COLUMN TDescription NVARCHAR(500) NULL;

----Modified on 22/10/2020 by Trọng Kiên: Bổ sung cột PlanID----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='PlanID')
		ALTER TABLE AT9000 ADD PlanID VARCHAR(50) 
	END

--- Đình Hòa [13/01/2021]: Merger cột từ fix dự án sang STD
--- Modified  on 01/12/2018: Bổ sung trường IsInheritContract
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsInheritContract') 
   ALTER TABLE AT9000 ADD IsInheritContract TINYINT NULL DEFAULT(0)
END

---- Modified on 17/12/2018 by Như Hàn: Bổ sung cột VoucherOrder, PlanID lập phiếu chi từ kế hoạch nhận hàng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'VoucherOrder') 
	ALTER TABLE AT9000 ADD VoucherOrder VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'PlanID') 
	ALTER TABLE AT9000 ADD PlanID VARCHAR(50) NULL
END

--- Modified  on 10/7/2019 by Hồng Thảo: Chuyển đổi kiểu dữ liệu cột diễn giải vì lưu không đủ dữ liệu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'VDescription') 
   ALTER TABLE AT9000 
   ALTER COLUMN VDescription NVARCHAR(MAX) NULL
END

---- Modified on 01/08/2019 by Như Hàn: Bổ sung cột 20 cột quy cách của sản phẩm
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'PS01ID')
        ALTER TABLE AT9000 ADD	PS01ID NVARCHAR(50) NULL,
								PS02ID NVARCHAR(50) NULL,
								PS03ID NVARCHAR(50) NULL,
								PS04ID NVARCHAR(50) NULL,
								PS05ID NVARCHAR(50) NULL,
								PS06ID NVARCHAR(50) NULL,
								PS07ID NVARCHAR(50) NULL,
								PS08ID NVARCHAR(50) NULL,
								PS09ID NVARCHAR(50) NULL,
								PS10ID NVARCHAR(50) NULL,
								PS11ID NVARCHAR(50) NULL,
								PS12ID NVARCHAR(50) NULL,
								PS13ID NVARCHAR(50) NULL,
								PS14ID NVARCHAR(50) NULL,
								PS15ID NVARCHAR(50) NULL,
								PS16ID NVARCHAR(50) NULL,
								PS17ID NVARCHAR(50) NULL,
								PS18ID NVARCHAR(50) NULL,
								PS19ID NVARCHAR(50) NULL,
								PS20ID NVARCHAR(50) NULL
    END
---- Modified on 12/12/2019 by Tuấn Anh: Bổ sung cột ReVoucherID3386, IsAuto3386: Bút toán tổng hợp => Tự động tạo phiếu bút toán cấn trừ 3386 cho khách hàng BLUESKY
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ReVoucherID3386') 
	ALTER TABLE AT9000 ADD ReVoucherID3386 VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsAuto3386') 
	ALTER TABLE AT9000 ADD IsAuto3386 bit NULL
END

-- Modified on 20/04/2020 by Huỳnh Thử: Mở rộng cột TDescription, BDescription cho khách hàng CBD
DECLARE	@CustomerName INT
SET @CustomerName = (SELECT TOP 1 CustomerName FROM dbo.CustomerIndex) 	
IF @CustomerName = 103
BEGIN
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'BDescription') 
	ALTER TABLE AT9000 ALTER COLUMN BDescription NVARCHAR(MAX) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'TDescription') 
	ALTER TABLE AT9000 ALTER COLUMN TDescription NVARCHAR(MAX) NULL
END
END 

---- Modified on 23/04/2020 by Lê Hoàng: Bổ sung cột nhóm thuế nhập khẩu cho khách hàng Tân Hòa Lợi để tính chi phí nhập khẩu
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ImTaxConvertedGroupID') 
	ALTER TABLE AT9000 ADD ImTaxConvertedGroupID NVARCHAR(50) NULL
END
--- Modified by Hải Long on 08/09/2017: Bổ sung trường IsAdvancePayment cho Bê Tông Long An
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsAdvancePayment')
        ALTER TABLE AT9000 ADD IsAdvancePayment TINYINT NULL    
		        
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'DVoucherID')
        ALTER TABLE AT9000 ADD DVoucherID NVARCHAR(50) NULL          

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'DTransactionID')
        ALTER TABLE AT9000 ADD DTransactionID NVARCHAR(50) NULL          
    END	    

--- Modified by Nhựt Trường on 15/12/2021: Angel - Điều chỉnh độ dài chuỗi DParameter02 từ 250 lên 500
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DParameter02')
		ALTER TABLE AT9000 ALTER COLUMN DParameter02 NVARCHAR(500) NULL
	END
---- Modified on 15/03/2022 by Xuân Nguyên: Bổ sung cột lý do hủy
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'CancelReason') 
ALTER TABLE AT9000 ADD CancelReason NVARCHAR(250) NULL

---- Modified on 08/04/2022 by Xuân Nguyên: Bổ sung cột lý do hủy
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'ExInvoiceNo') 
ALTER TABLE AT9000 ADD ExInvoiceNo NVARCHAR(250) NULL

---- Modified on 01/06/2022 by Kiều Nga: Điều chỉnh độ dài cột RefNo02
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='RefNo02')
	ALTER TABLE AT9000 ALTER COLUMN RefNo02 NVARCHAR(250) NULL 
END

---- Modified on 03/11/2022 by Thanh Lượng: Bổ sung cột BankAccountID Customize bổ sung cột TK ngân hàng cho khách hàng THIENNAM
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='BankAccountID')
		ALTER TABLE AT9000 ADD BankAccountID NVARCHAR(250) NULL 
	END

---- Modified on 11/11/2022 by Thành Sang: Bổ sung cột IsPriceAfterVAT, PriceBeforeVAT cho khách hàng VIMEC
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9000' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'IsPriceAfterVAT')
		ALTER TABLE AT9000 ADD IsPriceAfterVAT TINYINT NULL
		        
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT9000' AND col.name = 'PriceBeforeVAT')
		ALTER TABLE AT9000 ADD PriceBeforeVAT DECIMAL(28,8) NULL
    END	    

---- Modified on 23/02/2023 by Kiều Nga: Bổ sung cột DepartmentID (MEKIO)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='DepartmentID')
	ALTER TABLE AT9000 ADD DepartmentID NVARCHAR(50) NULL 
END

---- Modified on 22/12/2023 by Hương Nhung Bổ sung cột AddressE cho khách hàng PANGLOBE
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT9000' AND col.name='AddressE')
	ALTER TABLE AT9000 ADD AddressE NVARCHAR(50) NULL 
END