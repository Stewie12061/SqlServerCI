-- <Summary>
---- 
-- <History>
---- Create on 15/05/2011 by Lê Thị Thu Hiền
---- Modified by Le Thi Thu Hien on 13/12/2011
---- Modified on 04/09/2012 by Bao Anh: Thay doi do dai cho cac truong Tham so
---- Modified on 03/02/2012 by Huỳnh Tấn Phú: Bo sung 5 ma phan tich Ana
---- Modified on 10/01/2022 by Minh Hiếu: bổ sung cột chức vụ và người liên hệ
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT2101]') AND type in (N'U'))
CREATE TABLE [dbo].[OT2101](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[QuotationID] [nvarchar](50) NOT NULL,	
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[QuotationNo] [nvarchar](50) NULL,
	[QuotationDate] [datetime] NULL,
	[RefNo1] [nvarchar](50) NULL,
	[RefNo2] [nvarchar](50) NULL,
	[RefNo3] [nvarchar](50) NULL,
	[Attention1] [nvarchar](250) NULL,
	[Attention2] [nvarchar](250) NULL,
	[Dear] [nvarchar](100) NULL,
	[Condition] [nvarchar](100) NULL,
	[SaleAmount] [decimal](28, 8) NULL,
	[PurchaseAmount] [decimal](28, 8) NULL,
	[Disabled] [tinyint] NOT NULL,
	[Status] [tinyint] NOT NULL,
	[OrderStatus] [tinyint] NOT NULL,
	[IsSO] [tinyint] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar](50) NULL,
	[EndDate] [datetime] NULL,
	[Transport] [nvarchar](250) NULL,
	[DeliveryAddress] [nvarchar](250) NULL,
	[PaymentID] [nvarchar](50) NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[Ana01ID] [nvarchar](50) NULL,
	[Ana02ID] [nvarchar](50) NULL,
	[Ana03ID] [nvarchar](50) NULL,
	[SalesManID] [nvarchar](50) NULL,
	[ClassifyID] [nvarchar](50) NULL,
	[ObjectName] [nvarchar](250) NULL,
	[Ana04ID] [nvarchar](50) NULL,
	[Ana05ID] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[ApportionID] [nvarchar](50) NULL,
	[IsConfirm] [tinyint] NOT NULL,
	[DescriptionConfirm] [nvarchar](250) NULL,
	[ContactorID] [nvarchar](50) NULL,
 CONSTRAINT [PK_OT2101] PRIMARY KEY NONCLUSTERED 
(
	[QuotationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2101_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2101] ADD  CONSTRAINT [DF_OT2101_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2101_Status]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2101] ADD  CONSTRAINT [DF_OT2101_Status]  DEFAULT ((0)) FOR [Status]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2101_OrderStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2101] ADD  CONSTRAINT [DF_OT2101_OrderStatus]  DEFAULT ((0)) FOR [OrderStatus]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OT2101_IsSO]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2101] ADD  CONSTRAINT [DF_OT2101_IsSO]  DEFAULT ((0)) FOR [IsSO]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__OT2101__IsConfir__11505495]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OT2101] ADD  CONSTRAINT [DF__OT2101__IsConfir__11505495]  DEFAULT ((0)) FOR [IsConfirm]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'QuotationStatus')
           Alter Table  OT2101 Add QuotationStatus tinyint Not Null Default(0)
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'NumOfValidDays')
           Alter Table  OT2101 Add NumOfValidDays int Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar01')
           Alter Table  OT2101 Add Varchar01 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar02')
           Alter Table  OT2101 Add Varchar02 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar03')
           Alter Table  OT2101 Add Varchar03 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar04')
           Alter Table  OT2101 Add Varchar04 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar05')
           Alter Table  OT2101 Add Varchar05 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar06')
           Alter Table  OT2101 Add Varchar06 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar07')
           Alter Table  OT2101 Add Varchar07 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar08')
           Alter Table  OT2101 Add Varchar08 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar09')
           Alter Table  OT2101 Add Varchar09 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar10')
           Alter Table  OT2101 Add Varchar10 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar11')
           Alter Table  OT2101 Add Varchar11 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar12')
           Alter Table  OT2101 Add Varchar12 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar13')
           Alter Table  OT2101 Add Varchar13 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar14')
           Alter Table  OT2101 Add Varchar14 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar15')
           Alter Table  OT2101 Add Varchar15 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar16')
           Alter Table  OT2101 Add Varchar16 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar17')
           Alter Table  OT2101 Add Varchar17 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar18')
           Alter Table  OT2101 Add Varchar18 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar19')
           Alter Table  OT2101 Add Varchar19 nvarchar(50) Null
End 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Varchar20')
           Alter Table  OT2101 Add Varchar20 nvarchar(50) Null
END
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2101' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'PriceListID')
    ALTER TABLE OT2101 ADD PriceListID NVARCHAR(50) NULL
END 
If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin 
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'Ana06ID')
Alter Table  OT2101 Add Ana06ID nvarchar(50) Null,
					 Ana07ID nvarchar(50) Null,
					 Ana08ID nvarchar(50) Null,
					 Ana09ID nvarchar(50) Null,
					 Ana10ID nvarchar(50) Null
End
---- Alter Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar01')
		ALTER TABLE OT2101 ALTER COLUMN Varchar01 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar02')
		ALTER TABLE OT2101 ALTER COLUMN Varchar02 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar03')
		ALTER TABLE OT2101 ALTER COLUMN Varchar03 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar04')
		ALTER TABLE OT2101 ALTER COLUMN Varchar04 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar05')
		ALTER TABLE OT2101 ALTER COLUMN Varchar05 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar06')
		ALTER TABLE OT2101 ALTER COLUMN Varchar06 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar07')
		ALTER TABLE OT2101 ALTER COLUMN Varchar07 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar08')
		ALTER TABLE OT2101 ALTER COLUMN Varchar08 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar09')
		ALTER TABLE OT2101 ALTER COLUMN Varchar09 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar10')
		ALTER TABLE OT2101 ALTER COLUMN Varchar10 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar11')
		ALTER TABLE OT2101 ALTER COLUMN Varchar11 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar12')
		ALTER TABLE OT2101 ALTER COLUMN Varchar12 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar13')
		ALTER TABLE OT2101 ALTER COLUMN Varchar13 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar14')
		ALTER TABLE OT2101 ALTER COLUMN Varchar14 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar15')
		ALTER TABLE OT2101 ALTER COLUMN Varchar15 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar16')
		ALTER TABLE OT2101 ALTER COLUMN Varchar16 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar17')
		ALTER TABLE OT2101 ALTER COLUMN Varchar17 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar18')
		ALTER TABLE OT2101 ALTER COLUMN Varchar18 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar19')
		ALTER TABLE OT2101 ALTER COLUMN Varchar19 NVARCHAR(250) NULL 
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Varchar20')
		ALTER TABLE OT2101 ALTER COLUMN Varchar20 NVARCHAR(250) NULL 
	END
--Modify by Cao Thị Phượng Date 23/03/2017 Bổ sung trường CHo module ASOFT-CRM
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2101' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'OpportunityID') 
   ALTER TABLE OT2101 ADD OpportunityID VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2101' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'DeleteFlg') 
   ALTER TABLE OT2101 ADD DeleteFlg TINYINT NULL  Default(0)
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2101' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'RelatedToTypeID') 
   ALTER TABLE OT2101 ADD RelatedToTypeID INT NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2101' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'ConfirmUserID') 
   ALTER TABLE OT2101 ADD ConfirmUserID VARCHAR(50) NULL 
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT2101' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'ConfirmDate') 
   ALTER TABLE OT2101 ADD ConfirmDate DATETIME NULL 
END
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2101' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'APKMaster_9000')
    ALTER TABLE OT2101 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Attention2')
		ALTER TABLE OT2101 ALTER COLUMN Attention2 NVARCHAR(4000) NULL 
	END

--Modify by Kiều Nga Date 27/09/2019 Bổ sung trường hệ số tổng (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Coefficient')
	ALTER TABLE OT2101 ADD Coefficient decimal(28,8) Null 
END

--Modify by Kiều Nga Date 07/11/2019 Bổ sung tổng số lượng mặt hàng (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='TotalInventoryID')
	ALTER TABLE OT2101 ADD TotalInventoryID decimal(28,8) Null 
END

--Modify by Kiều Nga Date 07/11/2019 Bổ sung tổng số lượng nguyên tệ (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='TotalOriginalAmount')
	ALTER TABLE OT2101 ADD TotalOriginalAmount decimal(28,8) Null 
END

--Modify by Kiều Nga Date 07/11/2019 Bổ sung tổng số lượng quy đổi (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='TotalConvertedAmount')
	ALTER TABLE OT2101 ADD TotalConvertedAmount decimal(28,8) Null 
END

--Modify by Kiều Nga Date 07/11/2019 Bổ sung tổng tiền thuế (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='TotalVATOriginalAmount')
	ALTER TABLE OT2101 ADD TotalVATOriginalAmount decimal(28,8) Null 
END

--Modify by Kiều Nga Date 27/09/2019 Bổ sung tổng tiền thuế quy đổi (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='TotalVATConvertedAmount')
	ALTER TABLE OT2101 ADD TotalVATConvertedAmount decimal(28,8) Null 
END

--Modify by Bảo Toàn Date 20/02/2020 Tăng size [Description] (Đức Tín)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2101' AND xtype='U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT2101' AND col.name='Description')
	ALTER TABLE OT2101 ALTER COLUMN [Description] NVARCHAR(MAX) 
END

--- Modified by Kiều Nga on 26/03/2020: Bổ sung thêm trường công việc
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2101' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'TaskID')
    ALTER TABLE OT2101 ADD [TaskID] Nvarchar(50) NULL 
END

--- Modified by Bảo Toàn on 07/04/2020: Bổ sung thêm trường xác nhận tính lương. 0 hoặc NULL: chưa tính. 1: Đã tính
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2101' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2101' AND col.name = 'IsPayroll')
    ALTER TABLE OT2101 ADD [IsPayroll] TINYINT  NULL 
END

If Exists (Select * From sysobjects Where name = 'OT2101' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2101'  and col.name = 'ContactorID')
           Alter Table  OT2101 Add ContactorID nvarchar(50) Null
End 

