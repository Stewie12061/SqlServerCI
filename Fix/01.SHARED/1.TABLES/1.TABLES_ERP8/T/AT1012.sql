-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 30/12/2015 by Phương Thảo: Bổ sung thông tin Tỷ giá Mua/bán và Ngân hàng
---- Modified on 15/19/2016 by Phương Thảo: Bổ sung thông tin Tỷ giá xấp xỉ (TT53)
---- <Example>
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1012]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1012](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ExchangeRateID] [nvarchar](50) NOT NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[ExchangeDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_AT1012] PRIMARY KEY NONCLUSTERED 
(
	[ExchangeRateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1012' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1012' AND col.name = 'BankID')
        ALTER TABLE AT1012 ADD BankID NVARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1012' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1012' AND col.name = 'IsDefault')
        ALTER TABLE AT1012 ADD IsDefault TINYINT NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1012' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1012' AND col.name = 'BuyingExchangeRate')
        ALTER TABLE AT1012 ADD BuyingExchangeRate DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1012' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1012' AND col.name = 'SellingExchangeRate')
        ALTER TABLE AT1012 ADD SellingExchangeRate DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1012' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1012' AND col.name = 'ApproximateExRate')
        ALTER TABLE AT1012 ADD ApproximateExRate DECIMAL(28,8) NULL
    END

--- Modified by Đình Định on 15/11/2023: Bổ sung cột ExchangeToDate.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1012' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1012' AND col.name = 'ExchangeToDate')
        ALTER TABLE AT1012 ADD ExchangeToDate DATETIME NULL
    END