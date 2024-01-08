-- <Summary>
---- 
-- <History>
---- Create on 21/12/2010 by Huỳnh Tấn Phú
---- Modified on 15/01/2020 by Pham Le Hoang: Bổ sung cột Máy in, loại in (0/NULL là hóa đơn bán hàng, khác là các báo khác sau này)
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT3000]') AND type in (N'U'))
CREATE TABLE [dbo].[AT3000](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[ReportID] [nvarchar](50) NOT NULL,
	[ReportName] [nvarchar](250) NOT NULL,
	[Pages] [int] NOT NULL,
	[Page1] [nvarchar](250) NOT NULL,
	[Page2] [nvarchar](250) NULL,
	[Page3] [nvarchar](250) NULL,
	[Page4] [nvarchar](250) NULL,
	[Page5] [nvarchar](250) NULL,
	[Page6] [nvarchar](250) NULL,
	[Page7] [nvarchar](250) NULL,
	[Page8] [nvarchar](250) NULL,
	[Page9] [nvarchar](250) NULL,
 CONSTRAINT [PK_AT3000] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT3000' AND xtype ='U') 
BEGIN
		   --cột Printer sẽ NULL với các hóa đơn tự in (cũ), cột này bổ sung để in các báo cáo tự in với từng máy in khác
           IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
           ON col.id = tab.id WHERE tab.name = 'AT3000' AND col.name = 'Printer')
           ALTER TABLE AT3000 ADD Printer NVARCHAR(4000) NULL
		   --NULL hoặc 0 sẽ là của Hóa đơn tự in (dữ liệu cũ), 1 sẽ là mới bổ sung in cho từng mẫu báo cáo với từng máy in khác nhau
		   IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
           ON col.id = tab.id WHERE tab.name = 'AT3000' AND col.name = 'PrintType')
           ALTER TABLE AT3000 ADD PrintType INT NULL
END