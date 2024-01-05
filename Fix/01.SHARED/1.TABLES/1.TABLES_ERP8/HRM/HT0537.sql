---- Create by Nguyễn Văn Tài on 12/16/2020 5:14:34 PM
---- Hồ sơ lương nhân viên thời vụ.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0537]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT0537]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [EmployeeID] VARCHAR(50) NOT NULL,
  [EmployeeName] NVARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [TeamID] VARCHAR(50) NULL,
  [SectionID] VARCHAR(50) NULL,
  [CheckInTime] VARCHAR(10) NULL,
  [CheckOutTime] VARCHAR(10) NULL,
  [BaseTimeAmount] DECIMAL(28,8) NULL,
  [NightTimeAmount] DECIMAL(28,8) NULL,
  [OTTimeAmount] DECIMAL(28,8) NULL,
  [Date] DATETIME NULL,
  [BaseSalary] DECIMAL(28,8) NULL,
  [NightShiftSalary] DECIMAL(28,8) NULL,
  [OTSalary] DECIMAL(28,8) NULL,
  [EatingFee] DECIMAL(28,8) NULL,
  [HeavyAllowance] DECIMAL(28,8) NULL,
  [ServiceSalary] DECIMAL(28,8) NULL,
  [TotalSalary] DECIMAL(28,8) NULL,
  [IsCalculated] TINYINT NULL,
  [Error] NVARCHAR(MAX) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
CONSTRAINT [PK_HT0537] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

----Modified by Văn Tài on 28/12/2020: Bổ sung cờ "Đã xử lý tổng hợp lương"
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0537' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT0537' AND col.name = 'IsCalculated')
    ALTER TABLE HT0537 ADD IsCalculated TINYINT NULL
END