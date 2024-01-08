-- <Summary>
---- Kết quả thử việc
-- <History>
---- Create on 18/10/2023 by Phương Thảo ---Tham khảo HT0534(Kết quả thử việc bảng ERP8)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HRMT2200]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HRMT2200]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT newid() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [ResultNo] VARCHAR(50) NOT NULL,
      [ResultDate] DATETIME NULL,
	    [ReviewPerson] VARCHAR(50) NULL,
      [DecidePerson] VARCHAR(50) NULL,
      [EmployeeID] VARCHAR(50) NULL,
	    [ContractNo] VARCHAR(50) NULL,
	    [TestFromDate] DATETIME NULL,
	    [TestToDate] DATETIME NULL,
      [ResultID] TINYINT NULL,
      [IsStopBeforeEndDate] TINYINT NULL,
      [EndDate] DATETIME NULL,
      [Notes] NVARCHAR(250) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME DEFAULT getdate() NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME DEFAULT getdate() NULL,
	    [DeleteFlg] TINYINT DEFAULT (0) NULL
    CONSTRAINT [PK_HRMT2200] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [ResultNo]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


