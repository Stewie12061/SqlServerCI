-- <Summary>
---- 
-- <History>
---- Create on 27/12/2013 by Lê Thị Thu Hiền
---- Modified on 27/12/2013 by Le Thi Thu Hien: Do fix đã chép trước đó sai cột nên add lại cột và delete cột cũ
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0048]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0048]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TitleID] VARCHAR(50) NOT NULL,
      [SalaryLevel] VARCHAR(50) NOT NULL,
      [SalaryCoefficient] DECIMAL(28,8) DEFAULT (0) NULL,
      [DetailNotes] NVARCHAR(1000) NULL
    CONSTRAINT [PK_HT0048] PRIMARY KEY CLUSTERED
      (
      [TitleID],
      [SalaryLevel]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT0048' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT0048'  and col.name = 'DetailNotes')
           Alter Table  HT0048 Add DetailNotes nvarchar(1000) Null
End 
---- Drop Columns
If Exists (Select * From sysobjects Where name = 'HT0048' and xtype ='U') 
BEGIN
IF EXISTS (SELECT * FROM SYSCOLUMNS COL INNER JOIN SYSOBJECTS TAB 
ON col.id = tab.id where tab.name =   'HT0048'  and col.name = 'Notes')
ALTER TABLE HT0048 DROP COLUMN Notes
END


--- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C01')
        ALTER TABLE HT0048 ADD C01 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C02')
        ALTER TABLE HT0048 ADD C02 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C03')
        ALTER TABLE HT0048 ADD C03 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C04')
        ALTER TABLE HT0048 ADD C04 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C05')
        ALTER TABLE HT0048 ADD C05 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C06')
        ALTER TABLE HT0048 ADD C06 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C07')
        ALTER TABLE HT0048 ADD C07 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C08')
        ALTER TABLE HT0048 ADD C08 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C09')
        ALTER TABLE HT0048 ADD C09 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C10')
        ALTER TABLE HT0048 ADD C10 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C11')
        ALTER TABLE HT0048 ADD C11 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C12')
        ALTER TABLE HT0048 ADD C12 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C13')
        ALTER TABLE HT0048 ADD C13 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C14')
        ALTER TABLE HT0048 ADD C14 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C15')
        ALTER TABLE HT0048 ADD C15 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C16')
        ALTER TABLE HT0048 ADD C16 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C17')
        ALTER TABLE HT0048 ADD C17 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C18')
        ALTER TABLE HT0048 ADD C18 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C19')
        ALTER TABLE HT0048 ADD C19 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C20')
        ALTER TABLE HT0048 ADD C20 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C21')
        ALTER TABLE HT0048 ADD C21 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C22')
        ALTER TABLE HT0048 ADD C22 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C23')
        ALTER TABLE HT0048 ADD C23 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C24')
        ALTER TABLE HT0048 ADD C24 DECIMAL(28,8) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0048' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT0048' AND col.name = 'C25')
        ALTER TABLE HT0048 ADD C25 DECIMAL(28,8) NULL
    END