---- Create by Nguyen Hoang Bao Thy on 27/11/2015 1:09:00 PM
---- Đơn Xin Nghỉ Phép

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2011]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2011]
     (
      [Row] INT NULL,
	  DivisionID VARCHAR(50) NULL,
	  TranMonth INT NULL,
	  TranYear INT NULL,
	  ID VARCHAR(50) NULL,
	  Description NVARCHAR(500) NULL,
	  DepartmentID VARCHAR(50) NULL,
	  SectionID VARCHAR(50) NULL,
	  SubsectionID VARCHAR(50) NULL,
	  ProcessID VARCHAR(50) NULL,
	  EmployeeID VARCHAR(50) NULL,
	  AbsentTypeID VARCHAR(50) NULL,
	  ShiftID VARCHAR(50) NULL,
	  LeaveFromDate DATETIME NULL,
	  LeaveToDate DATETIME NULL,
	  TotalTime DECIMAL(28, 2) NULL,
	  OffsetTime DECIMAL(28, 2) NULL,
	  TimeAllowance DECIMAL(28, 2) NULL,
	  FromWorkingDate DATETIME NULL,
	  ToWorkingDate DATETIME NULL,
	  IsNextDay TINYINT NULL,
	  IsValid TINYINT NULL,
	  TotalDay DECIMAL NULL,
	  ApproveLevel INT NULL,
	  IsSeri TINYINT NULL,
	  Reason NVARCHAR(250) NULL,
	  ApprovePersonID01 VARCHAR(50) NULL,
	  ApprovePersonID02 VARCHAR(50) NULL,
	  ApprovePersonID03 VARCHAR(50) NULL,
	  ApprovePersonID04 VARCHAR(50) NULL,
	  ApprovePersonID05 VARCHAR(50) NULL,
	  ApprovePersonID06 VARCHAR(50) NULL,
	  ApprovePersonID07 VARCHAR(50) NULL,
	  ApprovePersonID08 VARCHAR(50) NULL,
	  ApprovePersonID09 VARCHAR(50) NULL,
	  ApprovePersonID10 VARCHAR(50) NULL,
	  TransactionKey VARCHAR(50) NULL,
	  TransactionID  VARCHAR(50) NULL,
	  CreateDate  DATETIME NULL,
	  ErrorColumn VARCHAR(50) NULL,
	  ErrorMessage  VARCHAR(50) NULL
     )
END

----Add column----
--IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT2011' AND xtype = 'U')
--    BEGIN
--        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--        ON col.id = tab.id WHERE tab.name = 'OOT2011' AND col.name = 'OffsetTime')
--        ALTER TABLE OOT2011 ADD OffsetTime DECIMAL(28,2) NULL
--    END
    