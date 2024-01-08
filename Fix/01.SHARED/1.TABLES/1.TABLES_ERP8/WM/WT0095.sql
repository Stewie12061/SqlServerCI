-- <Summary>
---- 
-- <History>
---- Create on 06/06/2014 by Thanh Sơn
---- Modified on 09/06/2014 by Lê Thị Thu Hiền
---- Modified by Tiểu Mai on 09/08/2016: Bổ sung trường duyệt 2 cấp (AN PHÁT)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0095]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[WT0095]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,
      [VoucherTypeID] VARCHAR(50) NULL,
      [VoucherID] VARCHAR(50) NOT NULL,
      [VoucherNo] VARCHAR(50) NULL,
      [VoucherDate] DATETIME NULL,
      [RefNo01] NVARCHAR(100) NULL,
      [RefNo02] NVARCHAR(100) NULL,
      [ObjectID] VARCHAR(50) NULL,
      [WareHouseID] VARCHAR(50) NULL,
      [InventoryTypeID] VARCHAR(50) NULL,
      [EmployeeID] VARCHAR(50) NULL,
      [ContactPerson] NVARCHAR(250) NULL,
      [RDAddress] NVARCHAR(250) NULL,
      [Description] NVARCHAR(1000) NULL,
      [TableID] VARCHAR(50) NULL,
      [ProjectID] VARCHAR(50) NULL,
      [OrderID] VARCHAR(50) NULL,
      [BatchID] VARCHAR(50) NULL,
      [ReDeTypeID] VARCHAR(50) NULL,
      [KindVoucherID] INT NULL,
      [WareHouseID2] VARCHAR(50) NULL,
      [Status] TINYINT DEFAULT (0) NULL,
      [VATObjectName] NVARCHAR(250) NULL,
      [IsGoodsFirstVoucher] TINYINT DEFAULT (0) NULL,
      [MOrderID] VARCHAR(50) NULL,
      [ApportionID] VARCHAR(50) NULL,
      [IsInheritWarranty] TINYINT DEFAULT (0) NULL,
      [EVoucherID] NVARCHAR(500) NULL,
      [IsGoodsRecycled] TINYINT DEFAULT (0) NULL,
      [RefVoucherID] VARCHAR(50) NULL,
      [IsCheck] TINYINT DEFAULT (0) NULL,
      [IsVoucher] TINYINT DEFAULT (0) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [StandardPrice] DECIMAL(28,8) DEFAULT (0) NULL
    CONSTRAINT [PK_WT0095] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'WT0095' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'StatusID')
           Alter Table  WT0095 Add StatusID tinyint Null
End 

---- ---- Modified by Tiểu Mai on 09/08/2016: Bổ sung trường duyệt 2 cấp (AN PHÁT)
If Exists (Select * From sysobjects Where name = 'WT0095' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'IsConfirm01')
	Alter Table  WT0095 Add IsConfirm01 TINYINT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'ConfDescription01')
	Alter Table  WT0095 Add ConfDescription01 NVARCHAR(250) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'IsConfirm02')
	Alter Table  WT0095 Add IsConfirm02 TINYINT NULL
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'ConfDescription02')
	Alter Table  WT0095 Add ConfDescription02 NVARCHAR(250) Null
End 

----- Modified by Bảo Thy on 30/12/2016: bổ sung 2 trường hợp đồng (EIMSKIP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0095' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'ContractNo') 
   ALTER TABLE WT0095 ADD ContractNo VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'ContractID') 
   ALTER TABLE WT0095 ADD ContractID VARCHAR(50) NULL 
END

----- Modified by Bảo Thy on 30/12/2016: bổ sung 20 tham số
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0095' AND xtype = 'U')
BEGIN
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter01')
    Alter Table  WT0095 Add SParameter01 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter02')
    Alter Table  WT0095 Add SParameter02 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter03')
    Alter Table  WT0095 Add SParameter03 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter04')
    Alter Table  WT0095 Add SParameter04 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter05')
    Alter Table  WT0095 Add SParameter05 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter06')
    Alter Table  WT0095 Add SParameter06 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter07')
    Alter Table  WT0095 Add SParameter07 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter08')
    Alter Table  WT0095 Add SParameter08 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter09')
    Alter Table  WT0095 Add SParameter09 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter10')
    Alter Table  WT0095 Add SParameter10 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter11')
    Alter Table  WT0095 Add SParameter11 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter12')
    Alter Table  WT0095 Add SParameter12 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter13')
    Alter Table  WT0095 Add SParameter13 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter14')
    Alter Table  WT0095 Add SParameter14 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter15')
    Alter Table  WT0095 Add SParameter15 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter16')
    Alter Table  WT0095 Add SParameter16 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter17')
    Alter Table  WT0095 Add SParameter17 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter18')
    Alter Table  WT0095 Add SParameter18 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter19')
    Alter Table  WT0095 Add SParameter19 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'SParameter20')
    Alter Table  WT0095 Add SParameter20 nvarchar(250) Null


END
---- Modified by Khánh Đoan on 20/09/2019: Bổ sung trường TypeRule 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0095' AND xtype = 'U')
BEGIN

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'WT0095'  and col.name = 'TypeRule')
	Alter Table  WT0095 Add TypeRule INT  NULL
END

----- Modified by Trà Giang on 10/12/2019: Bổ sung trường Ngày giao hàng cho MAITHU
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'WT0095' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'WT0095' AND col.name = 'DeliveryDate') 
   ALTER TABLE WT0095 ADD DeliveryDate Datetime NULL 
END