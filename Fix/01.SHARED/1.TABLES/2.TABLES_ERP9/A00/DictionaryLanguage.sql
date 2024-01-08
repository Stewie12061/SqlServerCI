---- Create by tan loc on 24/03/2022 12:54:11 PM
---- DictionaryLanguage - Bảng từ điển ngôn ngữ
---- Dùng để chạy fix update ngôn ngữ từ bảng từ điển [DictionaryLanguage] sang bảng A00001

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[DictionaryLanguage]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[DictionaryLanguage]
(
  [ID] [int] IDENTITY(1,1) NOT NULL,
  [vi-VN] NVARCHAR(MAX) NULL,
  [en-US] NVARCHAR(MAX) NULL,
  [zh-CN] NVARCHAR(MAX) NULL,
CONSTRAINT [PK_DictionaryLanguage] PRIMARY KEY CLUSTERED
(
  [ID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 08/11/2019 - Tấn Lộc: Bổ sung cột TypeOfLanguage: A00001 - Ngôn ngữ màn hình, A00002 - Ngôn ngữ Message --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'DictionaryLanguage' AND col.name = 'TypeOfLanguage')
BEGIN
	ALTER TABLE DictionaryLanguage ADD TypeOfLanguage NVARCHAR(250) NULL
END