-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Minh Lâm
---- Modified on 14/08/2020 by Huỳnh Thử -- Merge Code: MEKIO và MTE
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT2400]') AND type in (N'U'))
CREATE TABLE [dbo].[HT2400](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,
	[EmpFileID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[DepartmentID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NOT NULL,
	[TeamID] [nvarchar](50) NULL,
	[SalaryCoefficient] [decimal](28, 8) NULL,
	[TimeCoefficient] [decimal](28, 8) NULL,
	[DutyCoefficient] [decimal](28, 8) NULL,
	[BaseSalary] [decimal](28, 8) NULL,
	[Salary01] [decimal](28, 8) NULL,
	[InsuranceSalary] [decimal](28, 8) NULL,
	[Salary02] [decimal](28, 8) NULL,
	[Salary03] [decimal](28, 8) NULL,
	[C01] [decimal](28, 8) NULL,
	[C02] [decimal](28, 8) NULL,
	[C03] [decimal](28, 8) NULL,
	[C04] [decimal](28, 8) NULL,
	[C05] [decimal](28, 8) NULL,
	[C06] [decimal](28, 8) NULL,
	[C07] [decimal](28, 8) NULL,
	[C08] [decimal](28, 8) NULL,
	[C09] [decimal](28, 8) NULL,
	[C10] [decimal](28, 8) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastmodifyUserID] [nvarchar](50) NULL,
	[Orders] [int] NOT NULL,
	[TaxObjectID] [nvarchar](50) NULL,
	[EmployeeStatus] [tinyint] NULL,
	[IsOtherDayPerMonth] [tinyint] NULL,
	[WorkTerm] [decimal](28, 8) NULL,
	[Appointed] [int] NOT NULL,
	[ToDateTranfer] [datetime] NULL,
	[FromDateTranfer] [datetime] NULL,
	[C11] [decimal](28, 8) NULL,
	[C12] [decimal](28, 8) NULL,
	[C13] [decimal](28, 8) NULL,
 CONSTRAINT [PK_HT2400] PRIMARY KEY NONCLUSTERED 
(
	[EmpFileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT2400_Order]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2400] ADD  CONSTRAINT [DF_HT2400_Order]  DEFAULT ((0)) FOR [Orders]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT2400__Employee__5E313CCF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2400] ADD  CONSTRAINT [DF__HT2400__Employee__5E313CCF]  DEFAULT ((1)) FOR [EmployeeStatus]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT2400__IsOtherD__6C7F5C26]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2400] ADD  CONSTRAINT [DF__HT2400__IsOtherD__6C7F5C26]  DEFAULT ((0)) FOR [IsOtherDayPerMonth]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT2400__Appointe__7CB5C3EF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT2400] ADD  CONSTRAINT [DF__HT2400__Appointe__7CB5C3EF]  DEFAULT ((0)) FOR [Appointed]
END
---- Add Columns
-- Thêm cột Notes01 - Notes16 vào bảng HT2400
IF(ISNULL(COL_LENGTH('HT2400', 'Notes01'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes01 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes02'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes02 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes03'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes03 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes04'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes04 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes05'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes05 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes06'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes06 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes07'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes07 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes08'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes08 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes09'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes09 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes10'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes10 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes11'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes11 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes12'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes12 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes13'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes13 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes14'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes14 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes15'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes15 nvarchar(50) NULL 
IF(ISNULL(COL_LENGTH('HT2400', 'Notes16'), 0) <= 0)
ALTER TABLE HT2400 ADD Notes16 nvarchar(50) NULL
If Exists (Select * From sysobjects Where name = 'HT2400' and xtype ='U') 
Begin
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C14')
       Alter Table  HT2400 Add C14 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C15')
       Alter Table  HT2400 Add C15 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C16')
       Alter Table  HT2400 Add C16 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C17')
       Alter Table  HT2400 Add C17 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C18')
       Alter Table  HT2400 Add C18 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C19')
       Alter Table  HT2400 Add C19 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C20')
       Alter Table  HT2400 Add C20 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C21')
       Alter Table  HT2400 Add C21 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C22')
       Alter Table  HT2400 Add C22 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C23')
       Alter Table  HT2400 Add C23 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C24')
       Alter Table  HT2400 Add C24 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'C25')
       Alter Table  HT2400 Add C25 decimal(28,8) Null
END
-- Thêm cột Notes17 - Notes28 vào bảng HT2400
If Exists (Select * From sysobjects Where name = 'HT2400' and xtype ='U') 
Begin
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes17')
       Alter Table  HT2400 Add Notes17 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes18')
       Alter Table  HT2400 Add Notes18 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes19')
       Alter Table  HT2400 Add Notes19 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes20')
       Alter Table  HT2400 Add Notes20 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes21')
       Alter Table  HT2400 Add Notes21 nvarchar(50) Null
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes22')
       Alter Table  HT2400 Add Notes22 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes23')
       Alter Table  HT2400 Add Notes23 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes24')
       Alter Table  HT2400 Add Notes24 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes25')
       Alter Table  HT2400 Add Notes25 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes26')
       Alter Table  HT2400 Add Notes26 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes27')
       Alter Table  HT2400 Add Notes27 nvarchar(50) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'Notes28')
       Alter Table  HT2400 Add Notes28 nvarchar(50) Null
END
If Exists (Select * From sysobjects Where name = 'HT2400' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'IsJobWage')
           Alter Table  HT2400 Add IsJobWage tinyint Null
End 
If Exists (Select * From sysobjects Where name = 'HT2400' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT2400'  and col.name = 'IsPiecework')
           Alter Table  HT2400 Add IsPiecework tinyint Null
End 

--- Modified by Bảo Thy on 07/02/2017
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'EndDate') 
   ALTER TABLE HT2400 ADD EndDate DATETIME NULL 
END

DECLARE @CustomerIndex INT 
SELECT @CustomerIndex = CustomerName FROM dbo.CustomerIndex 
----- Modify by Huỳnh Thử on 14/08/2020: Merge Code: MEKIO và MTE
IF(@CustomerIndex= 50 OR @CustomerIndex= 115)
BEGIN
	--- Modified by Phương Thảo on 08/12/2017
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana01ID') 
	   ALTER TABLE HT2400 ADD Ana01ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana01ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana02ID') 
	   ALTER TABLE HT2400 ADD Ana02ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana02ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana03ID') 
	   ALTER TABLE HT2400 ADD Ana03ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana03ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana04ID') 
	   ALTER TABLE HT2400 ADD Ana04ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana04ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana05ID') 
	   ALTER TABLE HT2400 ADD Ana05ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana05ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana06ID') 
	   ALTER TABLE HT2400 ADD Ana06ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana06ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana07ID') 
	   ALTER TABLE HT2400 ADD Ana07ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana07ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana08ID') 
	   ALTER TABLE HT2400 ADD Ana08ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana08ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana09ID') 
	   ALTER TABLE HT2400 ADD Ana09ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana09ID===============================================*/ 

	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'Ana10ID') 
	   ALTER TABLE HT2400 ADD Ana10ID NVARCHAR(50) NULL 
	END

	/*===============================================END Ana10ID===============================================*/ 


	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
	BEGIN 
	   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'DutyID') 
	   ALTER TABLE HT2400 ADD DutyID NVARCHAR(50) NULL 
	END
END

----Modified by Kiều Nga on 11/12/2020: Bổ sung check đã bắn hệ số huê hồng xuống erp8
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT2400' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT2400' AND col.name = 'IsInheritRevenueCoefficient')
    ALTER TABLE HT2400 ADD IsInheritRevenueCoefficient Tinyint NULL
END