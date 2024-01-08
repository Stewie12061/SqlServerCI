-- <Summary>
---- 
-- <History>
---- Create on 06/06/2014 by Thanh Sơn
---- Modified on 09/06/2014 by Lê Thị Thu Hiền
---- Modified on 22/02/2016 by Tiểu Mai: Bổ sung InheritTableID, InheritVoucherID, InheritTransactionID
---- Modify on 14/03/2016 by Bảo Anh: Bổ sung trường InheritApportionID
---- Modified on 14/08/2020 by Huỳnh Thử -- Merge Code: MEKIO và MTE
---- Modified on 24/03/2022 by Nhựt Trường -- Tăng độ rộng cho cột 'Lô nhập'.
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0096]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[WT0096]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TransactionID] VARCHAR(50) NOT NULL,
      [VoucherID] VARCHAR(50) NULL,
      [BatchID] VARCHAR(50) NULL,
      [InventoryID] VARCHAR(50) NULL,
      [UnitID] VARCHAR(50) NULL,
      [ActualQuantity] DECIMAL(28,8) DEFAULT (0) NULL,
      [UnitPrice] DECIMAL(28,8) DEFAULT (0) NULL,
      [OriginalAmount] DECIMAL(28,8) DEFAULT (0) NULL,
      [ConvertedAmount] DECIMAL(28,8) DEFAULT (0) NULL,
      [Notes] NVARCHAR(250) NULL,
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,
      [CurrencyID] VARCHAR(50) NULL,
      [ExchangeRate] DECIMAL(28,8) DEFAULT (0) NULL,
      [SaleUnitPrice] DECIMAL(28,8) DEFAULT (0) NULL,
      [SaleAmount] DECIMAL(28,8) DEFAULT (0) NULL,
      [DiscountAmount] DECIMAL(28,8) DEFAULT (0) NULL,
      [SourceNo] NVARCHAR(50) NULL,
      [DebitAccountID] NVARCHAR(50) NULL,
      [CreditAccountID] NVARCHAR(50) NULL,
      [LocationID] VARCHAR(50) NULL,
      [ImLocationID] VARCHAR(50) NULL,
      [LimitDate] DATETIME NULL,
      [Orders] INT NULL,
      [ConversionFactor] DECIMAL(28,8) DEFAULT (0) NULL,
      [ReTransactionID] VARCHAR(50) NULL,
      [ReVoucherID] VARCHAR(50) NULL,
      [Ana01ID] VARCHAR(50) NULL,
      [Ana02ID] VARCHAR(50) NULL,
      [Ana03ID] VARCHAR(50) NULL,
      [PeriodID] VARCHAR(50) NULL,
      [ProductID] VARCHAR(50) NULL,
      [OrderID] VARCHAR(50) NULL,
      [InventoryName1] NVARCHAR(250) NULL,
      [Ana04ID] VARCHAR(50) NULL,
      [Ana05ID] VARCHAR(50) NULL,
      [OTransactionID] VARCHAR(50) NULL,
      [ReSPVoucherID] VARCHAR(50) NULL,
      [ReSPTransactionID] VARCHAR(50) NULL,
      [ETransactionID] VARCHAR(50) NULL,
      [MTransactionID] VARCHAR(50) NULL,
      [Parameter01] DECIMAL(28,8) DEFAULT (0) NULL,
      [Parameter02] DECIMAL(28,8) DEFAULT (0) NULL,
      [Parameter03] DECIMAL(28,8) DEFAULT (0) NULL,
      [Parameter04] DECIMAL(28,8) DEFAULT (0) NULL,
      [Parameter05] DECIMAL(28,8) DEFAULT (0) NULL,
      [ConvertedQuantity] DECIMAL(28,8) DEFAULT (0) NULL,
      [ConvertedPrice] DECIMAL(28,8) DEFAULT (0) NULL,
      [ConvertedUnitID] VARCHAR(50) NULL,
      [MOrderID] VARCHAR(50) NULL,
      [SOrderID] VARCHAR(50) NULL,
      [STransactionID] VARCHAR(50) NULL,
      [Ana06ID] VARCHAR(50) NULL,
      [Ana07ID] VARCHAR(50) NULL,
      [Ana08ID] VARCHAR(50) NULL,
      [Ana09ID] VARCHAR(50) NULL,
      [Ana10ID] VARCHAR(50) NULL,
      [LocationCode] NVARCHAR(50) NULL,
      [Location01ID] VARCHAR(50) NULL,
      [Location02ID] VARCHAR(50) NULL,
      [Location03ID] VARCHAR(50) NULL,
      [Location04ID] VARCHAR(50) NULL,
      [Location05ID] VARCHAR(50) NULL,
      [WVoucherID] VARCHAR(50) NULL,
      [Notes01] NVARCHAR(250) NULL,
      [Notes02] NVARCHAR(250) NULL,
      [Notes03] NVARCHAR(250) NULL,
      [Notes04] NVARCHAR(250) NULL,
      [Notes05] NVARCHAR(250) NULL,
      [Notes06] NVARCHAR(250) NULL,
      [Notes07] NVARCHAR(250) NULL,
      [Notes08] NVARCHAR(250) NULL,
      [Notes09] NVARCHAR(250) NULL,
      [Notes10] NVARCHAR(250) NULL,
      [Notes11] NVARCHAR(250) NULL,
      [Notes12] NVARCHAR(250) NULL,
      [Notes13] NVARCHAR(250) NULL,
      [Notes14] NVARCHAR(250) NULL,
      [Notes15] NVARCHAR(250) NULL,
      [MarkQuantity] DECIMAL(28,8) DEFAULT (0) NULL,
      [OExpenseConvertedAmount] DECIMAL(28,8) DEFAULT (0) NULL,
      [StandardPrice] DECIMAL(28,8) DEFAULT (0) NULL,
      [StandardAmount] DECIMAL(28,8) DEFAULT (0) NULL
    CONSTRAINT [PK_WT0096] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
---- Adđ Columns
If Exists (Select * From sysobjects Where name = 'WT0096' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'ReceiveQuantity')
           Alter Table  WT0096 Add ReceiveQuantity decimal(28,8) Null
End 
If Exists (Select * From sysobjects Where name = 'WT0096' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'Status')
           Alter Table  WT0096 Add Status tinyint NULL
           
		     If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'Status')
           Alter Table  WT0096 Add Status tinyint NULL

		       If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'ReceiptQuantity')
           Alter Table  WT0096 Add ReceiptQuantity DECIMAL(28,0) NULL
           
END

--- Add columns
If Exists (Select * From sysobjects Where name = 'WT0096' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'InheritVoucherID')
           Alter Table  WT0096 Add InheritTableID NVARCHAR(50) NULL, InheritVoucherID NVARCHAR(50) NULL, InheritTransactionID NVARCHAR(50) Null

		   --- trường dùng để nhận biết kế thừa từ NVL/bán phẩm nào của bộ định mức trong kế hoạch dự tính sản xuất (Angel)
		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'InheritApportionID')
           Alter Table  WT0096 Add InheritApportionID NVARCHAR(50) NULL
End 

---Modified by Bảo Thy on 05/09/2016
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0096' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0096' AND col.name = 'SOrderIDRecognition')
        ALTER TABLE WT0096 ADD SOrderIDRecognition VARCHAR(50) NULL
    END

---Modified by Khánh Đoan on 24/09/2019 : Bổ sung 2 trường RePVoucherID , RepTransactionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0096' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0096' AND col.name = 'RePVoucherID')
        ALTER TABLE WT0096 ADD RePVoucherID VARCHAR(50) NULL
    END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0096' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'WT0096' AND col.name = 'RePTransactionID')
        ALTER TABLE WT0096 ADD RePTransactionID VARCHAR(50) NULL
    END

	
DECLARE @CustomerIndex INT 
SELECT @CustomerIndex = CustomerName FROM dbo.CustomerIndex 
----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
IF(@CustomerIndex= 50 OR @CustomerIndex= 115)
	If Exists (Select * From sysobjects Where name = 'WT0096' and xtype ='U') 
	Begin
			   If not exists (select * from syscolumns col inner join sysobjects tab 
			   On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'StatusID')
			   Alter Table  WT0096 Add StatusID tinyint Null
	END

---Modified by Nhựt Trường on 24/03/2022: Tăng độ rộng cho cột 'Lô nhập'
If Exists (Select * From sysobjects Where name = 'WT0096' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name = 'WT0096' and col.name = 'SourceNo')
           Alter Table WT0096 Alter Column SourceNo [nvarchar](250) NULL          
End


If Exists (Select * From sysobjects Where name = 'WT0096' and xtype ='U') 
Begin
		   If not exists (select * from syscolumns col inner join sysobjects tab 
		   On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'IsProInventoryID')
		   Alter Table  WT0096 Add IsProInventoryID tinyint Null
END

--- Add columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0096' AND xtype = 'U')
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'T01')
    Alter Table  WT0096 Add T01 nvarchar(250) Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'T02')
    Alter Table  WT0096 Add T02 nvarchar(250) Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'T03')
    Alter Table  WT0096 Add T03 nvarchar(250) Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'T04')
    Alter Table  WT0096 Add T04 nvarchar(250) Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0096'  and col.name = 'T05')
    Alter Table  WT0096 Add T05 nvarchar(250) Null
END
