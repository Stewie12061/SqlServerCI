-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified by Tiểu Mai on 19/01/2016: Add columns DepartmentID, TeamID (Angel).
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT1002]') AND type in (N'U'))
CREATE TABLE [dbo].[OT1002](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[AnaID] [nvarchar](50) NOT NULL,
	[AnaTypeID] [nvarchar](50) NOT NULL,
	[AnaName] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[Disabled] [tinyint] NOT NULL,
	[AnaNameE] [nvarchar](250) NULL,
 CONSTRAINT [PK_OT1002] PRIMARY KEY NONCLUSTERED 
(
	[AnaID] ASC,
	[AnaTypeID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--- Tiểu Mai, 19/01/2016: Add columns DepartmentID, TeamID
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT1002' AND col.name = 'DepartmentID')
        ALTER TABLE OT1002 ADD	DepartmentID NVARCHAR(50) NULL, 
								TeamID NVARCHAR(50) NULL

--- Modified by Tiểu Mai on 04/07/2017: Add columns OrdersArea
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT1002' AND col.name = 'OrdersArea')
        ALTER TABLE OT1002 ADD	OrdersArea DECIMAL(28,8) NULL

------- Modified by Kim Thư on 03/12/2018: Add columns Notes01 và Notes02 (Angel).
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT1002' AND col.name = 'Notes01')
        ALTER TABLE OT1002 ADD	Notes01 NVARCHAR(4000) NULL

IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OT1002' AND col.name = 'Notes02')
        ALTER TABLE OT1002 ADD	Notes02 NVARCHAR(4000) NULL