---- Create by Nhật Thanh on 29/11/2022: Bảng lưu thông tin thuê kho
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[WT0056]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[WT0056]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [TranMonth] int NULL,
  [TranYear] int NULL,
  [VoucherDate] DATETIME NULL,
  [OrderID] VARCHAR(50) NULL,
  [ObjectID] VARCHAR(50) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [UnitPrice] DECIMAL(28,8) NULL,
  [FirstMonthQuantity] DECIMAL(28,8) NULL,
  [FirstMonthDays] DECIMAL(28,8) NULL,
  [FirstMonthAmount] DECIMAL(28,8) NULL,
  [NextMonthQuantity] DECIMAL(28,8) NULL,
  [NextMonthAmount] DECIMAL(28,8) NULL,
  [NextHalfMonthQuantity] DECIMAL(28,8) NULL,
  [NextHalfMonthAmount] DECIMAL(28,8) NULL,
  [Total] DECIMAL(28,8) NULL
)
ON [PRIMARY]
END

---- Modified by Kiều Nga on 24/11/2023: Bổ sung trường NextMonthQuantity2 
If Exists (Select * From sysobjects Where name = 'WT0056' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'WT0056'  and col.name = 'NextMonthQuantity2')
           Alter Table  WT0056 Add NextMonthQuantity2 decimal(28,8) Null
End 

