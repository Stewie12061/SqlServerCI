---- Create by Đặng Thị Tiểu Mai on 25/02/2016 11:12:06 AM
---- Thống kê sản xuất (Master - Angel)
---- Modified on 20/12/2016 by Hải Long: Tăng độ dài cho Parameter03 thành 200 ký tự

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT1801]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT1801]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] NVARCHAR(50) NOT NULL,
      [VoucherID] NVARCHAR(50) NOT NULL,
      [VoucherNo] NVARCHAR(50) NULL,
      [TranMonth] INT NULL,
      [TranYear] INT NULL,
      [VoucherTypeID] NVARCHAR(50) NULL,
      [VoucherDate] DATETIME NULL,
      [ProductDate] DATETIME NULL,
      [ObjectID] NVARCHAR(50) NULL,
      [TeamID] NVARCHAR(50) NULL,
      [VisorsID] NVARCHAR(50) NULL,
      [EmployeeID] NVARCHAR(50) NULL,
      [Description] NVARCHAR(250) NULL,
      [MTC01] NVARCHAR(250) NULL,
      [MTC02] NVARCHAR(250) NULL,
      [QuantityControl] DECIMAL(28,8) NULL,
      [ReImportQuantity] DECIMAL(28,8) NULL,
      [QuantityChoose] DECIMAL(28,8) NULL,
      [RateChoose] DECIMAL(28,8) NULL,
      [QuantityQualify] DECIMAL(28,8) NULL,
      [RateQualify] DECIMAL(28,8) NULL,
      [QuantityNotQualify] DECIMAL(28,8) NULL,
      [RateNotQualify] DECIMAL(28,8) NULL,
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
	  [CreateDate] DATETIME NULL,
	  [CreateUserID] NVARCHAR(50) NULL,
	  [LastModifyDate] DATETIME NULL,
	  [LastModifyUserID] NVARCHAR(50) NULL,
    CONSTRAINT [PK_MT1801] PRIMARY KEY CLUSTERED
      (
      [DivisionID],
      [VoucherID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END


DECLARE @CustomerName INT
  
SELECT TOP 1 @CustomerName = CustomerName FROM CustomerIndex

IF @CustomerName = 57 -- ANGEL
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT1801' AND xtype = 'U')
		BEGIN
			IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
			ON col.id = tab.id WHERE tab.name = 'MT1801' AND col.name = 'Parameter03')
			ALTER TABLE MT1801 ALTER COLUMN Parameter03 NVARCHAR(200) NULL
		END
END
