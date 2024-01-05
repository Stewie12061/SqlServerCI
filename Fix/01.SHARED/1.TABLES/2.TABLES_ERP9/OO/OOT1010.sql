---- Create by Nguyen Hoang Bao Thy on 26/11/2015 9:16:38 AM
---- Danh Mục Loại Bất Thường

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT1010]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT1010]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NULL,
      [UnusualTypeID] VARCHAR(50) NOT NULL,
      [Description] NVARCHAR(250) NOT NULL,
      [DescriptionE] NVARCHAR(250) NOT NULL,
      [HandleMethodID] NVARCHAR(250) NOT NULL,
      [Note] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NULL,
      [IsDefault] TINYINT DEFAULT (0) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_OOT1010] PRIMARY KEY CLUSTERED
      (
      [APK],
      [UnusualTypeID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


-- Add column
IF EXISTS ( SELECT TOP 1 1 FROM sysobjects WHERE NAME='OOT1010' AND xtype='U')
BEGIN
	 IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col 
					INNER JOIN sysobjects obj ON obj.id = col.id
	                WHERE col.name='IsDefault'
	                AND obj.name='OOT1010')
	                BEGIN
	                	ALTER TABLE OOT1010 ADD  IsDefault TINYINT NULL 
	                END
	              
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT1010' AND xtype = 'U')
    BEGIN
        IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT1010' AND col.name = 'HandleMethodID')
        ALTER TABLE OOT1010 ALTER COLUMN HandleMethodID NVARCHAR(250) NULL

		--- Modified on 30/08/2018 by Bảo Anh: Sửa lại không bắt buộc nhập DescriptionE
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'OOT1010' AND col.name = 'DescriptionE')
        ALTER TABLE OOT1010 ALTER COLUMN DescriptionE NVARCHAR(250) NULL
    END