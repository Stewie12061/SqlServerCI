-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 15/03/2016 by Tiểu Mai: Bổ sung trường Từ tháng, Đến tháng, Duyệt
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1406]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1406](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[RetributionID] [nvarchar](50) NOT NULL,
	[DepartmentID] [nvarchar](50) NOT NULL,
	[TeamID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[IsReward] [tinyint] NOT NULL,
	[DecisionNo] [nvarchar](50) NULL,
	[RetributeDate] [datetime] NULL,
	[Rank] [nvarchar](250) NULL,
	[SuggestedPerson] [nvarchar](250) NULL,
	[Reason] [nvarchar](250) NULL,
	[Form] [nvarchar](250) NULL,
	[Value] [decimal](28, 8) NULL,
	[DutyID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_HT1406] PRIMARY KEY NONCLUSTERED 
(
	[RetributionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


----- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1406' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1406' AND col.name = 'FormID')
        ALTER TABLE HT1406 ADD FormID NVARCHAR(50) NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1406' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1406' AND col.name = 'Times')
        ALTER TABLE HT1406 ADD Times INT NULL
    END

--- Add columns by Tieu Mai on 15/03/2016    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1406' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1406' AND col.name = 'FromMonth')
        ALTER TABLE HT1406 ADD  FromMonth INT NULL,
								FromYear INT NULL,
								ToMonth INT NULL,
								ToYear INT NULL
    END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1406' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1406' AND col.name = 'IsConfirm')
        ALTER TABLE HT1406 ADD  IsConfirm TINYINT DEFAULT(0),
								ConfDescription NVARCHAR(250) NULL

		--- Modified on 11/01/2019 by Bảo Anh: Bổ sung ngày nhận thưởng
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1406' AND col.name = 'AwardDate')
        ALTER TABLE HT1406 ADD AwardDate DATETIME NULL
    END        
   