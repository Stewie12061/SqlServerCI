﻿-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Việt Khánh
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CT1001]') AND type in (N'U'))
CREATE TABLE [dbo].[CT1001](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar] (3) NOT NULL,
	[ServiceTypeID] [nvarchar](50) NOT NULL,
	[ServiceTypeName] [nvarchar](250) NULL,
	[notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[Disabled] [tinyint] NULL,
CONSTRAINT [PK_CT1001] PRIMARY KEY CLUSTERED 
(
	[ServiceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]