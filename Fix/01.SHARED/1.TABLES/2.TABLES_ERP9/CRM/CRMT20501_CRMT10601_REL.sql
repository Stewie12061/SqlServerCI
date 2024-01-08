---- Create by Phan thanh hoàng vũ on 3/10/2017 3:36:32 PM
---- Mối quan hệ giữa cơ hội và loại hình bán hàng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT20501_CRMT10601_REL]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT20501_CRMT10601_REL]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [OpportunityID] VARCHAR(50) NOT NULL,
  [SalesTagID] VARCHAR(50) NOT NULL
CONSTRAINT [PK_CRMT20501_CRMT10601_REL] PRIMARY KEY CLUSTERED
(
  [OpportunityID],
  [SalesTagID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END