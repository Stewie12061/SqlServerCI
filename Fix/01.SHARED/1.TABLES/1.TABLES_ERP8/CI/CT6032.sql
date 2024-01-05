---- Create by Đặng Thị Tiểu Mai on 01/03/2016 1:46:09 PM
---- Danh sách kế hoạch bảo dưỡng, bảo trì thay thế

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT6032]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CT6032]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherID] NVARCHAR(50) NOT NULL,
      [VoucherNo] NVARCHAR(50) NULL,
      [VoucherDate] DATETIME NULL,
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
      [VoucherTypeID] NVARCHAR(50) NULL,
      [Description] NVARCHAR(250) NULL,
      [EmployeeID] NVARCHAR(50) NULL,
      [MTC01] NVARCHAR(250) NULL,
      [MTC02] NVARCHAR(250) NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL
    CONSTRAINT [PK_CT6032] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END