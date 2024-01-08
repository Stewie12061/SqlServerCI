USE [22S088_GREE]
GO

/****** Object:  Table [dbo].[AT0169]    Script Date: 12/11/2023 2:16:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AT0169](
	[APK] [uniqueidentifier] NOT NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
	[Year] [int] NULL,
	[SalesYear] [decimal](28, 8) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[Month] [int] NULL,
	[SalesMonth] [decimal](28, 8) NULL,
	[AdjustableSalesMonth] [decimal](28, 8) NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_AT0169] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AT0169] ADD  DEFAULT (newid()) FOR [APK]
GO


--IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0169' AND xtype = 'U')
--BEGIN
--	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
--    ON col.id = tab.id WHERE tab.name = 'AT0169' AND col.name = 'AdjustableSalesMonth')
--    ALTER TABLE AT0169 ADD [AdjustableSalesMonth] [decimal](28, 8) NULL
--END  