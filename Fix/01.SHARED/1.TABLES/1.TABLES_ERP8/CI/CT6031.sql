---- Create by Đặng Thị Tiểu Mai on 29/02/2016 4:35:25 PM
---- Cập nhật quá trình hoạt động phát sinh hàng ngày (Angel)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT6031]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CT6031]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID()  NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherID] NVARCHAR(50) NOT NULL,
      [TransactionID] NVARCHAR(50) NOT NULL,
      [MachineID] NVARCHAR(50) NULL,
      [MacErrorID] NVARCHAR(50) NULL,
      [DateTime] DATETIME NULL,
      [ComponentSub] NVARCHAR(300) NULL,
      [TimeCheck] DATETIME NULL,
      [Parameter01] NVARCHAR(100) NULL,
      [Parameter02] NVARCHAR(100) NULL,
      [Parameter03] NVARCHAR(100) NULL,
      [Parameter04] NVARCHAR(100) NULL,
      [Parameter05] NVARCHAR(100) NULL,
      [Parameter06] NVARCHAR(100) NULL,
      [Parameter07] NVARCHAR(100) NULL,
      [Parameter08] NVARCHAR(100) NULL,
      [Parameter09] NVARCHAR(100) NULL,
      [Parameter10] NVARCHAR(100) NULL,
      [Parameter11] NVARCHAR(100) NULL,
      [Parameter12] NVARCHAR(100) NULL,
      [Parameter13] NVARCHAR(100) NULL,
      [Parameter14] NVARCHAR(100) NULL,
      [Parameter15] NVARCHAR(100) NULL,
      [Parameter16] NVARCHAR(100) NULL,
      [Parameter17] NVARCHAR(100) NULL,
      [Parameter18] NVARCHAR(100) NULL,
      [Parameter19] NVARCHAR(100) NULL,
      [Parameter20] NVARCHAR(100) NULL,
      [Orders] INT
    CONSTRAINT [PK_CT6031] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID],
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
