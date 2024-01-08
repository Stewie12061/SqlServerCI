---- Create by Đặng Thị Tiểu Mai on 29/02/2016 4:34:59 PM
---- Danh sách quá trình hoạt động phát sinh hàng ngày (Angel)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT6030]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CT6030]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherID] NVARCHAR(50) NOT NULL,
      [VoucherNo] NVARCHAR(50) NULL,
      [VoucherTypeID] NVARCHAR(50),
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
      [Description] NVARCHAR(250) NULL,
      [VoucherDate] DATETIME NULL,
      [EmployeeID] NVARCHAR(50) NULL,
      [MTC01] NVARCHAR(100) NULL,
      [MTC02] NVARCHAR(100) NULL,
      [CreateDate] DATETIME NULL,
	  [CreateUserID] NVARCHAR(50) NULL,
	  [LastModifyDate] DATETIME NULL,
	  [LastModifyUserID] NVARCHAR(50) NULL
    CONSTRAINT [PK_CT6030] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified by Tiểu Mai on 10/12/2016: Bổ sung 20 tham số master
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='CT6030' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter01')
		ALTER TABLE CT6030 ADD Parameter01 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter02')
		ALTER TABLE CT6030 ADD Parameter02 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter03')
		ALTER TABLE CT6030 ADD Parameter03 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter04')
		ALTER TABLE CT6030 ADD Parameter04 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter05')
		ALTER TABLE CT6030 ADD Parameter05 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter06')
		ALTER TABLE CT6030 ADD Parameter06 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter07')
		ALTER TABLE CT6030 ADD Parameter07 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter08')
		ALTER TABLE CT6030 ADD Parameter08 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter09')
		ALTER TABLE CT6030 ADD Parameter09 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter10')
		ALTER TABLE CT6030 ADD Parameter10 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter11')
		ALTER TABLE CT6030 ADD Parameter11 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter12')
		ALTER TABLE CT6030 ADD Parameter12 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter13')
		ALTER TABLE CT6030 ADD Parameter13 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter14')
		ALTER TABLE CT6030 ADD Parameter14 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter15')
		ALTER TABLE CT6030 ADD Parameter15 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter16')
		ALTER TABLE CT6030 ADD Parameter16 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter17')
		ALTER TABLE CT6030 ADD Parameter17 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter18')
		ALTER TABLE CT6030 ADD Parameter18 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter19')
		ALTER TABLE CT6030 ADD Parameter19 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='CT6030' AND col.name='Parameter20')
		ALTER TABLE CT6030 ADD Parameter20 NVARCHAR(250) NULL
END 


