-- <Summary>
---- File đính kèm cho hợp đồng SIKICO.
-- <History>
---- Create on 12/10/2022 by Văn Tài

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0159]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0159]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NOT NULL,
    [DivisionID] VARCHAR(50) NOT NULL,
	[Orders] TINYINT NULL,
	[FileName] NVARCHAR(100) NOT NULL,
	[File] XML NOT NULL,
	[FileSize] DECIMAL(28, 2) NULL DEFAULT(0),
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_CT0159] PRIMARY KEY NONCLUSTERED 
	(
		[DivisionID] ASC,
		[APK] ASC
    ) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END


