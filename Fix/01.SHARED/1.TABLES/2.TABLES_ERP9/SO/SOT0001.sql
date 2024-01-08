---- Create by Đặng Thị Tiểu Mai on 17/05/2016 3:16:11 PM
---- Thiết lập loại chứng từ theo người dùng trên web

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT0001]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[SOT0001]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherTypeID] NVARCHAR(50) NOT NULL,
      [UserID] NVARCHAR(50) NOT NULL,
      [CurrencyID] NVARCHAR(50) NULL,
      [CreateUserID] NVARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastCreateUserID] NVARCHAR(50) NULL,
      [LastCreateDate] DATETIME NULL
    CONSTRAINT [PK_SOT0001] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherTypeID],
      [UserID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END