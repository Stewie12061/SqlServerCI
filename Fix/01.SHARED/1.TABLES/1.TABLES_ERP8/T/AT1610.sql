-- <Summary>
---- Master phương pháp phân bổ nhiều cấp (PACIFIC)
-- <History>
---- Create on 10/04/2017 by Hải Long
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1610]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1610](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[AllocationID] [nvarchar](50) NOT NULL,
	[AllocationType] [tinyint] NULL,
	[AllocationLevelID] [tinyint] NULL,
	[Description] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,		
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,	
	[LastModifyUserID] [nvarchar](50) NULL
 CONSTRAINT [PK_AT1610] PRIMARY KEY NONCLUSTERED 
(
	[AllocationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
