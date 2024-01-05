---- Create by Đặng Thị Tiểu Mai on 01/12/2015 3:16:51 PM
---- Danh sách bộ định mức theo quy cách

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT0135]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT0135]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [ApportionID] VARCHAR(50) NOT NULL,
      [ObjectID] VARCHAR(50) NULL,
      [InventoryTypeID] VARCHAR(50) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [Disabled] TINYINT DEFAULT (0) NULL,
      [Description] NVARCHAR(250) NULL,
      [IsBOM] TINYINT DEFAULT (0) NOT NULL,
      [ApportionTypeID] TINYINT NULL,
      [InheritApportionID] VARCHAR(50) NULL,
      [InheritApportionTypeID] TINYINT NULL
    CONSTRAINT [PK_MT0135] PRIMARY KEY CLUSTERED
      (
      	[DivisionID],
      	[ApportionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- ---- Modified by Tiểu Mai on 23/08/2016: Bổ sung lưu vết đề nghị định mức (AN PHÁT)
If Exists (Select * From sysobjects Where name = 'MT0135' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'MT0135'  and col.name = 'InheritVoucherID')
		Alter Table  MT0135 Add InheritVoucherID	NVARCHAR(50) NULL
END  

---- ---- Modified by Hải Long on 23/08/2016: Bổ sung cột đơn vị cấp phát (AN PHÁT)
If Exists (Select * From sysobjects Where name = 'MT0135' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'MT0135'  and col.name = 'AllocatedDivision')
		Alter Table  MT0135 Add AllocatedDivision NVARCHAR(250) NULL
END  

---- ---- Modified by Bảo Thy on 20/03/2017: Bổ sung lưu mã hợp đồng bán (TUNGTEX)
If Exists (Select * From sysobjects Where name = 'MT0135' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
		On col.id = tab.id where tab.name =   'MT0135'  and col.name = 'ContractNo')
		Alter Table MT0135 Add ContractNo NVARCHAR(250) NULL
END  