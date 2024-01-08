---- Create by Phan thanh hoàng vũ on 3/17/2017 1:20:32 PM
---- Mối liên hệ giữa nhóm người nhân và người nhận

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT10301_REL]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT10301_REL]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [GroupReceiverID] VARCHAR(50) NOT NULL,
  [RelatedToID] VARCHAR(50) NOT NULL,
  [RelatedToTypeID_REL] INT NOT NULL
CONSTRAINT [PK_CRMT10301_REL] PRIMARY KEY CLUSTERED
(
  [GroupReceiverID],
  [RelatedToID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END