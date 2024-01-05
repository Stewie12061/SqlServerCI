-- <Summary>
---- 
-- <History>
---- Create on 27/02/2022 by Hoài Bảo
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WMT2230]') AND type in (N'U'))
CREATE TABLE [dbo].[WMT2230](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TableID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[ProjectID] [nvarchar](50) NULL,
	[OrderID] [nvarchar](50) NULL,
	[BatchID] [nvarchar](50) NULL,
	[WareHouseID] [nvarchar](50) NULL,
	[ReDeTypeID] [nvarchar](50) NULL,
	[KindVoucherID] [int] NULL,
	[WareHouseID2] [nvarchar](50) NULL,
	[Status] [tinyint] NOT NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[RefNo01] [nvarchar](100) NULL,
	[RefNo02] [nvarchar](100) NULL,
	[RDAddress] [nvarchar](500) NULL,
	[ContactPerson] [nvarchar](500) NULL,
	[VATObjectName] [nvarchar](250) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
 CONSTRAINT [PK_WMT2230] PRIMARY KEY NONCLUSTERED 
(	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Add Columns
If Exists (Select * From sysobjects Where name = 'WMT2230' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'MOrderID')
    Alter Table  WMT2230 Add MOrderID nvarchar(50) Null 

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'ApportionID')
    Alter Table  WMT2230 Add ApportionID nvarchar(50) Null

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WMT2230' AND col.name='IsVoucher')
	ALTER TABLE WMT2230 ADD IsVoucher TINYINT DEFAULT(0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WMT2230' AND col.name='IsGoodsFirstVoucher')
	ALTER TABLE WMT2230 ADD IsGoodsFirstVoucher TINYINT DEFAULT(0) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name = 'WMT2230' and col.name = 'IsGoodsRecycled') 
	Alter Table  WMT2230 Add IsGoodsRecycled tinyint Null 

	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'EVoucherID')
	Alter Table  WMT2230 Add EVoucherID nvarchar(500) NULL

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'IsInheritWarranty')
    Alter Table  WMT2230 Add IsInheritWarranty tinyint Null

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='WMT2230' AND col.name='ImVoucherID')
	ALTER TABLE WMT2230 ADD ImVoucherID VARCHAR(50) NULL

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'ReVoucherID')
    Alter Table  WMT2230 Add ReVoucherID nvarchar(50) Null 

---- Add Columns Transport
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter01')
    Alter Table  WMT2230 Add SParameter01 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter02')
    Alter Table  WMT2230 Add SParameter02 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter03')
    Alter Table  WMT2230 Add SParameter03 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter04')
    Alter Table  WMT2230 Add SParameter04 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter05')
    Alter Table  WMT2230 Add SParameter05 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter06')
    Alter Table  WMT2230 Add SParameter06 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter07')
    Alter Table  WMT2230 Add SParameter07 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter08')
    Alter Table  WMT2230 Add SParameter08 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter09')
    Alter Table  WMT2230 Add SParameter09 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter10')
    Alter Table  WMT2230 Add SParameter10 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter11')
    Alter Table  WMT2230 Add SParameter11 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter12')
    Alter Table  WMT2230 Add SParameter12 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter13')
    Alter Table  WMT2230 Add SParameter13 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter14')
    Alter Table  WMT2230 Add SParameter14 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter15')
    Alter Table  WMT2230 Add SParameter15 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter16')
    Alter Table  WMT2230 Add SParameter16 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter17')
    Alter Table  WMT2230 Add SParameter17 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter18')
    Alter Table  WMT2230 Add SParameter18 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter19')
    Alter Table  WMT2230 Add SParameter19 nvarchar(250) Null

    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'WMT2230'  and col.name = 'SParameter20')
    Alter Table  WMT2230 Add SParameter20 nvarchar(250) Null
End
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WMT2230_TableID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WMT2230] ADD  CONSTRAINT [DF_WMT2230_TableID]  DEFAULT ('WMT2230') FOR [TableID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WMT2230_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WMT2230] ADD  CONSTRAINT [DF_WMT2230_Status]  DEFAULT ((0)) FOR [Status]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WMT2230_IsGoodsRecycled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WMT2230] ADD  CONSTRAINT DF_WMT2230_IsGoodsRecycled  DEFAULT ((0)) FOR IsGoodsRecycled
END