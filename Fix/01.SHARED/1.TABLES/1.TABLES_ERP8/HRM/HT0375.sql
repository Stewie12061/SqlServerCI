---- Create by Đặng Thị Tiểu Mai on 04/03/2016 4:02:34 PM
---- Đề nghị ký hợp đồng (Detail - Angel)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0375]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0375]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [SuggestID] NVARCHAR(50) NOT NULL,
      [TransactionID] NVARCHAR(50) NOT NULL,
      [Orders] INT NULL,
      [EmployeeID] NVARCHAR(50) NULL,
      [ContractID] NVARCHAR(50) NULL,
      [ContractNo] NVARCHAR(50) NULL,
      [ContractTypeID] NVARCHAR(50) NULL,
      [WorkDate] DATETIME NULL,
      [WorkEndDate] DATETIME NULL,
      [WorkAddress] NVARCHAR(250) NULL,
      [BaseSalaryOld] DECIMAL(28,8) NULL,
      [BaseSalaryNew] DECIMAL(28,8) NULL,
      [DutyID] NVARCHAR(50) NULL,
      [DepartmentID] NVARCHAR(50) NULL,
      [Notes] NVARCHAR(250) NULL,
      [StatusSuggest] TINYINT DEFAULT (0) NULL,
      [DescriptionConfirm] NVARCHAR(250) NULL,
      [ConfirmUserID] NVARCHAR(50) NULL
    CONSTRAINT [PK_HT0375] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [SuggestID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
