-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2538]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2538](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](200) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[DepartmentName] [nvarchar](100) NULL,
	[InsuranceSalary] [decimal](28, 8) NULL,
	[BaseSalary] [decimal](28, 8) NULL,
	[Salary01] [decimal](28, 8) NULL,
	[Salary02] [decimal](28, 8) NULL,
	[Salary03] [decimal](28, 8) NULL,
	[Orders] [int] NULL,
	[DutyName] [nvarchar](250) NULL,
	[TeamID] [nvarchar](50) NULL,
	[TeamName] [nvarchar](200) NULL,
	[WorkDate] [datetime] NULL,
	[Notes] [nvarchar](200) NULL,
	[Note1] [nvarchar](200) NULL,
	[IncomeID] [nvarchar](50) NULL,
	[Signs] [int] NULL,
	[Displayed] [int] NULL,
	[Caption] [nvarchar](200) NULL,
	[FOrders] [int] NULL,
	[PayrollMethodID] [nvarchar](50) NULL,
	[Amount] [decimal](28, 8) NULL,
	CONSTRAINT [PK_HT2538] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

---- Modifyed by Kim Vu on 23/02/2016: Bo sung cau truc bang cho phu hop
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2538' AND xtype='U')
	BEGIN			
		ALTER TABLE HT2538 alter column DivisionID NVARCHAR(50) NOT NULL
		ALTER TABLE HT2538 alter column [EmployeeID] nvarchar(50)
		ALTER TABLE HT2538 alter column [FullName] [nvarchar](250)
		ALTER TABLE HT2538 alter column [DepartmentID] [nvarchar](50)
		ALTER TABLE HT2538 alter column [DepartmentName] [nvarchar](250)
		ALTER TABLE HT2538 alter column [InsuranceSalary] [decimal](38, 8)
		ALTER TABLE HT2538 alter column [BaseSalary] [decimal](38, 8)
		ALTER TABLE HT2538 alter column [Salary01] [decimal](38, 8)
		ALTER TABLE HT2538 alter column [Salary02] [decimal](38, 8)
		ALTER TABLE HT2538 alter column [Salary03] [decimal](38, 8)
		ALTER TABLE HT2538 alter column [Amount] [decimal](38, 8)
		ALTER TABLE HT2538 alter column [Orders] [nvarchar](50) 
		ALTER TABLE HT2538 alter column [DutyName] [nvarchar](250)
		ALTER TABLE HT2538 alter column [TeamID] [nvarchar](50)
		ALTER TABLE HT2538 alter column [TeamName] [nvarchar](250)		
		ALTER TABLE HT2538 alter column [Notes] [nvarchar](250)
		ALTER TABLE HT2538 alter column [Note1] [nvarchar](250)
		ALTER TABLE HT2538 alter column [IncomeID] [nvarchar](250)
		ALTER TABLE HT2538 alter column [Caption] [nvarchar](250)		
	END