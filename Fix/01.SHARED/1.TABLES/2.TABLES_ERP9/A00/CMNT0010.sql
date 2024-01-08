---- Create by Thái Đình Ly on 10/24/2019 10:46:32 AM
---- Thiết lập dữ liệu mặc định màn hình

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CMNT0010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CMNT0010](
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [varchar](25) NULL,
	[Analysis] [varchar](250) NULL,
	[ScreenID] [varchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](25) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [varchar](25) NULL,
 CONSTRAINT [PK_ST0080] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



