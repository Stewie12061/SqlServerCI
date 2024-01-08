---- Create by Tiểu Mai on 2/23/2017 4:00:09 PM
---- Chi tiết chấm công sản phẩm (Customize BourBon)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT0411]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT0411]
(
  [APK] UNIQUEIDENTIFIER DEFAULT NEWID(),
  [DivisionID] NVARCHAR(50) NOT NULL,
  [TrackingID] NVARCHAR(50) NOT NULL,
  [TrackingDetailID] NVARCHAR(50) NOT NULL,
  [EmployeeID] NVARCHAR(50) NULL,
  [Amount] DECIMAL(28,8) NULL,
  [Orders] INT NULL
CONSTRAINT [PK_HT0411] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [TrackingID],
  [TrackingDetailID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

--- Modified by Tiểu Mai on 17/03/2017: Bổ sung cho Bourbon
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT0411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0411' AND col.name='Quantity')
		ALTER TABLE HT0411 ADD Quantity DECIMAL(28,8) NULL
	END
	
--- Modified by Tiểu Mai on 17/03/2017: Bổ sung cho Bourbon
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT0411' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0411' AND col.name='TranMonth')
		ALTER TABLE HT0411 ADD TranMonth INT NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT0411' AND col.name='TranYear')
		ALTER TABLE HT0411 ADD TranYear INT NULL
	END
	
