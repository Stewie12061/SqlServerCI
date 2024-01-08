-- <Summary>
---- Danh mục ô vựa
-- <History>
---- Create on 06/12/2018 by Hồng Thảo 

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0416]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0416]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] VARCHAR(50) NOT NULL,
	[StoreID] VARCHAR(50) NOT NULL,
	[StoreName] NVARCHAR(250) NOT NULL,
	[Length] DECIMAL(28,8) NULL,
	[Width] DECIMAL(28,8) NULL,
	[Area] DECIMAL(28,8) NULL,
	[Location] NVARCHAR(250) NULL,
	[Coefficent] DECIMAL(28,8) NULL,
	[BlockID] VARCHAR(50) NULL, 
	[IsCommon] TINYINT DEFAULT (0) NULL,
	[Disabled] TINYINT DEFAULT(0) NULL,
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_AT0416] PRIMARY KEY NONCLUSTERED 
(
	[StoreID] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON

)) ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'AT0416' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0416'  and col.name = 'LandPlotNo')
           Alter Table  AT0416 Add LandPlotNo NVARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0416' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0416'  and col.name = 'MapNo')
           Alter Table  AT0416 Add MapNo NVARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0416' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0416'  and col.name = 'Certificate')
           Alter Table  AT0416 Add [Certificate] NVARCHAR(250) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0416' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0416'  and col.name = 'CertificateNo')
           Alter Table  AT0416 Add CertificateNo NVARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0416' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0416'  and col.name = 'CertificateDate')
           Alter Table  AT0416 Add CertificateDate DATETIME NULL
END