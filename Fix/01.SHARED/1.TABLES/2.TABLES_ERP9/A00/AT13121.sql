---- Create by Trần Đình Hoà on 14/08/2020 
---- Tạo bảng để bỏ qua check detail khi load đến bảng này, không sử dụng cho mục đích khác.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT13121]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT13121]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
CONSTRAINT [PK_AT13121] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END












