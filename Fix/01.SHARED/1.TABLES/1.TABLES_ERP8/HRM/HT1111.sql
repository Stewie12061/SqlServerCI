---- Create by Nguyễn Hoàng Bảo Thy on 9/18/2017 3:23:59 PM
---- Kế hoạch sản xuất theo máy (detail)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1111]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1111]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [APKMaster] VARCHAR(50) NOT NULL,
  [Date] DATETIME NULL,
  [FromTime] NVARCHAR(100) NULL,
  [ToTime] NVARCHAR(100) NULL,
  [Notes] NVARCHAR(250) NULL
CONSTRAINT [PK_HT1111] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1111' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT1111' AND col.name = 'PlanningTime') 
	ALTER TABLE HT1111 ADD PlanningTime DECIMAL(28,8) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT1111' AND col.name = 'ProductID') 
	ALTER TABLE HT1111 ADD ProductID NVARCHAR(250) NULL
end