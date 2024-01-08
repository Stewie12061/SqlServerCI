﻿-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on 26/08/2013 by Bảo Anh: Bổ sung ngày BHYT
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1402]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1402](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[EmployeeID] [nvarchar](50) NOT NULL,	
	[BankID] [nvarchar](50) NULL,
	[BankAccountNo] [nvarchar](50) NULL,
	[SoInsuranceNo] [nvarchar](50) NULL,
	[SoInsurBeginDate] [datetime] NULL,
	[HeInsuranceNo] [nvarchar](50) NULL,
	[ArmyJoinDate] [datetime] NULL,
	[ArmyEndDate] [datetime] NULL,
	[ArmyLevel] [nvarchar](100) NULL,
	[Hobby] [nvarchar](100) NULL,
	[HospitalID] [nvarchar](50) NULL,
	[Height] [nvarchar](100) NULL,
	[Weight] [nvarchar](100) NULL,
	[BloodGroup] [nvarchar](100) NULL
 CONSTRAINT [PK_HT1402] PRIMARY KEY NONCLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add Columns
If Exists (Select * From sysobjects Where name = 'HT1402' and xtype ='U') 
Begin          
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1402'  and col.name = 'HFromDate')
           Alter Table  HT1402 Add HFromDate datetime Null           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'HT1402'  and col.name = 'HToDate')
           Alter Table  HT1402 Add HToDate datetime Null
END
-- Thêm cột PersonalTaxID vào bảng HT1402
IF(ISNULL(COL_LENGTH('HT1402', 'PersonalTaxID'), 0) <= 0)
ALTER TABLE HT1402 ADD PersonalTaxID nvarchar(50) NULL 

----Bổ sung cột CreateDate, CreateUserID, LastModifyDate, LastModifyUserID

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1402' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1402' AND col.name = 'CreateDate')
        ALTER TABLE HT1402 ADD CreateDate DATETIME NULL
    END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1402' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1402' AND col.name = 'CreateUserID')
        ALTER TABLE HT1402 ADD CreateUserID NVARCHAR(50) NULL
    END
    
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1402' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1402' AND col.name = 'LastModifyDate')
        ALTER TABLE HT1402 ADD LastModifyDate DATETIME NULL
    END
   
   IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1402' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1402' AND col.name = 'LastModifyUserID')
        ALTER TABLE HT1402 ADD LastModifyUserID NVARCHAR(50) NULL
    END
--Add column
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1402' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1402' AND col.name = 'ReAPK')
        ALTER TABLE HT1402 ADD ReAPK UNIQUEIDENTIFIER NULL
    END

--Modify by Phương Thảo 14/11/2023 ADD BankAddress
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1402' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1402' AND col.name = 'BankAddress')
        ALTER TABLE HT1402 ADD BankAddress NVARCHAR(MAX) NULL
    END