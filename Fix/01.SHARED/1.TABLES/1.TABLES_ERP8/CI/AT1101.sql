-- <Summary>
---- Danh mục đơn vị
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on 13/03/2015 by Thanh Sơn
---- Modify on 24/06/2015 by Bảo Anh: Bổ sung các trường định nghĩa niên độ tài chính
---- Modified on 08/10/2015 by Tiểu Mai: bổ sung các trường thiết lập: BaseCurrencyID, BankAccountID, QuantityDecimals, UnitCostDecimals, ConvertedDecimals, PercentDecimal
---- Modified on 20/11/2015 by Hoàng Vũ: Bổ sung thêm 2 trường WareHouseID, WareHouseTempID (Xử lý đơn hàng thêm nhanh trong call center) ->  CuustomizeIndex = 51 (Khách hàng hoàng trần)
---- Modified on 28/08/2020 by Đoàn Duy: Thêm trường kinh độ, vĩ độ để thực hiện chấm công trên app.
---- Modified on 13/12/2021 by Nhựt Trường: Merge code Angel - Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).
---- Modify on 02/09/2022 by Minh Hiếu: Chỉnh sủa độ dài cột Notes thành 1000 ký tự.
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1101]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1101](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[DivisionName] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[Tel] [nvarchar](100) NULL,
	[Fax] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Address] [nvarchar](250) NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[VATNO] [nvarchar](50) NULL,
	[BeginMonth] [int] NULL,
	[BeginYear] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[DivisionNameE] [nvarchar](250) NULL,
	[AddressE] [nvarchar](250) NULL,
	[ImageLogo] [ntext] NULL,
	[Logo] [image] NULL,
 CONSTRAINT [PK_AT1101] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1101_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1101] ADD  CONSTRAINT [DF_AT1101_Disabled]  DEFAULT ((0)) FOR [Disabled]
END

---- Add Columns
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentCertificate')
		ALTER TABLE AT1101 ADD TaxAgentCertificate NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentContractDate')
		ALTER TABLE AT1101 ADD TaxAgentContractDate DATETIME NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentFax')
		ALTER TABLE AT1101 ADD TaxAgentFax NVARCHAR(100) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentTel')
		ALTER TABLE AT1101 ADD TaxAgentTel NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentEmail')
		ALTER TABLE AT1101 ADD TaxAgentEmail NVARCHAR(250) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentPerson')
		ALTER TABLE AT1101 ADD TaxAgentPerson NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentContractNo')
		ALTER TABLE AT1101 ADD TaxAgentContractNo NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentCity')
		ALTER TABLE AT1101 ADD TaxAgentCity NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentDistrict')
		ALTER TABLE AT1101 ADD TaxAgentDistrict NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentAddress')
		ALTER TABLE AT1101 ADD TaxAgentAddress NVARCHAR(250) NULL
	END	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentName')
		ALTER TABLE AT1101 ADD TaxAgentName NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxAgentNo')
		ALTER TABLE AT1101 ADD TaxAgentNo NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'IsUseTaxAgent')
		ALTER TABLE AT1101 ADD IsUseTaxAgent TINYINT NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'ManagingUnitTaxNo')
		ALTER TABLE AT1101 ADD ManagingUnitTaxNo NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'ManagingUnit')
		ALTER TABLE AT1101 ADD ManagingUnit NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxDepartID')
		ALTER TABLE AT1101 ADD TaxDepartID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxDepartmentID')
		ALTER TABLE AT1101 ADD TaxDepartmentID VARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'TaxreturnPerson')
		ALTER TABLE AT1101 ADD TaxreturnPerson NVARCHAR(250) NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'FiscalBeginDate')
		ALTER TABLE AT1101 ADD FiscalBeginDate NVARCHAR(50) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'District')
		ALTER TABLE AT1101 ADD District NVARCHAR(250) NULL
	END
	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'City')
		ALTER TABLE AT1101 ADD City NVARCHAR(250) NULL
	END
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'Industry')
		ALTER TABLE AT1101 ADD Industry NVARCHAR(500) NULL
	END

--- Bổ sung các trường định nghĩa niên độ tài chính
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'StartDate')
		ALTER TABLE AT1101 ADD StartDate DateTime DEFAULT('01/01/1900') NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'EndDate')
		ALTER TABLE AT1101 ADD EndDate DATETIME DEFAULT('12/31/1900') NULL
	END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'PeriodNum')
		ALTER TABLE AT1101 ADD PeriodNum INT DEFAULT(12) NULL
	END
	
--- Bổ sung các trường thiết lập ngày 08/10/2015
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'BaseCurrencyID')
		ALTER TABLE AT1101 ADD BaseCurrencyID VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'BankAccountID')
		ALTER TABLE AT1101 ADD BankAccountID VARCHAR(50) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'QuantityDecimals')
		ALTER TABLE AT1101 ADD QuantityDecimals TINYINT DEFAULT(0) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'UnitCostDecimals')
		ALTER TABLE AT1101 ADD UnitCostDecimals TINYINT DEFAULT(0) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'ConvertedDecimals')
		ALTER TABLE AT1101 ADD ConvertedDecimals TINYINT DEFAULT(0) NULL
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'PercentDecimal')
		ALTER TABLE AT1101 ADD PercentDecimal TINYINT DEFAULT(0) NULL
	END
	
--WareHouseID: Dùng cho CRM call center (Customizeindex = 51 Hoàng Trần) ngày 20/11/2015
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'WareHouseID')
        ALTER TABLE AT1101 ADD WareHouseID VARCHAR(50) NULL
    END

--WareHouseTempID: Dùng cho CRM call center (Customizeindex = 51 Hoàng Trần) ngày 20/11/2015
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'WareHouseTempID')
        ALTER TABLE AT1101 ADD WareHouseTempID VARCHAR(50) NULL
    END
    
    
-- Các thiết lập cho APP MOBILE 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'IsCheckinDistance')
        ALTER TABLE AT1101 ADD IsCheckinDistance TINYINT DEFAULT(1)    	
    	
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'CheckinDistance')
        ALTER TABLE AT1101 ADD CheckinDistance INT DEFAULT(50)
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'IsCheckinImage')
        ALTER TABLE AT1101 ADD IsCheckinImage TINYINT DEFAULT(0)
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'ImageResolution')
        ALTER TABLE AT1101 ADD ImageResolution TINYINT DEFAULT(0)
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'MaxImageQuantity')
        ALTER TABLE AT1101 ADD MaxImageQuantity TINYINT DEFAULT(5)        
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'IsEnableSaleManLocation')
        ALTER TABLE AT1101 ADD IsEnableSaleManLocation TINYINT DEFAULT(1)                   
		
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'IsStringGoogleKey')
        ALTER TABLE AT1101 ADD IsStringGoogleKey TINYINT DEFAULT(0)       
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'StringGoogleKey')
        ALTER TABLE AT1101 ADD StringGoogleKey NVARCHAR(200) NULL     

    END    
    
--Thêm Đơn vị cha để quản lý cây trong sơ đồ tổ chức
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'ParentDivisionID')
   ALTER TABLE AT1101 ADD ParentDivisionID VARCHAR(50) NULL
END

---- Thêm trường kinh độ ----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'Longitude')
		ALTER TABLE AT1101 ADD Longitude DECIMAL(28,8) NULL
	END

---- Thêm trường vĩ độ ----
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'Latitude')
		ALTER TABLE AT1101 ADD Latitude DECIMAL(28,8) NULL
	END

---- Merge code Angel: Edit độ dài chuỗi DivisionID lên 50 ký tự (Do Fix bảng cũ ở Angel đang được khai báo là 3 ký tự).
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1101' AND xtype = 'U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id = tab.id WHERE tab.name = 'AT1101' AND col.name = 'DivisionID')
		ALTER TABLE AT1101 ALTER COLUMN DivisionID [nvarchar](50) NOT NULL
	END


--- Modified by Minh Hiếu on 09/02/2022: Sửa độ dài cột Notes thành 1000
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='OT2001' AND xtype='U')
	BEGIN
		 IF EXISTS 
    (
    SELECT * 
    FROM syscolumns col 
    INNER JOIN sysobjects tab ON col.id = tab.id 
    WHERE tab.name = 'AT1101' 
    AND col.name = 'Notes'
    )
		ALTER TABLE AT1101 ALTER COLUMN [Notes] Nvarchar(1000) NULL
	END