-- <Summary>
---- 
-- <History>
---- Create on 01/03/2023 by Thành Sang
---- Modified on ... by ...
---- <Example>
--drop table HT4537
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT4537]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].HT4537
     (
	  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [CodeMaster] VARCHAR(50) NULL,
      [OrderNo] INT NULL,
      [ID] VARCHAR(50) NOT NULL,
      [Description] NVARCHAR(250) NULL,
      [DescriptionE] NVARCHAR(250) NULL,
	  [CodeMasterName] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL,
	 CONSTRAINT [PK_HT4537] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


