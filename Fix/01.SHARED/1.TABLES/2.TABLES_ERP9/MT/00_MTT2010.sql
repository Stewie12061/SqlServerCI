IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MTT2010]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MTT2010]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [TranMonth] INT NOT NULL,
      [TranYear] INT NOT NULL,
      [EduVoucherNo] VARCHAR(50) NULL,
      [StudentID] VARCHAR(50) NOT NULL,
      [ClassID] VARCHAR(50) NOT NULL,
      [ClassDate] DATETIME NULL,
      [IsChangeClass] TINYINT DEFAULT (0) NULL,
      [StatusID] VARCHAR(50) NULL,
      [IsFree] TINYINT DEFAULT (0) NOT NULL,
      [ReduceAmount] DECIMAL(28,8) DEFAULT (0) NULL,
      [ReduceTime] DECIMAL(28,8) DEFAULT (0) NULL,
      [ReduceReasonID] VARCHAR(50) NULL,
      [ReturnMoney] DECIMAL(28,8) DEFAULT (0) NULL,
      [ReturnDate] DATETIME NULL,
      [ReturnReason] VARCHAR(50) NULL,
      [ReturnPersonID] NVARCHAR(50) NULL,
      [Notes] NVARCHAR(500) NULL,
      [BeginDate] DATETIME NULL,
      [EndDate] DATETIME NULL,
      [NextCourseID] VARCHAR(50) NULL,
      [NextClassID] VARCHAR(50) NULL,
      [ReduceNotes] NVARCHAR(500) NULL,
      [CourseID] VARCHAR(50) NULL,
      [WeekQuantity] DECIMAL(28,8) DEFAULT (0) NULL,
      [SendMoney] DECIMAL(28,8) DEFAULT (0) NULL,
      [SendNotes] NVARCHAR(500) NULL,
      [DeleteFlag] TINYINT DEFAULT (0) NOT NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_MTT2010] PRIMARY KEY CLUSTERED
      (
      [APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

