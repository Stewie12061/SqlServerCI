---- Create by Nguyễn Văn Tài on 12/07/2022
---- Import Đơn Xin Phép Bổ Sung/Hủy Quẹt Thẻ

 
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2041]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2041]
     (
		[Row] INT NULL,
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
		[APKMaster] UNIQUEIDENTIFIER NULL,
		[DivisionID] VARCHAR(50) NULL,
		[TranMonth] INT NULL,
		[TranYear] INT NULL,
		[ID] VARCHAR(50) NULL,
		[Description] NVARCHAR(500) NULL,
		[DepartmentID] VARCHAR(50) NULL,
		[SectionID] VARCHAR(50) NULL,
		[SubsectionID] VARCHAR(50) NULL,
		[ProcessID] VARCHAR(50) NULL,
		[Status] TINYINT DEFAULT (0) NULL,
		[DeleteFlag] TINYINT DEFAULT (0) NULL,
		[InOut] TINYINT NULL,
		[Date] DATETIME NULL,
		[EmployeeID] VARCHAR(50) NULL,
		[Reason] NVARCHAR(250) NULL,
		[Note] NVARCHAR(250) NULL,
		[WorkingDate] DATETIME NULL,
		[ApproveLevel] TINYINT NULL DEFAULT(0),
		[ApprovingLevel] TINYINT NULL DEFAULT(0),
		[ApprovePersonID01] VARCHAR(50) NULL,
		[ApprovePersonID02] VARCHAR(50) NULL,
		[ApprovePersonID03] VARCHAR(50) NULL,
		[ApprovePersonID04] VARCHAR(50) NULL,
		[ApprovePersonID05] VARCHAR(50) NULL,
		[ApprovePersonID06] VARCHAR(50) NULL,
		[ApprovePersonID07] VARCHAR(50) NULL,
		[ApprovePersonID08] VARCHAR(50) NULL,
		[ApprovePersonID09] VARCHAR(50) NULL,
		[ApprovePersonID10] VARCHAR(50) NULL,
		[TransactionKey] VARCHAR(50) NULL,
		[TransactionID]  VARCHAR(50) NULL,
		[CreateDate]  DATETIME NULL,
		[ErrorColumn] VARCHAR(50) NULL,
		[ErrorMessage]  VARCHAR(50) NULL
	 )
END
