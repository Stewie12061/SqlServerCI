-- <Summary>
---- 
-- <History>
---- Create on 20/04/2011 by Việt Khánh
---- Modified on 21/01/2014 by Bảo Anh: Bổ sung các trường nhận biết hợp đồng thuộc đơn hàng và mặt hàng nào (Sinolife)
---- Modified on 24/03/2015 by Thanh Sơn:
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1020]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1020](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ContractID] [nvarchar](50) NOT NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[ContractNo] [nvarchar](50) NOT NULL,
	[ContractName] [nvarchar](250) NULL,
	[ContractType] [tinyint] NULL,
	[SignDate] [datetime] NULL,
	[ObjectID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[Amount] [decimal](28, 8) NULL,
	[Description] [nvarchar](250) NULL,
	[ConRef01] [nvarchar](250) NULL,
	[ConRef02] [nvarchar](250) NULL,
	[ConRef03] [nvarchar](250) NULL,
	[ConRef04] [nvarchar](250) NULL,
	[ConRef05] [nvarchar](250) NULL,
	[ConRef06] [nvarchar](250) NULL,
	[ConRef07] [nvarchar](250) NULL,
	[ConRef08] [nvarchar](250) NULL,
	[ConRef09] [nvarchar](250) NULL,
	[ConRef10] [nvarchar](250) NULL,	
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT1020] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,
	[ContractID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'SOrderID')
		ALTER TABLE AT1020 ADD SOrderID NVARCHAR(50) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'STransactionID')
		ALTER TABLE AT1020 ADD STransactionID NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'BeginDate')
		ALTER TABLE AT1020 ADD BeginDate DATETIME NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'EndDate')
		ALTER TABLE AT1020 ADD EndDate DATETIME NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ExchangeRate')
		ALTER TABLE AT1020 ADD ExchangeRate DECIMAL(28,8) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConvertedAmount')
		ALTER TABLE AT1020 ADD ConvertedAmount DECIMAL(28,8) NULL
	END

----- Modified by Tiểu Mai on 21/11/2016: Bổ sung tham số hợp đồng 11 --> 20	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef11')
		ALTER TABLE AT1020 ADD [ConRef11] nvarchar(250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef12')
		ALTER TABLE AT1020 ADD [ConRef12] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef13')
		ALTER TABLE AT1020 ADD [ConRef13] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef14')
		ALTER TABLE AT1020 ADD [ConRef14] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef15')
		ALTER TABLE AT1020 ADD [ConRef15] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef16')
		ALTER TABLE AT1020 ADD [ConRef16] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef17')
		ALTER TABLE AT1020 ADD [ConRef17] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef18')
		ALTER TABLE AT1020 ADD [ConRef18] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef19')
		ALTER TABLE AT1020 ADD [ConRef19] [nvarchar](250) NULL
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRef20')
		ALTER TABLE AT1020 ADD [ConRef20] [nvarchar](250) NULL
	END

---- Modified by Bảo Thy on 28/12/2016: BỔ sung customize hợp đồng cho An Bình
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'WorkHistory')
    ALTER TABLE AT1020 ADD WorkHistory NText NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'AppendixContract')
	ALTER TABLE AT1020 ADD AppendixContract NText NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
	ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'RefContractNo')
	ALTER TABLE AT1020 ADD RefContractNo VARCHAR(50) NULL
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'InventoryGroup')
    ALTER TABLE AT1020 ADD InventoryGroup VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'InventoryGroup')
    ALTER TABLE AT1020 ADD InventoryGroup VARCHAR(50) NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'IsEndContract')
    ALTER TABLE AT1020 ADD IsEndContract TINYINT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'NumberDateEC')
    ALTER TABLE AT1020 ADD NumberDateEC INT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'IsDueContract')
    ALTER TABLE AT1020 ADD IsDueContract TINYINT NULL

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'NumberDateDC')
    ALTER TABLE AT1020 ADD NumberDateDC INT NULL
END

----Modified by Bảo Thy on 28/12/2016: add column bảng giá, đơn vị tính ngày (EIMSKIP)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'PriceID') 
   ALTER TABLE AT1020 ADD PriceID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'DayUnit') 
   ALTER TABLE AT1020 ADD DayUnit TINYINT NULL 
END

----Modified by Hải Long on 31/07/2017: Bổ sung trường đánh dấu phụ lục hợp đồng (TDCLA)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'IsAppendixContract')
   ALTER TABLE AT1020 ADD IsAppendixContract TINYINT DEFAULT(0) NULL 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'InheritContractID') 
   ALTER TABLE AT1020 ADD InheritContractID NVARCHAR(50) NULL    
END
----Modified by Tra Giang on 26/10/2018: Bổ sung 20 trường tên tham số (thông tin bổ sung)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName01')
   ALTER TABLE AT1020 ADD ConRefName01 NVARCHAR(50) NULL 
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName02') 
   ALTER TABLE AT1020 ADD ConRefName02 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName03') 
   ALTER TABLE AT1020 ADD ConRefName03 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName04') 
   ALTER TABLE AT1020 ADD ConRefName04 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName05') 
   ALTER TABLE AT1020 ADD ConRefName05 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName06') 
   ALTER TABLE AT1020 ADD ConRefName06 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName07') 
   ALTER TABLE AT1020 ADD ConRefName07 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName08') 
   ALTER TABLE AT1020 ADD ConRefName08 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName09') 
   ALTER TABLE AT1020 ADD ConRefName09 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName10') 
   ALTER TABLE AT1020 ADD ConRefName10 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName11') 
   ALTER TABLE AT1020 ADD ConRefName11 NVARCHAR(50) NULL    
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName12') 
   ALTER TABLE AT1020 ADD ConRefName12 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName13') 
   ALTER TABLE AT1020 ADD ConRefName13 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName14') 
   ALTER TABLE AT1020 ADD ConRefName14 NVARCHAR(50) NULL    
      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName15') 
   ALTER TABLE AT1020 ADD ConRefName15 NVARCHAR(50) NULL    
         IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName16') 
   ALTER TABLE AT1020 ADD ConRefName16 NVARCHAR(50) NULL    
	      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName17') 
   ALTER TABLE AT1020 ADD ConRefName17 NVARCHAR(50) NULL    
	      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName18') 
   ALTER TABLE AT1020 ADD ConRefName18 NVARCHAR(50) NULL    
	      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName19') 
   ALTER TABLE AT1020 ADD ConRefName19 NVARCHAR(50) NULL    
	      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ConRefName20') 
   ALTER TABLE AT1020 ADD ConRefName20 NVARCHAR(50) NULL  
   --Edit by Tra Giang on 09/11/2018: bổ sung 10 mã phân tích 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana01ID') 
   ALTER TABLE AT1020 ADD Ana01ID NVARCHAR(50) NULL  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana02ID') 
   ALTER TABLE AT1020 ADD Ana02ID NVARCHAR(50) NULL  
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana03ID') 
   ALTER TABLE AT1020 ADD Ana03ID NVARCHAR(50) NULL  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana04ID') 
   ALTER TABLE AT1020 ADD Ana04ID NVARCHAR(50) NULL  
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana05ID') 
   ALTER TABLE AT1020 ADD Ana05ID NVARCHAR(50) NULL  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana06ID') 
   ALTER TABLE AT1020 ADD Ana06ID NVARCHAR(50) NULL  
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana07ID') 
   ALTER TABLE AT1020 ADD Ana07ID NVARCHAR(50) NULL  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana08ID') 
   ALTER TABLE AT1020 ADD Ana08ID NVARCHAR(50) NULL  
    IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana09ID') 
   ALTER TABLE AT1020 ADD Ana09ID NVARCHAR(50) NULL  
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Ana10ID') 
   ALTER TABLE AT1020 ADD Ana10ID NVARCHAR(50) NULL  
END

----Modified by Huỳnh Thử on 04/08/2020: Bổ sung trường UnitType
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'UnitType') 
   ALTER TABLE AT1020 ADD UnitType INT NULL    
END

----Modified by Kiều Nga on 12/11/2020: Bổ sung trường bảng giá customize CBD
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'PriceListID') 
   ALTER TABLE AT1020 ADD PriceListID NVARCHAR(50) NULL    
END

----Modified by Hoài Phong on 08/03/2021: Bổ sung trường bảng giá gói hợp đồng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ContractPackageID') 
   ALTER TABLE AT1020 ADD ContractPackageID NVARCHAR(80) NULL    
END

----Modified by Huỳnh Thử on 05/07/2021: Bổ sung trường hạn mục
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'Category') 
   ALTER TABLE AT1020 ADD Category NVARCHAR(500) NULL    
END

---Modify on 31/12/2021 by Anh Tuấn: Bổ sung cột DeleteFlg
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'DeleteFlg') 
   ALTER TABLE AT1020 ADD DeleteFlg TINYINT DEFAULT (0) NULL 
END

----Modified by Minh Hiếu on 18/01/2022: Bổ sung trường ContactorID,DeliveryTime
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'ContactorID') 
   ALTER TABLE AT1020 ADD ContactorID VARCHAR(50) NULL      
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN 
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'DeliveryTime') 
   ALTER TABLE AT1020 ADD DeliveryTime NVARCHAR(250) NULL      
END

----Modified by Hoài Bảo on 21/09/2022: Bổ sung trường VATOriginalAmount, VATConvertedAmount
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'VATOriginalAmount') 
   ALTER TABLE AT1020 ADD VATOriginalAmount DECIMAL(28,8) NULL
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'VATConvertedAmount') 
   ALTER TABLE AT1020 ADD VATConvertedAmount DECIMAL(28,8) NULL
END

----Modified by Tấn Lộc on 02/09/2022: Bổ sung trường AssignedToUserID
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1020' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1020' AND col.name = 'AssignedToUserID') 
   ALTER TABLE AT1020 ADD AssignedToUserID VARCHAR(250) NULL
END