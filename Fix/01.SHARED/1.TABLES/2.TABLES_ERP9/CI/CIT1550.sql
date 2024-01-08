-- <Summary> Danh mục giá vốn dự kiến (Master)
-- <History>
---- Create on 15/06/2023 by Nhật Thanh
---- Modified on ... by ...
---- <Example>
-- DROP TABLE CIT1550
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1550]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CIT1550]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [ID] NVARCHAR(50) NOT NULL, 
	  [Description] NVARCHAR(250) NOT NULL,
      [FromDate] DATETIME NOT NULL,
      [ToDate] DATETIME NOT NULL,
      [IsDisabled] TINYINT DEFAULT (0) NOT NULL,
      [IsCommon] TINYINT DEFAULT (0) NOT NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL
    CONSTRAINT [PK_CIT1550] PRIMARY KEY CLUSTERED
      (
		[ID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END