-- <Summary>
---- Lưới hệ số (HRMT2215)
-- <History>
---- Create on 19/12/2023 by Phương Thảo

---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HRMT2215]') AND type in (N'U'))
CREATE TABLE [dbo].[HRMT2215](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[APKMaster] [uniqueidentifier] NULL,
	[DivisionID] nvarchar(6) NOT NULL,
	[CoefficientID] [nvarchar](50) NOT NULL,
	[FieldName] [nvarchar](250) NULL,
	[CoefficientName] [nvarchar](250) NULL,
	[Caption] [nvarchar](250) NULL,
	[IsUsed] [tinyint] NULL,
	[IsConstant] [tinyint] NULL,
	[ValueOfConstant] [decimal](28, 8) NULL,
 CONSTRAINT [PK_HRMT2215] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

