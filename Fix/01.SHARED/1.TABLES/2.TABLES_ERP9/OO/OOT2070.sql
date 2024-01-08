---- Create by Nguyen Hoang Bao Thy on 23/02/2016 1:30:43 PM
---- Đơn Xin Đổi Ca

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2070]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2070]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [ShiftID] VARCHAR(50) NOT NULL,
      [ChangeFromDate] DATETIME NOT NULL,
      [ChangeToDate] DATETIME NOT NULL,
      [Status] TINYINT DEFAULT (0) NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT2070] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified on 03/01/2019 by Bảo Anh: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2070' AND xtype = 'U')
BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2070' AND col.name = 'ApproveLevel') 
			ALTER TABLE OOT2070 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2070' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OOT2070 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)
END