-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified by Tiểu Mai on 14/03/2016: Bổ sung trường check Giữ lương, Đã nhận lương, Duyệt (ANGEL)
---- Modified by Hải Long on 14/03/2016: Bổ sung trường ghi chú (Notes) (ANGEL)
---- Modified by Văn Tài  on 28/12/2020: Bổ sung trường Ban (SectionID) (NQH)
---- Modified by Nhật Thanh  on 23/09/2022: Bổ sung trường IGAbsentAmount từ 41 đến 200
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS(SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT3400]') AND type in (N'U'))
CREATE TABLE [dbo].[HT3400](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[TeamID] [nvarchar](50) NULL,
	[SectionID] [nvarchar](50) NULL,
	[GeneralCo] [decimal](28, 8) NULL,
	[GeneralAbsentAmount] [decimal](28, 8) NULL,
	[BaseSalary] [decimal](28, 8) NULL,
	[Income01] [decimal](28, 8) NULL,
	[Income02] [decimal](28, 8) NULL,
	[Income03] [decimal](28, 8) NULL,
	[Income04] [decimal](28, 8) NULL,
	[Income05] [decimal](28, 8) NULL,
	[Income06] [decimal](28, 8) NULL,
	[Income07] [decimal](28, 8) NULL,
	[Income08] [decimal](28, 8) NULL,
	[Income09] [decimal](28, 8) NULL,
	[Income10] [decimal](28, 8) NULL,
	[InsAmount] [decimal](28, 8) NULL,
	[HeaAmount] [decimal](28, 8) NULL,
	[TempAmount] [decimal](28, 8) NULL,
	[TraAmount] [decimal](28, 8) NULL,
	[TaxAmount] [decimal](28, 8) NULL,
	[SubAmount01] [decimal](28, 8) NULL,
	[SubAmount02] [decimal](28, 8) NULL,
	[SubAmount03] [decimal](28, 8) NULL,
	[SubAmount04] [decimal](28, 8) NULL,
	[SubAmount05] [decimal](28, 8) NULL,
	[PayRollMethodID] [nvarchar](50) NULL,
	[CreatedUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[SubAmount06] [decimal](28, 8) NULL,
	[SubAmount07] [decimal](28, 8) NULL,
	[SubAmount08] [decimal](28, 8) NULL,
	[SubAmount09] [decimal](28, 8) NULL,
	[SubAmount10] [decimal](28, 8) NULL,
	[IGAbsentAmount01] [decimal](28, 8) NULL,
	[IGAbsentAmount02] [decimal](28, 8) NULL,
	[IGAbsentAmount03] [decimal](28, 8) NULL,
	[IGAbsentAmount04] [decimal](28, 8) NULL,
	[IGAbsentAmount05] [decimal](28, 8) NULL,
	[IGAbsentAmount06] [decimal](28, 8) NULL,
	[IGAbsentAmount07] [decimal](28, 8) NULL,
	[IGAbsentAmount08] [decimal](28, 8) NULL,
	[IGAbsentAmount09] [decimal](28, 8) NULL,
	[IGAbsentAmount10] [decimal](28, 8) NULL,
	[TaxRate] [decimal](28, 8) NULL,
	[Income11] [decimal](28, 8) NULL,
	[Income12] [decimal](28, 8) NULL,
	[Income13] [decimal](28, 8) NULL,
	[Income14] [decimal](28, 8) NULL,
	[Income15] [decimal](28, 8) NULL,
	[Income16] [decimal](28, 8) NULL,
	[Income17] [decimal](28, 8) NULL,
	[Income18] [decimal](28, 8) NULL,
	[Income19] [decimal](28, 8) NULL,
	[Income20] [decimal](28, 8) NULL,
	[SubAmount11] [decimal](28, 8) NULL,
	[SubAmount12] [decimal](28, 8) NULL,
	[SubAmount13] [decimal](28, 8) NULL,
	[SubAmount14] [decimal](28, 8) NULL,
	[SubAmount15] [decimal](28, 8) NULL,
	[SubAmount16] [decimal](28, 8) NULL,
	[SubAmount17] [decimal](28, 8) NULL,
	[SubAmount18] [decimal](28, 8) NULL,
	[SubAmount19] [decimal](28, 8) NULL,
	[SubAmount20] [decimal](28, 8) NULL,
	[IGAbsentAmount11] [decimal](28, 8) NULL,
	[IGAbsentAmount12] [decimal](28, 8) NULL,
	[IGAbsentAmount13] [decimal](28, 8) NULL,
	[IGAbsentAmount14] [decimal](28, 8) NULL,
	[IGAbsentAmount15] [decimal](28, 8) NULL,
	[IGAbsentAmount16] [decimal](28, 8) NULL,
	[IGAbsentAmount17] [decimal](28, 8) NULL,
	[IGAbsentAmount18] [decimal](28, 8) NULL,
	[IGAbsentAmount19] [decimal](28, 8) NULL,
	[IGAbsentAmount20] [decimal](28, 8) NULL,
	[IsOtherDayPerMonth] [tinyint] NULL,
	[IGAbsentAmount21] [decimal](28, 8) NULL,
	[IGAbsentAmount22] [decimal](28, 8) NULL,
	[IGAbsentAmount23] [decimal](28, 8) NULL,
	[IGAbsentAmount24] [decimal](28, 8) NULL,
	[IGAbsentAmount25] [decimal](28, 8) NULL,
	[IGAbsentAmount26] [decimal](28, 8) NULL,
	[IGAbsentAmount27] [decimal](28, 8) NULL,
	[IGAbsentAmount28] [decimal](28, 8) NULL,
	[IGAbsentAmount29] [decimal](28, 8) NULL,
	[IGAbsentAmount30] [decimal](28, 8) NULL,
	[IGAbsentAmount31] [decimal](28, 8) NULL,
	[IGAbsentAmount32] [decimal](28, 8) NULL,
	[IGAbsentAmount33] [decimal](28, 8) NULL,
	[IGAbsentAmount34] [decimal](28, 8) NULL,
	[IGAbsentAmount35] [decimal](28, 8) NULL,
	[IGAbsentAmount36] [decimal](28, 8) NULL,
	[IGAbsentAmount37] [decimal](28, 8) NULL,
	[IGAbsentAmount38] [decimal](28, 8) NULL,
	[IGAbsentAmount39] [decimal](28, 8) NULL,
	[IGAbsentAmount40] [decimal](28, 8) NULL,
	CONSTRAINT [PK_HT3400] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS(SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__HT3400__IsOtherD__71CE2128]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT3400] ADD  CONSTRAINT [DF__HT3400__IsOtherD__71CE2128]  DEFAULT ((0)) FOR [IsOtherDayPerMonth]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT3400' and xtype ='U') 
Begin
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income21')
       Alter Table  HT3400 Add Income21 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income22')
       Alter Table  HT3400 Add Income22 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income23')
       Alter Table  HT3400 Add Income23 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income24')
       Alter Table  HT3400 Add Income24 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income25')
       Alter Table  HT3400 Add Income25 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income26')
       Alter Table  HT3400 Add Income26 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income27')
       Alter Table  HT3400 Add Income27 decimal(28,8) Null       
	   If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income28')
       Alter Table  HT3400 Add Income28 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income29')
       Alter Table  HT3400 Add Income29 decimal(28,8) Null       
       If not exists (select * from syscolumns col inner join sysobjects tab 
       On col.id = tab.id where tab.name =   'HT3400'  and col.name = 'Income30')
       Alter Table  HT3400 Add Income30 decimal(28,8) Null
END

---- Add Columns by Tieu Mai on 14/03/2016
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT3400' and xtype ='U') 
BEGIN
       If not exists (SELECT * FROM syscolumns col inner join sysobjects tab 
       ON col.id = tab.id WHERE tab.name =   'HT3400'  and col.name = 'IsKeepSalary')
       ALTER TABLE HT3400 ADD	IsKeepSalary TINYINT DEFAULT(0),
								IsReceiveSalary TINYINT DEFAULT(0) 
END
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT3400' and xtype ='U') 
BEGIN
       If not exists (SELECT * FROM syscolumns col inner join sysobjects tab 
       ON col.id = tab.id WHERE tab.name =   'HT3400'  and col.name = 'IsConfirm')
       ALTER TABLE HT3400 ADD	IsConfirm TINYINT DEFAULT(0),
								DescriptionConfirm NVARCHAR(250) NULL
END  

---- Bổ sung trường Notes by Hải Long on 13/12/2016
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT3400' and xtype ='U') 
BEGIN
       If not exists (SELECT * FROM syscolumns col inner join sysobjects tab 
       ON col.id = tab.id WHERE tab.name =   'HT3400'  and col.name = 'Notes')
       ALTER TABLE HT3400 ADD Notes NVARCHAR(250) NULL
END  

---- Bổ sung trường SectionID by Văn Tài on 28/12/2020
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'HT3400' and xtype ='U') 
BEGIN
       If not exists (SELECT * FROM syscolumns col inner join sysobjects tab 
       ON col.id = tab.id WHERE tab.name =   'HT3400'  and col.name = 'SectionID')
       ALTER TABLE HT3400 ADD SectionID VARCHAR(50) NULL
END
DECLARE @sSQL nvarchar(500)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT3400' AND xtype = 'U')
BEGIN
	DECLARE @cnt INT = 41
	WHILE @cnt <= 200 
	BEGIN
		SET @sSQL='IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = ''HT3400'' AND col.name = ''IGAbsentAmount'+CONVERT(varchar(10), @cnt)+''')
	ALTER TABLE HT3400 ADD IGAbsentAmount'+CONVERT(varchar(10), @cnt) +' [decimal](28, 8) NULL
		'
		EXECUTE sp_executesql @sSQL
		SET @cnt = @cnt + 1
	END
END