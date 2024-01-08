-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 17/09/2018 by Kim Thư - Bổ sung EndQuantity, ReOrderQuantity, Status, Message
---- Modified on 23/10/2018 by Kim Thư - Bổ sung UserID
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT8003]') AND type in (N'U'))
CREATE TABLE [dbo].[AT8003](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[ReVoucherID] [nvarchar](50) NULL,
	[ReTransactionID] [nvarchar](50) NULL,
	[NewQuantity] [decimal](28, 8) NULL,
	[OldQuantity] [decimal](28, 8) NULL,
CONSTRAINT [PK_AT8003] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


-----------------------Bổ sung EndQuantity, ReOrderQuantity, Status, Message - Kim Thư----------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT8003' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT8003' AND col.name='EndQuantity')
	ALTER TABLE AT8003 ADD EndQuantity DECIMAL(28, 8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT8003' AND col.name='ReOrderQuantity')
	ALTER TABLE AT8003 ADD ReOrderQuantity DECIMAL(28, 8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT8003' AND col.name='Status')
	ALTER TABLE AT8003 ADD Status TINYINT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT8003' AND col.name='Message')
	ALTER TABLE AT8003 ADD Message NVARCHAR(250) NULL
END

----------------------- Modified on 23/10/2018 by Kim Thư - Bổ sung UserID---------------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT8003' AND xtype='U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='AT8003' AND col.name='UserID')
	ALTER TABLE AT8003 ADD UserID VARCHAR(50) NULL
END

