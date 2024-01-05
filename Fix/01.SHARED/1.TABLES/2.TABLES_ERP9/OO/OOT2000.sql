---- Create by Nguyen Hoang Bao Thy on 02/12/2015 8:37:04 AM
---- Bảng phân ca

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2000]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2000]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] UNIQUEIDENTIFIER NOT NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [D01] VARCHAR(50) NULL,
      [D02] VARCHAR(50) NULL,
      [D03] VARCHAR(50) NULL,
      [D04] VARCHAR(50) NULL,
      [D05] VARCHAR(50) NULL,
      [D06] VARCHAR(50) NULL,
      [D07] VARCHAR(50) NULL,
      [D08] VARCHAR(50) NULL,
      [D09] VARCHAR(50) NULL,
      [D10] VARCHAR(50) NULL,
      [D11] VARCHAR(50) NULL,
      [D12] VARCHAR(50) NULL,
      [D13] VARCHAR(50) NULL,
      [D14] VARCHAR(50) NULL,
      [D15] VARCHAR(50) NULL,
      [D16] VARCHAR(50) NULL,
      [D17] VARCHAR(50) NULL,
      [D18] VARCHAR(50) NULL,
      [D19] VARCHAR(50) NULL,
      [D20] VARCHAR(50) NULL,
      [D21] VARCHAR(50) NULL,
      [D22] VARCHAR(50) NULL,
      [D23] VARCHAR(50) NULL,
      [D24] VARCHAR(50) NULL,
      [D25] VARCHAR(50) NULL,
      [D26] VARCHAR(50) NULL,
      [D27] VARCHAR(50) NULL,
      [D28] VARCHAR(50) NULL,
      [D29] VARCHAR(50) NULL,
      [D30] VARCHAR(50) NULL,
      [D31] VARCHAR(50) NULL,
      [Note] NVARCHAR(250) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT2000] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT2000' AND col.name = 'Status')
        ALTER TABLE OOT2000 ADD Status TINYINT NULL

		--- Modify on 23/07/2018 by Bảo Anh: Bổ sung D32, D33
		If not exists (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		On col.id = tab.id where tab.name = 'OOT2000' and col.name = 'D32')
        Alter Table OOT2000 Add D32 [varchar](50) Null

		If not exists (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
		On col.id = tab.id where tab.name = 'OOT2000' and col.name = 'D33')
			Alter Table OOT2000 Add D33 [varchar](50) Null

		---- Modified on 03/01/2019 by Bảo Anh: Bổ sung cột số cấp phải duyệt và số cấp đã duyệt
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2000' AND col.name = 'ApproveLevel') 
			ALTER TABLE OOT2000 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2000' AND col.name = 'ApprovingLevel') 
			ALTER TABLE OOT2000 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)
	END

