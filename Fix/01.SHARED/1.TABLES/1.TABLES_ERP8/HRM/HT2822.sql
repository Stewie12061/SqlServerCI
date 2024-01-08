-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh L�m
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2822]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2822](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[SalaryCondID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[ParameterCalOld] [decimal](28, 8) NULL,
	[ParameterCalNew] [decimal](28, 8) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[TableID] [nvarchar](50) NULL,
	CONSTRAINT [PK_HT2822] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
