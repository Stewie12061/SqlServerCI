-- <Summary>
---- Master hóa đơn điện tử
-- <History>
---- Create on 17/08/2017 by Hải Long
---- Modified on 07/11/2018 by Kim Thư - Bổ sung cột InvoiceGuid lấy mã từ BKAV trả về khi phát hành hóa đơn
---- Modified on 03/12/2018 by Kim Thư - Bổ sung cột InvoicePublishDate - lưu ngày phát hành hóa đơn
---- Modified on 19/03/2019 by Kim Thư: Bổ sung BranchID - Chi nhánh phát hành hóa đơn ( 32-Phúc Long, 44-Savi)
---- Modified on 21/10/2020 by Hoài Phong: Bổ sung TableID 
---- Modified on 18/04/2023 by Thành Sang: Tăng độ rộng cho cột Description
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1035]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1035](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,		
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[InvoiceCode] [nvarchar](50) NULL,	
	[Serial] [nvarchar](50) NULL,	
	[InvoiceNo] [nvarchar](50) NULL,	
	[InvoiceDate] [datetime] NULL,		
	[ObjectID] [nvarchar](50) NULL,	
	[CurrencyID] [nvarchar](50) NULL,	
	[ExchangeRate] [decimal](28,8) NULL,
	[VATGroupID] [nvarchar](50) NULL,	
	[VATRate] [decimal](28,8) NULL,
	[VATOriginalAmount] [decimal](28,8) NULL,
	[VATConvertedAmount] [decimal](28,8) NULL,
	[Description] [nvarchar](250) NULL,	
	[EInvoiceType] [tinyint] NULL,
	[IsLastEInvoice] [tinyint] NULL,	
	[TypeOfAdjust] [tinyint] NULL,	
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritInvoiceCode] [nvarchar](50) NULL,	
	[InheritSerial] [nvarchar](50) NULL,	
	[InheritInvoiceNo] [nvarchar](50) NULL,		
	[InheritEInvoiceType] [tinyint] NULL,	
	[AT9000VoucherID] [nvarchar](50) NULL,	
	[AT9000VoucherNo] [nvarchar](50) NULL,		
	[IsCancel] [tinyint] NULL,		
	[CancelDate] [datetime] NULL,					
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL
 CONSTRAINT [PK_AT1035] PRIMARY KEY NONCLUSTERED 
(
	[VoucherID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


--- Modified by Hải Long on 11/09/2017: Bổ sung trường InvoiceSign, InheritInvoiceSign
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
    BEGIN      
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'InvoiceSign')
        ALTER TABLE AT1035 ADD InvoiceSign NVARCHAR(50) NULL            
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'InheritInvoiceSign')
        ALTER TABLE AT1035 ADD InheritInvoiceSign NVARCHAR(50) NULL   
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'InheritInvoiceDate')
        ALTER TABLE AT1035 ADD InheritInvoiceDate DATETIME NULL  
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'VATTypeID')
        ALTER TABLE AT1035 ADD VATTypeID NVARCHAR(50) NULL    
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'VATObjectID')
        ALTER TABLE AT1035 ADD VATObjectID NVARCHAR(50) NULL  
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'VATDebitAccountID')
        ALTER TABLE AT1035 ADD VATDebitAccountID NVARCHAR(50) NULL  
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'VATCreditAccountID')
        ALTER TABLE AT1035 ADD VATCreditAccountID NVARCHAR(50) NULL                                  
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'VoucherTypeID')
        ALTER TABLE AT1035 ADD VoucherTypeID NVARCHAR(50) NULL   
        
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'VoucherDate')
        ALTER TABLE AT1035 ADD VoucherDate DATETIME NULL  
                                          
    END	   
---- Modified on 07/11/2018 by Kim Thư - Bổ sung cột InvoiceGuid lấy mã từ BKAV trả về khi phát hành hóa đơn----	  
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'InvoiceGuid') 
	ALTER TABLE AT1035 ADD InvoiceGuid VARCHAR(MAX) NULL
END

---- Modified on 03/12/2018 by Kim Thư - Bổ sung cột InvoicePublishDate - lưu ngày phát hành hóa đơn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'InvoicePublishDate') 
	ALTER TABLE AT1035 ADD InvoicePublishDate DATETIME NULL
END

---- Modified on 19/03/2019 by Kim Thư: Bổ sung BranchID - Chi nhánh phát hành hóa đơn ( 32-Phúc Long)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'BranchID') 
	ALTER TABLE AT1035 ADD BranchID VARCHAR(50) NULL
END
---- Modified on 21/10/2020 by Hoài Phong: Bổ sung TableID 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'TableID') 
	ALTER TABLE AT1035 ADD TableID VARCHAR(50) NULL
END

	--- Add columns by Nhặt Thanh on 28/02/2022: Bổ sung trường phương tiện vận chuyển
	IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'Transportation')
        ALTER TABLE AT1035 ADD Transportation NVARCHAR(50)  NULL
    END
---- Modified on 15/03/2022 by Xuân Nguyên: Bổ sung cột lý do hủy
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'CancelReason') 
	ALTER TABLE AT1035 ADD CancelReason NVARCHAR(250) NULL
END

--- Modified on 18/04/2023 by Thành Sang: Tăng độ rộng cho cột Description
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1035' AND xtype = 'U')
BEGIN 
	IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'AT1035' AND col.name = 'Description') 
	ALTER TABLE AT1035 ALTER COLUMN Description NVARCHAR(500) NULL
END