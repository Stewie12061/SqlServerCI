-- <Summary>
---- 
-- <History>
---- Create on 18/07/2019 by Kiều Nga: Định mức Quota theo nhân viên (Master)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2000]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2000](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[Year] [int] NULL,
	[EmployeeID] [varchar](50) NULL,
	[TotalQuota] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
	
 CONSTRAINT [PK_SOT2000] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2000' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2000' AND col.name = 'Beginning')
    ALTER TABLE SOT2000 ADD Beginning decimal (28, 8)
END

IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SOT2001_Beginning]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SOT2000] ADD  CONSTRAINT [DF_SOT2001_Beginning]  DEFAULT ((0)) FOR [Beginning]
END