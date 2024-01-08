﻿---- Create by Cao Thị Phượng on 3/3/2017 9:39:37 AM
---- Ghi chú và đối tượng liên quan

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT90031_REL]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT90031_REL]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] Varchar(50) not null,
  [NotesID] INT NOT NULL,
  [RelatedToTypeID_REL] INT NOT NULL,
  [RelatedToID] VARCHAR(50) NOT NULL
CONSTRAINT [PK_CRMT90031_REL] PRIMARY KEY CLUSTERED
(
  [NotesID], 
  [RelatedToID],
  [RelatedToTypeID_REL]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END