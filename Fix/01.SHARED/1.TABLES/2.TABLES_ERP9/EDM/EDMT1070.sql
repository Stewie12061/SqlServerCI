﻿---- Create by Hồng Thảo on 25/08/2018
---- Danh mục điều tra tâm lý 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT1070]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT1070]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [PsychologizeType] VARCHAR(50) NOT NULL,
  [PsychologizeID] VARCHAR(50) NOT NULL,
  [PsychologizeName] NVARCHAR(250) NULL,
  [PsychologizeGroup] VARCHAR(50) NULL,
  [Orders] VARCHAR(50) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,	
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_EDMT1070] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [PsychologizeID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



