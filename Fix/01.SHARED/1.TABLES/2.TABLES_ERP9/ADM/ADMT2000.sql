---- Create by Khâu Vĩnh Tâm on 3/30/2020 9:04:49 AM
---- Quản lý màn hình/bộ màn hình

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[ADMT2000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[ADMT2000]
(
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NULL,
	[ModuleID] [varchar](50) NULL,
	[ScreenID] [varchar](50) NULL,
	[ScreenName] [nvarchar](250) NULL,
	[ScreenType] [int] NULL,
	[TypeInput] [int] NULL,
	[Parent] [varchar](250) NULL,
	[MenuText] [varchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,

CONSTRAINT [PK_ADMT2000] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END