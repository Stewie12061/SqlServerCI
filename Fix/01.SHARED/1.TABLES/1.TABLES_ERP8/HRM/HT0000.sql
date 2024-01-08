-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modify on 14/08/2013 by Bao Anh: Bo sung cho Thuan Loi de tao du lieu cham cong cho data thue
---- Modify on 10/09/2020 by Văn Tài: Bổ sung các cột từ 8.3.7 DA sang.
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT0000]') AND type in (N'U'))
CREATE TABLE [dbo].[HT0000](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] nvarchar(3) NOT NULL,	
	[TranMonth] [int] NOT NULL,
	[TranYear] [int] NULL,
	[ExpenseAccountID] [nvarchar](50) NULL,
	[PayableAccountID] [nvarchar](50) NULL,
	[TimeConvert] [decimal](28, 8) NOT NULL,
	[PayrollMethodID] [nvarchar](50) NULL,
	[DayPerMonth] [decimal](28, 8) NULL,
	[LenAbsentCardNo] [int] NULL,
	[RateExchange] [decimal](28, 8) NOT NULL,
	[OtherDayPerMonth] [decimal](28, 8) NULL,
	[IsOtherDayPerMonth] [tinyint] NULL,
	[CoefficientDecimals] [tinyint] NOT NULL,
	[AbsentDecimals] [tinyint] NOT NULL,
	[OriginalDecimals] [tinyint] NOT NULL,
	[ConvertedDecimals] [tinyint] NOT NULL,
	[PriceDecimals] [tinyint] NOT NULL,
	[QuantityDecimals] [tinyint] NOT NULL,
	[OthersDecimals] [tinyint] NOT NULL,
	[GAbsentLoanID] [nvarchar](50) NULL,
	[OtherDecimals] [int] NULL,
	[ProductAbsentMethod] [tinyint] NOT NULL,
	[ConvertedProductAbsent] [tinyint] NOT NULL,
	[WdEmployeeHost] [NVARCHAR](MAX) NULL,
	[WdEmployeeUser] [NVARCHAR](50) NULL,
	[WdEmployeePassword] [NVARCHAR](50) NULL
	CONSTRAINT [PK_HT0000] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__RateExch__51CB65EA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__RateExch__51CB65EA]  DEFAULT ((1)) FOR [RateExchange]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__Coeffici__0D0205A8]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__Coeffici__0D0205A8]  DEFAULT ((2)) FOR [CoefficientDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__AbsentDe__0DF629E1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__AbsentDe__0DF629E1]  DEFAULT ((2)) FOR [AbsentDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__Original__0EEA4E1A]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__Original__0EEA4E1A]  DEFAULT ((3)) FOR [OriginalDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__Converte__0FDE7253]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__Converte__0FDE7253]  DEFAULT ((3)) FOR [ConvertedDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__PriceDec__10D2968C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__PriceDec__10D2968C]  DEFAULT ((3)) FOR [PriceDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__Quantity__11C6BAC5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__Quantity__11C6BAC5]  DEFAULT ((2)) FOR [QuantityDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__OthersDe__12BADEFE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__OthersDe__12BADEFE]  DEFAULT ((0)) FOR [OthersDecimals]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__ProductA__1C1337C1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__ProductA__1C1337C1]  DEFAULT ((0)) FOR [ProductAbsentMethod]
END
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT0000__Converte__1D075BFA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0000] ADD  CONSTRAINT [DF__HT0000__Converte__1D075BFA]  DEFAULT ((0)) FOR [ConvertedProductAbsent]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT0000' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'AdvanceAccountID')
		Alter Table  HT0000 Add AdvanceAccountID nvarchar(50) Null        
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'TargetData')
		Alter Table  HT0000 Add TargetData nvarchar(50) NULL           
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'LateBeginPermit')
		Alter Table  HT0000 Add LateBeginPermit int NULL           
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'EarlyEndPermit')
		Alter Table  HT0000 Add EarlyEndPermit int NULL           
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'WorkMarks')
		Alter Table  HT0000 Add WorkMarks int NULL           
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'RegulationsMarks')
		Alter Table  HT0000 Add RegulationsMarks int NULL           
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'BankAccountID')
		Alter Table  HT0000 Add BankAccountID nvarchar(50) NULL           
    
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'MinSalary')
		Alter Table  HT0000 Add MinSalary decimal(28,8) NULL           
    
	IF not exists (SELECT * FROM syscolumns col inner join sysobjects tab 
    ON col.id = tab.id WHERE tab.name =   'HT0000'  and col.name = 'IsWarningBirthday')
		ALTER TABLE  HT0000 ADD IsWarningBirthday INT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'PerInTaxID')
		Alter Table  HT0000 Add PerInTaxID nvarchar(50) Null

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'IsTranEntrySalary')
        Alter Table  HT0000 Add IsTranEntrySalary tinyint Not Null Default(0)

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'IsTranferEmployee')
        Alter Table  HT0000 Add IsTranferEmployee tinyint Not Null Default(0)

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'IsWarningContract')
        Alter Table  HT0000 Add IsWarningContract int Null Default(-1)

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'IsWarningIDDef')
        Alter Table  HT0000 Add IsWarningIDDef int Null Default(-1)

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'IsWarningPassport')
        Alter Table  HT0000 Add IsWarningPassport int Null Default(-1)

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'IsWarningDrivingLic')
        Alter Table  HT0000 Add IsWarningDrivingLic int Null Default(-1)

	--- Modify on 02/12/2015 by Bảo Anh: Bổ sung loại công đi trễ/về sớm trừ tiền (IPL)
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'InOutAbsentTypeID')
        Alter Table  HT0000 Add InOutAbsentTypeID nvarchar(50) Null

	--- Modify on 14/12/2015 by Bảo Anh: Bổ sung loại công cộng thêm cho nhân viên nữ (Meiko)
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'FEAbsentTypeID')
        Alter Table  HT0000 Add FEAbsentTypeID nvarchar(50) Null

	--- Modify on 28/12/2015 by Phương Thảo: Bổ sung thiết lập cảnh báo hợp đồng sắp hết hạn cho NV thử việc
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'WarningContractCandidate')
        Alter Table  HT0000 Add WarningContractCandidate int Null

	--- Modify on 27/04/2016 by Bảo Anh: Bổ sung loại công đi trễ/về sớm trừ công (IPL)
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'InOutAbsentTypeID_H')
    Alter Table  HT0000 Add InOutAbsentTypeID_H nvarchar(50) Null
	
	--- Modified by Tiểu Mai on 30/11/2016: Bổ sung số lẻ ngày nghỉ phép
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'HolidayDecimals')
	Alter Table  HT0000 Add HolidayDecimals TINYINT NULL
END

--- Modify by Phương Thảo on 15/11/2016: Loại công thực tế (nv chính thức & nv thử việc)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'CActAbsentTypeID')
    ALTER TABLE HT0000 ADD CActAbsentTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'TActAbsentTypeID')
    ALTER TABLE HT0000 ADD TActAbsentTypeID VARCHAR(50) NULL
END


--- Modified by Phương Thảo on 03/01/2017: Bổ sung thiết lập thông tin tính bảo hiểm  
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'MinAreaSalary') 
   ALTER TABLE HT0000 ADD MinAreaSalary DECIMAL(28,8) NULL 
END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'MinAbsenthours') 
   ALTER TABLE HT0000 ADD MinAbsenthours DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'MaxSalary1') 
   ALTER TABLE HT0000 ADD MaxSalary1 DECIMAL(28,8) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'MaxSalary2') 
   ALTER TABLE HT0000 ADD MaxSalary2 DECIMAL(28,8) NULL 
END

--- Modified by Tiểu Mai on 17/11/2016: Bổ sung thiết lập số ngày phép còn lại vào hệ số lương cho nv nghỉ việc
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'VacationFactor')
Alter Table  HT0000 Add VacationFactor NVARCHAR(50) NULL

--- Modified by Tiểu Mai on 17/11/2016: Bổ sung thiết lập mẫu email duyệt
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'EmailApprove')
Alter Table  HT0000 Add EmailApprove NVARCHAR(50) NULL

--- Modified by Tiểu Mai on 17/11/2016: Bổ sung thiết lập mẫu email đề nghị
If not exists (select * from syscolumns col inner join sysobjects tab 
On col.id = tab.id where tab.name = 'HT0000'  and col.name = 'EmailSuggest')
Alter Table  HT0000 Add EmailSuggest NVARCHAR(50) NULL
   
--- Modified by Phương Thảo on 28/06/2017: Bổ sung thiết lập không phân biệt giờ chấm công vào/ra
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'IsNotIO') 
   ALTER TABLE HT0000 ADD IsNotIO TINYINT NULL 
END

--- Modified by Văn Tài on 12/11/2019: Bổ sung thiết lập WebDav lưu trữ file.
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'WdEmployeeHost') 
   ALTER TABLE HT0000 ADD WdEmployeeHost [NVARCHAR](MAX) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'WdEmployeeUser') 
   ALTER TABLE HT0000 ADD WdEmployeeUser [NVARCHAR](50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'WdEmployeePassword') 
   ALTER TABLE HT0000 ADD WdEmployeePassword [NVARCHAR](50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0000' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'KPIWarningMarks') 
   ALTER TABLE HT0000 ADD KPIWarningMarks TINYINT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'AppraisalWarningMarks') 
   ALTER TABLE HT0000 ADD AppraisalWarningMarks TINYINT NULL 
END

---- 19/10/2019 - Vĩnh Tâm: Bổ sung cột TargetRateDecimals
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'HT0000' AND col.name = 'TargetRateDecimals')
BEGIN
	ALTER TABLE HT0000 ADD TargetRateDecimals TINYINT DEFAULT 4
END

---- Modified on 22/11/2018 by Kim Thư: Bổ sung WarningFamilyDecrease - số ngày cảnh báo sắp hết hiệu lực giảm trừ gia cảnh (Angel)  
If Exists (Select * From sysobjects Where name = 'HT0000' and xtype ='U') 
Begin
    If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'WarningFamilyDecrease')
		Alter Table  HT0000 Add WarningFamilyDecrease INT Null        

	
	--- Modified by Văn Tài on 09/09/2022: Bổ sung 2 trường khai báo trường hệ số Khen thưởng/Kỷ thuật để tính lương.
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'CoefficientReward')
		Alter Table  HT0000 Add CoefficientReward VARCHAR(50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'HT0000'  and col.name = 'CoefficientDiscipline')
		Alter Table  HT0000 Add CoefficientDiscipline VARCHAR(50) NULL
End