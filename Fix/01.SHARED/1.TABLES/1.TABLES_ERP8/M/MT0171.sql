-- <Summary>
---- 
-- <History>
---- Create on 09/03/2016 by Bảo Anh: chi tiết các đợt sản xuất thành phẩm/bán phẩm (Angel)
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT0171]') AND type in (N'U'))
CREATE TABLE [dbo].[MT0171](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[InventoryID] [nvarchar](50) NOT NULL,
	[Orders] [int] NULL,
	[RequestDate] [datetime] NULL,
	[BeginDate] [datetime] NULL,
	[FinishDate] [datetime] NULL,
	[Quantity] decimal(28,8) NULL,
	
 CONSTRAINT [PK_MT0171] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified on 26/03/2019 by Kim Thư: Bổ sung PerformDate - Số ngày thực hiện
----											Power - Công suất
----											Hours - Thời gian
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'MT0171' AND xtype ='U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0171' AND col.name = 'PerformDate')
    ALTER TABLE MT0171 ADD PerformDate DECIMAL (28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0171' AND col.name = 'Power')
    ALTER TABLE MT0171 ADD Power DECIMAL (28,8) NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'MT0171' AND col.name = 'Hours')
    ALTER TABLE MT0171 ADD Hours DECIMAL (28,8) NULL
END 

