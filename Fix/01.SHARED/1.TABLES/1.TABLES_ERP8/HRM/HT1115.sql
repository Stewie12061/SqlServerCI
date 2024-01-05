---- Create by Thái Huỳnh Khả Vi on 9/21/2017 10:53:48 AM
---- Thời gian dừng máy

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1115]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1115]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [MachineID] VARCHAR(50) NOT NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [Date] DATETIME NULL,
  [FromTime] VARCHAR(50) NULL,
  [ToTime] VARCHAR(50) NULL,
  [TotalTime] DECIMAL (28,8) NULL,
  [Notes] NVARCHAR(250) NULL,
  [CreateUserID] NVARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] NVARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_HT1115] PRIMARY KEY CLUSTERED
(
  [APK],
  [DivisionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

---- Modified by Bảo Thy on 20/11/2017: bổ sung thời gian nghỉ chuẩn từ-đến (newtoyo)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1115' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT1115' AND col.name = 'StandardFromTime') 
   ALTER TABLE HT1115 ADD StandardFromTime VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT1115' AND col.name = 'StandardToTime') 
   ALTER TABLE HT1115 ADD StandardToTime VARCHAR(50) NULL 
END
