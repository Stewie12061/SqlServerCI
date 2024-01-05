-- <Summary>
---- Bảng thông tin giao hàng (Detail)
-- <History>
---- Create on 01/08/2022 by Văn Tài
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2202]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2202](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[MonitorID] [nvarchar](50) NOT NULL,
	[TransactionVoucher] [nvarchar](50) NULL,
	[Weight] [decimal](28, 8) NULL,
	[DeliveryAddress] [nvarchar](250) NULL,
	[Status] [tinyint] NULL DEFAULT (0),
	[VoucherNo] [nvarchar](50) NULL,
 CONSTRAINT [PK_SOT2202] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

---------------- 14/06/2023 - Hoài Thanh: Bổ sung cột Notes
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'SOT2202' AND col.name = 'Notes')
BEGIN
	ALTER TABLE SOT2202 ADD Notes NVARCHAR(MAX) NULL
END

---------------- 14/11/2023 - Ngô Dũng: Bổ sung cột AmountReceived
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'SOT2202' AND col.name = 'AmountReceived')
BEGIN
	ALTER TABLE SOT2202 ADD AmountReceived DECIMAL(28) NULL
END