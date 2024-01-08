---- Create by Dũng DV on 13/09/2019
---- Danh mục Phiếu dịch vụ

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT2170]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT2170]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMInherited] UNIQUEIDENTIFIER NULL,--APK KẾ THỪA 'CRMF2093.APKPOST0027
  [APKDInherited] UNIQUEIDENTIFIER NULL,--APK KẾ THỪA CRMF2093.APKPOST0028	
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NULL,
  [WarrantyRecipientID] VARCHAR(50) NULL,
  [MemberID] VARCHAR(50) NOT NULL,
  [InheritVoucherNo] NVARCHAR(50) NOT NULL,
  [Tel] VARCHAR(25) NULL,
  [InventoryID] VARCHAR(20) NOT NULL,
  [SerialNo] VARCHAR(50) NULL,
  [DeliveryDate] DATETIME NULL, --Ngày giao máy
  [WarrantyCard] VARCHAR(50) NOT NULL,
  [ExportVoucherNo] VARCHAR(50) NULL,
  [PurchaseDate] DATETIME NULL,
  [MachineStatus] NVARCHAR(250) NULL,
  [FailureStatus] NVARCHAR(250) NULL,
  [IsGuarantee] TINYINT DEFAULT (0) NULL,
  [IsAtStore] TINYINT DEFAULT (0) NULL,
  [StatusID] TINYINT DEFAULT (0) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
 
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME DEFAULT GETDATE() NOT NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CRMT2170] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID],
  [VoucherNo]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
--18/11/2019 : edit trường InheritVoucherNo cho phép Null 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT2170' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'CRMT2170' AND col.name = 'InheritVoucherNo')
		ALTER TABLE CRMT2170 ALTER COLUMN  InheritVoucherNo NVARCHAR(50) NULL
	END

------Modified by [Lương Mỹ] on [25/11/2019]: Bổ sung cột ShopID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT2170' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT2170' AND col.name = 'ShopID') 
   ALTER TABLE CRMT2170 ADD ShopID VARCHAR(50) NULL

END 

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsInTime
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsInTime')
           ALTER TABLE dbo.CRMT2170
					ADD IsInTime TINYINT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsTransferMoney
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsTransferMoney')
ALTER TABLE dbo.CRMT2170
	ADD IsTransferMoney TINYINT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsDelivery
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsDelivery')
ALTER TABLE dbo.CRMT2170
	ADD IsDelivery TINYINT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột WarrantyStaffScores
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'WarrantyStaffScores')
ALTER TABLE dbo.CRMT2170
	ADD WarrantyStaffScores INT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột DeliveryStaffScrores
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'DeliveryStaffScrores')
ALTER TABLE dbo.CRMT2170
	ADD DeliveryStaffScrores INT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột RepairStaffScores
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'RepairStaffScores')
ALTER TABLE dbo.CRMT2170
	ADD RepairStaffScores INT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột TransferMoneyTime
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'TransferMoneyTime')
ALTER TABLE dbo.CRMT2170
	ADD TransferMoneyTime DATETIME NULL;
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsOutTime
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsOutTime')
ALTER TABLE dbo.CRMT2170
	ADD IsOutTime  INT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột OutTime
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'OutTime')
ALTER TABLE dbo.CRMT2170
	ADD OutTime DATETIME NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsCordinator
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsCordinator')
ALTER TABLE dbo.CRMT2170
	ADD IsCordinator INT NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột FailureStatus
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'FailureStatus')
ALTER TABLE dbo.CRMT2170 ALTER COLUMN [FailureStatus]  
            nvarchar(250)COLLATE Latin1_General_100_CI_AI_SC NOT NULL;  
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột MachineStatus
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'MachineStatus')
ALTER TABLE dbo.CRMT2170 ALTER COLUMN [MachineStatus]  
            nvarchar(250)COLLATE Latin1_General_100_CI_AI_SC NOT NULL;  
End 
GO

------Modified by [Manh Nguyen] on [23/12/2019]: Bổ sung độ dài tối đa CheckInUsers
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'CheckInUsers')
ALTER TABLE dbo.CRMT2170 ALTER COLUMN CheckInUsers NVARCHAR(MAX) NULL
End 
GO

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsDelivered
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsDelivered')
ALTER TABLE dbo.CRMT2170
	ADD IsDelivered TINYINT NULL
End 

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột IsPayment
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'IsPayment')
ALTER TABLE dbo.CRMT2170
	ADD IsPayment TINYINT NULL
End 

------Modified by [Kiều Nga] on [27/02/2020]: Thay đổi độ dài InventoryID
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'InventoryID')
ALTER TABLE dbo.CRMT2170 ALTER COLUMN InventoryID VARCHAR(50)
End 
GO

------Modified by [Đoàn Duy] on [27/04/2021]: Thêm cột CheckInUsers
If Exists (Select * From sysobjects Where name = 'CRMT2170' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CRMT2170'  and col.name = 'CheckInUsers')
ALTER TABLE dbo.CRMT2170
	ADD CheckInUsers NVARCHAR (50) NULL
End 