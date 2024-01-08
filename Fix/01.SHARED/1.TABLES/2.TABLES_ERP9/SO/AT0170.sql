USE [22S088_GREE]
GO

/****** Object:  Table [dbo].[AT0170]    Script Date: 12/11/2023 2:23:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AT0170](
	[APK] [uniqueidentifier] NOT NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[SalesMonth] [decimal](28, 8) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[InventoryID] [nvarchar](50) NULL,
	[TargetMonth] [decimal](28, 8) NULL,
	[AdjustableTargetMonth] [decimal](28, 8) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_AT0170] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AT0170] ADD  DEFAULT (newid()) FOR [APK]
GO


--IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0170' AND xtype = 'U')
--BEGIN
--	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT0170' AND col.name = 'AdjustableTargetMonth')
--    ALTER TABLE AT0170 ADD [AdjustableTargetMonth] [decimal](28, 8) NULL
--END  