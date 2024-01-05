---- Create by Khâu Vĩnh Tâm on 8/19/2019 8:16:40 AM
---- Bảng dữ liệu lương mềm

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[KPIT2040]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[KPIT2040]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NULL,
  [DepartmentID] VARCHAR(50) NULL,
  [EmployeeID] VARCHAR(50) NULL,
  [TranMonth] INT NULL,
  [TranYear] INT NULL,
  [FixedSalary] DECIMAL(28,2) NULL,
  [EffectiveSalary] DECIMAL(28,2) NULL,
  [TargetSales] DECIMAL(28,2) NULL,
  [CompletionRate] DECIMAL(28,2) NULL,
  [StatusID] VARCHAR(50) NULL,
  [ActualEffectiveSalary] DECIMAL(28,2) NULL,
  [Disabled] TINYINT DEFAULT 0 NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_KPIT2040] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-------------------- 29/08/2019 - Truong lam: Thêm cột nhận lương mềm --------------------

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2040' AND col.name = 'IsGetEffectiveSalary')
BEGIN
  ALTER TABLE KPIT2040 ADD IsGetEffectiveSalary TINYINT
END

-------- 03/09/2019 - Truong lam: Thêm cột Status: Trạng thái khóa xử lý tính lương mềm --------
-------- Giá trị: 0: Cho phép chỉnh sửa; 1: Đã tính lương mềm; 2: Khóa kì lương
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2040' AND col.name = 'Status')
BEGIN
  ALTER TABLE KPIT2040 ADD Status TINYINT
END

-------- 05/07/2021 - Văn Tài: Thêm cột ContinuousTargetSales: Dữ liệu cộng dồn --------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'KPIT2040' AND col.name = 'ContinuousTargetSales')
BEGIN
  ALTER TABLE KPIT2040 ADD ContinuousTargetSales DECIMAL(18, 8) NULL
END