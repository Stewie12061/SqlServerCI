-- Create by VanTinh on 28/08/2018
-- Hồ sơ học sinh - EDMF2010

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[EDMT2010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[EDMT2010]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[StudentID] VARCHAR(50) NOT NULL,
	[StudentName] NVARCHAR(64) NULL,
	StatusID VARCHAR(50) NULL,
	DateOfBirth DATETIME NULL,
	PlaceOfBirth NVARCHAR(128) NULL,
	NationalityID VARCHAR(50) NULL,
	NationID VARCHAR(50) NULL,
	SexID TINYINT NULL,
	[Address] NVARCHAR(128) NULL,
	GradeID VARCHAR(50) NULL,
	ClassID VARCHAR(50) NULL,
	ArrangeClassID VARCHAR(50) NULL,
	[Description] NVARCHAR(500) NULL,
	[Image] VARBINARY(MAX) NULL,
	[FileAttach] [VARBINARY](8000) NULL,
	ComfirmID VARCHAR(50) NULL,
	RegistrationDate DATETIME NULL,
	Receiver VARCHAR(50) NULL,
	CreateUserID VARCHAR(50) NULL,
	CreateDate DATETIME NULL,
	LastModifyUserID VARCHAR(50) NULL,
	LastModifyDate DATETIME NULL,
	IsInheritConsultant TINYINT NULL,
	APKConsultant UNIQUEIDENTIFIER NULL,
	DeleteFlg TINYINT DEFAULT(0) NULL,
	FatherID VARCHAR(50) NULL,
	FatherDateOfBirth DATETIME NULL,
	FatherPlaceOfBirth NVARCHAR(64) NULL,
	FatherNationalityID VARCHAR(50) NULL,
	FatherNationID VARCHAR(50) NULL,
	FatherJob NVARCHAR(50) NULL,
	FatherOffice NVARCHAR(50) NULL,
	FatherPhone VARCHAR(32) NULL,
	FatherMobiphone VARCHAR(32) NULL,
	FatherEmail VARCHAR(32) NULL,
	FatherImage VARBINARY(MAX) NULL,

	MotherID VARCHAR(50) NULL,
	MotherDateOfBirth DATETIME NULL,
	MotherPlaceOfBirth NVARCHAR(64) NULL,
	MotherNationalityID VARCHAR(50) NULL,
	MotherNationID VARCHAR(50) NULL,
	MotherJob NVARCHAR(50) NULL,
	MotherOffice NVARCHAR(50) NULL,
	MotherPhone VARCHAR(32) NULL,
	MotherMobiphone VARCHAR(32) NULL,
	MotherEmail VARCHAR(32) NULL,
	MotherImage VARBINARY(MAX) NULL,

	Picker1Name NVARCHAR(64) NULL,
	Picker1RelateTo NVARCHAR(64) NULL,
	Picker1HomePhone VARCHAR(32) NULL,
	Picker1MobiPhone VARCHAR(32) NULL,
	Picker1OfficePhone VARCHAR(32) NULL,
	Picker1Image VARBINARY(MAX) NULL,
	Picker2PickerName NVARCHAR(64) NULL,
	Picker2RelateTo NVARCHAR(64) NULL,
	Picker2HomePhone VARCHAR(32) NULL,
	Picker2MobiPhone VARCHAR(32) NULL,
	Picker2OfficePhone VARCHAR(32) NULL,
	Picker2Image VARBINARY(MAX) NULL,
	PickerNotes NVARCHAR(128) NULL,
CONSTRAINT [PK_EDMT2010] PRIMARY KEY CLUSTERED
(
  [APK], [DivisionID]
)
) ON [PRIMARY]

END
GO



------Modified by Hồng Thảo on 6/4/2019: Bổ sung cột mã học sinh, xưng hô, phân loại cho đối tượng và học sinh để sinh tự đông 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2010' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'SType01IDS') 
   ALTER TABLE EDMT2010 ADD SType01IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'SType02IDS') 
   ALTER TABLE EDMT2010 ADD SType02IDS VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'SType03IDS') 
   ALTER TABLE EDMT2010 ADD SType03IDS VARCHAR(50) NULL

END 



---- Modified by Hồng Thảo on 29/8/2019: Tăng kiểu dữ liệu lưu email 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2010' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'FatherEmail') 
   ALTER TABLE EDMT2010 ALTER COLUMN FatherEmail NVARCHAR(250) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'MotherEmail') 
   ALTER TABLE EDMT2010 ALTER COLUMN MotherEmail NVARCHAR(250) NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'FatherPhone') 
   ALTER TABLE EDMT2010 ALTER COLUMN FatherPhone NVARCHAR(50) NULL 

    IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'MotherPhone') 
   ALTER TABLE EDMT2010 ALTER COLUMN MotherPhone NVARCHAR(50) NULL 


END

---- Modified by Khánh Đoan  on 20/12/2019: Bổ sung cột ngày nhập học , ngày bắt đầu học thử, ngày kết thúc học thử 


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2010' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'AdmissionDate') 
   ALTER TABLE EDMT2010 ADD AdmissionDate DATETIME NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'BeginTrialDate') 
   ALTER TABLE EDMT2010 ADD BeginTrialDate DATETIME NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'EndTrialDate') 
   ALTER TABLE EDMT2010 ADD EndTrialDate DATETIME NULL

END 

---- Modified by Đình Hòa on 09/03/2021: Thêm cột lưu tên file Image
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT2010' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'Picker1ImageName') 
   ALTER TABLE EDMT2010 ADD Picker1ImageName NVARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'EDMT2010' AND col.name = 'Picker2ImageName') 
   ALTER TABLE EDMT2010 ADD Picker2ImageName NVARCHAR(50) NULL

END 







