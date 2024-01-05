---- Create by Nguyễn Hoàng Bảo Thy on 05/08/2016 4:54:27 PM
---- Lưu danh sách các đơn đang được duyệt tại OOF2050

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2052]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2052]
     (
      [DivisionID] VARCHAR(50) NOT NULL,
      [APKMaster] VARCHAR(50) NOT NULL,
      [APK] VARCHAR(50) NOT NULL,
      [Type] VARCHAR(50) NULL,
      [Level] INT DEFAULT (0) NULL,
      [ApprovingLevel] TINYINT DEFAULT (0) NULL,
      [AppoveLevel] TINYINT DEFAULT (0) NULL,
      [UserID] VARCHAR(50) NULL
    CONSTRAINT [PK_OOT2052] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [APKMaster],
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified on 02/01/2019 by Bảo Anh: Bổ sung cột APKDetail là APK của các bảng nghiệp vụ
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2052' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'OOT2052' AND col.name = 'APKDetail') 
			ALTER TABLE OOT2052 ADD APKDetail UNIQUEIDENTIFIER NULL
END
