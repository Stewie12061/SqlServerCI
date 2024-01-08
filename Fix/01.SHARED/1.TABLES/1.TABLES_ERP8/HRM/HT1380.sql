-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Cam Loan
---- Modified on 30/08/2013 by Bảo Anh: Bổ sung phân loại mã tự động cho quyết định thôi việc
---- Modify on 30/09/2014 by Bảo Anh: Bổ sung thông tin tạm nghỉ
---- Modify on 17/08/2016 by Bảo Thy: Bổ sung 20 tham số
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1380]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1380](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DecidingNo] [nvarchar](50) NOT NULL,
	[DecidingDate] [datetime] NULL,
	[DecidingPerson] [nvarchar](50) NULL,
	[DecidingPersonDuty] [nvarchar](250) NULL,
	[Proposer] [nvarchar](100) NULL,
	[ProposerDuty] [nvarchar](250) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[DutyName] [nvarchar](250) NULL,
	[WorkDate] [datetime] NULL,
	[LeaveDate] [datetime] NOT NULL,
	[QuitJobID] [nvarchar](50) NOT NULL,
	[Allowance] [nvarchar](50) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_HT1380] PRIMARY KEY CLUSTERED 
(
	[DecidingNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1380_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1380] ADD  CONSTRAINT [DF_HT1380_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1380_LastModifyDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1380] ADD  CONSTRAINT [DF_HT1380_LastModifyDate]  DEFAULT (getdate()) FOR [LastModifyDate]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT1380' and xtype ='U') 
Begin          
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1380'  and col.name = 'S1')
           Alter Table  HT1380 Add S1 nvarchar(50) Null           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1380'  and col.name = 'S2')
           Alter Table  HT1380 Add S2 nvarchar(50) Null           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1380'  and col.name = 'S3')
           Alter Table  HT1380 Add S3 nvarchar(50) Null
END
IF EXISTS (SELECT * FROM sysobjects WHERE NAME='HT1380' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1380' AND col.name='Subsidies')
	ALTER TABLE HT1380 ADD Subsidies NVARCHAR (500) NULL	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1380' AND col.name='IsBreaking')
	ALTER TABLE HT1380 ADD IsBreaking tinyint NULL default(0)	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='HT1380' AND col.name='LeaveToDate')
	ALTER TABLE HT1380 ADD LeaveToDate Datetime NULL
END



IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1380' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter01')
        ALTER TABLE HT1380 ADD Parameter01 NVARCHAR(250) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter02')
        ALTER TABLE HT1380 ADD Parameter02 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter03')
        ALTER TABLE HT1380 ADD Parameter03 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter04')
        ALTER TABLE HT1380 ADD Parameter04 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter05')
        ALTER TABLE HT1380 ADD Parameter05 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter06')
        ALTER TABLE HT1380 ADD Parameter06 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter07')
        ALTER TABLE HT1380 ADD Parameter07 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter08')
        ALTER TABLE HT1380 ADD Parameter08 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter09')
        ALTER TABLE HT1380 ADD Parameter09 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter10')
        ALTER TABLE HT1380 ADD Parameter10 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter11')
        ALTER TABLE HT1380 ADD Parameter11 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter12')
        ALTER TABLE HT1380 ADD Parameter12 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter13')
        ALTER TABLE HT1380 ADD Parameter13 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter14')
        ALTER TABLE HT1380 ADD Parameter14 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter15')
        ALTER TABLE HT1380 ADD Parameter15 NVARCHAR(250) NULL
    
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter16')
        ALTER TABLE HT1380 ADD Parameter16 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter17')
        ALTER TABLE HT1380 ADD Parameter17 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter18')
        ALTER TABLE HT1380 ADD Parameter18 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter19')
        ALTER TABLE HT1380 ADD Parameter19 NVARCHAR(250) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'Parameter20')
        ALTER TABLE HT1380 ADD Parameter20 NVARCHAR(250) NULL
    END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1380' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1380' AND col.name = 'IsFired')
        ALTER TABLE HT1380 ADD IsFired TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT1380' AND col.name='TeamID')
		ALTER TABLE HT1380 ADD TeamID VARCHAR(50) NULL
    END