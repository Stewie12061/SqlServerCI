-- <Summary>
---- 
-- <History>
---- Create on 23/08/2019 by Kiều Nga
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT1040]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT1040](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TaskID] [nvarchar](50) NOT NULL,
	[TaskName] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
 CONSTRAINT [PK_SOT1040] PRIMARY KEY NONCLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

