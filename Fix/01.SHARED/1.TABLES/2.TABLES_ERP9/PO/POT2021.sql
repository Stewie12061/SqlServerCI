-- <Summary>
---- 
-- <History>
---- Create on 14/03/2019 by Như Hàn: Bảng yêu cầu báo giá nhà cung cấp
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[POT2021]') AND type in (N'U'))
CREATE TABLE [dbo].[POT2021](
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [varchar](50) NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[OverDate] [datetime] NULL,
	[ObjectID] [varchar](50) NULL,
	[CurrencyID] [varchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[EmployeeID] [varchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
	
 CONSTRAINT [PK_POT2021] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'POT2021' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'POT2021' AND col.name = 'APKMaster_9000')
    ALTER TABLE POT2021 ADD APKMaster_9000 UNIQUEIDENTIFIER NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'POT2021' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'POT2021' AND col.name = 'Status')
    ALTER TABLE POT2021 ADD Status tinyint NOT NULL DEFAULT ((0))
END

