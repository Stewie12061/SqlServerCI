-- <Summary>
---- Thông tin Pallet Detail
-- <History>
---- Create on 29/08/2019 by Khánh Đoan

---- Modified on ... by ...
---- Modified on 24/03/2022 by Nhựt Trường -- Tăng độ rộng cho cột 'Lô nhập'.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT2002]') AND type in (N'U'))
CREATE TABLE [dbo].[WT2002](
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[TransactionID] VARCHAR(50) NOT NULL,
	[VoucherID]VARCHAR(50) NOT NULL,
	[InventoryID] VARCHAR(50)NOT NULL,
	[UnitID] VARCHAR(50) NULL,
	[ActualQuantity] DECIMAL(28,8) NULL,
	[UnitPrice] DECIMAL(28,8) NULL,
	[OriginalAmount] DECIMAL(28,8) NULL,
	[ConvertedAmount] DECIMAL(28,8) NULL,
	[Notes] NVARCHAR(250) NULL,
	[SourceNo] NVARCHAR(50) NULL,
	[LimitDate] DATETIME NULL,
	[TranMonth]INT NULL,
	[TranYear]INT NULL,
	[LocationID]NVARCHAR(50)NULL,
	[Orders] INT NULL,
	[ReTransactionID] NVARCHAR(50)NULL,
	[ReVoucherNo] NVARCHAR(50)NULL,
	[InheritVoucherID] NVARCHAR(50)NULL,
	[InheritTransactionID] NVARCHAR(50)NULL,
	[ReVoucherID]NVARCHAR(50)NULL,
	[ReVoucherDate] DATETIME  NULL,
	[CreateUserID] VARCHAR(50)  NULL,
	[CreateDate] DATETIME  NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME  NULL
 CONSTRAINT [PK_WT2002] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID],
	[TransactionID]
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- Modified by Huỳnh Thử 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT2002' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2002' AND col.name = 'RePVoucherID') 
   ALTER TABLE WT2002 ADD RePVoucherID NVARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT2002' AND col.name = 'RePTransactionID') 
   ALTER TABLE WT2002 ADD RePTransactionID NVARCHAR(50) NULL 
END

---Modified by Nhựt Trường on 24/03/2022: Tăng độ rộng cho cột 'Lô nhập'
If Exists (Select * From sysobjects Where name = 'WT2002' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name = 'WT2002' and col.name = 'SourceNo')
           Alter Table  WT2002 Alter Column SourceNo [nvarchar](250) NULL          
End