-- <Summary>
---- 
-- <History>
---- Create on 06/08/2021 by Lê Hoàng
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1407_DT]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1407_DT](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TimeRecorderID] [nvarchar](50) NOT NULL,
	[AbsentCardID] [nvarchar](50) NOT NULL,
	[FingerIndex] [int] NULL,
	[FingerTempData] [varchar](max) NULL,
	[Flag] [int] NULL,
	[FingerTempLength] [int] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_HT1407_DT] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


