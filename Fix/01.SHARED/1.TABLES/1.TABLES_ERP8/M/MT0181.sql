---- Create by Đặng Thị Tiểu Mai on 05/09/2016 2:30:47 PM
---- Kế hoạch sản xuất tháng (AN PHÁT)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT0181]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT0181]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherID] NVARCHAR(50) NOT NULL,
      [VoucherNo] NVARCHAR(50) NULL,
      [VoucherDate] DATETIME NULL,
      [VoucherTypeID] NVARCHAR(50) NULL,
      [InventoryTypeID] NVARCHAR(50) NULL,
      [ObjectID] NVARCHAR(50) NULL,
      [EmployeeID] NVARCHAR(50) NULL,
      [Description] NVARCHAR(250) NULL,
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] NVARCHAR(50) NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL
    CONSTRAINT [PK_MT0181] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

