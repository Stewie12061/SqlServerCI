-- <Summary>
---- Chi tiết phép thâm niên
-- <History>
---- Created by Tiểu Mai on 05/12/2016
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1028]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1028](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[SeniorityID] [nvarchar](50) NOT NULL,
	[FromValues] [decimal](28,8) NOT NULL,
	[ToValues] [decimal](28,8) NOT NULL,
	[VacSeniorDays] [decimal](28,8) NULL,
	[VacSeniorPrevDays] [decimal](28,8) NULL,
	[Orders] INT NULL
 CONSTRAINT [PK_HT1028] PRIMARY KEY NONCLUSTERED 
(	
	[DivisionID],
	[SeniorityID], 
	[FromValues], 
	[ToValues] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


