-- <Summary>
---- 
-- <History>
---- Create on 18/07/2019 by Kiều Nga: Định mức Quota theo nhân viên (detail)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2001]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2001](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[ExpensesID] [varchar](50) NULL,
	[TypeID] [tinyint] NOT NULL,
	[Amount] [decimal](28) NULL,
	[DeleteFlag] [int] NULL

 CONSTRAINT [PK_SOT2001] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SOT2001_Amount]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SOT2001] ADD  CONSTRAINT [DF_SOT2001_Amount]  DEFAULT ((0)) FOR [Amount]
END

