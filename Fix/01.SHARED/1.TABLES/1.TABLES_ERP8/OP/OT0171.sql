---- Create by Nguyễn Hoàng Bảo Thy on 5/3/2017 2:02:18 PM
---- Detail Quản lý tiến độ sản xuất

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT0171]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT0171]
(
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TransactionID] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [VoucherID] VARCHAR(50) NULL,
  [StepID] VARCHAR(50) NULL,
  [CompletedDate] DATETIME NULL,
  [OrderNo] INT NOT NULL
CONSTRAINT [PK_OT0171] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TransactionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END



IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT0171' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT0171' AND col.name = 'OrderNo') 
   ALTER TABLE OT0171 ADD OrderNo INT NULL 
END

/*===============================================END OrderNo===============================================*/ 