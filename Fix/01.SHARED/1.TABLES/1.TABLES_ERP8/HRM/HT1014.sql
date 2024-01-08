﻿-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1014]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1014](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TargetID] [nvarchar](50) NOT NULL,
	[TargetTypeID] [nvarchar](50) NOT NULL,
	[TargetName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_HT1014] PRIMARY KEY NONCLUSTERED 
(
	[TargetID] ASC,
	[TargetTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT1014_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT1014] ADD  CONSTRAINT [DF_HT1014_Disabled]  DEFAULT ((0)) FOR [Disabled]
END