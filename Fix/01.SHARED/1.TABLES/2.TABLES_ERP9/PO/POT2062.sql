-- <Summary>
---- Detail book cont đơn hàng xuất khẩu (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoàng Trúc on 17/12/2019
----Modified by: Văn Tài on 17/01/2020: Bổ sung alter thêm cột S01ID -> S20ID. SOrderID.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POT2062]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POT2062]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] UNIQUEIDENTIFIER NOT NULL,
  [Orders] INT NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [SOrderID] VARCHAR(50) NOT NULL,
  [SOrderNo] VARCHAR(50) NOT NULL,
  [SOVoucherDate] DATETIME NULL,
  [ObjectID] NVARCHAR(250) NULL,
  [CurrencyID] VARCHAR(50) NULL,
  [InventoryID] VARCHAR(50) NULL,
  [InventoryName] NVARCHAR(250) NULL,
  [InheritTransactionID] NVARCHAR(250),
  [UnitID] VARCHAR(50) NULL,
  [S01ID] VARCHAR(50) NULL,
  [S02ID] VARCHAR(50) NULL,
  [S03ID] VARCHAR(50) NULL,
  [S04ID] VARCHAR(50) NULL,
  [S05ID] VARCHAR(50) NULL,
  [S06ID] VARCHAR(50) NULL,
  [S07ID] VARCHAR(50) NULL,
  [S08ID] VARCHAR(50) NULL,
  [S09ID] VARCHAR(50) NULL,
  [S10ID] VARCHAR(50) NULL,
  [S11ID] VARCHAR(50) NULL,
  [S12ID] VARCHAR(50) NULL,
  [S13ID] VARCHAR(50) NULL,
  [S14ID] VARCHAR(50) NULL,
  [S15ID] VARCHAR(50) NULL,
  [S16ID] VARCHAR(50) NULL,
  [S17ID] VARCHAR(50) NULL,
  [S18ID] VARCHAR(50) NULL,
  [S19ID] VARCHAR(50) NULL,
  [S20ID] VARCHAR(50) NULL,
  [Quantity] DECIMAL (28, 8) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_POT2062] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END
----17/12/2019 : Bổ sung cột InheritTransactionID
If Exists (Select * From sysobjects Where name = 'POT2062' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'InheritTransactionID')
           Alter Table  POT2062 Add InheritTransactionID NVARCHAR(250) NULL
End 
----20/12/2019 : Bổ sung cột ObjectID
If Exists (Select * From sysobjects Where name = 'POT2062' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'ObjectID')
           Alter Table  POT2062 Add ObjectID VARCHAR(50) NULL

--- 17/01/2020: Bổ sung alter thêm cột S01ID -> S20ID
		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S01ID')
           Alter Table  POT2062 Add S01ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S01ID')
           Alter Table  POT2062 Add S01ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S01ID')
           Alter Table  POT2062 Add S01ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S02ID')
           Alter Table  POT2062 Add S02ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S03ID')
           Alter Table  POT2062 Add S03ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S04ID')
           Alter Table  POT2062 Add S04ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S05ID')
           Alter Table  POT2062 Add S05ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S06ID')
           Alter Table  POT2062 Add S06ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S07ID')
           Alter Table  POT2062 Add S07ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S08ID')
           Alter Table  POT2062 Add S08ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S09ID')
           Alter Table  POT2062 Add S09ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S10ID')
           Alter Table  POT2062 Add S10ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S11ID')
           Alter Table  POT2062 Add S11ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S12ID')
           Alter Table  POT2062 Add S12ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S13ID')
           Alter Table  POT2062 Add S13ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S14ID')
           Alter Table  POT2062 Add S14ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S15ID')
           Alter Table  POT2062 Add S15ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S16ID')
           Alter Table  POT2062 Add S16ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S17ID')
           Alter Table  POT2062 Add S17ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S18ID')
           Alter Table  POT2062 Add S18ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S19ID')
           Alter Table  POT2062 Add S19ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'S20ID')
           Alter Table  POT2062 Add S20ID VARCHAR(50) NULL

		   If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'POT2062'  and col.name = 'SOrderID')
           Alter Table  POT2062 Add SOrderID VARCHAR(50) NULL
End 


