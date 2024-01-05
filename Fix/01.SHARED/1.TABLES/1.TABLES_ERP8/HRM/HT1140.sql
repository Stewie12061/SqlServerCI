-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1140]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1140](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[MethodID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_HT1140] PRIMARY KEY CLUSTERED 
(
	[MethodID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1140_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1140] ADD  CONSTRAINT [DF_HT1140_Disabled]  DEFAULT ((0)) FOR [Disabled]
END


--- Modified on 26/03/2018 by Bảo Anh: Bổ sung Phòng ban, Tổ nhóm
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1140]') AND type in (N'U'))
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 
					FROM syscolumns col INNER JOIN sysobjects tab 
					ON col.id = tab.id WHERE tab.name = 'HT1140' AND col.name = 'TeamID')
	BEGIN    
		ALTER TABLE HT1140 ADD TeamID NVARCHAR(50) NULL
	END

	IF NOT EXISTS (SELECT TOP 1 1 
				FROM syscolumns col INNER JOIN sysobjects tab 
				ON col.id = tab.id WHERE tab.name = 'HT1140' AND col.name = 'DepartmentID')
	BEGIN     
		ALTER TABLE HT1140 ADD DepartmentID NVARCHAR(50) NULL   
	END
END