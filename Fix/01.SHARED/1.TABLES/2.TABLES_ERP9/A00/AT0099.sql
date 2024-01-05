-- <Summary> Đổ nguồn Combobox, dữ liệu master data (Thay thế dùng view chết load combo bên ERP8)
-- <History>
---- Create on 12/05/2016 by Phan thanh hoàng Vũ
---- Modified on ... by ...
---- <Example>

 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0099]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].AT0099
     (
      [CodeMaster] VARCHAR(50) NOT NULL,
      [OrderNo] INT NULL,
      [ID] VARCHAR(50) NOT NULL,
      [Description] NVARCHAR(250) NULL,
      [DescriptionE] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_AT0099] PRIMARY KEY CLUSTERED
      (
      [CodeMaster],
      [ID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

-------------------- 13/08/2020 - Tấn Lộc: Bổ sung cột ID1 --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0099' AND col.name = 'ID1')
BEGIN
	ALTER TABLE AT0099 ADD ID1 VARCHAR(50) NULL
END

---------------- 28/07/2021 - Tấn Lộc: Bổ sung cột CodeMasterName ----------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0099' AND col.name = 'CodeMasterName')
BEGIN
	ALTER TABLE AT0099 ADD CodeMasterName NVARCHAR(MAX) NULL
END