-- <Summary>
---- 
-- <History>
---- Create on 25/09/2012 by Huỳnh Tấn Phú
---- Modify on 12/12/2013 by Bảo Anh: Bổ sung trường ShortName, Alias
---- Modify on 12/12/2013 by Bảo Anh: Bổ sung trường thực lãnh và thuế TNCN
---- Modified on 21/01/2015 by Thanh Sơn: bổ sung thêm 3 trường cho SG Petro
---- Modified on 28/01/2016 by Bảo Anh: Bổ sung thêm 3 trường IdentifyDate, IdentifyPlace, ArmyLevel
---- Modified on 27/12/2016 by Hải Long: Bổ sung thêm 3 trường IsKeepSalary, IsReceiveSalary, Notes_HT3400 (ANGEL)
---- Modified by Bảo Anh on 01/03/2018: Bổ sung thêm 3 trường ShiftID01, ShiftID02, ShiftID03 cho GodRej
---- Modified by Bảo Anh on 11/05/2018: Bổ sung thêm 3 trường ShiftID01_SUN, ShiftID02_SUN, ShiftID03_SUN cho GodRej
---- Modified by Kim Thư on 06/12/2018: Bổ sung CountryName, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05
---- Modified by Kim Thư on 31/12/2018: Bổ sung AbsentCardNo NVARCHAR(50)
---- Modified by Kim Thư on 23/01/2019 : sửa kiểu dữ liệu VARCHAR(50) cho 6 cột Shift
---- Modified by Kim Thư on 21/03/2019 : Bổ sung TeamNotes - Ghi chú của tổ nhóm
---- Modified by Kim Thư on 05/06/2019: Bổ sung 12 cột Lương đóng BHXH từng tháng cho GodRej
---- Modified by Nhật Thanh on 15/08/2022: Bổ sung cột Lương đến ColumnAmount200

---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT7110]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HT7110](
	[APK] [uniqueidentifier] NULL DEFAULT NEWID(),
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[STT] [int] NULL,
	[DivisionID] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[DepartmentName] [nvarchar](250) NULL,
	[TeamID] [nvarchar](50) NULL,
	[TeamName] [nvarchar](250) NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](250) NULL,
	[IdentifyCardNo] [nvarchar](50) NULL,
	[BankID] [nvarchar](50) NULL,
	[BankName] [nvarchar](250) NULL,
	[BankAccountNo] [nvarchar](50) NULL,
	[DutyID] [nvarchar](50) NULL,
	[DutyName] [nvarchar](250) NULL,
	[Orders] [int] NULL,
	[Groups] [tinyint] NULL,
	[BaseSalary] [decimal](28, 8) NULL,
	[ColumnAmount01] [decimal](28, 8) NULL,
	[ColumnAmount02] [decimal](28, 8) NULL,
	[ColumnAmount03] [decimal](28, 8) NULL,
	[ColumnAmount04] [decimal](28, 8) NULL,
	[ColumnAmount05] [decimal](28, 8) NULL,
	[ColumnAmount06] [decimal](28, 8) NULL,
	[ColumnAmount07] [decimal](28, 8) NULL,
	[ColumnAmount08] [decimal](28, 8) NULL,
	[ColumnAmount09] [decimal](28, 8) NULL,
	[ColumnAmount10] [decimal](28, 8) NULL,
	[ColumnAmount11] [decimal](28, 8) NULL,
	[ColumnAmount12] [decimal](28, 8) NULL,
	[ColumnAmount13] [decimal](28, 8) NULL,
	[ColumnAmount14] [decimal](28, 8) NULL,
	[ColumnAmount15] [decimal](28, 8) NULL,
	[ColumnAmount16] [decimal](28, 8) NULL,
	[ColumnAmount17] [decimal](28, 8) NULL,
	[ColumnAmount18] [decimal](28, 8) NULL,
	[ColumnAmount19] [decimal](28, 8) NULL,
	[ColumnAmount20] [decimal](28, 8) NULL,
	[ColumnAmount21] [decimal](28, 8) NULL,
	[ColumnAmount22] [decimal](28, 8) NULL,
	[ColumnAmount23] [decimal](28, 8) NULL,
	[ColumnAmount24] [decimal](28, 8) NULL,
	[ColumnAmount25] [decimal](28, 8) NULL,
	[ColumnAmount26] [decimal](28, 8) NULL,
	[ColumnAmount27] [decimal](28, 8) NULL,
	[ColumnAmount28] [decimal](28, 8) NULL,
	[ColumnAmount29] [decimal](28, 8) NULL,
	[ColumnAmount30] [decimal](28, 8) NULL,
	[ColumnAmount31] [decimal](28, 8) NULL,
	[ColumnAmount32] [decimal](28, 8) NULL,
	[ColumnAmount33] [decimal](28, 8) NULL,
	[ColumnAmount34] [decimal](28, 8) NULL,
	[ColumnAmount35] [decimal](28, 8) NULL,
	[ColumnAmount36] [decimal](28, 8) NULL,
	[ColumnAmount37] [decimal](28, 8) NULL,
	[ColumnAmount38] [decimal](28, 8) NULL,
	[ColumnAmount39] [decimal](28, 8) NULL,
	[ColumnAmount40] [decimal](28, 8) NULL,
	[ColumnAmount41] [decimal](28, 8) NULL,
	[ColumnAmount42] [decimal](28, 8) NULL,
	[ColumnAmount43] [decimal](28, 8) NULL,
	[ColumnAmount44] [decimal](28, 8) NULL,
	[ColumnAmount45] [decimal](28, 8) NULL,
	[ColumnAmount46] [decimal](28, 8) NULL,
	[ColumnAmount47] [decimal](28, 8) NULL,
	[ColumnAmount48] [decimal](28, 8) NULL,
	[ColumnAmount49] [decimal](28, 8) NULL,
	[ColumnAmount50] [decimal](28, 8) NULL,
	[WorkDate] [datetime] NULL,
	[LeaveDate] [datetime] NULL,

 CONSTRAINT [PK__HT7110__47ED27BF] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
---- Add Columns
--- Thêm field bảng HT7110
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT7110' AND xtype = 'U') 
BEGIN
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Birthday')
    ALTER TABLE HT7110 ADD Birthday datetime NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'PersonalTaxID')
    ALTER TABLE HT7110 ADD PersonalTaxID NVARCHAR(50) NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'EducationLevelID')
    ALTER TABLE HT7110 ADD EducationLevelID nvarchar(50) NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'EducationLevelName')
    ALTER TABLE HT7110 ADD EducationLevelName nvarchar(250) NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'MajorID')
    ALTER TABLE HT7110 ADD MajorID NVARCHAR(50) NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'MajorName')
    ALTER TABLE HT7110 ADD MajorName NVARCHAR(250) NULL	
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShortName')
    ALTER TABLE HT7110 ADD ShortName NVARCHAR(50) NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Alias')
    ALTER TABLE HT7110 ADD Alias NVARCHAR(50) NULL        
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Total')
    ALTER TABLE HT7110 ADD Total decimal(28,8) NULL    
    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'TaxAmount')
    ALTER TABLE HT7110 ADD TaxAmount decimal(28,8) NULL   
END 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ExpenseAccountID')
		ALTER TABLE HT7110 ADD ExpenseAccountID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'PayableAccountID')
		ALTER TABLE HT7110 ADD PayableAccountID VARCHAR(50) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'PerInTaxID')
		ALTER TABLE HT7110 ADD PerInTaxID VARCHAR(50) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'TranMonth')
		ALTER TABLE HT7110 ADD TranMonth INT NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'TranYear')
		ALTER TABLE HT7110 ADD TranYear INT NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'IdentifyDate')
		ALTER TABLE HT7110 ADD IdentifyDate datetime NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'IdentifyPlace')
		ALTER TABLE HT7110 ADD IdentifyPlace NVARCHAR(250) NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ArmyLevel')
		ALTER TABLE HT7110 ADD ArmyLevel NVARCHAR(100) NULL
	END
	
-- Bổ sung thêm 3 trường IsKeepSalary, IsReceiveSalary, Notes_HT3400 (ANGEL)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'IsKeepSalary')
		ALTER TABLE HT7110 ADD IsKeepSalary TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'IsReceiveSalary')
		ALTER TABLE HT7110 ADD IsReceiveSalary TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Notes_HT3400')
		ALTER TABLE HT7110 ADD Notes_HT3400 NVARCHAR(250) NULL
	END	
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID01')
		ALTER TABLE HT7110 ADD ShiftID01 TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID02')
		ALTER TABLE HT7110 ADD ShiftID02 TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID03')
		ALTER TABLE HT7110 ADD ShiftID03 TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID01_SUN')
		ALTER TABLE HT7110 ADD ShiftID01_SUN TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID02_SUN')
		ALTER TABLE HT7110 ADD ShiftID02_SUN TINYINT NULL

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID03_SUN')
		ALTER TABLE HT7110 ADD ShiftID03_SUN TINYINT NULL
	END

---- Modified by Kim Thư on 06/12/2018: Bổ sung CountryName, Parameter01, Parameter02, Parameter03, Parameter04, Parameter05
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'CountryName')
	ALTER TABLE HT7110 ADD CountryName NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Parameter01')
	ALTER TABLE HT7110 ADD Parameter01 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Parameter02')
	ALTER TABLE HT7110 ADD Parameter02 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Parameter03')
	ALTER TABLE HT7110 ADD Parameter03 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Parameter04')
	ALTER TABLE HT7110 ADD Parameter04 NVARCHAR(250) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'Parameter05')
	ALTER TABLE HT7110 ADD Parameter05 NVARCHAR(250) NULL
END

---- Modified by Kim Thư on 31/12/2018: Bổ sung AbsentCardNo NVARCHAR(50)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'AbsentCardNo')
	ALTER TABLE HT7110 ADD AbsentCardNo NVARCHAR(50) NULL
END

---- Modified by Hoàng Trúc on 23/01/2019 : sửa kiểu dữ liệu VARCHAR(50) 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID01')
		ALTER TABLE HT7110 ALTER COLUMN ShiftID01 VARCHAR(50) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID02')
		ALTER TABLE HT7110 ALTER COLUMN ShiftID02 VARCHAR(50) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID03')
		ALTER TABLE HT7110 ALTER COLUMN ShiftID03 VARCHAR(50) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID01_SUN')
		ALTER TABLE HT7110 ALTER COLUMN ShiftID01_SUN VARCHAR(50) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID02_SUN')
		ALTER TABLE HT7110 ALTER COLUMN ShiftID02_SUN VARCHAR(50) NULL

		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'ShiftID03_SUN')
		ALTER TABLE HT7110 ALTER COLUMN ShiftID03_SUN VARCHAR(50) NULL
	END
---- Modified by Kim Thư on 21/03/2019 : Bổ sung TeamNotes - Ghi chú của tổ nhóm
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'TeamNotes')
		ALTER TABLE HT7110 ADD TeamNotes NVARCHAR(MAX) NULL
	END

---- Modified by Kim Thư on 05/06/2019: Bổ sung 12 cột Lương đóng BHXH từng tháng cho GodRej
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_1')
	ALTER TABLE HT7110 ADD InCome25_1 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_2')
	ALTER TABLE HT7110 ADD InCome25_2 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_3')
	ALTER TABLE HT7110 ADD InCome25_3 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_4')
	ALTER TABLE HT7110 ADD InCome25_4 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_5')
	ALTER TABLE HT7110 ADD InCome25_5 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_6')
	ALTER TABLE HT7110 ADD InCome25_6 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_7')
	ALTER TABLE HT7110 ADD InCome25_7 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_8')
	ALTER TABLE HT7110 ADD InCome25_8 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_9')
	ALTER TABLE HT7110 ADD InCome25_9 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_10')
	ALTER TABLE HT7110 ADD InCome25_10 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_11')
	ALTER TABLE HT7110 ADD InCome25_11 DECIMAL(28,8) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InCome25_12')
	ALTER TABLE HT7110 ADD InCome25_12 DECIMAL(28,8) NULL

	
	---- Modified by Văn Tài on 15/09/2022: Bổ sung cột PayrollMethodID Để đáp ứng thiết lập lương HQ7110, HT7110 chưa đổ dữ liệu cột này.
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'PayrollMethodID')
	ALTER TABLE HT7110 ADD PayrollMethodID VARCHAR(50) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'InLateCount')
	ALTER TABLE HT7110 ADD InLateCount INT DEFAULT(0) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'HT7110' AND col.name = 'OutEarlyCount')
	ALTER TABLE HT7110 ADD OutEarlyCount INT DEFAULT(0) NULL
END

DECLARE @sSQL NVARCHAR(4000) = ''
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT7110' AND xtype = 'U')
BEGIN
	DECLARE @cnt INT = 51
	WHILE @cnt <= 200 
	BEGIN
		SET @sSQL='IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = ''HT7110'' AND col.name = ''ColumnAmount'+CONVERT(varchar(10), @cnt)+''')
	ALTER TABLE HT7110 ADD ColumnAmount'+CONVERT(varchar(10), @cnt) +' [decimal](28, 8) NULL
		'
		EXECUTE sp_executesql @sSQL
		SET @cnt = @cnt + 1
	END
END