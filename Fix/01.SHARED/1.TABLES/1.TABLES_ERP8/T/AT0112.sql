-- <Summary>
---- 
-- <History>
---- Create on 27/07/2016 by Tiểu Mai
---- Purpose: Phiếu lắp ráp master (ANGEL)

---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0112]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0112](
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
	[BatchID] [nvarchar](50) NULL,
	[Type] [tinyint] NOT NULL, --- 0:lap rap, 1: thao do
	[EmployeeID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[RefNo01] [nvarchar](100) NULL,
	[RefNo02] [nvarchar](100) NULL
 CONSTRAINT [PK_AT0112] PRIMARY KEY NONCLUSTERED 
(	[DivisionID] ASC,
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0112_TableID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0112] ADD  CONSTRAINT [DF_AT0112_TableID]  DEFAULT ('AT0112') FOR [TableID]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT0112_Type]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT0112] ADD  CONSTRAINT [DF_AT0112_Type]  DEFAULT ((0)) FOR [Type]
END

--- [Kiều Nga][10/06/2021]Bổ sung trường thêm trường Apportion
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0112' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0112' AND col.name = 'Apportion')
	ALTER TABLE AT0112 ADD Apportion INT NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0112' AND xtype = 'U')
BEGIN
    IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0112' AND col.name = 'DivisionID')
	ALTER TABLE AT0112 ALTER COLUMN DivisionID [nvarchar](50) NOT NULL
END
--- [Thanh Lượng][30/05/2023]Bổ sung trường thêm trường ApportionID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0112' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT0112' AND col.name = 'ApportionID')
	ALTER TABLE AT0112 ADD ApportionID INT NULL
END

