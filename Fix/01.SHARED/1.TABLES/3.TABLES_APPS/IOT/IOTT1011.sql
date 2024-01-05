---- Create by Đoàn Duy on 29/09/2022 15:13:42 PM
---- Lưu AccessToken sau khi Account linking với google

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[IOTT1011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[IOTT1011](
	[APK] [uniqueidentifier] NOT NULL DEFAULT (NEWID()),
	[ClientDomain] [nvarchar](50) NOT NULL,
	[AccessToken] [nvarchar](250) NOT NULL,
	[IOTHost] [nvarchar](250) NOT NULL,
	[CreateDate] DATETIME NULL,
	[ExpireDate] DATETIME NULL
 CONSTRAINT [PK_IOTT1011] PRIMARY KEY CLUSTERED 
(
	[ClientDomain],[AccessToken]
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
