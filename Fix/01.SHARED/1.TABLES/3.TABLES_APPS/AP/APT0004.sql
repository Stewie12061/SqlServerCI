-- <Summary>
---- Bảng chứa dữ liệu lập kế hoạch viếng thăm (APP - MOBILE)
-- <History>
---- Create on 09/06/2017 by Hải Long
---- Modified on
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APT0004]') AND type in (N'U'))
CREATE TABLE [dbo].[APT0004](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,	
	[ScheduleDate] DATE NOT NULL,		
	[UserID] [nvarchar](50) NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[Notes] [nvarchar](4000) NULL,
	[CreateUserID] [nvarchar](50) NULL, 
	[CreateDate] [datetime] NULL
 CONSTRAINT [PK_APT0004] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,	
	[ScheduleDate] ASC,
	[UserID] ASC,
	[ObjectID] ASC	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
