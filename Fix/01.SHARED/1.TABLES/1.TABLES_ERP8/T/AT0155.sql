﻿-- <Summary>
---- 
-- <History>
---- Create on 04/01/2016 by Bảo Anh: Danh mục loại thông số máy
---- Modified on ... by ...

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0155]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0155](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TypeID] [nvarchar](50) NOT NULL,
	[DetailTypeID] [nvarchar](250) NOT NULL,
	[DetailTypeName] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT0155] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[TypeID] ASC,
	[DetailTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]