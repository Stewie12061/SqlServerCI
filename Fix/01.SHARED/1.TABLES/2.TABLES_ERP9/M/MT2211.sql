-- <Summary>
---- Details nghiệp vụ thống kê kết quả sản xuất module M (Quản lý sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Kiều Nga on 15/03/2021
--[Phương Thảo] [24/04/2023]-Bổ sung cột StartTime và EndTime

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2211]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2211]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[ProductionOrder] VARCHAR(50)NOT NULL, -- Lệnh sản xuất
	[PhaseID] VARCHAR(50) NULL, -- Công đoạn
	[ObjectID] VARCHAR(50) NULL, -- Đối tượng
	[SourceMachineID] VARCHAR(50) NULL, -- Nguồn lực máy
	[SourceEmployeeID] NVARCHAR(MAX) NULL, -- Nguồn lực nhân công
	[InventoryID] VARCHAR(50) NULL, -- Thành phẩm
	[UnitID] VARCHAR(50) NULL, -- Đơn vị tính
	[Quantity] DECIMAL(28,8) NULL, -- Số lượng
	[Length] NVARCHAR(250) NULL, -- Dài
	[Width] NVARCHAR(250) NULL, -- Rộng
	[Height] NVARCHAR(250) NULL, -- Cao
	[Description] NVARCHAR(MAX) NULL, -- Diễn giải
	[CreateDate] DATETIME NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NOT NULL

CONSTRAINT [PK_MT2211] PRIMARY KEY CLUSTERED
(
  [APK] ASC,
  [DivisionID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'SourceEmployeeName')
           Alter Table  MT2211 Add SourceEmployeeName NVARCHAR(MAX) NULL
END

If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'InheritTableID')
           Alter Table  MT2211 Add InheritTableID NVARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'InheritVoucherID')
           Alter Table  MT2211 Add InheritVoucherID NVARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'InheritTransactionID')
           Alter Table  MT2211 Add InheritTransactionID NVARCHAR(50) NULL
END

--[Kiều Nga][10/05/2021] Bổ sung 20 cột quy cách 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT2211' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S01ID') 
   ALTER TABLE MT2211 ADD S01ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S02ID') 
   ALTER TABLE MT2211 ADD S02ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S03ID') 
   ALTER TABLE MT2211 ADD S03ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S04ID') 
   ALTER TABLE MT2211 ADD S04ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S05ID') 
   ALTER TABLE MT2211 ADD S05ID NVARCHAR(50) NULL    
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S06ID') 
   ALTER TABLE MT2211 ADD S06ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S07ID') 
   ALTER TABLE MT2211 ADD S07ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S08ID') 
   ALTER TABLE MT2211 ADD S08ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S09ID') 
   ALTER TABLE MT2211 ADD S09ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S10ID') 
   ALTER TABLE MT2211 ADD S10ID NVARCHAR(50) NULL       
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S11ID') 
   ALTER TABLE MT2211 ADD S11ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S12ID') 
   ALTER TABLE MT2211 ADD S12ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S13ID') 
   ALTER TABLE MT2211 ADD S13ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S14ID') 
   ALTER TABLE MT2211 ADD S14ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S15ID') 
   ALTER TABLE MT2211 ADD S15ID NVARCHAR(50) NULL    
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S16ID') 
   ALTER TABLE MT2211 ADD S16ID NVARCHAR(50) NULL  
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S17ID') 
   ALTER TABLE MT2211 ADD S17ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S18ID') 
   ALTER TABLE MT2211 ADD S18ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S19ID') 
   ALTER TABLE MT2211 ADD S19ID NVARCHAR(50) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'MT2211' AND col.name = 'S20ID') 
   ALTER TABLE MT2211 ADD S20ID NVARCHAR(50) NULL               	
END 

If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'IsWarehouse')
           Alter Table  MT2211 Add IsWarehouse TINYINT DEFAULT (0) NULL
END

--[Kiều Nga][23/09/2022] Bổ sung cột MachineTime
If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'MachineTime')

           Alter Table  MT2211 Add MachineTime DECIMAL(28,8) NULL
END

--[Kiều Nga][23/09/2022] Bổ sung cột LaborTime
If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'LaborTime')
           Alter Table  MT2211 Add LaborTime DECIMAL(28,8) NULL
END

--[Thanh Lượng][02/03/2023] Bổ sung các cột cần thiết

If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
			-- Phân loại công việc
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'TaskTypeName')
           Alter Table  MT2211 Add TaskTypeName VARCHAR(50) NULL
		   -- Công việc phát sinh
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'TaskArise')
           Alter Table  MT2211 Add TaskArise VARCHAR(50) NULL
		   --CA SX
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'ProductionShift')
           Alter Table  MT2211 Add ProductionShift VARCHAR(25) NULL
		   -- Mã chi tiết
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'DetailID')
           Alter Table  MT2211 Add DetailID VARCHAR(25) NULL
		     -- Tên chi tiết
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'DetailName')
           Alter Table  MT2211 Add DetailName VARCHAR(50) NULL
		  
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'Ana06ID')
           Alter Table  MT2211 Add Ana06ID VARCHAR(25) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'Ana06Name')
           Alter Table  MT2211 Add Ana06Name VARCHAR(25) NULL	
		   -- Mã ID
		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'UserID')
           Alter Table  MT2211 Add UserID VARCHAR(25) NULL   	
		    -- Người  thao tác
		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'CreateUserName')
           Alter Table  MT2211 Add CreateUserName VARCHAR(25) NULL
		   -- CycleTime
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'CycleTime')
           Alter Table  MT2211 Add CycleTime DECIMAL(28,8) NULL		  
		   -- Sản lượng kế hoạch
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'ItemPlan')
           Alter Table  MT2211 Add ItemPlan DECIMAL(28,8) NULL
		    -- Sản lượng Thực tế OK
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'ItemActual')
           Alter Table  MT2211 Add ItemActual DECIMAL(28,8) NULL
		    
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'ItemReturnedQuantity')
           Alter Table  MT2211 Add ItemReturnedQuantity INT NULL
		   
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'ItemBalance')
           Alter Table  MT2211 Add ItemBalance INT NULL
		   -- Tổng thời gian KH
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'TotalPlan')
           Alter Table  MT2211 Add TotalPlan DECIMAL(28,8) NULL
		   -- TGLV thực tế (hrs)
		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'TotalActualTime')
           Alter Table  MT2211 Add TotalActualTime DECIMAL(28,8) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
            ON col.id = tab.id where tab.name =   'MT2211'  and col.name = 'StartTime')
           ALTER Table  MT2211 Add StartTime DATETIME;

	       If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'EndTime')
            Alter Table  MT2211 Add EndTime DATETIME;


		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'PreparePlanTime')
           Alter Table  MT2211 Add PreparePlanTime  DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'RestPlanTime1')
           Alter Table  MT2211 Add RestPlanTime1 DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'MainMealPlanTime')
           Alter Table  MT2211 Add MainMealPlanTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'RestPlanTime2')
           Alter Table  MT2211 Add RestPlanTime2 DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'SideMealPlanTime')
           Alter Table  MT2211 Add SideMealPlanTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'CleanPlanTime')
           Alter Table  MT2211 Add CleanPlanTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'TotalPlanTime')
           Alter Table  MT2211 Add TotalPlanTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'MoldProblemTime')
           Alter Table  MT2211 Add MoldProblemTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'DeviceProblemTime')
           Alter Table  MT2211 Add DeviceProblemTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'materialProblemTime')
           Alter Table  MT2211 Add materialProblemTime DECIMAL(28,8) NULL

		    If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'ReplaceProplumnTime')
           Alter Table  MT2211 Add ReplaceProplumnTime DECIMAL(28,8) NULL

		   	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'FeedbackProblemTime')
           Alter Table  MT2211 Add FeedbackProblemTime DECIMAL(28,8) NULL

		   	If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'TotalProblemTime')
           Alter Table  MT2211 Add TotalProblemTime DECIMAL(28,8) NULL
--[Phương Thảo] [24/04/2023]-Bổ sung cột StartTime và EndTime START EDIT
			If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'StartTime')
           ALTER TABLE MT2211 ALTER COLUMN StartTime DATETIME;

		    If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'EndTime')
           ALTER TABLE MT2211 ALTER COLUMN EndTime DATETIME;

		    If  exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'SourceEmployeeName')
           Alter Table  MT2211 ALTER COLUMN SourceEmployeeName NVARCHAR(50) NULL

		    If  exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'DetailID')
           Alter Table  MT2211 ALTER COLUMN DetailID VARCHAR(25) NULL

		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'Ana06Name')
           Alter Table  MT2211 ALTER COLUMN Ana06Name NVARCHAR(250) NULL	

		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'DetailName')
           Alter Table  MT2211 ALTER COLUMN DetailName NVARCHAR(250) NULL

--[Phương Thảo] [24/04/2023]-Bổ sung cột StartTime và EndTime END EDIT
END

--[Hoàng Long][18/09/2023] Bổ sung cột Số PO
If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'PONumber')
           Alter Table  MT2211 Add PONumber  NVARCHAR(50) NULL
END
---------------- 13/09/2023 - Thanh Lượng: Bổ sung cột Specification, IsWaste ----------------
If Exists (Select * From sysobjects Where name = 'MT2211' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'Specification')
           Alter Table  MT2211 Add Specification  NVARCHAR(500) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'MT2211'  and col.name = 'IsWaste')
           Alter Table  MT2211 Add IsWaste  TINYINT NULL
END
