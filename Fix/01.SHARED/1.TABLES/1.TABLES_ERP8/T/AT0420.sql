-- <Summary>
----Nghiệp vụ các khoản thu lô đất
-- <History>
---- Create on 05/04/2022 by Kiều Nga

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0420]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0420]
(
	[APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] VARCHAR(50) NOT NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
	[ObjectID] VARCHAR(50) NULL,
	[ContractNo] VARCHAR(50) NULL,		
	[CostTypeID] VARCHAR(50) NULL,
	[Quantity] DECIMAL(28,8) NULL,
	[Amount] DECIMAL(28,8) NULL,
	[Description] NVARCHAR(250) NULL,
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	CONSTRAINT [PK_AT0420] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
) ON [PRIMARY]
END


If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'CurrencyID')
           Alter Table  AT0420 Add CurrencyID VARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'ExchangeRate')
           Alter Table  AT0420 Add ExchangeRate DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'OriginalAmount')
           Alter Table  AT0420 Add OriginalAmount DECIMAL(28,8) NULL
END

--- Modify on 25/04/2022 by Kiều Nga : Bổ sung chỉ số đầu, chỉ số cuối cho khoản thu
If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'FromValue')
           Alter Table  AT0420 Add FromValue DECIMAL(28,8) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'ToValue')
           Alter Table  AT0420 Add ToValue DECIMAL(28,8) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'AdministrativeExpensesDate')
           Alter Table  AT0420 Add AdministrativeExpensesDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'VATGroupID')
           Alter Table  AT0420 Add VATGroupID VARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'VATRate')
           Alter Table  AT0420 Add VATRate DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'FromDate')
           Alter Table  AT0420 Add FromDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'ToDate')
           Alter Table  AT0420 Add ToDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'CountMonth')
           Alter Table  AT0420 Add CountMonth DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'VATConvertedAmount')
           Alter Table  AT0420 Add VATConvertedAmount DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'ConvertedAmount')
           Alter Table  AT0420 Add ConvertedAmount DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'AdministrativeExpenses')
           Alter Table  AT0420 Add AdministrativeExpenses DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'AdministrativeExpenses')
           Alter Table  AT0420 Add AdministrativeExpenses DECIMAL(28,8) NULL
END

---[Kiều Nga][05/01/2023] Bổ sung thêm các cột ngày kết thúc tính PQL, giảm giá, tăng lãi phí
If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'EndAdministrativeExpensesDate')
           Alter Table  AT0420 Add EndAdministrativeExpensesDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'DiscountAmount')
           Alter Table  AT0420 Add DiscountAmount DECIMAL(28,8) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'IncreaseInterestRates')
           Alter Table  AT0420 Add IncreaseInterestRates DECIMAL(28,8) NULL
END

---[Kiều Nga][17/01/2023] Bổ sung thêm cột số chứng từ, ngày thời hạn thanh toán
If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'VoucherNo')
           Alter Table  AT0420 Add VoucherNo VARCHAR(50) NULL
END

If Exists (Select * From sysobjects Where name = 'AT0420' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT0420'  and col.name = 'PaymentTerm')
           Alter Table  AT0420 Add PaymentTerm DATETIME NULL
END