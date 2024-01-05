-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2803]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2803](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](3) NOT NULL,
	[EmpLoaMonthID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[WorkTerm] [decimal](28, 8) NULL,
	[DaysPrevYear] [decimal](28, 8) NULL,
	[DaysInYear] [decimal](28, 8) NULL,
	[DaysSpent] [decimal](28, 8) NULL,
	[DaysRemained] [decimal](28, 8) NULL,
	[IsAdded] [tinyint] NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_HT2802] PRIMARY KEY CLUSTERED 
(
	[EmpLoaMonthID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT2802_IsAdded]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2803] ADD  CONSTRAINT [DF_HT2802_IsAdded]  DEFAULT ((1)) FOR [IsAdded]
END

---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT2803' AND col.name='MethodVacationID')
		ALTER TABLE HT2803 ADD MethodVacationID NVARCHAR(50) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT2803' AND col.name='DaysPrevMonth')
		ALTER TABLE HT2803 ADD DaysPrevMonth DECIMAL(28,8) NULL
	END		
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT2803' AND col.name='DaysInYear')
		ALTER TABLE HT2803 ADD DaysInYear DECIMAL(28,8) NULL
	END	
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT2803' AND col.name='VacSeniorDays')
		ALTER TABLE HT2803 ADD VacSeniorDays DECIMAL(28,8) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT2803' AND col.name='AddDays')
		ALTER TABLE HT2803 ADD AddDays DECIMAL(28,8) NULL
	END	
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HT2803' AND col.name='DaysSpentToMonth')
		ALTER TABLE HT2803 ADD DaysSpentToMonth DECIMAL(28,8) NULL
	END	
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HT2803' AND xtype='U')
	BEGIN
		IF EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT2802_IsAdded]') AND type = 'D')
		ALTER TABLE HT2803 DROP CONSTRAINT [DF_HT2802_IsAdded]
	END	
	
---- Add giá trị default = 0 (1: ghi nhận đã tính phép, 0: chưa tính phép)
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT2802_IsAdded]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2803] ADD  CONSTRAINT [DF_HT2802_IsAdded]  DEFAULT ((0)) FOR [IsAdded]
END	
																	