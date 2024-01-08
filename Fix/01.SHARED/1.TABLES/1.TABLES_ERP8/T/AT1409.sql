-- <Summary>
---- 
-- <History>
---- Create on 13/12/2010 by Thanh Trẫm
---- Modified on ... by ...
----Modify by: Phương Thảo, Date  13/03/2023 : [2023/03/IS/0097] Điều chỉnh thêm OrderNo để sắp xếp phân hệ 
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1409]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1409](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ModuleID] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[DescriptionE] [nvarchar](250) NULL,
 CONSTRAINT [PK_AT1409] PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
--Add column 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT1409' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT1409' AND col.name='OrderNo')
		BEGIN
		   ALTER TABLE AT1409 ADD OrderNo INT NULL 
		END	
	END

