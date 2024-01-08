-- <Summary>
---- 
-- <History>
---- Create on 25/10/2023 by Hoàng Long
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2190]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2190](
    [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] [NVARCHAR](100) NOT NULL,
  [DeleteFlg] [TINYINT] DEFAULT (0) NULL,
  [TranMonth] [INT] NULL,
  [TranYear] [INT] NULL,
  [VoucherTypeID] [NVARCHAR](100) NULL,
  [VoucherID] [NVARCHAR](100) NULL,
  [VoucherNo] [NVARCHAR](100) NULL,
  [VoucherDate] [DATETIME] NULL,
  [CarNumber] [NVARCHAR](100) NULL,
  [SeriNo] [NVARCHAR](100) NULL,
  [ProductionOrder] [NVARCHAR](100) NULL,
  [ObjectID] [NVARCHAR](100) NULL,
  [ObjectName] [NVARCHAR](100) NULL,
  [ObjectType] [NVARCHAR](100) NULL,
  [Address] [NVARCHAR](1000) NULL,
  [Address2] [NVARCHAR](1000) NULL,
  [Phone] [NVARCHAR](20) NULL,
  [SourceNo] [NVARCHAR](100) NULL,
  [MVoucherDate]  [DATETIME] NULL,
  [ExWarehouseID]  [NVARCHAR](100) NULL,
  [Description] [NVARCHAR](4000) NULL,
  [QRCode] [NVARCHAR](4000) NULL,
  [CreateUserID] [NVARCHAR](100) NULL,
  [CreateDate] [DATETIME] NULL,
  [LastModifyUserID] [NVARCHAR](100) NULL,
  [LastModifyDate] [DATETIME] NULL,
CONSTRAINT [PK_SOT2190] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2190' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2190' AND col.name = 'AddressID2')
	BEGIN
		ALTER TABLE SOT2190 ADD AddressID2 VARCHAR(50) NULL
	END
END