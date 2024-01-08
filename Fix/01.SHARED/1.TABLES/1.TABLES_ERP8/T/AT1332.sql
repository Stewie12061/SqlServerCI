---- Create by Tiểu Mai on 6/28/2017 11:17:53 AM
---- Thiết lập quy trình chuyển kho


IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT1332]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT1332]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] NVARCHAR(50) NOT NULL,
  [VoucherID] NVARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NULL,
  [Description] NVARCHAR(500) NULL,
  [EmployeeID] NVARCHAR(50) NULL,
  [InventoryID] NVARCHAR(50) NOT NULL,
  [InventoryTypeID] NVARCHAR(50) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL
CONSTRAINT [PK_AT1332] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [VoucherID],
  [InventoryID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

----- Modified by Tiểu Mai on 30/06/2017: Bổ sung cột lưu lại user và thời gian tạo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1332' AND xtype = 'U')
    BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1332' AND col.name = 'CreateDate')
        ALTER TABLE AT1332 ADD CreateDate DATETIME NULL
        
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1332' AND col.name = 'CreateUserID')
        ALTER TABLE AT1332 ADD CreateUserID	NVARCHAR(50) NULL
        
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1332' AND col.name = 'LastModifyDate')
        ALTER TABLE AT1332 ADD LastModifyDate DATETIME NULL
        
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1332' AND col.name = 'LastModifyUserID')
        ALTER TABLE AT1332 ADD LastModifyUserID	NVARCHAR(50) NULL
    END 


