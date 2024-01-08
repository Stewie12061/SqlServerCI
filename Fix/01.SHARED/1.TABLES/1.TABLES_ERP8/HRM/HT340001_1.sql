-- <Summary>
---- 
-- <History>
---- Create on 28/11/2016 by Bảo Thy: Lưu Income31->Income150
---- Modified on 14/08/2020 by Huỳnh Thử -- Merge Code: MEKIO và MTE
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT340001_1]') AND type in (N'U'))
CREATE TABLE [dbo].[HT340001_1](
	[APK] uniqueidentifier NOT NULL DEFAULT (NEWID()),
	[DivisionID] nvarchar(50) NOT NULL,
	[TransactionID] nvarchar(50) NOT NULL,
	[ProjectID] nvarchar(50) NULL,
	[Income31] decimal(28,8) NULL,
	[Income32] decimal(28,8) NULL,
	[Income33] decimal(28,8) NULL,
	[Income34] decimal(28,8) NULL,
	[Income35] decimal(28,8) NULL,
	[Income36] decimal(28,8) NULL,
	[Income37] decimal(28,8) NULL,
	[Income38] decimal(28,8) NULL,
	[Income39] decimal(28,8) NULL,
	[Income40] decimal(28,8) NULL,
	[Income41] decimal(28,8) NULL,
	[Income42] decimal(28,8) NULL,
	[Income43] decimal(28,8) NULL,
	[Income44] decimal(28,8) NULL,
	[Income45] decimal(28,8) NULL,
	[Income46] decimal(28,8) NULL,
	[Income47] decimal(28,8) NULL,
	[Income48] decimal(28,8) NULL,
	[Income49] decimal(28,8) NULL,
	[Income50] decimal(28,8) NULL,
	[Income51] decimal(28,8) NULL,
	[Income52] decimal(28,8) NULL,
	[Income53] decimal(28,8) NULL,
	[Income54] decimal(28,8) NULL,
	[Income55] decimal(28,8) NULL,
	[Income56] decimal(28,8) NULL,
	[Income57] decimal(28,8) NULL,
	[Income58] decimal(28,8) NULL,
	[Income59] decimal(28,8) NULL,
	[Income60] decimal(28,8) NULL,
	[Income61] decimal(28,8) NULL,
	[Income62] decimal(28,8) NULL,
	[Income63] decimal(28,8) NULL,
	[Income64] decimal(28,8) NULL,
	[Income65] decimal(28,8) NULL,
	[Income66] decimal(28,8) NULL,
	[Income67] decimal(28,8) NULL,
	[Income68] decimal(28,8) NULL,
	[Income69] decimal(28,8) NULL,
	[Income70] decimal(28,8) NULL,
	[Income71] decimal(28,8) NULL,
	[Income72] decimal(28,8) NULL,
	[Income73] decimal(28,8) NULL,
	[Income74] decimal(28,8) NULL,
	[Income75] decimal(28,8) NULL,
	[Income76] decimal(28,8) NULL,
	[Income77] decimal(28,8) NULL,
	[Income78] decimal(28,8) NULL,
	[Income79] decimal(28,8) NULL,
	[Income80] decimal(28,8) NULL,
	[Income81] decimal(28,8) NULL,
	[Income82] decimal(28,8) NULL,
	[Income83] decimal(28,8) NULL,
	[Income84] decimal(28,8) NULL,
	[Income85] decimal(28,8) NULL,
	[Income86] decimal(28,8) NULL,
	[Income87] decimal(28,8) NULL,
	[Income88] decimal(28,8) NULL,
	[Income89] decimal(28,8) NULL,
	[Income90] decimal(28,8) NULL,
	[Income91] decimal(28,8) NULL,
	[Income92] decimal(28,8) NULL,
	[Income93] decimal(28,8) NULL,
	[Income94] decimal(28,8) NULL,
	[Income95] decimal(28,8) NULL,
	[Income96] decimal(28,8) NULL,
	[Income97] decimal(28,8) NULL,
	[Income98] decimal(28,8) NULL,
	[Income99] decimal(28,8) NULL,
	[Income100] decimal(28,8) NULL,
	[Income101] decimal(28,8) NULL,
	[Income102] decimal(28,8) NULL,
	[Income103] decimal(28,8) NULL,
	[Income104] decimal(28,8) NULL,
	[Income105] decimal(28,8) NULL,
	[Income106] decimal(28,8) NULL,
	[Income107] decimal(28,8) NULL,
	[Income108] decimal(28,8) NULL,
	[Income109] decimal(28,8) NULL,
	[Income110] decimal(28,8) NULL,
	[Income111] decimal(28,8) NULL,
	[Income112] decimal(28,8) NULL,
	[Income113] decimal(28,8) NULL,
	[Income114] decimal(28,8) NULL,
	[Income115] decimal(28,8) NULL,
	[Income116] decimal(28,8) NULL,
	[Income117] decimal(28,8) NULL,
	[Income118] decimal(28,8) NULL,
	[Income119] decimal(28,8) NULL,
	[Income120] decimal(28,8) NULL,
	[Income121] decimal(28,8) NULL,
	[Income122] decimal(28,8) NULL,
	[Income123] decimal(28,8) NULL,
	[Income124] decimal(28,8) NULL,
	[Income125] decimal(28,8) NULL,
	[Income126] decimal(28,8) NULL,
	[Income127] decimal(28,8) NULL,
	[Income128] decimal(28,8) NULL,
	[Income129] decimal(28,8) NULL,
	[Income130] decimal(28,8) NULL,
	[Income131] decimal(28,8) NULL,
	[Income132] decimal(28,8) NULL,
	[Income133] decimal(28,8) NULL,
	[Income134] decimal(28,8) NULL,
	[Income135] decimal(28,8) NULL,
	[Income136] decimal(28,8) NULL,
	[Income137] decimal(28,8) NULL,
	[Income138] decimal(28,8) NULL,
	[Income139] decimal(28,8) NULL,
	[Income140] decimal(28,8) NULL,
	[Income141] decimal(28,8) NULL,
	[Income142] decimal(28,8) NULL,
	[Income143] decimal(28,8) NULL,
	[Income144] decimal(28,8) NULL,
	[Income145] decimal(28,8) NULL,
	[Income146] decimal(28,8) NULL,
	[Income147] decimal(28,8) NULL,
	[Income148] decimal(28,8) NULL,
	[Income149] decimal(28,8) NULL,
	[Income150] decimal(28,8) NULL,
 CONSTRAINT [PK_HT340001_1] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

DECLARE @CustomerIndex INT 
SELECT @CustomerIndex = CustomerName FROM dbo.CustomerIndex 
----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
IF(@CustomerIndex= 50 OR @CustomerIndex= 115)
BEGIN
	
---- Bổ sung S21 -> S100 (MEIKO)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount21')
        ALTER TABLE HT340001_1 ADD SubAmount21 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount22')
        ALTER TABLE HT340001_1 ADD SubAmount22 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount23')
        ALTER TABLE HT340001_1 ADD SubAmount23 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount24')
        ALTER TABLE HT340001_1 ADD SubAmount24 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount25')
        ALTER TABLE HT340001_1 ADD SubAmount25 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount26')
        ALTER TABLE HT340001_1 ADD SubAmount26 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount27')
        ALTER TABLE HT340001_1 ADD SubAmount27 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount28')
        ALTER TABLE HT340001_1 ADD SubAmount28 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount29')
        ALTER TABLE HT340001_1 ADD SubAmount29 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount29')
        ALTER TABLE HT340001_1 ADD SubAmount29 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount30')
        ALTER TABLE HT340001_1 ADD SubAmount30 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount31')
        ALTER TABLE HT340001_1 ADD SubAmount31 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount32')
        ALTER TABLE HT340001_1 ADD SubAmount32 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount33')
        ALTER TABLE HT340001_1 ADD SubAmount33 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount34')
        ALTER TABLE HT340001_1 ADD SubAmount34 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount35')
        ALTER TABLE HT340001_1 ADD SubAmount35 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount36')
        ALTER TABLE HT340001_1 ADD SubAmount36 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount37')
        ALTER TABLE HT340001_1 ADD SubAmount37 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount38')
        ALTER TABLE HT340001_1 ADD SubAmount38 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount39')
        ALTER TABLE HT340001_1 ADD SubAmount39 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount40')
        ALTER TABLE HT340001_1 ADD SubAmount40 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount41')
        ALTER TABLE HT340001_1 ADD SubAmount41 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount42')
        ALTER TABLE HT340001_1 ADD SubAmount42 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount43')
        ALTER TABLE HT340001_1 ADD SubAmount43 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount44')
        ALTER TABLE HT340001_1 ADD SubAmount44 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount45')
        ALTER TABLE HT340001_1 ADD SubAmount45 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount46')
        ALTER TABLE HT340001_1 ADD SubAmount46 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount47')
        ALTER TABLE HT340001_1 ADD SubAmount47 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount48')
        ALTER TABLE HT340001_1 ADD SubAmount48 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount49')
        ALTER TABLE HT340001_1 ADD SubAmount49 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount50')
        ALTER TABLE HT340001_1 ADD SubAmount50 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount51')
        ALTER TABLE HT340001_1 ADD SubAmount51 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount52')
        ALTER TABLE HT340001_1 ADD SubAmount52 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount53')
        ALTER TABLE HT340001_1 ADD SubAmount53 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount54')
        ALTER TABLE HT340001_1 ADD SubAmount54 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount55')
        ALTER TABLE HT340001_1 ADD SubAmount55 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount56')
        ALTER TABLE HT340001_1 ADD SubAmount56 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount57')
        ALTER TABLE HT340001_1 ADD SubAmount57 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount58')
        ALTER TABLE HT340001_1 ADD SubAmount58 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount59')
        ALTER TABLE HT340001_1 ADD SubAmount59 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount60')
        ALTER TABLE HT340001_1 ADD SubAmount60 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount61')
        ALTER TABLE HT340001_1 ADD SubAmount61 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount62')
        ALTER TABLE HT340001_1 ADD SubAmount62 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount63')
        ALTER TABLE HT340001_1 ADD SubAmount63 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount64')
        ALTER TABLE HT340001_1 ADD SubAmount64 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount65')
        ALTER TABLE HT340001_1 ADD SubAmount65 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount66')
        ALTER TABLE HT340001_1 ADD SubAmount66 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount67')
        ALTER TABLE HT340001_1 ADD SubAmount67 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount68')
        ALTER TABLE HT340001_1 ADD SubAmount68 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount69')
        ALTER TABLE HT340001_1 ADD SubAmount69 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount70')
        ALTER TABLE HT340001_1 ADD SubAmount70 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount71')
        ALTER TABLE HT340001_1 ADD SubAmount71 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount72')
        ALTER TABLE HT340001_1 ADD SubAmount72 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount73')
        ALTER TABLE HT340001_1 ADD SubAmount73 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount74')
        ALTER TABLE HT340001_1 ADD SubAmount74 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount75')
        ALTER TABLE HT340001_1 ADD SubAmount75 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount76')
        ALTER TABLE HT340001_1 ADD SubAmount76 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount77')
        ALTER TABLE HT340001_1 ADD SubAmount77 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount78')
        ALTER TABLE HT340001_1 ADD SubAmount78 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount79')
        ALTER TABLE HT340001_1 ADD SubAmount79 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount80')
        ALTER TABLE HT340001_1 ADD SubAmount80 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount81')
        ALTER TABLE HT340001_1 ADD SubAmount81 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount82')
        ALTER TABLE HT340001_1 ADD SubAmount82 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount83')
        ALTER TABLE HT340001_1 ADD SubAmount83 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount84')
        ALTER TABLE HT340001_1 ADD SubAmount84 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount85')
        ALTER TABLE HT340001_1 ADD SubAmount85 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount86')
        ALTER TABLE HT340001_1 ADD SubAmount86 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount87')
        ALTER TABLE HT340001_1 ADD SubAmount87 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount88')
        ALTER TABLE HT340001_1 ADD SubAmount88 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount89')
        ALTER TABLE HT340001_1 ADD SubAmount89 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount90')
        ALTER TABLE HT340001_1 ADD SubAmount90 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount91')
        ALTER TABLE HT340001_1 ADD SubAmount91 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount92')
        ALTER TABLE HT340001_1 ADD SubAmount92 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount93')
        ALTER TABLE HT340001_1 ADD SubAmount93 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount94')
        ALTER TABLE HT340001_1 ADD SubAmount94 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount95')
        ALTER TABLE HT340001_1 ADD SubAmount95 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount96')
        ALTER TABLE HT340001_1 ADD SubAmount96 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount97')
        ALTER TABLE HT340001_1 ADD SubAmount97 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount98')
        ALTER TABLE HT340001_1 ADD SubAmount98 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount99')
        ALTER TABLE HT340001_1 ADD SubAmount99 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'SubAmount100')
        ALTER TABLE HT340001_1 ADD SubAmount100 DECIMAL(28,8) NULL
    END


---->>>>>>>>>Modified by Bảo Thy on 17/01/2017: Bổ sung I151 -> I200 (MEIKO)

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT340001_1' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income151')
        ALTER TABLE HT340001_1 ADD Income151 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income152')
        ALTER TABLE HT340001_1 ADD Income152 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income153')
        ALTER TABLE HT340001_1 ADD Income153 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income154')
        ALTER TABLE HT340001_1 ADD Income154 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income155')
        ALTER TABLE HT340001_1 ADD Income155 DECIMAL(28,8) NULL
 

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income156')
        ALTER TABLE HT340001_1 ADD Income156 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income157')
        ALTER TABLE HT340001_1 ADD Income157 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income158')
        ALTER TABLE HT340001_1 ADD Income158 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income159')
        ALTER TABLE HT340001_1 ADD Income159 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income160')
        ALTER TABLE HT340001_1 ADD Income160 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income161')
        ALTER TABLE HT340001_1 ADD Income161 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income162')
        ALTER TABLE HT340001_1 ADD Income162 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income163')
        ALTER TABLE HT340001_1 ADD Income163 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income164')
        ALTER TABLE HT340001_1 ADD Income164 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income165')
        ALTER TABLE HT340001_1 ADD Income165 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income166')
        ALTER TABLE HT340001_1 ADD Income166 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income167')
        ALTER TABLE HT340001_1 ADD Income167 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income168')
        ALTER TABLE HT340001_1 ADD Income168 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income169')
        ALTER TABLE HT340001_1 ADD Income169 DECIMAL(28,8) NULL
 

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income170')
        ALTER TABLE HT340001_1 ADD Income170 DECIMAL(28,8) NULL
 

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income171')
        ALTER TABLE HT340001_1 ADD Income171 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income172')
        ALTER TABLE HT340001_1 ADD Income172 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income173')
        ALTER TABLE HT340001_1 ADD Income173 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income174')
        ALTER TABLE HT340001_1 ADD Income174 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income175')
        ALTER TABLE HT340001_1 ADD Income175 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income176')
        ALTER TABLE HT340001_1 ADD Income176 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income177')
        ALTER TABLE HT340001_1 ADD Income177 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income178')
        ALTER TABLE HT340001_1 ADD Income178 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income179')
        ALTER TABLE HT340001_1 ADD Income179 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income180')
        ALTER TABLE HT340001_1 ADD Income180 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income181')
        ALTER TABLE HT340001_1 ADD Income181 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income182')
        ALTER TABLE HT340001_1 ADD Income182 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income183')
        ALTER TABLE HT340001_1 ADD Income183 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income184')
        ALTER TABLE HT340001_1 ADD Income184 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income185')
        ALTER TABLE HT340001_1 ADD Income185 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income186')
        ALTER TABLE HT340001_1 ADD Income186 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income187')
        ALTER TABLE HT340001_1 ADD Income187 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income188')
        ALTER TABLE HT340001_1 ADD Income188 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income189')
        ALTER TABLE HT340001_1 ADD Income189 DECIMAL(28,8) NULL
 

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income190')
        ALTER TABLE HT340001_1 ADD Income190 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income191')
        ALTER TABLE HT340001_1 ADD Income191 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income192')
        ALTER TABLE HT340001_1 ADD Income192 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income193')
        ALTER TABLE HT340001_1 ADD Income193 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income194')
        ALTER TABLE HT340001_1 ADD Income194 DECIMAL(28,8) NULL
 

        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income195')
        ALTER TABLE HT340001_1 ADD Income195 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income196')
        ALTER TABLE HT340001_1 ADD Income196 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income197')
        ALTER TABLE HT340001_1 ADD Income197 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income198')
        ALTER TABLE HT340001_1 ADD Income198 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income199')
        ALTER TABLE HT340001_1 ADD Income199 DECIMAL(28,8) NULL


        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT340001_1' AND col.name = 'Income200')
        ALTER TABLE HT340001_1 ADD Income200 DECIMAL(28,8) NULL

    END
END	