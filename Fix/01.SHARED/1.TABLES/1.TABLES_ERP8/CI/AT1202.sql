-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modify on 18/08/2014 by Bảo Anh: Bổ sung cột mã nhánh (Sinolife)
---- Modified on 08/10/2014 by Bảo Anh: Xoa field BranchID
---- Modified by Tiểu Mai  on 16/05/2016: Bổ sung trường IsUser, UserID
---- Modified by Quốc Tuấn on 10/06/2016: Bổ sung trường ObjectNameNoUnicode
---- Modified by Văn Tài   on 10/09/2020: Bổ sung trường thiếu từ 8.3.7 DA sang.
---- Modified by Hoài Phong   on 19/11/2020: Tăng ký tự dữ liệu của cột Email
---- Modified by Thành Sang  on 22/12/2020: Bổ sung thuộc tính IsDealer
---- Modified by Minh Hiếu  on 14/02/2022: Bổ sung thuộc tính Tel1,Tel2
---- Modified by Văn Tài	 on 28/03/2022: Bổ sung 5 MPT.
---- Modified by Xuân Nguyên	 on 28/03/2022: Bổ sung ClassifyID.
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1202]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1202](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[S1] [nvarchar](50) NULL,
	[S2] [nvarchar](50) NULL,
	[S3] [nvarchar](50) NULL,
	[ObjectName] [nvarchar](250) NULL,
	[IsSupplier] [tinyint] NOT NULL,
	[IsCustomer] [tinyint] NULL,
	[IsDealer] [tinyint] NOT NULL,
	[IsUpdateName] [tinyint] NOT NULL,
	[TradeName] [nvarchar](250) NULL,
	[LegalCapital] [decimal](28, 8) NULL,
	[FieldID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ObjectTypeID] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[CountryID] [nvarchar](50) NULL,
	[CityID] [nvarchar](50) NULL,
	[Tel] [nvarchar](100) NULL,
	[Fax] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Website] [nvarchar](100) NULL,
	[PaymentID] [nvarchar](50) NULL,
	[Note] [nvarchar](250) NULL,
	[BankName] [nvarchar](250) NULL,
	[BankAddress] [nvarchar](250) NULL,
	[BankAccountNo] [nvarchar](50) NULL,
	[FinanceStatusID] [nvarchar](50) NULL,
	[LicenseNo] [nvarchar](50) NULL,
	[LicenseOffice] [nvarchar](100) NULL,
	[LicenseDate] [datetime] NULL,
	[Register] [nvarchar](50) NULL,
	[Potentility] [nvarchar](50) NULL,
	[BrabNameID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[VATNo] [nvarchar](50) NULL,
	[ReCreditLimit] [decimal](28, 8) NULL,
	[PaCreditLimit] [decimal](28, 8) NULL,
	[ReDueDays] [decimal](28, 8) NULL,
	[PaDueDays] [decimal](28, 8) NULL,
	[PaDiscountDays] [decimal](28, 8) NULL,
	[PaDiscountPercent] [decimal](28, 8) NULL,
	[AreaID] [nvarchar](50) NULL,
	[RePaymentTermID] [nvarchar](50) NULL,
	[PaPaymentTermID] [nvarchar](50) NULL,
	[O01ID] [nvarchar](50) NULL,
	[O02ID] [nvarchar](50) NULL,
	[O03ID] [nvarchar](50) NULL,
	[O04ID] [nvarchar](50) NULL,
	[O05ID] [nvarchar](50) NULL,
	[DeAddress] [nvarchar](250) NULL,
	[ReDays] [int] NULL,
	[IsLockedOver] [tinyint] NOT NULL,
	[ReAddress] [nvarchar](250) NULL,
	[Note1] [nvarchar](250) NULL,
	[PaAccountID] [nvarchar](50) NULL,
	[ReAccountID] [nvarchar](50) NULL,
	[Contactor] [nvarchar](250) NULL,
	[Phonenumber] [nvarchar](100) NULL,
	[DutyID] [varchar](50) NULL,
 CONSTRAINT [PK_AT1202] PRIMARY KEY NONCLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1202_IsSupply]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1202] ADD  CONSTRAINT [DF_AT1202_IsSupply]  DEFAULT ((0)) FOR [IsSupplier]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1202_IsCustomer]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1202] ADD  CONSTRAINT [DF_AT1202_IsCustomer]  DEFAULT ((0)) FOR [IsCustomer]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1202_IsUpdateName]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1202] ADD  CONSTRAINT [DF_AT1202_IsUpdateName]  DEFAULT ((0)) FOR [IsUpdateName]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1202_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1202] ADD  CONSTRAINT [DF_AT1202_Disabled]  DEFAULT ((0)) FOR [Disabled]
END
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1202_IsLockedOver]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1202] ADD  CONSTRAINT [DF_AT1202_IsLockedOver]  DEFAULT ((0)) FOR [IsLockedOver]
END
---- Add Columns
If Exists (Select * From sysobjects Where name = 'AT1202' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'LevelNo')
           Alter Table  AT1202 Add LevelNo int Null           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'ManagerID')
           Alter Table  AT1202 Add ManagerID nvarchar(50) Null           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'MiddleID')
           Alter Table  AT1202 Add MiddleID nvarchar(50) Null           
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'AccAmount')
           Alter Table  AT1202 Add AccAmount decimal(28,8) Null default(0)     
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'BranchID')
           Alter Table  AT1202 Add BranchID nvarchar (50) Null
		   -- Thinh Thêm IsCommon
		    IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
			ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsCommon')
			ALTER TABLE AT1202 ADD [IsCommon] [tinyint] NULL

			-- Sang Thêm IsDealer - Phân biệt khách hàng saleout và salein
			If not exists (select * from syscolumns col inner join sysobjects tab 
            On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'IsDealer')
            Alter Table  AT1202 ADD [IsDealer] [tinyint] Null        
END
---- Delete Columns
If Exists (Select * From sysobjects Where name = 'AT1202' and xtype ='U') 
Begin
        If exists (select * from syscolumns col inner join sysobjects tab 
        On col.id = tab.id where tab.name =   'AT1202'  and col.name = 'BranchID')
			Alter table AT1202 drop column BranchID
End
--CustomizeIndex = 51 Hoàng trần: Thêm nhanh khách hàng---
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsVATObjectID')
        ALTER TABLE AT1202 ADD IsVATObjectID TINYINT NULL
    END
--CustomizeIndex = 51 Hoàng trần: Thêm nhanh khách hàng---
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'VATObjectID')
        ALTER TABLE AT1202 ADD VATObjectID VARCHAR(50) NULL
    END
--CustomizeIndex = 51 Hoàng trần: Thêm nhanh khách hàng---	
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsInvoice')
        ALTER TABLE AT1202 ADD IsInvoice TINYINT NULL
    END
--CustomizeIndex = 51 Hoàng trần: Thêm nhanh khách hàng---
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsUsing')
        ALTER TABLE AT1202 ADD IsUsing TINYINT NULL
    END
--CustomizeIndex = 51 Hoàng trần: Thêm nhanh khách hàng---
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'RouteID')
        ALTER TABLE AT1202 ADD RouteID VARCHAR(50) NULL
    END	
	
--CustomizeIndex = 51 Hoàng trần: Thêm nhanh khách hàng---
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsOrganize')
        ALTER TABLE AT1202 ADD IsOrganize TINYINT NULL
    END	
 
 --- Modified by Tiểu Mai on 16/05/2016: Thêm cột tự động tại UserID cho khách hàng ANGEL   
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsUser')
        ALTER TABLE AT1202 ADD IsUser TINYINT NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'UserID')
        ALTER TABLE AT1202 ADD UserID NVARCHAR(50) NULL
        
        --- Bỏ trường này
        IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'UserID')
        ALTER TABLE At1202 DROP COLUMN UserID
        
        -- Thêm trường này bổ sung tìm kiếm tên không dấu
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'ObjectNameNoUnicode')
        ALTER TABLE AT1202 ADD ObjectNameNoUnicode VARCHAR(250) NULL
    END
    
    
--APP MOBILE: Bổ sung thông tin vị trí
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Longitude')
        ALTER TABLE AT1202 ADD Longitude DECIMAL(28,8) NULL
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Latitude')
        ALTER TABLE AT1202 ADD Latitude DECIMAL(28,8) NULL   
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsLocation')
        ALTER TABLE AT1202 ADD IsLocation TINYINT DEFAULT(0) NULL    
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'LocationAddress')
        ALTER TABLE AT1202 ADD LocationAddress NVARCHAR(500) NULL                         
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'UpdateLocationTime')
        ALTER TABLE AT1202 ADD UpdateLocationTime DATETIME NULL 
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'UpdateLocationUserID')
        ALTER TABLE AT1202 ADD UpdateLocationUserID NVARCHAR(50) NULL                  
    END    
       
---- Modified on 16/08/2017 by Hải Long: Bổ sung trường sử dụng hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsUsedEInvoice')
        ALTER TABLE AT1202 ADD IsUsedEInvoice TINYINT DEFAULT(0) NULL
    END	    
    
---- Modified on 16/08/2017 by Hải Long: Bổ sung trường đối tượng cha hóa đơn điện tử
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'EInvoiceObjectID')
        ALTER TABLE AT1202 ADD EInvoiceObjectID NVARCHAR(50) NULL
    END	 

---- Modified by Bảo Thy on 02/01/2018: Bổ sung trường Đối tượng phụ thuộc

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'RelationObjectID') 
   ALTER TABLE AT1202 ADD RelationObjectID VARCHAR(50) NULL 
END


--Customize BLUESKY: để phân biệt là học sinh hay bổ bẹ, nếu là Bố Mẹ thì phải bắn bố/mẹ qua thông tin người dùng (Phân quyền là nhóm người dùng là phụ huynh) để phục vụ cho bố/mẹ đăng nhập trên APP BLUESKY
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'IsParents') 
   ALTER TABLE AT1202 ADD IsParents TINYINT NULL 
END
/*===============================================END IsParents===============================================*/ 

--Customize BLUESKY: Thông thin Bố
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'FatherObjectID') 
   ALTER TABLE AT1202 ADD FatherObjectID VARCHAR(50) NULL 
END
/*===============================================END FatherObjectID===============================================*/ 

--Customize BLUESKY: Thông thin Bố
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'MotherObjectID') 
   ALTER TABLE AT1202 ADD MotherObjectID VARCHAR(50) NULL 
END
/*===============================================END MotherObjectID===============================================*/ 

---- Modified by Hồng Thảo on 06/04/2019: Bổ sung trường Đối tượng phụ thuộc

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'InheritConsultantID') 
   ALTER TABLE AT1202 ADD InheritConsultantID VARCHAR(50) NULL 
END



---------------- 19/11/2020 - Hoài Phong: Thay đổi kiểu dữ liệu của cột Email ----------------
IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Email')
BEGIN
	ALTER TABLE AT1202 ALTER COLUMN Email NVARCHAR(MAX)  NULL
END


---- Modified by Minh Hiếu: Bổ sung trường chức vụ

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'DutyID') 
   ALTER TABLE AT1202 ADD DutyID VARCHAR(50) NULL 
END

---- Modified by Minh Hiếu: Bổ sung trường tel
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Tel1') 
   ALTER TABLE AT1202 ADD Tel1 [nvarchar](100) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Tel2') 
   ALTER TABLE AT1202 ADD Tel2 [nvarchar](100) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'S01ID') 
   ALTER TABLE AT1202 ADD S01ID [nvarchar](50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'S02ID') 
   ALTER TABLE AT1202 ADD S02ID [nvarchar](50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'S03ID') 
   ALTER TABLE AT1202 ADD S03ID [nvarchar](50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'S04ID') 
   ALTER TABLE AT1202 ADD S04ID [nvarchar](50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'S05ID') 
   ALTER TABLE AT1202 ADD S05ID [nvarchar](50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'ClassifyID')
    ALTER TABLE AT1202 ADD ClassifyID NVARCHAR(50) NULL
END

-----------Modify by Hoài Bảo - Date 31/08/2022 thêm cột DeleteFlg --------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'DeleteFlg') 
   ALTER TABLE AT1202 ADD DeleteFlg TINYINT DEFAULT (0) NULL
END

-----------Modify by Thành Sang - Date 17/05/2023 thêm cột DistricID, WardID --------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'DistrictID') 
   ALTER TABLE AT1202 ADD DistrictID [nvarchar](50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'WardID') 
   ALTER TABLE AT1202 ADD WardID [nvarchar](50) NULL
END

-----------Modify by Hoàng Long - Date 17/08/2023 thêm cột O06ID,O07ID --------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'O06ID') 
   ALTER TABLE AT1202 ADD O06ID NVARCHAR(100) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'O07ID') 
   ALTER TABLE AT1202 ADD O07ID NVARCHAR(100) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'WeddingDate') 
   ALTER TABLE AT1202 ADD WeddingDate [datetime] NULL 
END

-----------Modify by Thanh Lượng - Date 06/12/2023 thêm cột --------------------

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'ApartmentNumb') --Số nhà
   ALTER TABLE AT1202 ADD ApartmentNumb  NVARCHAR(100) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'StreetName') -- Tên đường
   ALTER TABLE AT1202 ADD StreetName  NVARCHAR(100) NULL 

      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'BankBrachName') -- Chi nhanh ngân hàng
   ALTER TABLE AT1202 ADD BankBrachName  NVARCHAR(100) NULL 

      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'RepresentativeName') -- Người đại diện
   ALTER TABLE AT1202 ADD RepresentativeName  NVARCHAR(100) NULL 

      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'CICName_Repr')  -- CCCD/CMND
   ALTER TABLE AT1202 ADD CICName_Repr  NVARCHAR(100) NULL 

      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'DateOfBirth_Repr')  -- Ngày sinh người đại diện
   ALTER TABLE AT1202 ADD DateOfBirth_Repr [datetime] NULL 

      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Phonenumber_Repr') -- sdt người đại diện
   ALTER TABLE AT1202 ADD Phonenumber_Repr  NVARCHAR(100) NULL 
END


-----------Modify by Hương Nhung - Date 13/12/2023 thêm cột --------------------

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1202' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'Ward') -- Phường, xã
   ALTER TABLE AT1202 ADD Ward  NVARCHAR(100) NULL 

      IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1202' AND col.name = 'District') -- Quận, huyện
   ALTER TABLE AT1202 ADD District  NVARCHAR(100) NULL 

END