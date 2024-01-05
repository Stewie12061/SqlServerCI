---- Create by Cao Thị Phượng on 3/6/2017 8:50:50 AM
---- Danh sách đầu mối

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT20301]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT20301]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [LeadID] VARCHAR(50) NOT NULL,
  [LeadName] NVARCHAR(255) NULL,
  [Prefix] NVARCHAR(50) NULL,
  [LeadTel] NVARCHAR(100) NULL,
  [LeadMobile] NVARCHAR(100) NULL,
  [Address] NVARCHAR(255) NULL,
  [Email] NVARCHAR(100) NULL,
  [JobID] NVARCHAR(100) NULL,
  [CompanyName] NVARCHAR(255) NULL,
  [TitleID] NVARCHAR(50) NULL,
  [LeadStatusID] Varchar(50) NULL,
  [LeadSourceID] INT NULL,
  [LeadTypeID] NVARCHAR(100) NULL,
  [AssignedToUserID] VARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [IsCommon] TINYINT DEFAULT 0 NULL,
  [Description] NVARCHAR(255) NULL,
  [GenderID] TINYINT NULL,
  [BirthDate] DATETIME NULL,
  [PlaceOfBirth] NVARCHAR(255) NULL,
  [MaritalStatusID] INT NULL,
  [BankAccountNo01] NVARCHAR(100) NULL,
  [BankIssueName01] NVARCHAR(250) NULL,
  [NotesPrivate] NVARCHAR(max) NULL,
  [Hobbies] NVARCHAR(max) NULL,
  [BusinessFax] NVARCHAR(50) NULL,
  [BusinessEmail] NVARCHAR(100) NULL,
  [BusinessMobile] NVARCHAR(50) NULL,
  [CompanyDate] DATETIME NULL,
  [Website] NVARCHAR(100) NULL,
  [NumOfEmployee] VARCHAR(50) NULL,
  [OwnerID] VARCHAR(50) NULL,
  [EnterpriseDefinedID] VARCHAR(50) NULL,
  [NotesCompany] NVARCHAR(Max) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [VATCode] VARCHAR(50) NULL,
  [BusinessAddress] NVARCHAR(250) NULL,
  [IsConvertOpp] TINYINT DEFAULT (0) NULL,
  [ConvertOwnerID] VARCHAR(50) NULL,
  [RelatedToTypeID] INT DEFAULT 1 NOT NULL,
  [CampaignID]  VARCHAR(50) NULL
CONSTRAINT [PK_CRMT20301] PRIMARY KEY CLUSTERED
(
  [LeadID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'O01ID') 
   ALTER TABLE CRMT20301 ADD O01ID NVARCHAR(50) NULL 
END

/*===============================================END O01ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'O02ID') 
   ALTER TABLE CRMT20301 ADD O02ID NVARCHAR(50) NULL 
END

/*===============================================END O02ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'O03ID') 
   ALTER TABLE CRMT20301 ADD O03ID NVARCHAR(50) NULL 
END

/*===============================================END O03ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'O04ID') 
   ALTER TABLE CRMT20301 ADD O04ID NVARCHAR(50) NULL 
END

/*===============================================END O04ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'O05ID') 
   ALTER TABLE CRMT20301 ADD O05ID NVARCHAR(50) NULL 
END

/*===============================================END O05ID===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'CampaignID') 
   ALTER TABLE CRMT20301 ADD CampaignID VARCHAR(50) NULL 
END

/*=======================================================================================================*/ 

-------------Modify on 20/9/2019 by Hồng Thảo: Bổ sung cột kế thừa từ phiếu thông tin tư vấn nhằm khi cập nhật lần 2 sẽ k tạo đầu mối (BlueSky)

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'InheritConsultantID') 
   ALTER TABLE CRMT20301 ADD InheritConsultantID VARCHAR(50) NULL 
END

-------------Modify on 16/11/2020 by Đình Hòa: Bổ sung cột Thương hiệu (CBD)

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'TradeMarkID') 
   ALTER TABLE CRMT20301 ADD TradeMarkID VARCHAR(50) NULL 
END

-------------Modify on 26/11/2020 by Đình Hòa: Bổ sung cột Mục tiêu chuyển đổi(CBD)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'ConversionTargetID') 
   ALTER TABLE CRMT20301 ADD ConversionTargetID VARCHAR(50) NULL 
END

-------------Modify on 31/12/2021 by Anh Tuấn: Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'DeleteFlg') 
   ALTER TABLE CRMT20301 ADD DeleteFlg TINYINT DEFAULT (0) NULL 
END

---------------- 07/04/2022 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột Description ----------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20301' AND col.name = 'Description') 
	BEGIN
		-- Xóa index
		DROP INDEX [Index_Combo] ON [dbo].[CRMT20301]

		ALTER TABLE CRMT20301 ALTER COLUMN Description NVARCHAR(MAX) NULL
		-- Tạo lại index
		CREATE NONCLUSTERED INDEX [Index_Combo] ON [dbo].[CRMT20301]
		(
			[LeadID] ASC,
			[LeadStatusID] ASC,
			[LeadSourceID] ASC,
			[LeadTypeID] ASC,
			[AssignedToUserID] ASC
		)
		INCLUDE ([APK],
				[DivisionID],
				[LeadName],
				[LeadTel],
				[LeadMobile],
				[Address],
				[Email],
				[JobID],
				[CompanyName],
				[TitleID],
				[Disabled],
				[IsCommon],
				[Description],
				[BirthDate],
				[Hobbies],
				[Website],
				[CreateUserID],
				[CreateDate],
				[LastModifyUserID],
				[LastModifyDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	END
		
END