---- Create by tanphu on 3/3/2015 1:32:23 PM
---- Modify by Trọng Kiên on 18/03/2021 1:32:23 PM
---- Modify by Kiều Nga on 29/11/2021 Fix lỗi lưu dự trù chi phí sản xuất
---- Master dự trù nguyên vật liệu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT2201]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT2201]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NULL,
  [EstimateID] NVARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [VoucherTypeID] NVARCHAR(50) NULL,
  [VoucherNo] NVARCHAR(50) NULL,
  [VoucherDate] DATETIME NULL,
  [Status] INT NULL,
  [SOrderID] NVARCHAR(50) NULL,
  [ApportionType] NVARCHAR(50) NULL,
  [DepartmentID] NVARCHAR(50) NULL,
  [EmployeeID] NVARCHAR(50) NULL,
  [InventoryTypeID] NVARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [WareHouseID] NVARCHAR(50) NULL,
  [OrderStatus] INT NULL,
  [IsPicking] TINYINT NULL,
  [FileType] INT NULL,
  [PeriodID] NVARCHAR(50) NULL,
  [ObjectID] NVARCHAR(50) NULL,
  [IsConfirm] TINYINT DEFAULT (0) NOT NULL,
  [DescriptionConfirm] NVARCHAR(250) NULL,
  [Varchar01] NVARCHAR(100) NULL,
  [Varchar02] NVARCHAR(100) NULL,
  [Varchar03] NVARCHAR(100) NULL,
  [Varchar04] NVARCHAR(100) NULL,
  [Varchar05] NVARCHAR(100) NULL,
  [Varchar06] NVARCHAR(100) NULL,
  [Varchar07] NVARCHAR(100) NULL,
  [Varchar08] NVARCHAR(100) NULL,
  [Varchar09] NVARCHAR(100) NULL,
  [Varchar10] NVARCHAR(100) NULL,
  [Varchar11] NVARCHAR(100) NULL,
  [Varchar12] NVARCHAR(100) NULL,
  [Varchar13] NVARCHAR(100) NULL,
  [Varchar14] NVARCHAR(100) NULL,
  [Varchar15] NVARCHAR(100) NULL,
  [Varchar16] NVARCHAR(100) NULL,
  [Varchar17] NVARCHAR(100) NULL,
  [Varchar18] NVARCHAR(100) NULL,
  [Varchar19] NVARCHAR(100) NULL,
  [Varchar20] NVARCHAR(100) NULL,
  [StatusID] VARCHAR(50) NULL,
  [DeleteFlg] TINYINT DEFAULT (0) NULL,
  [SuppliesDate] DATETIME NULL
CONSTRAINT [PK_OT2201] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2201' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2201' AND col.name = 'APKMaster_9000')
    ALTER TABLE OT2201 ADD APKMaster_9000 UNIQUEIDENTIFIER DEFAULT newid() NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'OT2201' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'OT2201' AND col.name = 'Levels')
    ALTER TABLE OT2201 ADD Levels INT NULL
END

If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'CreateUserID')
           Alter Table  OT2201 Add CreateUserID VARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'CreateDate')
           Alter Table  OT2201 Add CreateDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'LastModifyUserID')
           Alter Table  OT2201 Add LastModifyUserID VARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'LastModifyDate')
           Alter Table  OT2201 Add LastModifyDate DATETIME NULL
END

-- Đình Hoà [21/07/2021] : Merger từ FIX ERP8 -> ERP9
If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'TeamID')
           Alter Table  OT2201 Add TeamID nvarchar(50) Null

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'StatusID')
           Alter Table  OT2201 Add StatusID varchar(50) Null

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'DeleteFlg')
           Alter Table  OT2201 Add DeleteFlg TINYINT Null

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'SuppliesDate')
           Alter Table  OT2201 Add SuppliesDate DATETIME Null
END

-- Bổ sung trường EstimateTypeID cho HHP (CustomizeIndex = 71): EstimateTypeID = 1: Phiếu điều chỉnh dự trù chi phi sx
If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
		If not exists (select TOP 1 1 from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'EstimateTypeID')
		Alter Table  OT2201 Add EstimateTypeID TINYINT DEFAULT((0))
           
		If not exists (select TOP 1 1 from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'InheritVoucherID')
		Alter Table  OT2201 Add InheritVoucherID NVARCHAR(50) Null      
           
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='OT2201' AND col.name='AdjustSOrderID')
		ALTER TABLE OT2201 ADD AdjustSOrderID NVARCHAR(50) NULL   	           
End

If Exists (Select * From sysobjects Where name = 'OT2201' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'ObjectName')
           Alter Table  OT2201 Add ObjectName NVARCHAR(MAX) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'EmployeeName')
           Alter Table  OT2201 Add EmployeeName NVARCHAR(MAX) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'Note')
           Alter Table  OT2201 Add Note NVARCHAR(MAX) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'ApproveLevel')
           Alter Table  OT2201 Add ApproveLevel INT NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'OT2201'  and col.name = 'ApprovingLevel')
           Alter Table  OT2201 Add ApprovingLevel INT NULL
END