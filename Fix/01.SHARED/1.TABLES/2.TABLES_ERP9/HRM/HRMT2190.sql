-- <Summary>
---- 
-- <History>
---- Create on 17/08/2010 by Phương Thảo ---Tham khảo HT2460(màn hình hồ sơ bảo hiểm ở bản 8)

IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HRMT2190]') AND type in (N'U'))
CREATE TABLE [dbo].[HRMT2190](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[InsurFileID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[DepartmentID] [nvarchar](50) NOT NULL,
	[TeamID] [nvarchar](50) NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[SNo] [nvarchar](50) NULL,
	[SBeginDate] [datetime] NULL,
	[HNo] [nvarchar](50) NULL,
	[HFromDate] [datetime] NULL,
	[HToDate] [datetime] NULL,
	[CNo] [nvarchar](50) NULL,
	[CFromDate] [datetime] NULL,
	[CToDate] [datetime] NULL,
	[HospitalID] [nvarchar](50) NULL,
	[Basesalary] [decimal](28, 8) NULL,
	[InsuranceSalary] [decimal](28, 8) NULL,
	[Salary01] [decimal](28, 8) NULL,
	[Salary02] [decimal](28, 8) NULL,
	[Salary03] [decimal](28, 8) NULL,
	[IsS] [tinyint] NOT NULL,
	[IsH] [tinyint] NOT NULL,
	[IsT] [tinyint] NOT NULL,
	[Notes] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	CONSTRAINT [PK_HRMT2190] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_Basesalary]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_Basesalary]  DEFAULT ((0)) FOR [Basesalary]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_InsuranceSalary]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_InsuranceSalary]  DEFAULT ((0)) FOR [InsuranceSalary]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_Salary01]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_Salary01]  DEFAULT ((0)) FOR [Salary01]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_Salary02]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_Salary02]  DEFAULT ((0)) FOR [Salary02]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190]  DEFAULT ((0)) FOR [Salary03]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_IsS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_IsS]  DEFAULT ((1)) FOR [IsS]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_IsH]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_IsH]  DEFAULT ((1)) FOR [IsH]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HRMT2190_IsT]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HRMT2190] ADD  CONSTRAINT [DF_HRMT2190_IsT]  DEFAULT ((1)) FOR [IsT]
END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HRMT2190' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HRMT2190' AND col.name = 'DutyID')
        ALTER TABLE HRMT2190 ADD DutyID VARCHAR(50) NULL
    END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='HRMT2190' AND xtype='U')
	BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='HRMT2190' AND col.name='DeleteFlg')
		ALTER TABLE HRMT2190 ADD DeleteFlg TINYINT DEFAULT (0) NULL
	END