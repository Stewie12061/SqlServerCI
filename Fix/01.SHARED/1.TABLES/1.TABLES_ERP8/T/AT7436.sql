-- <Summary>
---- 
-- <History>
---- Create on 14/04/2017 by Hải Long
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT7436]') AND type in (N'U'))
CREATE TABLE [dbo].[AT7436](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[ReportCode] [nvarchar](50) NOT NULL,
	[ReportName] [nvarchar](250) NULL,
	[ReportID] [nvarchar](50) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT7436] PRIMARY KEY NONCLUSTERED 
(
	[ReportCode] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT7436_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT7436] ADD  CONSTRAINT [DF_AT7436_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
