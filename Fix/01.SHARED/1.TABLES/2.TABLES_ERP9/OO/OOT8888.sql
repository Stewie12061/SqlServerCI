---- Create by Bảo Thy on 19/02/2016 10:25:39 AM
---- Danh sách báo cáo Approve Online

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT8888]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT8888]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [ReportID] NVARCHAR(50) NOT NULL,
      [ReportName] NVARCHAR(250) NULL,
      [Title] NVARCHAR(250) NULL,
      [GroupID] NVARCHAR(50) NOT NULL,
      [Type] TINYINT NOT NULL,
      [Disabled] TINYINT NOT NULL,
      [SQLstring] NVARCHAR(4000) NULL,
      [Orderby] NVARCHAR(1000) NULL,
      [Description] NVARCHAR(250) NULL,
      [DescriptionE] NVARCHAR(250) NULL,
      [TitleE] NVARCHAR(250) NULL,
      [ReportNameE] NVARCHAR(250) NULL,
      [IsDelete] TINYINT DEFAULT (0) NOT NULL
    CONSTRAINT [PK_OOT8888] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [ReportID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

----Add column----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT8888' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT8888' AND col.name = 'IsCommon')
        ALTER TABLE OOT8888 ADD IsCommon TINYINT NULL
    END
