---- Create by Phan thanh hoàng vũ on 3/6/2017 3:42:51 PM
---- Danh mục chiến dịch

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT20401]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT20401]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [CampaignID] VARCHAR(50) NOT NULL,
  [CampaignName] NVARCHAR(250) NOT NULL,
  [CampaignType] VARCHAR(50) NULL,
  [AssignedToUserID] VARCHAR(50) NULL,
  [Description] NVARCHAR(max) NULL,
  [ExpectOpenDate] DATETIME NULL,
  [ExpectCloseDate] DATETIME NULL,
  [CampaignStatus] INT NULL,
  [InventoryID] VARCHAR(50) NULL,
  [Sponsor] NVARCHAR(250) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [BudgetCost] DECIMAL(28,8) NULL,
  [ExpectedRevenue] DECIMAL(28,8) NULL,
  [ExpectedSales] INT NULL,
  [ExpectedROI] DECIMAL(28,8) NULL,
  [ExpectedResponse] INT NULL,
  [ActualCost] DECIMAL(28,8) NULL,
  [ActualSales] INT NULL,
  [CreateDate] DATETIME NULL,
  [ActualROI] DECIMAL(28,8) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [RelatedToTypeID] INT DEFAULT 6 NOT NULL
CONSTRAINT [PK_CRMT20401] PRIMARY KEY CLUSTERED
(
  [CampaignID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
---- Create by Cao Thị Phượng on 3/7/2017 3:42:51 PM bổ sung cột doanh thu thực tế
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'ActualRevenue') 
   ALTER TABLE CRMT20401 ADD ActualRevenue DECIMAL(28,8) NULL 
END

---- Create by Hồng Thảo on 11/4/2019: Chuyển not null thành null 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'CampaignType') 
   ALTER TABLE CRMT20401 ALTER COLUMN  CampaignType  VARCHAR(50) NULL 
END

---- Create by Đình Hòa on 03/11/2020: Bổ sung column 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'PlaceDate') 
   ALTER TABLE CRMT20401 ADD PlaceDate DATETIME NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'LeadsTarget') 
   ALTER TABLE CRMT20401 ADD LeadsTarget DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'ChangeCostTarget') 
   ALTER TABLE CRMT20401 ADD ChangeCostTarget DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'AttendLeaderTarget') 
   ALTER TABLE CRMT20401 ADD AttendLeaderTarget DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'AttendRateTarget') 
   ALTER TABLE CRMT20401 ADD AttendRateTarget DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'LeadsActual') 
   ALTER TABLE CRMT20401 ADD LeadsActual DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'ChangeCostActual') 
   ALTER TABLE CRMT20401 ADD ChangeCostActual DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'AttendLeaderActual') 
   ALTER TABLE CRMT20401 ADD AttendLeaderActual DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'AttendRateActual') 
   ALTER TABLE CRMT20401 ADD AttendRateActual DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'Age') 
   ALTER TABLE CRMT20401 ADD Age NVARCHAR(100) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'AreaID') 
   ALTER TABLE CRMT20401 ADD AreaID NVARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'Position') 
   ALTER TABLE CRMT20401 ADD Position NVARCHAR(Max) NULL 
END

--- Thay đổi kiểu dữ liệu của COLUMN BusinessLines
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'BusinessLinesID') 
   BEGIN
   ALTER TABLE CRMT20401 ADD BusinessLinesID VARCHAR(25) NULL 
   END
   ELSE
   BEGIN
   ALTER TABLE CRMT20401 ALTER COLUMN BusinessLinesID VARCHAR(MAX) NULL 
   END
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'Behavior') 
   ALTER TABLE CRMT20401 ADD Behavior NVARCHAR(Max) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'LeadsPreviousActual') 
   ALTER TABLE CRMT20401 ADD LeadsPreviousActual DECIMAL(28,8) NULL 
END

--Modify on 14/01/2021 by Đình Hòa: Bổ sung cột Tỉ lệ đúng chân dung và Số lead đúng chân dung(CBD)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'LeadPortrait') 
   ALTER TABLE CRMT20401 ADD LeadPortrait DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20301' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'LeadPortraitRate') 
   ALTER TABLE CRMT20401 ADD LeadPortraitRate DECIMAL(28,8) NULL 
END

---------------- 26/07/2021 - Tấn Lộc: Thay đổi kiểu dữ liệu của cột CampaignStatus từ INT sang VARCHAR(50) ----------------
IF EXISTS (SELECT * FROM syscolumns col 
				INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'CampaignStatus')
BEGIN
	-- Check tồn tại của Index Index_Combo. Nếu có tồn tại thì drop trước khi change kiểu dữ liệu của cột
	IF EXISTS (SELECT TOP 1 1 FROM sys.indexes AS i  WHERE is_hypothetical = 0 AND i.index_id <> 0 AND i.object_id = OBJECT_ID('CRMT20401') AND i.name = 'Index_Combo')
		BEGIN 
			DROP INDEX Index_Combo ON CRMT20401;
		END
	ALTER TABLE CRMT20401 ALTER COLUMN CampaignStatus VARCHAR(50) NULL
END

---Modify on 31/12/2021 by Anh Tuấn: Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT20401' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'CRMT20401' AND col.name = 'DeleteFlg') 
   ALTER TABLE CRMT20401 ADD DeleteFlg TINYINT DEFAULT (0) NULL 
END