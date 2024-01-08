-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Thanh Nguyen
---- Modified on ... by ...
---- Modified on 31/10/2023 by Đức Tuyên Update: Báo cáo P&L chi tiết (Customize INNOTEK).
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT7621]') AND type in (N'U'))
CREATE TABLE [dbo].[AT7621](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[ReportCode] [nvarchar](50) NOT NULL,
	[LineID] [nvarchar](50) NOT NULL,
	[LineCode] [nvarchar](50) NULL,
	[LineDescription] [nvarchar](250) NULL,
	[LevelID] [tinyint] NULL,
	[Sign] [nvarchar](5) NULL,
	[AccuLineID] [nvarchar](50) NULL,
	[CaculatorID] [nvarchar](50) NULL,
	[FromAccountID] [nvarchar](50) NULL,
	[ToAccountID] [nvarchar](50) NULL,
	[FromCorAccountID] [nvarchar](50) NULL,
	[ToCorAccountID] [nvarchar](50) NULL,
	[AnaTypeID] [nvarchar](50) NULL,
	[FromAnaID] [nvarchar](50) NULL,
	[ToAnaID] [nvarchar](50) NULL,
	[IsPrint] [tinyint] NULL,
	[BudgetID] [nvarchar](50) NULL,
CONSTRAINT [PK_AT7621] PRIMARY KEY CLUSTERED 
(
	[ReportCode] ASC,
	[LineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modified by Tiểu Mai on 28/06/2016: Bổ sung trường cho AN PHÁT
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT7621' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7621' AND col.name = 'FromWareHouseID')
        ALTER TABLE AT7621 ADD FromWareHouseID NVARCHAR(50) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7621' AND col.name = 'ToWareHouseID')
        ALTER TABLE AT7621 ADD ToWareHouseID NVARCHAR(50) NULL
    END	

--Bổ sung đối tượng, cờ để hỗ trợ báo cáo (Customize INNOTEK)
IF ((SELECT CustomerName FROM CustomerIndex) = 161)
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT7621' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT7621' AND col.name = 'IsObject')
		ALTER TABLE AT7621 ADD IsObject TINYINT NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT7621' AND col.name = 'ObjectID')
		ALTER TABLE AT7621 ADD ObjectID NVARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT7621' AND col.name = 'IsCredit')
		ALTER TABLE AT7621 ADD IsCredit TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		ON col.id = tab.id WHERE tab.name = 'AT7621' AND col.name = 'IsDebit')
		ALTER TABLE AT7621 ADD IsDebit TINYINT NULL
	END
END
