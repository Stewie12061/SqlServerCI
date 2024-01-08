IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[DRT2011]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[DRT2011]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [ContractNo] VARCHAR(50) NOT NULL,
      [AddressID] VARCHAR(50) NULL,
      [Address] NVARCHAR(500) NULL,
      [Ward] NVARCHAR(250) NULL,
      [District] NVARCHAR(250) NULL,
      [City] NVARCHAR(250) NULL,
      [Note] NVARCHAR(2000) NULL
    CONSTRAINT [PK_DRT2011] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects obj WHERE obj.name='DRT2011' AND obj.xtype='U')
BEGIN
	IF NOT EXISTS ( SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects obj ON obj.id = col.id
	                WHERE obj.name='DRT2011' AND col.name='IsSend')
	                BEGIN
	                	ALTER TABLE DRT2011 ADD IsSend TINYINT NULL
	                END
END