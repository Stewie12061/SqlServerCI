-- <Summary>
---- Danh mục trình độ chuyên môn
-- <History>
---- Create on 17/01/2019 by Bảo Anh
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT0536]') AND type in (N'U'))
CREATE TABLE [dbo].[HT0536](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[SpecialID] [varchar](50) NOT NULL,
	[SpecialName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL DEFAULT(0),
	[CreateUserID] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_HT0536] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[SpecialID] ASC
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT0536_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0536] ADD  CONSTRAINT [DF_HT0536_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT0536_LastModifyDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0536] ADD  CONSTRAINT [DF_HT0536_LastModifyDate]  DEFAULT (getdate()) FOR [LastModifyDate]
END
