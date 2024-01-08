-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh L�m
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2541]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2541](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[Num] [decimal](28, 8) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[DepartmentName] [nvarchar](250) NULL,
	[InsuranceSalary] [decimal](28, 8) NULL,
	[BaseSalary] [decimal](28, 8) NULL,
	[Salary01] [decimal](28, 8) NULL,
	[Salary02] [decimal](28, 8) NULL,
	[Salary03] [decimal](28, 8) NULL,
	[TeamID] [nvarchar](50) NULL,
	[TeamName] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[Note1] [nvarchar](250) NULL,
	[IncomeID] [nvarchar](50) NULL,
	[Signs] [int] NULL,
	[Displayed] [int] NULL,
	[Amount] [decimal](28, 8) NULL,
	[Caption] [nvarchar](250) NULL,
	[FOrders] [int] NULL,
	[a] [nvarchar](50) NULL,
	CONSTRAINT [PK_HT2541] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
