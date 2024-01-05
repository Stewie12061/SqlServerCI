---- Create by Nhật Thanh
---- Đăng ký thông tin dự án
---- Modified on 20/07/2023 by Lê Thanh Lượng - [2023/07/IS/0224]: Thêm một số trường theo yêu cầu
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2300]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OOT2300]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [Electronic] TINYINT NULL,
  [Technology] TINYINT NULL,
  [Pharmacy] TINYINT NULL,
  [LightManpowerIndustry] TINYINT NULL,
  [LightMachineryIndustry] TINYINT NULL,
  [HeavyIndustry] TINYINT NULL,
  [OthersWorkshopType] TINYINT NULL,
  [OthersWorkshopTypeText] NVARCHAR(250)  NULL,
  [NewConstruction] TINYINT NULL,
  [RenovationProject] TINYINT NULL,
  [ProfessionalNewConstruction] TINYINT NULL,
  [Initial] TINYINT NULL,
  [DeepInto] TINYINT NULL,
  [Final] TINYINT NULL,
  [AirCondition] TINYINT NULL,
  [CoolingDemand] TINYINT NULL,
  [CoolingDemandText] NVARCHAR(250)  NULL,
  [HeatingDemand] TINYINT NULL,
  [HeatingDemandText] NVARCHAR(250)  NULL,
  [HeatingDevice] TINYINT NULL,
  [HeatingDeviceKW] TINYINT NULL,
  [HeatingDeviceKWText] NVARCHAR(250)  NULL,
  [HeatingDeviceKWTextKr] NVARCHAR(250)  NULL,
  [NewWind] TINYINT NULL,
  [LowStandards] TINYINT NULL,
  [HighStandards] TINYINT NULL,
  [OthersNewWind] TINYINT NULL,
  [VentilationStandards] NVARCHAR(250)  NULL,
  [PersonnelStandards] NVARCHAR(250)  NULL,
  [PersonnelDensity] NVARCHAR(250)  NULL,
  [VentilationStandardsKr] NVARCHAR(250)  NULL,
  [PersonnelStandardsKr] NVARCHAR(250)  NULL,
  [PersonnelDensityKr] NVARCHAR(250)  NULL,
  [WasteWind] TINYINT NULL,
  [Determined] TINYINT NULL,
  [DetailDescription] TINYINT NULL,
  [DetailDescriptionText] NVARCHAR(250)  NULL,
  [DetailDescriptionKr] TINYINT NULL,
  [DetailDescriptionTextKr] NVARCHAR(250)  NULL,
  [WasteWindPlan] TINYINT NULL,
  [Cleanness] TINYINT NULL,
  [DescribedCleanliness] TINYINT NULL,
  [SeparateDescription] TINYINT NULL,
  [SeparateDescriptionText] NVARCHAR(250)  NULL,
  [SeparateDescriptionKr] TINYINT NULL,
  [SeparateDescriptionTextKr] NVARCHAR(250)  NULL,
  [Humidity] TINYINT NULL,
  [HumidityRequirement] TINYINT NULL,
  [TechnologicalProcess] TINYINT NULL,
  [TechnologicalProcessText] NVARCHAR(250)  NULL,
  [TechnologicalProcessTextKr] NVARCHAR(250)  NULL,
  [CoolingProduction] TINYINT NULL,
  [ProductionRequired] TINYINT NULL,
  [Water] TINYINT NULL,
  [LowAlcohol] TINYINT NULL,
  [LowAlcoholType] NVARCHAR(250)  NULL,
  [Concentration] NVARCHAR(250)  NULL,
  [FrozenOil] TINYINT NULL,
  [FrozenOilText] NVARCHAR(250)  NULL,
  [OtherEnvironment] TINYINT NULL,
  [OtherEnvironmentText] NVARCHAR(250)  NULL,
  [PowerRequirement] TINYINT NULL,
  [EquipmentNeeds] TINYINT NULL,
  [EquipmentNeedsText] NVARCHAR(250)  NULL,
  [EquipmentNeedsTextKr] NVARCHAR(250)  NULL,
  [OwnDescription] TINYINT NULL,
  [OwnDescriptionText] NVARCHAR(250)  NULL,
  [StrictParameters] TINYINT NULL,
  [CoolingTemperature1] NVARCHAR(250)  NULL,
  [CoolingTemperature2] NVARCHAR(250)  NULL,
  [TrafficRequest] NVARCHAR(250)  NULL,
  [Pressure] NVARCHAR(250)  NULL,
  [CoolingTemperature1Kr] NVARCHAR(250)  NULL,
  [CoolingTemperature2Kr] NVARCHAR(250)  NULL,
  [TrafficRequestKr] NVARCHAR(250)  NULL,
  [PressureKr] NVARCHAR(250)  NULL,
  [Brick240500] TINYINT NULL,
  [Brick240] TINYINT NULL,
  [CompositePlate] TINYINT NULL,
  [Bearing] NVARCHAR(250)  NULL,
  [PlateType] NVARCHAR(250)  NULL,
  [BearingKr] NVARCHAR(250)  NULL,
  [PlateTypeKr] NVARCHAR(250)  NULL,
  [Insulation] TINYINT NULL,
  [InsulationText] NVARCHAR(250)  NULL,
  [InsulationTextKr] NVARCHAR(250)  NULL,
  [NonInsulation] TINYINT NULL,
  [NonCeiling] TINYINT NULL,
  [Plasterboard] TINYINT NULL,
  [OtherCeiling] TINYINT NULL,
  [OtherCeilingText] NVARCHAR(250)  NULL,
  [NormalHeight] TINYINT NULL,
  [HighHeight] TINYINT NULL,
  [HighHeightText] NVARCHAR(250)  NULL,
  [HighHeightTextKr] NVARCHAR(250)  NULL,
  [WholeFactory] TINYINT NULL,
  [WholeFactoryText] NVARCHAR(250)  NULL,
  [InsideWorkshop] TINYINT NULL,
  [InsideWorkshopText] NVARCHAR(250)  NULL,
  [Locally] TINYINT NULL,
  [LocallyText] NVARCHAR(250)  NULL,
  [DrawDescription] TINYINT NULL,
  [DrawNonDescription] TINYINT NULL,
  [RequestDesign] TINYINT NULL,
  [DesignBuildingHeight] NVARCHAR(250)  NULL,
  [DesignFloorHeight] NVARCHAR(250)  NULL,
  [DesignBuildingHeightKr] NVARCHAR(250)  NULL,
  [DesignFloorHeightKr] NVARCHAR(250)  NULL,
  [PreferredDeviceTypeText] NVARCHAR(250)  NULL,
  [InstallationLocationPlanText] NVARCHAR(250)  NULL,
  [EstimatedShelfLifeText] NVARCHAR(250)  NULL,
  [OtherManufacturersText] NVARCHAR(250)  NULL,
  [SpecialControlText] NVARCHAR(250)  NULL,
  [OtherSpecialDescriptionText] NVARCHAR(250)  NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_OOT2300] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
-- Người duyệt
If Exists (Select * From sysobjects Where name = 'OOT2300' and xtype ='U') 
Begin
	--NV Thiết kế 设计员:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'EmployeeCreate')
	ALTER TABLE OOT2300 ADD EmployeeCreate NVARCHAR(250) NULL
	--Mã dự án 项目编码:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ProjectID')
	ALTER TABLE OOT2300 ADD ProjectID NVARCHAR(250) NULL
	--NVKD 销售员:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'SalesmanRegister')
	ALTER TABLE OOT2300 ADD SalesmanRegister NVARCHAR(250) NULL
	--Bộ phận 部门:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'SectionRegister')
	ALTER TABLE OOT2300 ADD SectionRegister NVARCHAR(250) NULL
	--Ngày đăng ký 登记日期:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'RegisterDate')
	ALTER TABLE OOT2300 ADD RegisterDate DATETIME NULL
	--Ngày hoàn thành 完成时间:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'RegisterPlanEndDate')
	ALTER TABLE OOT2300 ADD RegisterPlanEndDate DATETIME NULL
	--Tên khách hàng 客户名称:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'OjectName')
	ALTER TABLE OOT2300 ADD OjectName NVARCHAR(250) NULL
	--Điện thoại liên hệ 联系电话:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ObjectPhoneNumber')
	ALTER TABLE OOT2300 ADD ObjectPhoneNumber VARCHAR(50) NULL
	-- Chủ đầu tư
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'InvestorName')
	ALTER TABLE OOT2300 ADD InvestorName NVARCHAR(250) NULL
	--Nhà thầu 承包商名称:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ContactorObject')
	ALTER TABLE OOT2300 ADD ContactorObject NVARCHAR(250) NULL
	--Người nhận báo giá 询价人:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'QuotePriceMan')
	ALTER TABLE OOT2300 ADD QuotePriceMan NVARCHAR(250) NULL
	--Chức vụ 职务:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ObjectDutyName')
	ALTER TABLE OOT2300 ADD ObjectDutyName NVARCHAR(250) NULL
	--Tên dự án 项目名称:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ProjectName')
	ALTER TABLE OOT2300 ADD ProjectName NVARCHAR(250) NULL
	--Loại dự án 项目类型:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ProjectType')
	ALTER TABLE OOT2300 ADD ProjectType NVARCHAR(250) NULL
	--Địa chỉ dư án 项目地址:
			IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ProjectAddress')
	ALTER TABLE OOT2300 ADD ProjectAddress NVARCHAR(250) NULL
	--Người liên hệ 联系人:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ContactorProject')
	ALTER TABLE OOT2300 ADD ContactorProject NVARCHAR(250) NULL
	--Chức vụ 职务:
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ProjectDutyName')
	ALTER TABLE OOT2300 ADD ProjectDutyName NVARCHAR(250) NULL
	--Điện thoại 电话:
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'OOT2300'  and col.name = 'ProjectPhoneNumber')
	ALTER TABLE OOT2300 ADD ProjectPhoneNumber VARCHAR(50) NULL


END