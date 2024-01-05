-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modifyed by Kim Vu on 23/02/2016: Bo sung cau truc bang cho phu hop
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2537]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2537](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](20) NOT NULL,
	[FullName] [nvarchar](200) NULL,
	[DepartmentID] [nvarchar](20) NULL,
	[DepartmentName] [nvarchar](100) NULL,
	[InsuranceSalary] [decimal](28, 8) NULL,
	[BaseSalary] [decimal](28, 8) NULL,
	[Salary01] [decimal](28, 8) NULL,
	[Salary02] [decimal](28, 8) NULL,
	[Salary03] [decimal](28, 8) NULL,
	[Orders] [int] NULL,
	[DutyName] [nvarchar](250) NULL,
	[TeamID] [nvarchar](20) NULL,
	[TeamName] [nvarchar](200) NULL,
	[WorkDate] [datetime] NULL,
	[Notes] [nvarchar](200) NULL,
	[Note1] [nvarchar](200) NULL,
	[IncomeID] [nvarchar](20) NULL,
	[Signs] [int] NULL,
	[Displayed] [int] NULL,
	[Amount] [decimal](28, 8) NULL,
	[Caption] [nvarchar](200) NULL,
	[FOrders] [int] NULL,
	[a] [nvarchar](20) NULL,
 CONSTRAINT [PK_HT2537] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2537' AND xtype='U')
	BEGIN
				IF EXISTS (SELECT 1 
                      FROM   information_schema.table_constraints  C 
                             INNER JOIN information_schema.key_column_usage  K
                                      ON C.table_name = K.table_name 
                                        AND C.constraint_catalog = 
                                            K.constraint_catalog 
                                        AND C.constraint_schema = 
                                            K.constraint_schema 
                                        AND C.constraint_name = 
                                            K.constraint_name 
                      WHERE  C.constraint_type = 'PRIMARY KEY' 
                             AND column_name = 'DivisionID' 
                             AND C.table_name = 'HT2537' 
                             )
		BEGIN			
			ALTER TABLE HT2537 DROP CONSTRAINT [PK_HT2537]
			ALTER TABLE HT2537 ADD CONSTRAINT [PK_HT2537] PRIMARY KEY ([APK])
		END
		ALTER TABLE HT2537 alter column DivisionID NVARCHAR(50)
		ALTER TABLE HT2537 alter column [EmployeeID] nvarchar(50)
		ALTER TABLE HT2537 alter column [FullName] [nvarchar](250)
		ALTER TABLE HT2537 alter column [DepartmentID] [nvarchar](50)
		ALTER TABLE HT2537 alter column [DepartmentName] [nvarchar](250)
		ALTER TABLE HT2537 alter column [InsuranceSalary] [decimal](38, 8)
		ALTER TABLE HT2537 alter column [BaseSalary] [decimal](38, 8)
		ALTER TABLE HT2537 alter column [Salary01] [decimal](38, 8)
		ALTER TABLE HT2537 alter column [Salary02] [decimal](38, 8)
		ALTER TABLE HT2537 alter column [Salary03] [decimal](38, 8)
		ALTER TABLE HT2537 alter column [Amount] [decimal](38, 8)
		ALTER TABLE HT2537 alter column [Orders] [nvarchar](50) 
		ALTER TABLE HT2537 alter column [DutyName] [nvarchar](250)
		ALTER TABLE HT2537 alter column [TeamID] [nvarchar](50)
		ALTER TABLE HT2537 alter column [TeamName] [nvarchar](250)		
		ALTER TABLE HT2537 alter column [Notes] [nvarchar](250)
		ALTER TABLE HT2537 alter column [Note1] [nvarchar](250)
		ALTER TABLE HT2537 alter column [IncomeID] [nvarchar](250)
		ALTER TABLE HT2537 alter column [Caption] [nvarchar](250)
		ALTER TABLE HT2537 alter column [a] [nvarchar](50)	
	END
	