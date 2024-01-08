-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Việt Khánh
---- Modified on 22/12/2011 by Nguyễn Bình Minh
---- Modified on 27/03/2013 by Bảo Quỳnh
---- Modified on 15/04/2015 by Hoàng Vũ: Add column into table AT7915 about [TT200] => Báo cáo bảng cân đối kế toán
---- Modified on 13/07/2020 by Văn Tài: Move bổ sung 2 cột Amount5, Amount6 sang STD.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT7915]') AND type in (N'U'))
CREATE TABLE [dbo].[AT7915](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[LineID] [nvarchar](50) NOT NULL,
	[LineCode] [nvarchar](50) NULL,
	[LineDescription] [nvarchar](250) NULL,
	[PrintStatus] [tinyint] NULL,
	[Amount1] [decimal](28, 8) NULL,
	[Amount2] [decimal](28, 8) NULL,
	[Level1] [tinyint] NULL,
	[Type] [tinyint] NULL,
	[Accumulator] [nvarchar](100) NULL,
	[LineDescriptionE] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
CONSTRAINT [PK_AT7915] PRIMARY KEY NONCLUSTERED 
(
	[LineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
IF(ISNULL(COL_LENGTH('AT7915', 'Amount3'), 0) <= 0)
	ALTER TABLE AT7915 ADD Amount3 DECIMAL(28, 8) NULL
IF(ISNULL(COL_LENGTH('AT7915', 'Amount4'), 0) <= 0)
	ALTER TABLE AT7915 ADD Amount4 DECIMAL(28, 8) NULL
If Exists (Select * From sysobjects Where name = 'AT7915' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7915'  and col.name = 'DisplayedMark')
           Alter Table  AT7915 Add DisplayedMark tinyint default 0 NULL --0: Hiện dấu dương, 1: Hiện dấu âm
END

---- Modified by on 28/09/2016 by Phương Thảo :  Bổ sung lấy số phát sinh nợ, co (Customize Meiko)
If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT7915'  and col.name = 'Amount5')
        Alter Table  AT7915 Add Amount5 DECIMAL(28, 8) NULL 

If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT7915'  and col.name = 'Amount6')
        Alter Table  AT7915 Add Amount6 DECIMAL(28, 8) NULL 

--- Modified by Hải Long on 17/04/2017: Add column ExchangeRate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT7915' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7915' AND col.name = 'ExchangeRate')
        ALTER TABLE AT7915 ADD ExchangeRate DECIMAL(28) NULL
    END    
    
    
--- Modified by Hải Long on 14/05/2017: Add column ExchangeRate
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT7915' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT7915' AND col.name = 'ExchangeRate2')
        ALTER TABLE AT7915 ADD ExchangeRate2 DECIMAL(28) NULL
    END        