-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lam
---- Modified by Tiểu Mai on 10/03/2016: Add columns IsConfirm01, IsConfirm02, ConfDescription01, ConfDescription02, StatusRecruit
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1411]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1411](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[RecruitTimeID] [nvarchar](50) NULL,
	[RecruitDetail] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[DutyID] [nvarchar](50) NULL,
	[NoOfRecruit] [decimal](28, 8) NULL,
	[NoOfMale] [decimal](28, 8) NULL,
	[NoOfApplicant] [decimal](28, 8) NULL,
	[NoOfRecruited] [decimal](28, 8) NULL,
	[NoOfProbation] [decimal](28, 8) NULL,
	CONSTRAINT [PK_HT1411] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Add Columns by Tieu Mai on 10/03/2016
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT1411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT1411' AND col.name='IsConfirm01')
		ALTER TABLE HT1411 ADD	IsConfirm01 INT DEFAULT(0) NULL,
								ConfDescription01 NVARCHAR(250) NULL,
								IsConfirm02 INT DEFAULT(0) NULL,
								ConfDescription02 NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1411' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1411' AND col.name = 'StatusRecruit')
        ALTER TABLE HT1411 ADD	StatusRecruit TINYINT DEFAULT(0) NOT NULL,
								[ConfirmUserID] [nvarchar](50) NULL,
								[ConfirmDate] [datetime] NULL
    END	
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1411' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1411' AND col.name = 'Parameter01')
        ALTER TABLE HT1411 ADD	Parameter01 NVARCHAR(200) NULL,
								Parameter02 NVARCHAR(200) NULL,
								Parameter03 NVARCHAR(200) NULL,
								Parameter04 NVARCHAR(200) NULL,
								Parameter05 NVARCHAR(200) NULL,
								Parameter06 NVARCHAR(200) NULL,
								Parameter07 NVARCHAR(200) NULL,
								Parameter08 NVARCHAR(200) NULL,
								Parameter09 NVARCHAR(200) NULL,
								Parameter10 NVARCHAR(200) NULL,
								Parameter11 NVARCHAR(200) NULL,
								Parameter12 NVARCHAR(200) NULL,
								Parameter13 NVARCHAR(200) NULL,
								Parameter14 NVARCHAR(200) NULL,
								Parameter15 NVARCHAR(200) NULL,
								Parameter16 NVARCHAR(200) NULL,
								Parameter17 NVARCHAR(200) NULL,
								Parameter18 NVARCHAR(200) NULL,
								Parameter19 NVARCHAR(200) NULL,
								Parameter20 NVARCHAR(200) NULL
								
    END	    	
