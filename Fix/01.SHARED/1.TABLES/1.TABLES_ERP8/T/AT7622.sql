-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Thanh Nguyen
---- Modified on 17/04/2013 by Lê Thị Thu Hiền
---- Modified on 24/05/2013 by Bảo Quỳnh
---- Modified on 11/1/2019 by Kim Thư: Bổ sung cột Amount00: Lũy kế từ đầu năm của kỳ hiện tại đến kỳ hiện tại
---- <Example>
/****** Object:  Table [dbo].[AT7622]    Script Date: 07/23/2010 11:24:45 ******/
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT7622]') AND type in (N'U'))
CREATE TABLE [dbo].[AT7622](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] [nvarchar](50) NOT NULL,
	[ReportCode] [nvarchar](50) NOT NULL,
	[LineID] [nvarchar](50) NOT NULL,
	[Amount01] [decimal](28, 8) NULL,
	[Amount02] [decimal](28, 8) NULL,
	[Amount03] [decimal](28, 8) NULL,
	[Amount04] [decimal](28, 8) NULL,
	[Amount05] [decimal](28, 8) NULL,
	[Amount06] [decimal](28, 8) NULL,
	[Amount07] [decimal](28, 8) NULL,
	[Amount08] [decimal](28, 8) NULL,
	[Amount09] [decimal](28, 8) NULL,
	[Amount10] [decimal](28, 8) NULL,
	[Amount11] [decimal](28, 8) NULL,
	[Amount12] [decimal](28, 8) NULL,
	[Amount13] [decimal](28, 8) NULL,
	[Amount14] [decimal](28, 8) NULL,
	[Amount15] [decimal](28, 8) NULL,
	[Amount16] [decimal](28, 8) NULL,
	[Amount17] [decimal](28, 8) NULL,
	[Amount18] [decimal](28, 8) NULL,
	[Amount19] [decimal](28, 8) NULL,
	[Amount20] [decimal](28, 8) NULL,
CONSTRAINT [PK_AT7622] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT7622' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7622'  and col.name = 'Amount21')
           Alter Table  AT7622 Add Amount21 decimal(28,8) Null
End 
If Exists (Select * From sysobjects Where name = 'AT7622' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7622'  and col.name = 'Amount22')
           Alter Table  AT7622 Add Amount22 decimal(28,8) Null
End 
If Exists (Select * From sysobjects Where name = 'AT7622' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7622'  and col.name = 'Amount23')
           Alter Table  AT7622 Add Amount23 decimal(28,8) Null
End 
If Exists (Select * From sysobjects Where name = 'AT7622' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7622'  and col.name = 'Amount24')
           Alter Table  AT7622 Add Amount24 decimal(28,8) Null
End 
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount01LastPeriod')  ALTER TABLE AT7622 ADD Amount01LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount02LastPeriod')  ALTER TABLE AT7622 ADD Amount02LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount03LastPeriod')  ALTER TABLE AT7622 ADD Amount03LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount04LastPeriod')  ALTER TABLE AT7622 ADD Amount04LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount05LastPeriod')  ALTER TABLE AT7622 ADD Amount05LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount06LastPeriod')  ALTER TABLE AT7622 ADD Amount06LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount07LastPeriod')  ALTER TABLE AT7622 ADD Amount07LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount08LastPeriod')  ALTER TABLE AT7622 ADD Amount08LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount09LastPeriod')  ALTER TABLE AT7622 ADD Amount09LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount10LastPeriod')  ALTER TABLE AT7622 ADD Amount10LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount11LastPeriod')  ALTER TABLE AT7622 ADD Amount11LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount12LastPeriod')  ALTER TABLE AT7622 ADD Amount12LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount13LastPeriod')  ALTER TABLE AT7622 ADD Amount13LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount14LastPeriod')  ALTER TABLE AT7622 ADD Amount14LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount15LastPeriod')  ALTER TABLE AT7622 ADD Amount15LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount16LastPeriod')  ALTER TABLE AT7622 ADD Amount16LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount17LastPeriod')  ALTER TABLE AT7622 ADD Amount17LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount18LastPeriod')  ALTER TABLE AT7622 ADD Amount18LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount19LastPeriod')  ALTER TABLE AT7622 ADD Amount19LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount20LastPeriod')  ALTER TABLE AT7622 ADD Amount20LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount21LastPeriod')  ALTER TABLE AT7622 ADD Amount21LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount22LastPeriod')  ALTER TABLE AT7622 ADD Amount22LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount23LastPeriod')  ALTER TABLE AT7622 ADD Amount23LastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount24LastPeriod')  ALTER TABLE AT7622 ADD Amount24LastPeriod decimal(28,8)

----------- Modify by Phuong Thao on 30/09/2016: Bo sung group theo ma phan tich
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupID1')  ALTER TABLE AT7622 ADD GroupID1 Varchar(50)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupID2')  ALTER TABLE AT7622 ADD GroupID2 Varchar(50)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupID3')  ALTER TABLE AT7622 ADD GroupID3 Varchar(50)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupID4')  ALTER TABLE AT7622 ADD GroupID4 Varchar(50)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupID5')  ALTER TABLE AT7622 ADD GroupID5 Varchar(50)

IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupName1')  ALTER TABLE AT7622 ADD GroupName1 NVarchar(250)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupName2')  ALTER TABLE AT7622 ADD GroupName2 NVarchar(250)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupName3')  ALTER TABLE AT7622 ADD GroupName3 NVarchar(250)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupName4')  ALTER TABLE AT7622 ADD GroupName4 NVarchar(250)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'GroupName5')  ALTER TABLE AT7622 ADD GroupName5 NVarchar(250)

----------- Modify by Hải Long on 21/04/2017: Bổ sung cột thành tiền USD PACIFIC
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount01A')  ALTER TABLE AT7622 ADD Amount01A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount02A')  ALTER TABLE AT7622 ADD Amount02A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount03A')  ALTER TABLE AT7622 ADD Amount03A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount04A')  ALTER TABLE AT7622 ADD Amount04A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount05A')  ALTER TABLE AT7622 ADD Amount05A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount06A')  ALTER TABLE AT7622 ADD Amount06A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount07A')  ALTER TABLE AT7622 ADD Amount07A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount08A')  ALTER TABLE AT7622 ADD Amount08A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount09A')  ALTER TABLE AT7622 ADD Amount09A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount10A')  ALTER TABLE AT7622 ADD Amount10A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount11A')  ALTER TABLE AT7622 ADD Amount11A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount12A')  ALTER TABLE AT7622 ADD Amount12A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount13A')  ALTER TABLE AT7622 ADD Amount13A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount14A')  ALTER TABLE AT7622 ADD Amount14A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount15A')  ALTER TABLE AT7622 ADD Amount15A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount16A')  ALTER TABLE AT7622 ADD Amount16A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount17A')  ALTER TABLE AT7622 ADD Amount17A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount18A')  ALTER TABLE AT7622 ADD Amount18A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount19A')  ALTER TABLE AT7622 ADD Amount19A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount20A')  ALTER TABLE AT7622 ADD Amount20A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount21A')  ALTER TABLE AT7622 ADD Amount21A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount22A')  ALTER TABLE AT7622 ADD Amount22A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount23A')  ALTER TABLE AT7622 ADD Amount23A decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount24A')  ALTER TABLE AT7622 ADD Amount24A decimal(28,8)

IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount01ALastPeriod')  ALTER TABLE AT7622 ADD Amount01ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount02ALastPeriod')  ALTER TABLE AT7622 ADD Amount02ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount03ALastPeriod')  ALTER TABLE AT7622 ADD Amount03ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount04ALastPeriod')  ALTER TABLE AT7622 ADD Amount04ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount05ALastPeriod')  ALTER TABLE AT7622 ADD Amount05ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount06ALastPeriod')  ALTER TABLE AT7622 ADD Amount06ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount07ALastPeriod')  ALTER TABLE AT7622 ADD Amount07ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount08ALastPeriod')  ALTER TABLE AT7622 ADD Amount08ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount09ALastPeriod')  ALTER TABLE AT7622 ADD Amount09ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount10ALastPeriod')  ALTER TABLE AT7622 ADD Amount10ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount11ALastPeriod')  ALTER TABLE AT7622 ADD Amount11ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount12ALastPeriod')  ALTER TABLE AT7622 ADD Amount12ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount13ALastPeriod')  ALTER TABLE AT7622 ADD Amount13ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount14ALastPeriod')  ALTER TABLE AT7622 ADD Amount14ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount15ALastPeriod')  ALTER TABLE AT7622 ADD Amount15ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount16ALastPeriod')  ALTER TABLE AT7622 ADD Amount16ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount17ALastPeriod')  ALTER TABLE AT7622 ADD Amount17ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount18ALastPeriod')  ALTER TABLE AT7622 ADD Amount18ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount19ALastPeriod')  ALTER TABLE AT7622 ADD Amount19ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount20ALastPeriod')  ALTER TABLE AT7622 ADD Amount20ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount21ALastPeriod')  ALTER TABLE AT7622 ADD Amount21ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount22ALastPeriod')  ALTER TABLE AT7622 ADD Amount22ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount23ALastPeriod')  ALTER TABLE AT7622 ADD Amount23ALastPeriod decimal(28,8)
IF NOT EXISTS(SELECT TOP 1 1 FROM syscolumns WHERE OBJECT_ID('AT7622')=ID AND name = 'Amount24ALastPeriod')  ALTER TABLE AT7622 ADD Amount24ALastPeriod decimal(28,8)

---- Modified on 11/1/2019 by Kim Thư: Bổ sung cột Amount00: Lũy kế từ đầu năm của kỳ hiện tại đến kỳ hiện tại
If Exists (Select * From sysobjects Where name = 'AT7622' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT7622'  and col.name = 'Amount00')
           Alter Table  AT7622 Add Amount00 decimal(28,8) Null
End 