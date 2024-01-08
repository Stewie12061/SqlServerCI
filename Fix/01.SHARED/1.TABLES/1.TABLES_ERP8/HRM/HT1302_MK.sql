---- Create by Nguyễn Hoàng Bảo Thy on 01/06/2016 10:37:23 AM
---- Lịch sử công tác (Customize MEIKO)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1302_MK]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT1302_MK]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [HistoryID] NVARCHAR(50) NOT NULL,
      [DecideNo] VARCHAR(50) NOT NULL,
      [DecidePerson] VARCHAR(50) NULL,
      [Proposer] VARCHAR(50) NULL,
      [DecideDate] DATETIME DEFAULT GETDATE() NULL,
      [EmployeeID] NVARCHAR(50) NOT NULL,
      [IsPast] TINYINT NULL,
      [DepartmentID] NVARCHAR(50) NULL,
      [TeamID] NVARCHAR(50) NULL,
      [ProcessID] NVARCHAR(50) NULL,
      [DutyID] NVARCHAR(50) NULL,
      [FromDate] DATETIME DEFAULT GETDATE() NULL,
      [ToDate] DATETIME DEFAULT GETDATE() NULL,
      [DepartmentIDOld] NVARCHAR(50) NULL,
      [TeamIDOld] NVARCHAR(50) NULL,
      [SectionIDOld] NVARCHAR(50) NULL,
      [SectionID] NVARCHAR(50) NULL,
      [ProcessIDOld] NVARCHAR(50) NULL,
      [DutyIDOld] NVARCHAR(50) NULL,
      [Notes] NVARCHAR(250) NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL
    CONSTRAINT [PK_HT1302_MK] PRIMARY KEY CLUSTERED
      (
      [HistoryID],
      [DecideNo],
      [EmployeeID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END