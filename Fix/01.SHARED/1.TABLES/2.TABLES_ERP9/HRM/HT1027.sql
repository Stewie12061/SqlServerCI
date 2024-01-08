-- <Summary>
---- Danh mục phép thâm niên
-- <History>
---- Created by Tiểu Mai on 05/12/2016
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1027]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1027](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[SeniorityID] [nvarchar](50) NOT NULL,
	[DescriptionID] [nvarchar](250) NULL,	
	[Disabled] [tinyint] DEFAULT (0) NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_HT1027] PRIMARY KEY NONCLUSTERED 
(	
	[DivisionID],
	[SeniorityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
