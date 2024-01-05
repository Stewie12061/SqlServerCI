---- Create by Hoàng Long on 16/06/2023
---- Danh mục công thức chi phí
---- DROP TABLE CIT1540
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CIT1540]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1540](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](10) NOT NULL,
	[TypeID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](250) NULL,
	[Recipe] [nvarchar](250) NULL,
	[IsUsed] [tinyint] NOT NULL,
	[CreateUserID] NVARCHAR(50) NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] NVARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
 CONSTRAINT [PK_CIT1540] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_CIT1540_IsUsed]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CIT1540] ADD  CONSTRAINT [DF_CIT1540_IsUsed]  DEFAULT ((1)) FOR [IsUsed]
END