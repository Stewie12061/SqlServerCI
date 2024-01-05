---- Create by Nguyễn Hoàng Bảo Thy on 9/25/2017 10:19:03 AM
---- Nhật ký sản xuất (newtoyo)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1117]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1117]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [MachineID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [Date] DATETIME NULL,
  [ActWorkingTime] DECIMAL(28,8) NULL,
  [StandardQuantity] DECIMAL(28,8) NULL,
  [InQuantity] DECIMAL(28,8) NULL,
  [OutQuantity] DECIMAL(28,8) NULL,
  [InVariance] DECIMAL(28,8) NULL,
  [TotalVariance] DECIMAL(28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HT1117] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1117' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT1117' AND col.name = 'ShiftID') 
	ALTER TABLE HT1117 ADD ShiftID VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT1117' AND col.name = 'ActualRunningTime') 
	ALTER TABLE HT1117 ADD ActualRunningTime DECIMAL(28,8) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT1117' AND col.name = 'ProductID') 
	ALTER TABLE HT1117 ADD ProductID NVARCHAR(250) NULL
END