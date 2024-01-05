---- Create by Khâu Vĩnh Tâm on 06/08/2019 09:10:00 AM
---- Người tham gia và người theo dõi dự án

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2103]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2103]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [RelatedToID] VARCHAR(50) NULL,
  [UserID] VARCHAR(50) NULL,
  [TypeID] INT NULL,
  [RelatedToTypeID] INT NULL
CONSTRAINT [PK_OOT2103] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END