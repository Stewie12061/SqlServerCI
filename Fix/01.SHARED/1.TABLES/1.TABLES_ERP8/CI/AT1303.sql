-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Quốc Cường
---- Modified on 02/07/2018 by Hoàng Vũ: bổ sung trường IsBranchStore (Phân biệt chi nhánh hay cửa hàng), StatusInventory (Phân biệt trạng thái kho)
---- Modified on 30/07/2018 by Kim Thư: bổ sung trường IsCS và IsLocation (phân biệt kho có quản lý theo vị trí)

---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1303]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1303](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[WareHouseID] [nvarchar](50) NOT NULL,
	[WareHouseName] [nvarchar](250) NULL,	
	[Address] [nvarchar](250) NULL,
	[FullName] [nvarchar](250) NULL,
	[IsTemp] [tinyint] NOT NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT1303] PRIMARY KEY NONCLUSTERED 
(
	[WareHouseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1303_IsTemp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1303] ADD CONSTRAINT [DF_AT1303_IsTemp] DEFAULT ((0)) FOR [IsTemp]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1303_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1303] ADD CONSTRAINT [DF_AT1303_Disabled] DEFAULT ((0)) FOR [Disabled]
END

--- Modified by Tiểu Mai on 19/06/2018: Bổ sung Checkbox Nhập xuất theo đối tượng cho SG Petrol (CustomizeIndex = 36)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1303' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'IsObject') 
   ALTER TABLE AT1303 ADD IsObject TINYINT NULL 
END 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1303' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'IsBranchStore') 
   ALTER TABLE AT1303 ADD IsBranchStore TINYINT NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1303' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'StatusInventory') 
   ALTER TABLE AT1303 ADD StatusInventory INT NULL 
END
/*===============================================END StatusInventory===============================================*/ 

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1303' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'IsCS')
    ALTER TABLE AT1303 ADD IsCS TINYINT NULL
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'IsLocation')
    ALTER TABLE AT1303 ADD IsLocation TINYINT NULL
END
--Modefied by Khả Vi on 01/12/2017: Add Column 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1303' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'IsCS')
        ALTER TABLE AT1303 ADD IsCS TINYINT NULL
       IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'IsLocation')
        ALTER TABLE AT1303 ADD IsLocation TINYINT NULL
    END

	---- Add Columns Huỳnh Thử [25/07/2020]-- Fix lỗi chạy tool run all Fix
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1303' AND xtype='U')
	BEGIN

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1303' AND col.name='IndexCount')
		ALTER TABLE AT1303 ADD IndexCount INT  NULL

	END

--Modefied by Minh Hiếu on 01/04/2022: Add Column 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1303' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'Latitude')
        ALTER TABLE AT1303 ADD Latitude decimal(28,8) Default 0
       IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1303' AND col.name = 'Longitude')
        ALTER TABLE AT1303 ADD Longitude decimal(28,8) Default 0
    END
