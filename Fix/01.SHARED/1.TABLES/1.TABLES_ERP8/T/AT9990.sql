-- <Summary>
---- 
-- <History>
---- Create on 18/01/2016 by Bảo Anh: Lịch sử kế thừa lập hóa đơn bán hàng
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT9990]') AND type in (N'U'))
CREATE TABLE [dbo].[AT9990](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[InheritDate] [datetime] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[InheritSourceID] [tinyint] NOT NULL,	--- 0: đơn hàng bán, 1: phiếu xuất kho
	[InheritVoucherID] [nvarchar](max) NULL,
	[InheritVoucherNo] [nvarchar](max) NULL,
 CONSTRAINT [PK_AT9990] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT9990' AND type = 'U')
BEGIN
    IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT9990' AND col.name = 'DivisionID')
	ALTER TABLE AT9990 ALTER COLUMN DivisionID [nvarchar](50) NOT NULL
END