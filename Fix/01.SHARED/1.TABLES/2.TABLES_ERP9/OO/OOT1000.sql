---- Create by Nguyen Hoang Bao Thy on 26/11/2015 10:45:44 AM
---- Danh Mục Loại Phép

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1000]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT1000]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NULL,
      [AbsentTypeID] VARCHAR(50) NOT NULL,
      [Description] NVARCHAR(250) NOT NULL,
      [DescriptionE] NVARCHAR(250) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [TypeID] VARCHAR(50) NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_OOT1000] PRIMARY KEY CLUSTERED
      (
      [APK],
      [AbsentTypeID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
--Bổ sung biến isDefault không được sửa hoặc xóa
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME ='OOT1000' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col
					INNER JOIN sysobjects obj ON obj.id=col.id
	               WHERE col.name='IsDefault'
	               AND obj.name='OOT1000' AND obj.xtype='U')
				ALTER TABLE OOT1000 ADD IsDefault TINYINT NULL 

END 

--Modified on 20/06/2016 by Bảo Thy: Bổ sung ca làm việc ShiftID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT1000' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT1000' AND col.name = 'ShiftID')
        ALTER TABLE OOT1000 ADD ShiftID VARCHAR(50) NULL
    END

--Modified on 28/06/2017 by Phương Thảo: Bổ sung check phân biệt phép đi trễ về sớm và quy định
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT1000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT1000' AND col.name = 'IsDTVS') 
   ALTER TABLE OOT1000 ADD IsDTVS INT NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT1000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT1000' AND col.name = 'RestrictID') 
   ALTER TABLE OOT1000 ADD RestrictID NVARCHAR(50) NULL 
END

--Modified on 31/01/2019 by Bảo Anh: Bổ sung check phân biệt phép nghỉ bệnh
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT1000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT1000' AND col.name = 'IsSickLeave') 
   ALTER TABLE OOT1000 ADD IsSickLeave TINYINT NULL DEFAULT(0)

    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OOT1000' AND col.name = 'IsRegime') 
   ALTER TABLE OOT1000 ADD IsRegime TINYINT NULL DEFAULT(0)
END
