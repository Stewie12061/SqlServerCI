---- Create by Đặng Thị Tiểu Mai on 04/03/2016 4:02:03 PM
---- Đề nghị ký hợp đồng

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0374]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[HT0374]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [SuggestID] NVARCHAR(50) NOT NULL,
      [SuggestDate] DATETIME NULL,
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
      [EmployeeID] NVARCHAR(50),
      [Description] NVARCHAR(250) NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_HT0374] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [SuggestID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END