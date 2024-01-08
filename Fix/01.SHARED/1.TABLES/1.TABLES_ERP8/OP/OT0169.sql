---- Create by Trương Ngọc Phương Thảo on 5/3/2017 11:53:30 AM
---- Danh mục tiến độ sản xuất

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OT0169]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[OT0169]
(
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TransactionID] NVARCHAR(50) NOT NULL,
  [ProgressID] NVARCHAR(50) NULL,
  [StepID] NVARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [Note] NVARCHAR(250) NULL,
  [Days] INT NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [Colors] NVARCHAR(50) NULL
CONSTRAINT [PK_OT0169] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TransactionID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT0169' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'OT0169' AND col.name = 'OrderNo') 
   ALTER TABLE OT0169 ADD OrderNo INT NULL 
END

/*===============================================END OrderNo===============================================*/ 