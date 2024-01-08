
---- Create by Dũng DV on 14/09/2019
---- Thông tin linh kiện thay thế/dịch vụ

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST2051]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST2051]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [OrderID] INT NOT NULL,
  [ServiceID] VARCHAR(50) NOT NULL,
  [ServiceName] NVARCHAR(250) NOT NULL,
  [UnitID] VARCHAR(50) NOT NULL,
  [UnitName] NVARCHAR(250) NOT NULL,
  [QuotationQuantity] INT not NULL,
  [SuggestQuantity] INT NOT NULL,
  [ActualQuantity] INT NOT NULL,
  [ReturnQuantity] INT NOT NULL,
  [UnitPrice] MONEY NULL,
  [QuotationAmount] MONEY NULL,
  [Amount] MONEY NOT NULL,
  [IsWarranty] TINYINT DEFAULT (0) NULL,
  [Notes] NVARCHAR(250)  NULL,  
  
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME DEFAULT GETDATE() NOT NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_POST2051] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

------Modified by [Manh Nguyen] on [02/12/2019]: Bổ sung cột DetailID
If Exists (Select * From sysobjects Where name = 'POST2051' and xtype ='U')
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POST2051'  and col.name = 'DetailID')
ALTER TABLE dbo.POST2051
	ADD DetailID NVARCHAR(50) NULL
End 
GO

------Modified by [Manh Nguyen] on [24/02/2020]: Bổ sung cột Distance
If Exists (Select * From sysobjects Where name = 'POST2051' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POST2051'  and col.name = 'Notes')
ALTER TABLE dbo.POST2051 ADD Notes DECIMAL(10, 2) NULL
End 
GO
------Modified by [Manh Nguyen] on [24/02/2020]: Bổ sung cột Distance
If Exists (Select * From sysobjects Where name = 'POST2051' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POST2051'  and col.name = 'Notes01')
ALTER TABLE dbo.POST2051 ADD Notes01 DECIMAL(10, 2) NULL
End 
GO
------Modified by [Manh Nguyen] on [24/02/2020]: Bổ sung cột Distance
If Exists (Select * From sysobjects Where name = 'POST2051' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POST2051'  and col.name = 'Notes02')
ALTER TABLE dbo.POST2051 ADD Notes02 DECIMAL(10, 2) NULL
End 
GO

------Modified by [Kiều Nga] on [26/02/2020]: trường ghi chú
If Exists (Select * From sysobjects Where name = 'POST2051' and xtype ='U') 
Begin
        If not exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'POST2051'  and col.name = 'Description')
		ALTER TABLE dbo.POST2051 ADD Description NVARCHAR(250) 
End 
GO
