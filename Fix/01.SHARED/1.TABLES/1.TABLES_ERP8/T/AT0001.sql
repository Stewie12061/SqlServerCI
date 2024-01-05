-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 20/06/2014 by Thanh Sơn: Bổ sung thêm trường Số lẻ phần trăm và logo công ty

-- <Example>

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0001]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0001](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[CompanyName] [nvarchar](250) NULL,
	[ShortName] [nvarchar](250) NULL,
	[Tel] [nvarchar](100) NULL,
	[Fax] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](250) NULL,
	[CountryID] [nvarchar](50) NULL,
	[CityID] [nvarchar](50) NULL,
	[ChiefAccountant] [nvarchar](250) NULL,
	[Director] [nvarchar](250) NULL,
	[Chairmain] [nvarchar](250) NULL,
	[BaseCurrencyID] [nvarchar](50) NULL,
	[PeriodNum] [int] NULL,
	[DBID] [nvarchar](50) NULL,
	[QuantityDecimals] [tinyint] NOT NULL,
	[UnitCostDecimals] [tinyint] NOT NULL,
	[ConvertedDecimals] [tinyint] NOT NULL,
	[DBVersion] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[Serial] [nvarchar](250) NULL,
	[InvoiceNo] [nvarchar](250) NULL
	CONSTRAINT [PK_AT0001] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) 

) ON [PRIMARY]
END
---- Add giá trị Default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0001_QuantityDecimals]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0001] ADD  CONSTRAINT [DF_AT0001_QuantityDecimals]  DEFAULT ((2)) FOR [QuantityDecimals]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0001_UnitCost]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0001] ADD  CONSTRAINT [DF_AT0001_UnitCost]  DEFAULT ((2)) FOR [UnitCostDecimals]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0001_ConvertedDecimals]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0001] ADD  CONSTRAINT [DF_AT0001_ConvertedDecimals]  DEFAULT ((2)) FOR [ConvertedDecimals]
END
---- Add Columns
If Exists (Select TOP 1 1 From sysobjects Where name = 'AT0001' and xtype ='U') 
Begin
           If not exists (select TOP 1 1 from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0001'  and col.name = 'BankAccountID')
           Alter Table AT0001 Add BankAccountID nvarchar(50) Null
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0001' AND col.name='PercentDecimal')
		ALTER TABLE AT0001 ADD PercentDecimal TINYINT DEFAULT(2) NOT NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT0001' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0001' AND col.name='Logo')
		ALTER TABLE AT0001 ADD Logo IMAGE NULL
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT0001' AND col.name='WebSiteUpdate')
		ALTER TABLE AT0001 ADD WebSiteUpdate NVARCHAR(50) NULL
	END

--- Modify by Phương Thảo on 07/09/2016 : Add column IsSplitTable (tách bảng nghiệp vụ)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0001' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'IsSplitTable')
    ALTER TABLE AT0001 ADD IsSplitTable TINYINT NULL
END

-- Bổ sung trường Status check trang thai cap nhat. 0: Không tác động 1: Đang thực hiện
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0001' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'Status')
    ALTER TABLE AT0001 ADD Status TINYINT default(0)
END

--- Modify by Hải Long on 07/09/2016 : Add column InvoiceSign
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0001' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'InvoiceSign')
    ALTER TABLE AT0001 ADD InvoiceSign NVARCHAR(50) NULL
    
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'InvoiceCode')
    ALTER TABLE AT0001 ADD InvoiceCode NVARCHAR(50) NULL    
END

--- Modify by Đoàn Duy on 11/08/2020 : Add column AppVersion (version của app mobile)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0001' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'AppVersion')
    ALTER TABLE AT0001 ADD AppVersion NVARCHAR(50) NULL
END

-- <Summary>
---- 
-- <History>
---Modify Thị Phượng bổ sung trường customize KIM YEN

---Tỷ lệ huê hồng quản lý 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'CommissionManageRate') 
   ALTER TABLE AT0001 ADD CommissionManageRate DECIMAL(28,8) NULL 
END

/*===============================================END CommissionManageRate===============================================*/ 
--Tỷ lệ huê hồng nhân viên
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0001' AND col.name = 'CommissionEmployeeRate') 
   ALTER TABLE AT0001 ADD CommissionEmployeeRate DECIMAL(28,8) NULL 
END

/*===============================================END CommissionEmployeeRate===============================================*/ 