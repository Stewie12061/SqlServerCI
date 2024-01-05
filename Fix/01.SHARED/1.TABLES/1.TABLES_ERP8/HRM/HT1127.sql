-- <Summary>
---- Danh mục nhóm chức vụ
-- <History>
---- Create on 28/01/2019 by Bảo Anh
---- Modified on
---- <Example>

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1127]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1127](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[DutyGroupID] [varchar](50) NOT NULL,
	[DutyGroupName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL DEFAULT(0),
	[Orders] [int] NULL,
	[CreateUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NOT NULL,
	[LastModifyDate] [datetime] NULL,
	
 CONSTRAINT [PK_HT1127] PRIMARY KEY NONCLUSTERED 
(
	[DutyGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

---- Add giá trị default 
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1127_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1127] ADD  CONSTRAINT [DF_HT1127_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1127_LastModifyDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1127] ADD  CONSTRAINT [DF_HT1127_LastModifyDate]  DEFAULT (getdate()) FOR [LastModifyDate]
END