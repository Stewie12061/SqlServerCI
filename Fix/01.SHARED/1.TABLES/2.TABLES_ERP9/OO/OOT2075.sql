---- Created by Bảo Thy on 16/03/2018 09:11:01 AM
---- Import đơn xin đổi ca

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2075]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[OOT2075]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
      [DivisionID] VARCHAR(50) NULL,
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
	  [TypeID] TINYINT NULL,
      [ID] VARCHAR(250) NULL,
      [Description] NVARCHAR(250) NULL,
      [DepartmentID] VARCHAR(50) NULL,
      [TeamID] VARCHAR(50) NULL,
      [EmployeeID] VARCHAR(50) NOT NULL,
      [FullName] NVARCHAR(500) NULL,
      [D01] VARCHAR(50) NULL,
      [D02] VARCHAR(50) NULL,
      [D03] VARCHAR(50) NULL,
      [D04] VARCHAR(50) NULL,
      [D05] VARCHAR(50) NULL,
      [D06] VARCHAR(50) NULL,
      [D07] VARCHAR(50) NULL,
      [D08] VARCHAR(50) NULL,
      [D09] VARCHAR(50) NULL,
      [D10] VARCHAR(50) NULL,
      [D11] VARCHAR(50) NULL,
      [D12] VARCHAR(50) NULL,
      [D13] VARCHAR(50) NULL,
      [D14] VARCHAR(50) NULL,
      [D15] VARCHAR(50) NULL,
      [D16] VARCHAR(50) NULL,
      [D17] VARCHAR(50) NULL,
      [D18] VARCHAR(50) NULL,
      [D19] VARCHAR(50) NULL,
      [D20] VARCHAR(50) NULL,
      [D21] VARCHAR(50) NULL,
      [D22] VARCHAR(50) NULL,
      [D23] VARCHAR(50) NULL,
      [D24] VARCHAR(50) NULL,
      [D25] VARCHAR(50) NULL,
      [D26] VARCHAR(50) NULL,
      [D27] VARCHAR(50) NULL,
      [D28] VARCHAR(50) NULL,
      [D29] VARCHAR(50) NULL,
      [D30] VARCHAR(50) NULL,
      [D31] VARCHAR(50) NULL,
      [Note] NVARCHAR(250) NULL,
      [Row] INT NULL,
      [TransactionKey] VARCHAR(50) NULL,
      [TransactionID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [ErrorColumn] NVARCHAR(4000) NULL,
      [ErrorMessage] NVARCHAR(4000) NULL,
      [ApprovePersonID01] VARCHAR(50) NULL,
      [ApprovePersonID02] VARCHAR(50) NULL,
      [ApprovePersonID03] VARCHAR(50) NULL,
      [ApprovePersonID04] VARCHAR(50) NULL,
      [ApprovePersonID05] VARCHAR(50) NULL,
      [ApprovePersonID06] VARCHAR(50) NULL,
      [ApprovePersonID07] VARCHAR(50) NULL,
      [ApprovePersonID08] VARCHAR(50) NULL,
      [ApprovePersonID09] VARCHAR(50) NULL,
      [ApprovePersonID10] VARCHAR(50) NULL
    CONSTRAINT [PK_OOT2075] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
