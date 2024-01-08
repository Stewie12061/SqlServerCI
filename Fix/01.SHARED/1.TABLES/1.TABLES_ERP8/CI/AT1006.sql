-- <Summary> Danh mục nhóm tài khoản
-- <History>
---- Create on 12/05/2016 by Phan thanh hoàng Vũ
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1006]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT1006](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[GroupID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[GroupNameE] [nvarchar](250) NULL,
 CONSTRAINT [PK_AT1006] PRIMARY KEY NONCLUSTERED 
(
	[GroupID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1006_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1006] ADD  CONSTRAINT [DF_AT1006_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

--Alter Pimary key 
		--IF EXISTS (SELECT Top 1 1 FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'PRIMARY KEY' AND TABLE_SCHEMA = 'dbo' AND TABLE_NAME = 'AT1006')
		--Begin
		--	--Thay đối khóa chính từ 2 khóa sang 1 khóa (DivisionID, GroupID) -> (GroupID)
		--	ALTER TABLE AT1006 DROP CONSTRAINT pk_AT1006
		--	ALTER TABLE AT1006 ADD CONSTRAINT pk_AT1006 PRIMARY KEY ( GroupID)
		--End
--Add giá trị default
		IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1006_Disabled]') AND type = 'D')
		BEGIN
			ALTER TABLE [dbo].[AT1006] ADD  CONSTRAINT [DF_AT1006_Disabled]  DEFAULT ((0)) FOR [Disabled]
		END

--Add Columns
		IF EXISTS (SELECT * FROM sysobjects WHERE name = 'AT1006' AND xtype = 'U') 
		BEGIN
			IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab ON col.id = tab.id WHERE tab.name = 'AT1006' AND col.name = 'IsCommon')
			ALTER TABLE AT1006 ADD [IsCommon] [tinyint] NULL
		END