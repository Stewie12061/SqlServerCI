-- <Summary>
---- Master book cont đơn hàng xuất khẩu (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Trúc on 17/12/2019

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POT2061]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POT2061]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [VoucherDate] DATETIME NOT NULL,
  [TranMonth] INT NOT NULL,
  [TranYear] INT NOT NULL,
  [PackedTime] DATETIME NOT NULL,
  [DepartureDate] DATETIME NOT NULL,
  [ArrivalDate] DATETIME NOT NULL,
  [PortName] NVARCHAR(250) NULL,
  [ClosingTime] DATETIME NULL,
  [Forwarder] NVARCHAR(250) NULL,
  [ShipBrand] NVARCHAR(250) NULL,
  [ContQuantity] DECIMAL (28, 8) NULL,
  [Description] NVARCHAR(250) NULL,
  [DeleteFlag] INT NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_POT2061] PRIMARY KEY CLUSTERED
(
  [DivisionID] ASC,
  [VoucherNo]  ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Văn Tài, 07/01/2020: Add column.
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'POT2061' AND col.name = 'TranMonth')
        ALTER TABLE POT2061 ADD	TranMonth INT NULL

-- Văn Tài, 07/01/2020: Add column.
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'POT2061' AND col.name = 'TranYear')
        ALTER TABLE POT2061 ADD	TranYear INT NULL

-- Văn Tài, 07/01/2020: Add column.
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'POT2061' AND col.name = 'DeleteFlag')
        ALTER TABLE POT2061 ADD	DeleteFlag INT NULL

GO 
exec sp_rename 'POT2061.Closingtime', 'ClosingTime', 'COLUMN';