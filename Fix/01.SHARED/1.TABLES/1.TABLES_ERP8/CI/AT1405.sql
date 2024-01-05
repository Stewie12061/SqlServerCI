-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Trẫm
---- Modified on 10/07/2019	by Kim Thư: Sửa khóa chính bản 837 không chia dữ liệu dùng chung theo DivisionID. Bổ sung cột IsCommon (Dùng Chung)
---- Modified on 10/10/2022 by Nhựt Trường: Kiểm tra và set DEFAULT NEWID() cho cột APK nếu chưa có.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1405]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1405](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](250) NULL,
	[Password] [nvarchar](100) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_AT1405] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default 
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1405_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1405] ADD  CONSTRAINT [DF_AT1405_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

-- thêm cột IsCommon
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1405' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1405' AND col.name = 'IsCommon')
    ALTER TABLE AT1405 ADD IsCommon TINYINT DEFAULT 0
END

----Alter Pimary key 
--IF EXISTS (SELECT TOP 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'AT1405')
--Begin
--	--Thay đối khóa chính từ 3 khóa sang 2 khóa (bỏ DivisionID)
--	ALTER TABLE AT1405 DROP CONSTRAINT [PK_AT1405]
--	ALTER TABLE AT1405 ADD CONSTRAINT [PK_AT1405] PRIMARY KEY (UserID)
--End

--- Add Columns ChangeDatePassword: [Tuấn Anh] Modified [20/06/2019]
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1405' AND col.name = 'ChangedPasswordDate')
        ALTER TABLE AT1405 ADD ChangedPasswordDate DATETIME DEFAULT NULL

-- [01/02/2021] - [Tấn Thành] - Begin Add
-- Bổ sung cột UserToken
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT1405' AND col.name = 'UserToken')
BEGIN
	ALTER TABLE AT1405 ADD UserToken VARCHAR(MAX) NULL
END

-- Bổ sung cột TimeExpiredToken
IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT1405' AND col.name = 'TimeExpiredToken')
BEGIN
	ALTER TABLE AT1405 ADD TimeExpiredToken DATETIME NULL
END
-- [01/02/2021] - [Tấn Thành] - End Add

-- Modified on 10/10/2022 by Nhựt Trường: Kiểm tra và set DEFAULT NEWID() cho cột APK nếu chưa có.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1405' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1405' AND col.name = 'AKP')
   BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'AT1405' AND COLUMN_NAME = 'APK' AND ISNULL(Column_Default,'') = '')
	ALTER TABLE AT1405 ADD DEFAULT NEWID() FOR APK
   END
END