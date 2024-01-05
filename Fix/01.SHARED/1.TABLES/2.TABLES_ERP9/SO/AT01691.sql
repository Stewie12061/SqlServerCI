-- <Summary>
---- 
-- <History>
---- Create by Thanh Lượng on 19/01/2016:  
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT01691]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT01691](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TargetsID] [nvarchar](50) NOT NULL,
	[TransactonID] [nvarchar](50) NOT NULL,
	[FromDate] [datetime] NULL,
	[ToDate] [datetime] NULL,
	[Description] [nvarchar](250) NULL,
	[EmployeeLevel] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[SalesMonth] [decimal](28, 8) NULL,
	[SalesQuarter] [decimal](28, 8) NULL,
	[SalesYear] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	CONSTRAINT [PK_AT01691] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

--IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT01691' AND xtype = 'U')
--BEGIN
--	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'EmployeeID')
--    ALTER TABLE AT01691 ADD EmployeeID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'ObjectID')
--    ALTER TABLE AT01691 ADD ObjectID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'InventoryTypeID')
--    ALTER TABLE AT01691 ADD InventoryTypeID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'Orders')
--    ALTER TABLE AT01691 ADD Orders DECIMAL(28,8) NULL
    
--    -- Bổ sung loại mặt hàng (MPT đơn hàng bán số 4)
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'InventoryTypeID2')
--    ALTER TABLE AT01691 ADD InventoryTypeID2 NVARCHAR(50) NULL
--END        

----- Modified by Nhật Thanh on 14/12/2021: Bổ sung 5 trường ghi nhận 5 cấp nhân viên cho ANGEL
--IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT01691' AND xtype = 'U')
--BEGIN
--	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'SOAna01ID')
--    ALTER TABLE AT01691 ADD SOAna01ID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'SOAna02ID')
--    ALTER TABLE AT01691 ADD SOAna02ID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'SOAna03ID')
--    ALTER TABLE AT01691 ADD SOAna03ID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'SOAna04ID')
--    ALTER TABLE AT01691 ADD SOAna04ID NVARCHAR(50) NULL
    
--    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'SOAna05ID')
--    ALTER TABLE AT01691 ADD SOAna05ID NVARCHAR(50) NULL

--	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT01691' AND col.name = 'DivisionID')
--    ALTER TABLE AT01691 ALTER COLUMN DivisionID NVARCHAR(50) NOT NULL
--END  
